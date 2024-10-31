<%-- 
    Document   : JSP_CPass
    Created on : 23/06/2023, 01:55:14 PM
    Author     : LZAMUDIO
--%>

<%@page import="Objetos.Exito"%>
<%@page import="Objetos.ErrorValueObject"%>
<%! Exito exito;%>
<%! ErrorValueObject error;%>

<%@include file="Encabezado.jsp"%>
        <%
         System.out.println("---------------------Cambio de Password JSP---------------------");


        //En este caso si recibe un mensaje de error, uno de exito o ninguno.
	error = (ErrorValueObject) request.getAttribute("error");
        exito = (Exito) request.getAttribute("exito");
	if( error != null)
	{%>
          
        <script>
        swal("<%out.print(error.getMensaje());%>", "<%out.print(error.getDescripcion());%>", "error");    
        </script>
        
       
	<%  if(error.getException()!=null){%>
         
        <script>
        swal("EXCEPTION", "<%out.print(error.getException().getCause());%>", "error");    
        swal("StackTrace", "<%out.print(error.getException().getCause());%>", "error");  
        </script>   
  
        <%     
          }
        } else if( exito != null){
        %>
         <script>
        swal("<%out.print(exito.getMensaje());%>", "<%out.print(exito.getDescripcion());%>", "success"); 
     <% System.out.println("Mensaje de exito" + exito.getMensaje() + exito.getDescripcion() );%>
        </script>
	<% }%>
        <style>
            <%--Contorno Formulario--%>
                .form-container {
                  border: 4px solid #008080;
                  padding: 20px;
                }
        </style>     
    <center><h1 class="mtr d-none d-sm-inline">Sistema de Facturación</h1></center>
    <hr class="hr1">
    <center><h2 class="mtr d-none d-sm-inline">Subgerencia de Ingresos.</h2></center>
    <br><br>
    <center><h3 style="color:#1D84A8;"><b> C A M B I O <span style="padding-left:40px;"> </span> <span class="d-none d-sm-inline"> D E  </span><span style="padding-left:40px;"> </span> P A S S W O R D </b></h3></center>
    <BR>
    <div class="form-container">
    <div class="row justify-content-center ">
        <div class="col-md-8">
            <div class="form-group row "><%--PANTALLA COMPLETA 12--%>
                <div class="col-sm-6">
                    <label for="Cve">Clave de usuario</label>
                    <input class="form-control" id="Cve" name="Cve" value="" placeholder="Clave de Usuario">
                </div> 
                <div class="col-sm-6">
                    <label for="PssA">Password</label>
                    <input class="form-control" id="PssA" name="PssA" value="" placeholder="Password">
                </div> 
            </div>
    </div></div>
    <div class="row justify-content-center ">
        <div class="col-md-11">
            <div class="form-group row "><%--PANTALLA COMPLETA 12--%>
                <div class="col-sm-4">
                    <label for="Nom">Nombre(s)</label>
                    <input class="form-control" id="Nom" name="Nom" value="" placeholder="Nombre(s)">
                </div> 
                <div class="col-sm-4">
                    <label for="AP">Apellido Paterno</label>
                    <input class="form-control" id="AP" name="AP" value="" placeholder="Apellido Paterno">
                </div> 
                <div class="col-sm-4">
                    <label for="AP">Apellido Materno</label>
                    <input class="form-control" id="AM" name="AM" value="" placeholder="Apellido Materno">
                </div> 
            </div>
        </div></div><br></div><br>
            <center>
                <button type="submit" title="Cambiar" class="btn btn-info btn-lg fs-6"  value="Cambiar" name="action">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                       <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
                   </svg> <span class="d-none d-sm-inline">Cambiar</span></button>
            </center>
        
        
<%@include file="Pie.jsp"%>