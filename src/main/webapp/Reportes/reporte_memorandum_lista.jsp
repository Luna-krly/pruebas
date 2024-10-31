<%-- 
    Document   : reporte_memorandum_lista
    Created on : 5 jul 2024, 16:14:40
    Author     : Ing. Evelyn Leilani Avendaño
--%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.engine.fill.*"%>
<%@ page import="net.sf.jasperreports.engine.data.*" %>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JREmptyDataSource"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>

<%-- MEMORANDUM--%>
<%@page import="Objetos.obj_MGeneral"%>
<%! obj_MGeneral memorandum;%>
<%! List<obj_MGeneral> memorandumLista;%>

<%      
try {
    memorandumLista = (List<obj_MGeneral>) request.getAttribute("listaMemorandum");
    
    // Crear una fuente de datos JRBeanCollectionDataSource usando la lista de objetos
    JRDataSource dataSource = new JRBeanCollectionDataSource(memorandumLista);
    
    // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
    JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\FORMATOS FACTURACIÓN\\ReportMemoGeneral.jrxml");
    
    // Llena el reporte con datos y parámetros
    JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\FORMATOS FACTURACIÓN\\ReportMemoGeneral.jasper", null, dataSource);
    
    // Configura el tipo de contenido de la respuesta
    response.setContentType("application/PDF");
    response.setHeader("Content-Disposition", "inline; filename=\"ReporteMemorándumGeneral.pdf\"");
    
    // Exporta el reporte a un archivo PDF
    JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
    
     // Cierra la respuesta después de escribir el PDF
            response.getOutputStream();
            response.getOutputStream().flush();
            response.getOutputStream().close();
            out.clear(); // where out is a JspWriter
            out = pageContext.pushBody();
} catch (Exception ex) {
    System.out.println("Ocurrió un error al generar el reporte: " + ex);
    System.out.println("Ocurrió un error al generar el reporte: " + ex.getMessage());
}
%>
