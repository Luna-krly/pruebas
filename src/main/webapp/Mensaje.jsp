<%-- 
    Document   : Mensaje
    Created on : 16 may 2024, 16:26:09
    Author     : Ing. Evelyn Leilani Avendaño 
--%>

<%@page import="Objetos.obj_Mensaje"%>
<%! obj_Mensaje mensaje;%>

<%--MENSAJE DE ERROR SI ES QUE HAY--%>
<%
    mensaje = (obj_Mensaje) session.getAttribute("mensaje");
    // Si no hay mensaje en la sesión, intenta obtenerlo del request
    if (mensaje == null) {
        mensaje = (obj_Mensaje) request.getAttribute("mensaje");
    }

    // Si hay un mensaje, mostrarlo y eliminarlo de la sesión
    if (mensaje != null) {
    System.out.println("Hay un mensaje en mensaje.jsp");
      // session.removeAttribute("mensaje");
    if(mensaje.getTipo() == false ){ //ERROR
%>

<div class="alert fade alert-fixed alert-danger show text-center stc" id="myAlert"
     style="display:block; width: 30%; top:5%; right: 10px; left: 50%;
     transform: translate(-50%); position: fixed;">
    <h5><svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-exclamation-circle" viewBox="0 0 16 16">
            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
            <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>
        </svg>&nbsp;&nbsp; <%out.print(mensaje.getMensaje());%></h5>
        <%out.print(mensaje.getDescripcion());%>

</div>
<%

    } else{

%>
<div class="alert fade alert-fixed alert-success show text-center stc" id="myAlert"
     style="display:block; width: 30%; top:5%; right: 10px; left: 50%;
     transform: translate(-50%); position: fixed;">
    <h5><svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
            <path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"/>
            <path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"/>
        </svg>
        &nbsp;&nbsp; <%out.print(mensaje.getMensaje());%></h5>
        <%out.print(mensaje.getDescripcion());%>
</div>
<%}%>
<%session.removeAttribute("mensaje");}%>

<script>
//***************************************FUNCION PARA MENSAJES 
// Espera a que se cargue completamente el DOM antes de ejecutar el script
    document.addEventListener("DOMContentLoaded", function () {
        console.log(document.querySelector("#myAlert"), "aaaaaaaaaaaaaaa");
        // Cerrar la alerta después de 3.5 segundos
        setTimeout(function () {
            let alerta = document.querySelector("#myAlert");
            if (alerta) {
                alerta.style.display = "none";
            }
        }, 3500);
    });
//********************************************

</script>