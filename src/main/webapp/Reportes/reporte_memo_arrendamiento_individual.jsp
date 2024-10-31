<%-- 
    Document   : reporte_memo_arrendamiento_individual
    Created on : 22 jul 2024, 10:57:06
    Author     : Ing. Evelyn Leilani Avendaño
--%>
<%@page import="com.itextpdf.text.Document, com.itextpdf.text.pdf.PdfCopy, com.itextpdf.text.pdf.PdfReader" %>
<%@page import="java.io.ByteArrayOutputStream" %>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.engine.fill.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="Objetos.obj_MArrendamiento"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="jakarta.servlet.ServletOutputStream"%>

<%
    String DRIVER ="com.mysql.jdbc.Driver";
    String URL="jdbc:mysql://10.15.15.76:3306/facturacion?allowPublicKeyRetrieval=true&useSSL=false";
    String USER="facturacion";
    String PASSWORD="f4ctur4s";
    Connection conexion = null;

    try {
        response.reset();
        Class.forName(DRIVER);
        conexion = DriverManager.getConnection(URL, USER, PASSWORD);

        // Obtener los datos del request
        obj_MArrendamiento memorandum = (obj_MArrendamiento) request.getAttribute("memorandum");
        
        // Formatear la fecha
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat outputFormat = new SimpleDateFormat("dd 'DE' MMMM 'DE' yyyy", new Locale("es", "ES"));
        Date fechaDate = inputFormat.parse(memorandum.getFecha());
        String fechaFormateada = outputFormat.format(fechaDate).toUpperCase(new Locale("es", "ES"));
        
        DecimalFormat df = new DecimalFormat("#,##0.00");
        String totalFormateado = df.format(memorandum.getTotal());
        String direccionQR = (String) request.getAttribute("qrDireccion");
         // Crear una lista de áreas
        List<String> areas = new ArrayList<>();
        areas.add("CLIENTE");
        areas.add("GERENCIA DE CONTABILIDAD");
        areas.add("ÁREA EMISORA");
        areas.add("GERENCIA DE RECURSOS FINANCIEROS");

        // Lista para almacenar cada PDF generado
        List<ByteArrayOutputStream> pdfStreams = new ArrayList<>();

        for (String area : areas) {
            // Crear mapas para almacenar los parámetros
            HashMap<String, Object> parameterMemorandumA = new HashMap<>();
            parameterMemorandumA.put("NoMemo", String.valueOf(memorandum.getNoMemorandum()));
            parameterMemorandumA.put("remitente", memorandum.getRemitente());
            parameterMemorandumA.put("destinatario", memorandum.getDestinatario());
            parameterMemorandumA.put("NombreConcepto", memorandum.getNombreConcepto());
            parameterMemorandumA.put("Total", totalFormateado);
            parameterMemorandumA.put("TotalLetras", memorandum.getTotalLetras());
            parameterMemorandumA.put("ConceptoGeneral", memorandum.getConceptoGeneral());
            parameterMemorandumA.put("Cuenta", memorandum.getCuentaBancaria());
            parameterMemorandumA.put("Banco", memorandum.getDepositoBancario());
            parameterMemorandumA.put("NombreVo", memorandum.getNombreVo());
            parameterMemorandumA.put("PuestoVo", memorandum.getPuestoVo());
            parameterMemorandumA.put("NombreAtt", memorandum.getNombreAtt());
            parameterMemorandumA.put("PuestoAtt", memorandum.getPuestoAtt());
            parameterMemorandumA.put("fecha", fechaFormateada);
            parameterMemorandumA.put("Subtotal", df.format(memorandum.getSubtotal()));
            parameterMemorandumA.put("Iva", df.format(memorandum.getIva()));
            parameterMemorandumA.put("area", area); // Añadir el área como parámetro
            parameterMemorandumA.put("direccionQR", direccionQR); // Añadir el QR

            // Compilar el archivo JasperReport (.jrxml) en un archivo .jasper
            JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\FORMATOS FACTURACIÓN\\MEMOARREN.jrxml");

            // Llenar el reporte con datos y parámetros
            JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\FORMATOS FACTURACIÓN\\MEMOARREN.jasper", parameterMemorandumA, conexion);

            // Exportar cada reporte a un ByteArrayOutputStream en lugar de la respuesta directamente
            ByteArrayOutputStream pdfOutputStream = new ByteArrayOutputStream();
            JasperExportManager.exportReportToPdfStream(jasperPrint, pdfOutputStream);
            pdfStreams.add(pdfOutputStream);
        }

        // Combinar los PDFs
        Document document = new Document();
        ByteArrayOutputStream combinedPdf = new ByteArrayOutputStream();
        PdfCopy copy = new PdfCopy(document, combinedPdf);
        document.open();
        for (ByteArrayOutputStream pdfStream : pdfStreams) {
            PdfReader reader = new PdfReader(pdfStream.toByteArray());
            copy.addDocument(reader);
            reader.close();
        }
        document.close();

         // Configurar la respuesta para exportar el PDF combinado
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"memo_combinado.pdf\"");

        
        // Cierra la respuesta después de escribir el PDF YA NO APARECE MENSAGE DE ERROR GETOUTPUT STREAM
        combinedPdf.writeTo(response.getOutputStream());
        response.getOutputStream().flush();
        response.getOutputStream().close();
        out.clear(); // where out is a JspWriter
        out = pageContext.pushBody();

        } catch (Exception ex) {
            System.out.println("Ocurrió un error al generar reporte: " + ex);
        } finally {
            if (conexion != null) {
                conexion.close();
        }
    }
%>
