<%-- 
    Document   : JSP_CAccesos
    Created on : 14/06/2023, 11:55:36 AM
    Author     : Serv_Social
--%>
<%@page import="Objetos.Exito"%>
<%@page import="Objetos.ErrorValueObject"%>
<%! Exito exito;%>
<%! ErrorValueObject error;%>

<%@include file="Encabezado.jsp"%>
        <%
         System.out.println("---------------------Control de Accesos JSP---------------------");
        //Recibe los atributos si es que hay, dependiendo de lo que realice el SERVLET CodigoPostal.
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
.form-container {
  border: 2px solid #254E89;
  padding: 20px;
}

</style>
<center><h2 class="mtr d-none d-sm-inline">SISTEMA DE FACTURACIÓN</h2></center>
<hr class="hr1">
    <center><h3 class="mtr d-none d-sm-inline">SUBGERENCIA DE INGRESOS</h3></center>
    <br><br>
        <!-- Nav tabs -->
<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="control-tab" data-bs-toggle="tab" data-bs-target="#control" type="button" role="tab" aria-controls="home" aria-selected="true">Control de Accesos</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="reporte-tab" data-bs-toggle="tab" data-bs-target="#reporte" type="button" role="tab" aria-controls="profile" aria-selected="false">Reporte por Usuario</button>
  </li>
</ul>

