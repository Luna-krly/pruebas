<%-- 
    Document   : reportes_catalogos
    Created on : 3 abr 2024, 13:05:36
    Author     : Ing. Evelyn Leilani Avendaño 
--%>

<%--
 <%      
            try{
            //create a HashMap for Passing data to jasper report 
           HashMap employeeReportMap = new HashMap<String, Object>();
           employeeReportMap.put("dato","40565");
        
            // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
            JasperCompileManager.compileReportToFile("C:\\Users\\Serv_Social\\JaspersoftWorkspace\\MyReports\\Prueba.jrxml");

            // Llena el reporte con datos y parámetros
            JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\Users\\Serv_Social\\JaspersoftWorkspace\\MyReports\\Parametro.jasper", employeeReportMap, new JREmptyDataSource());
            response.setContentType("application/PDF");
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
            }
            
        %>



--%>


<%@page import="java.awt.Font" %>
<%@page import="java.awt.GraphicsEnvironment" %>
<%@page import="java.io.File" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Map" %>

<%@page import="net.sf.jasperreports.engine.*" %>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JREmptyDataSource"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/Diseño/img/LogoAhora.png">
    </head>
    <body>
    </body>
</html>

<%      
       String DRIVER ="com.mysql.jdbc.Driver";
       String URL="jdbc:mysql://10.15.15.76:3306/facturacion?allowPublicKeyRetrieval=true&useSSL=false";
       String USER="facturacion";
       String PASSWORD="f4ctur4s";
       Connection conexion=null;
       try{
       Class.forName(DRIVER);
       conexion=DriverManager.getConnection(URL,USER,PASSWORD);
        request.setCharacterEncoding("UTF-8");
        System.out.println("Ingresa a JSP Reportes");
   String opcion = request.getParameter("action");
    System.out.println("opcion que registra: " + opcion);
    
   if (opcion.equals("201")) {//CONCEPTOS
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatConceptos.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatConceptos.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_Conceptos.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

    } else if (opcion.equals("202")) {//PERMISOS
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
       JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatPermisos.jrxml");

       // Llena el reporte con datos y parámetros
       JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatPermisos.jasper", null, conexion);
       response.setContentType("application/PDF");
       response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_Permisos.pdf\"");
       // Exporta el reporte a un archivo PDF
       JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
            
   }else if (opcion.equals("203")) {//TIPOS DE INGRESO

        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatTipIng.jrxml");
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatTipIng.jasper", null, conexion);         
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_TipoIngreso.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

   }else if (opcion.equals("204")) {//BANCOS

        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatBancos.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatBancos.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_Bancos.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
            
   }else if (opcion.equals("205")) {//CLIENTES SAT
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
       JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatClientesSat.jrxml");
       // Llena el reporte con datos y parámetros
       JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatClientesSat.jasper", null, conexion);
       response.setContentType("application/PDF");
       response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_ClientesSAT.pdf\"");
       // Exporta el reporte a un archivo PDF
       JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
       
   }else if (opcion.equals("206")) {//CODIGO POSTAL
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
       JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatCodPos.jrxml");
       // Llena el reporte con datos y parámetros
       JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatCodPos.jasper", null, conexion);
       response.setContentType("application/PDF");
       response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_CódigoPostal.pdf\"");
       // Exporta el reporte a un archivo PDF
       JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
            
   }else if (opcion.equals("207")) {//TIPO DE COMPROBANTES
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatTipoComprob.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatTipoComprob.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_TipoComprobante.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
           
   }else if (opcion.equals("208")) {//FORMA DE PAGO
        
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatFormaPago.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatFormaPago.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_FormaPago.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

   }else if (opcion.equals("209")) {//IMPUESTOS 
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatImpuestos.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatImpuestos.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_Impuestos.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

   }else if (opcion.equals("210")) {//METODO DE PAGO
        
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatMetodoPago.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatMetodoPago.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_MétodoPago.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
           
   }else if (opcion.equals("211")) {//MONEDAS
        
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatMoneda.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatMoneda.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_Moneda.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
     
   }else if (opcion.equals("212")) {//OBJETO DE IMPUESTO
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatObjImp.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatObjImp.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_ObjetoImpuesto.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

   }else if (opcion.equals("213")) {//PAISES
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatPais.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatPais.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_País.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
  
   }else if (opcion.equals("214")) {//PERIODICIDADES
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatPeriodicidades.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatPeriodicidades.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_Periodicidades.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

   }else if (opcion.equals("215")) {//PRODUCTOS Y SERVICIOS
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatProdServ.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatProdServ.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_ProductosServicios.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

   }else if (opcion.equals("216")) {//RÉGIMEN FISCAL
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatRegFiscal.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatRegFiscal.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_RégimenFiscal.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
 
   }else if (opcion.equals("217")) {//TIPO DE FACTOR
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatTipoFactor.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatTipoFactor.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_TipoFactor.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

   }else if (opcion.equals("218")) {//TIPO DE RELACION
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatTipoRelacion.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatTipoRelacion.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_TipoRelación.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
        
   }else if (opcion.equals("219")) {//TIPO DE SERVICIO
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatTipoServ.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatTipoServ.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_TipoServicio.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

   }else if (opcion.equals("220")) {//UNIDAD DE MEDIDA
   
    // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
       JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatUdMedida.jrxml");
       // Llena el reporte con datos y parámetros
       JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatUdMedida.jasper", null, conexion);
       response.setContentType("application/PDF");
       response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_UnidadMedida.pdf\"");
       // Exporta el reporte a un archivo PDF
       JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
   
   }else if (opcion.equals("221")) {//USO DE CFDI
   
        // Compila el archivo JasperReport (.jrxml) en un archivo .jasper
        JasperCompileManager.compileReportToFile("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatUsoCfdi.jrxml");
        // Llena el reporte con datos y parámetros
        JasperPrint jasperPrint = JasperFillManager.fillReport("C:\\FacturasReportes\\REPORTES FACTURACIÓN\\CatUsoCfdi.jasper", null, conexion);
        response.setContentType("application/PDF");
        response.setHeader("Content-Disposition", "inline; filename=\"Catálogo_UsoCFDI.pdf\"");
        // Exporta el reporte a un archivo PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
        
   }else{
%>
<%@include file="../Encabezado.jsp" %>


<!-- Contenido Principal -->
<main class="col ps-md-2 pt-2 mx-3">
    <h5 class="text-center metro">No existe esta opción de catálogo</h5>
</main>

<%@include file="../Pie.jsp" %>
<%
System.out.println("No llego ningun dato");
}

       response.getOutputStream();
       response.getOutputStream().flush();
       response.getOutputStream().close();
       out.clear(); // where out is a JspWriter
       out = pageContext.pushBody();
// Add more conditions for other buttons if needed
        }catch(Exception ex){
            System.out.println("Ocurrio un error al generar reporte: " + ex);
        }
            
%>

