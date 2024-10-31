<%-- 
    Document   : JSP_Perfil
    Created on : 1/09/2023, 10:43:53 AM
    Author     : LZAMUDIO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Objetos.Usuario"%>
<%! Usuario usr2;%>


<%@include file="Encabezado.jsp"%>
<% usr2= (Usuario) session.getAttribute("usuario");
    if(usr2==null){
        request.getSession().removeAttribute("usuario");
        RequestDispatcher rd= request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);
        return;
        }
%>
<h2 class="text-center"> Bienvenid@ <span style="color:orange;"> <%out.print(usr2.getNombre());%> </span></h2>
<br>
<div class="text-center"><svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
</svg></div>

<br><br>
<h4 class="text-center"> Información de usuario: <span style="color:orange;"> <%out.print(usr2.getNombre());%> </span></h4>
<br>
<div class="d-flex justify-content-center">
<form class="row g-3" style="width: 80%;align-content: center;">
    <div class="col-md-12">
    <label for="usr" class="form-label">Usuario</label>
    <input class="form-control" id="usr" value="<%out.print(usr2.getUsuario());%>" disabled="true">
  </div>
  <div class="col-md-4">
    <label for="nmb" class="form-label">Nombre</label>
    <input class="form-control" id="nmb" value="<%out.print(usr2.getNombre());%>" disabled="true">
  </div>
  <div class="col-md-4">
    <label for="apat" class="form-label">Apellido Paterno</label>
    <input class="form-control" id="apat" value="<%out.print(usr2.getAPaterno());%>" disabled="true">
  </div>
  <div class="col-md-4">
    <label for="amat" class="form-label">Apellido Materno</label>
    <input class="form-control" id="amat" value="<%out.print(usr2.getAMaterno());%>" disabled="true">
  </div>

    
    
    
</form>
  </div>

<%@include file="Pie.jsp"%>