<!-- Tab panes -->
<div class="tab-content">
  <section class="tab-pane active" id="control" role="tabpanel" aria-labelledby="control-tab"><br>
  <form style="font-size: 16px;">
    <div class="row justify-content-center ">
        <div class="col-md-12">
            <h3 style="font-weight: bold;">Datos generales</h3>
            <div class="form-container">
            <div class="form-group row">
                <div class="col-sm-3">
                    <label for="clave">Clave de usuario</label>
                    <input class="form-control" type="text" name="clave" id="clave">
                </div>
                <div class="col-sm-3">
                    <label for="pass">Password</label>
                    <input class="form-control" type="password" name="pass" id="pass">
                </div>
                <div class="col-sm-2">
                    <label for="nom">Nombre</label>
                    <input class="form-control" type="text" name="nom" id="nom">
                </div>
                <div class="col-sm-2">
                    <label for="pat">Paterno</label>
                    <input class="form-control" type="text" name="pat" id="pat">
                </div>
                <div class="col-sm-2">
                    <label for="mat">Materno</label>
                    <input class="form-control" type="text" name="mat" id="mat">
                </div>
                </div>
            </div>
        </div>
    </div><br>
    <div class="row justify-content-center">
        <h3 style="font-weight: bold;">Permisos asignados</h3>
        <div class="col">
            <div class="form-container ">
                <div class="form-group row">
                    <p style="text-indent: 10px;"><label for="cat"><input type="checkbox" name="cat" id="cat"> CATALOGOS</label> </p>
                </div>
                <div class="form-group row">
                    <label style=" text-indent: 30px;" for="cli"><input type="checkbox" name="cli" id="cli"> Clientes</label>
                </div>
                <div class="form-group row">
                    <label style=" text-indent: 55px;" for="acli"><input type="checkbox" name="acli" id="acli"> Altas</label>
                </div>
                <div class="form-group row">
                    <label style=" text-indent: 55px;" for="ccli"><input type="checkbox" name="ccli" id="ccli"> Cambios</label>
                </div>
                <div class="form-group row">
                    <label style=" text-indent: 30px;" for="con"><input type="checkbox" name="con" id="con"> Conceptos</label>
                </div>
                <div class="form-group row">
                    <label style=" text-indent: 55px;" for="acon"><input type="checkbox" name="acon" id="acon"> Altas</label>
                </div>
                <div class="form-group row">
                    <label style=" text-indent: 55px;" for="ccon"><input type="checkbox" name="ccon" id="ccon"> Cambios</label>
                </div>
                 <div class="form-group row">
                    <label style=" text-indent: 30px;" for="cass"><input type="checkbox" name="cass" id="cass"> Control de accesos</label>
                </div>
                <div class="form-group row">
                    <label style=" text-indent: 55px;" for="acass"><input type="checkbox" name="acass" id="acass"> Altas</label>
                </div>
                <div class="form-group row">
                    <label style=" text-indent: 55px;" for="ccass"><input type="checkbox" name="ccass" id="ccass"> Cambios</label>
                </div>
                <div class="form-group row">
                    <label style=" text-indent: 55px;" for="rcass"><input type="checkbox" name="rcass" id="rcass"> Reporte</label>
                </div>
            </div>
	</div>

	<div class=" col-6">
            <div class="form-container">
                <div class="form-group row">
                    <p style="text-indent: 10px;"><label for="doc"><input type="checkbox" name="doc" id="doc"> DOCUMENTOS</label> </p>
                </div>
                <div class="form-group row"><%--FILA COMPLETA--%>
                        <div class="col-sm-6">
                        <label style="text-indent: 30px;" for="mmg"><input type="checkbox" name="mmg" id="mmg"> Memorandums Generales</label> 
                        </div>
                        <div class="col-sm-6">
                       <label style="text-indent: 30px;" for="cfac"><input type="checkbox" name="cfac" id="cfac"> Cancelación de Facturas</label>
                        </div>
                    </div>
                    <div class="form-group row"><%--FILA COMPLETA--%>
                        <div class="col-sm-6">
                            <label style=" text-indent: 55px;" for="ammg"><input type="checkbox" name="ammg" id="ammg"> Altas</label>
                        </div>
                        <div class="col-sm-6">
                        <label style=" text-indent: 55px;" for="ccfac"><input type="checkbox" name="ccfac" id="ccfac"> Cancelación de Facturas</label>
                        </div>
                    </div>
                    <div class="form-group row"><%--FILA COMPLETA--%>
                        <div class="col-sm-6">
                            <label style=" text-indent: 55px;" for="mommg"><input type="checkbox" name="mommg" id="mommg"> Modificación</label>
                        </div>
                        <div class="col-sm-6">
                            <label style=" text-indent: 55px;" for="rcfac"><input type="checkbox" name="rcfac" id="rcfac"> Reporte Facturas Canceladas</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-6">
                        <label style=" text-indent: 55px;" for="cmmg"><input type="checkbox" name="cmmg" id="cmmg"> Cancelación</label>
                        </div>
                        <div class="col-sm-6">
                        <label style=" text-indent: 30px;" for="rface"><input type="checkbox" name="rface" id="rface"> Registro Facturas Entregadas</label>
                        </div>
                    </div>   
                    <div class="form-group row">
                        <div class="col-sm-6">
                            <label style=" text-indent: 55px;" for="immg"><input type="checkbox" name="immg" id="immg"> Impresión</label>
                        </div>
                        <div class="col-sm-6">
                            <label style=" text-indent: 55px;" for="rfacfc"><input type="checkbox" name="rfacfc" id="rfacfc"> Fecha de Cancelación</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-6">
                            <label style=" text-indent: 55px;" for="rmmg"><input type="checkbox" name="rmmg" id="rmmg"> Reporte de memorandums</label>
                        </div>
                        <div class="col-sm-6">
                             <label style=" text-indent: 55px;" for="rpface"><input type="checkbox" name="rpface" id="rpface"> Reporte de Facturas Entregadas</label>
                        </div>
                    </div> 
                    <div class="form-group row">
                        <label style=" text-indent: 30px;" for="marr"><input type="checkbox" name="marr" id="marr"> Memorandums Arrendamientos</label>    
                    </div>
                    <div class="form-group row">
                        <label style=" text-indent: 55px;" for="marr"><input type="checkbox" name="marr" id="marr"> Alta</label>    
                    </div>
                    <div class="form-group row">
                        <label style=" text-indent: 55px;" for="mmarr"><input type="checkbox" name="mmarr" id="mmarr"> Modificación</label>    
                    </div>
                    <div class="form-group row">
                        <label style=" text-indent: 55px;" for="imarr"><input type="checkbox" name="imarr" id="imarr"> Impresión de Facturas</label>    
                    </div>
                    <div class="form-group row">
                        <label style=" text-indent: 55px;" for="rmarr"><input type="checkbox" name="rmarr" id="rmarr"> Reporte de facturas</label>    
                    </div>
                    <div class="form-group row">
                        <label style=" text-indent: 30px;" for="ncr"><input type="checkbox" name="ncr" id="ncr"> Notas de Crédito</label>    
                    </div>
                    <div class="form-group row">
                        <label style=" text-indent: 55px;" for="ancr"><input type="checkbox" name="ancr" id="ancr"> Alta</label>    
                    </div>
                    <div class="form-group row">
                        <label style=" text-indent: 55px;" for="mncr"><input type="checkbox" name="mncr" id="mncr"> Modificación</label>    
                    </div>
                    <div class="form-group row">
                        <label style=" text-indent: 55px;" for="incr"><input type="checkbox" name="incr" id="incr"> Impresión de Notas de Crédito</label>    
                    </div>

                    <div class="form-group row">
                        <label style=" text-indent: 55px;" for="cncr"><input type="checkbox" name="cncr" id="cncr"> Captura de Observaciones</label>    
                    </div>
                    <div class="form-group row">
                        <label style=" text-indent: 55px;" for="rncr"><input type="checkbox" name="rncr" id="rncr"> Reporte de Notas de Crédito</label>    
                    </div>    
                </div>
            </div>

        
	<div class="col">
            <div class="form-container">
                <div class="form-group row">
                    <p style="text-indent: 10px;"><label for="aut"><input type="checkbox" name="aut" id="aut"> AUTORIZACIONES</label> </p>
                </div>
                <div class="form-group row">
                       <label style="text-indent: 30px;" for="aaut"><input type="checkbox" name="aaut" id="aaut"> Autorizaciones</label>
                </div>
            </div>  <br>  
            <div class="form-container">    
                <div class="form-group row">
                    <p style="text-indent: 10px;"><label for="uti"><input type="checkbox" name="uti" id="uti"> UTILERIAS</label> </p>
                </div>
                <div class="form-group row">
                       <label style="text-indent: 30px;" for="carch"><input type="checkbox" name="carch" id="carch"> Copia de archivos</label>
                </div>
                <div class="form-group row">
                       <label style="text-indent: 30px;" for="cpss"><input type="checkbox" name="cpss" id="cpss"> Cambio de password</label>
                </div>
            </div>
        </div>

    </div>
  
        
                        <br>
