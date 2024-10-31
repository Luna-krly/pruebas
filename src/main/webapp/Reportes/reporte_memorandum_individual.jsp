<%-- 
    Document   : reporte_memorandum_individual
    Created on : 4 jul 2024, 15:38:48
    Author     : Ing. Evelyn Leilani Avendaño
--%>

<%@page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource" %>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.engine.fill.*"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JREmptyDataSource"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%> 
<%@page import="java.util.Locale"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>


<%-- MEMORANDUM--%>
<%@page import="Objetos.obj_MGeneral"%>
<%! obj_MGeneral memorandum;%>
<%! String recursosFinancieros;%>
<%! String areaEmisora;%>
<%! String gerenciaPresupuestos;%>
<%! String gerenciaContabilidad;%>
<%! String cliente;%>
<%! String direccionQR;%>


<%      
try{
     memorandum = (obj_MGeneral) request.getAttribute("memorandum");
     recursosFinancieros = (String) request.getAttribute("recursosFinancieros");
     areaEmisora = (String) request.getAttribute("areaEmisora");
     gerenciaPresupuestos = (String) request.getAttribute("gerenciaPresupuestos");
     gerenciaContabilidad = (String) request.getAttribute("gerenciaContabilidad");
     cliente = (String) request.getAttribute("cliente");
     direccionQR = (String) request.getAttribute("qrDireccion");

    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd"); // Formato de entrada
    SimpleDateFormat outputFormat = new SimpleDateFormat("dd 'DE' MMMM 'DE' yyyy", new Locale("es", "ES")); // Formato de salida
    Date fechaDate = inputFormat.parse(memorandum.getFecha()); // Convierte el string a Date
    String fechaFormateada = outputFormat.format(fechaDate).toUpperCase(new Locale("es", "ES")); // Convierte el Date a string en el nuevo formato y a mayúsculas

     // Crear la lista de áreas emisoras como Map
    List<Map<String, Object>> areasEmisorasList = new ArrayList<>();

    if (recursosFinancieros != null) {
        Map<String, Object> map = new HashMap<>();
        map.put("AreaEmisora", recursosFinancieros);
        areasEmisorasList.add(map);
    }
    if (areaEmisora != null) {
        Map<String, Object> map = new HashMap<>();
        map.put("AreaEmisora", areaEmisora);
        areasEmisorasList.add(map);
    }
    if (gerenciaPresupuestos != null) {
        Map<String, Object> map = new HashMap<>();
        map.put("AreaEmisora", gerenciaPresupuestos);
        areasEmisorasList.add(map);
    }
    if (gerenciaContabilidad != null) {
        Map<String, Object> map = new HashMap<>();
        map.put("AreaEmisora", gerenciaContabilidad);
        areasEmisorasList.add(map);
    }
    if (cliente != null) {
        Map<String, Object> map = new HashMap<>();
        map.put("AreaEmisora", cliente);
        areasEmisorasList.add(map);
    }
    if (areasEmisorasList.isEmpty()) {
        Map<String, Object> map = new HashMap<>();
        map.put("AreaEmisora", "");
        areasEmisorasList.add(map);
    }

    // Convertir la lista en un JRBeanCollectionDataSource
    JRDataSource dataSource = new JRBeanCollectionDataSource(areasEmisorasList);
    DecimalFormat df = new DecimalFormat("#,##0.00");
    String totalFormateado = df.format(memorandum.getTotal());
    
    //create a HashMap for Passing data to jasper report 
    HashMap parameterMemorandumG = new HashMap<String, Object>();
          
    parameterMemorandumG.put("NoMemo", String.valueOf(memorandum.getNoMemorandum()));
    parameterMemorandumG.put("NombreConcepto", memorandum.getNombreConcepto());
    parameterMemorandumG.put("fecha", fechaFormateada);
    parameterMemorandumG.put("remitente", memorandum.getRemitente());
    parameterMemorandumG.put("destinatario", memorandum.getDestinatario());
    parameterMemorandumG.put("ConceptoGeneral", memorandum.getConceptoGeneral());
    parameterMemorandumG.put("Total", totalFormateado);
    parameterMemorandumG.put("Iva", df.format(memorandum.getIva()));
    parameterMemorandumG.put("subtotal", df.format(memorandum.getSubtotal()));
    parameterMemorandumG.put("TotalLetras", memorandum.getTotalLetras());
    parameterMemorandumG.put("NombreVo", memorandum.getNombreVo());
    parameterMemorandumG.put("PuestoVo", memorandum.getPuestoVo());
    parameterMemorandumG.put("NombreAtt", memorandum.getNombreAtt());
    parameterMemorandumG.put("PuestoAtt", memorandum.getPuestoAtt());
    parameterMemorandumG.put("direccionQR", direccionQR);
   
    // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
    JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\FORMATOS FACTURACIÓN\\MemorandumGeneral.jrxml");

    // Llena el reporte con datos y parámetros
    JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\FORMATOS FACTURACIÓN\\MemorandumGeneral.jasper", parameterMemorandumG, dataSource);
    response.setContentType("application/PDF");
    response.setHeader("Content-Disposition", "inline; filename=\"Memorándum_"+memorandum.getNoMemorandum()+".pdf\"");
    // Exporta el reporte a un archivo PDF
    JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

    // Cierra la respuesta después de escribir el PDF
    response.getOutputStream();
    response.getOutputStream().flush();
    response.getOutputStream().close();
    out.clear(); // where out is a JspWriter
    out = pageContext.pushBody();
}catch(Exception ex){
                System.out.println("Ocurrio un error al generar reporte: " + ex);
System.out.println("Ocurrio un error al generar reporte: " + ex.getMessage());
    }
            
%>