<center>
<%--En la parte de los botones se definirá un mismo nombre para que entre a un IF en el servlet
El if realizará la función correspondiente según el valor (Nombre de lo que va a realizar) que reciba
--%>           
        <button type="submit" title="Guardar" class="btn btn-success btn-lg fs-6" value="Guardar" name="action">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-save-fill" viewBox="0 0 16 16">
        <path d="M8.5 1.5A1.5 1.5 0 0 1 10 0h4a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h6c-.314.418-.5.937-.5 1.5v7.793L4.854 6.646a.5.5 0 1 0-.708.708l3.5 3.5a.5.5 0 0 0 .708 0l3.5-3.5a.5.5 0 0 0-.708-.708L8.5 9.293V1.5z"/>
        </svg> <span class="d-none d-sm-inline">Guardar</span></button>
            
        <button type="submit" title="Buscar" class="btn btn-info btn-lg fs-6"  value="Buscar" name="action">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
        <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
        </svg> <span class="d-none d-sm-inline">Buscar</span></button>

        <button type="reset" title="Limpiar" class="btn btn-dark btn-lg fs-6" value="Limpiar" name="action">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right-square-fill" viewBox="0 0 16 16">
        <path d="M0 14a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v12zm4.5-6.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5a.5.5 0 0 1 0-1z"/>
        </svg> <span class="d-none d-sm-inline">Limpiar</span></button>
        
   </center>     
 </form>   
  </section>
        
        
  <section class="tab-pane" id="reporte" role="tabpanel" aria-labelledby="reporte-tab"><br>
  <form style="font-size: 18px;">
<div class="row justify-content-center ">
    <br>
        <div class="col-md-8">
            <h3 style="font-weight: bold;">Reporte por usuario</h3><br>
            <div class="form-container">
                <div class="form-group row">
                   <label for="TRep">Tipo de Reporte</label>
                    <select class="form-control" name="TRep" id="TRep" style="height:55%;" required>
                        <option>Reporte1</option>
                        <option>Reporte2</option>
                        <option>Reporte3</option>
                        <option>Reporte4</option>
                        <option>Reporte5</option>
                    </select>    
                </div>
                <div class="form-group row">
                    <label for="CUs">Clave de usuario</label>
                       <input type="text" class="form-control" id="CUs" name="CUs" required>
                </div>
            </div>
        </div>
</div>   
                        <br>
<center>
<%--En la parte de los botones se definirá un mismo nombre para que entre a un IF en el servlet
El if realizará la función correspondiente según el valor (Nombre de lo que va a realizar) que reciba
--%>           
        <button type="submit" title="Guardar" class="btn btn-success btn-lg fs-6" value="Guardar" name="action">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-save-fill" viewBox="0 0 16 16">
        <path d="M8.5 1.5A1.5 1.5 0 0 1 10 0h4a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h6c-.314.418-.5.937-.5 1.5v7.793L4.854 6.646a.5.5 0 1 0-.708.708l3.5 3.5a.5.5 0 0 0 .708 0l3.5-3.5a.5.5 0 0 0-.708-.708L8.5 9.293V1.5z"/>
        </svg> <span class="d-none d-sm-inline">Guardar</span></button>
            
        <button type="submit" title="Buscar" class="btn btn-info btn-lg fs-6"  value="Buscar" name="action">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
        <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
        </svg> <span class="d-none d-sm-inline">Buscar</span></button>

        <button type="reset" title="Limpiar" class="btn btn-dark btn-lg fs-6" value="Limpiar" name="action">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right-square-fill" viewBox="0 0 16 16">
        <path d="M0 14a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v12zm4.5-6.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5a.5.5 0 0 1 0-1z"/>
        </svg> <span class="d-none d-sm-inline">Limpiar</span></button>
        
   </center>          
 </form>  
  </section>
</div>
  

<script  type="text/javascript">




</script>

                    
<%@include file="Pie.jsp"%>