<%-- 
    Document   : Cambio_Primera_Vez
    Created on : 25 oct 2024, 18:37:36
    Author     : Ing. Evelyn Leilani Avendaño 
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="Objetos.obj_RepositorioImagenes" %>
<%
    // Crear una instancia de la clase de imágenes
    obj_RepositorioImagenes imagen = new obj_RepositorioImagenes();
    // Obtener la dirección de la imagen usando el método estático
    String logo = imagen.getLogo();
    String logoMovilidad = imagen.getLogoMovilidad();
    String logoSinNombre= imagen.getLogoSinNombre();
    String cambioClave= imagen.getCambioClave();
    String cambioClavePredeterminada= imagen.getCambioClavePredeterminada();
%>

<%
String usuario = (String) request.getAttribute("usuario");
if (usuario != null) {
    System.out.println("Sí existe la información del usuario");
} else {
    System.out.println("No existe la información del usuario");
    response.sendRedirect("index.jsp");
}
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CAMBIO CONTRASEÑA</title>
        <!--Bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <!-- TIPOGRAFIA LINK METRO -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Abel&family=Jost:wght@300&family=Jura:wght@300&family=Metrophobic&family=Montserrat:wght@300&family=Nunito+Sans:opsz@6..12&family=Saira:wght@100;500&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="W">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.1.0/mdb.min.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Diseño/CSS/login.css">
        <link rel="shortcut icon" href="<%= logoMovilidad %>">
        <script src="JS\customeMessage.js"></script>
    </head>
    <style>
        input:focus {
            border-color: #ff5000 !important;
            /* Color naranja */
            box-shadow: 0 0 0 0.2rem #ff5000 !important;
            /* Efecto de sombra opcional */
        }

        /* Estilos para el checkbox cuando está marcado */
        .form-check-input:checked {
            background-color: #ff5000 !important;
            border-color: #ff5000 !important;
        }

        /* Estilos adicionales para el enfoque del checkbox */
        .form-check-input:focus {
            box-shadow: 0 0 0 0.25rem #ff5000 !important;
        }
    </style>
    <style>
        .divider:after,
        .divider:before {
            content: "";
            flex: 1;
            height: 1px;
            background: #eee;
        }

        .h-custom {
            height: calc(100% - 73px);
        }

        .custom-btn {
            background-color: #ff5000;
            color: white;
        }

        @media (max-width: 450px) {
            .h-custom {
                height: 50%;
            }
        }
    </style>

    <body oncopy="return false" onpaste="return false" class="d-flex align-items-center py-4 bg-body-tertiary text-center">
        <main class="vh-100 w-100">
            <form class="vh-100 w-100" id="formulario" action="Srv_CambioClave" method="POST" class="text-center">
                <div class="container-fluid h-custom">
                    <div class="alert alert-primary  fw-bold " role="alert" style="z-index: 100;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-exclamation-circle fw-bold" viewBox="0 0 16 16">
                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                        <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0M7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0z"/>
                        </svg>  LAS CONTRASEÑAS DE LOS USUARIOS SON CIFRADAS PARA GARANTIZAR SU SEGURIDAD. ESTE PROCESO LAS CONVIERTE EN UN FORMATO IRRECONOCIBLE, IMPIDIENDO EL ACCESO A SU FORMA ORIGINAL. 
                    </div>
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-md-9 col-lg-6 col-xl-5">
                            <img src="<%= cambioClavePredeterminada %>" width="450" height="450" class="img-fluid"
                                 alt="Sample image">
                        </div>
                        <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1 text-center">
                            <div
                                class="d-none d-lg-flex flex-row mb-0 align-items-center justify-content-center justify-content-lg-start">
                                <img class="imglogo" src="<%= logoSinNombre %>" alt="MISTC"
                                     style="height: 4em; margin-left: 4px; margin-right: 15px;">
                                <h6 class="fontcontenido stc fw-bold">
                                    GERENCIA DE RECURSOS FINANCIEROS<br>
                                    SISTEMA DE FACTURACIÓN
                                </h6>
                            </div>
                            <div class="divider d-flex align-items-center my-4">
                            </div>
                            <p class="fw-bold mb-3 mt-1" style="color: #0452c8;">
                                ES NECESARIO QUE CREÉ SU CONTRASEÑA. POR FAVOR, ACTUALÍZELA AHORA.
                            </p>
                            <br>
                            <input type="text" style="font-weight: bold;" class="form-control" id="txtUsuarioCambio" name="txtUsuario" placeholder="Usuario" required value="<%=usuario%>" hidden>
                            <input type="text" style="font-weight: bold;" class="form-control" id="botonn" name="action" value="reset_clave"  hidden>
                            <!-- Pss input -->
                            <div class="form-floating stc fontcontenido">
                                <input type="password" class="form-control" id="clave1" name="clave1" required="">
                                <label for="floatingInput">NUEVA CONTRASEÑA</label>
                            </div>
                            <br>
                            <!-- CPss input -->
                            <div class="form-floating stc fontcontenido">
                                <input type="password" class="form-control" id="password" name="txtPassword" required="">
                                <label for="floatingPassword">CONFIRME SU NUEVA CONTRASEÑA</label>
                            </div>
                            <div class="divider d-flex align-items-center my-4"></div>
                            <div class="text-center text-lg-start mt-4 pt-2 stc">
                                <button type="submit" id="boton123" name="boton123" value="" class="btn btn-lg" style="padding-left: 2.5rem; padding-right: 2.5rem; background-color: #FF5000; color: white;" onclick="vrfCnt(event)">
                                    CAMBIAR CONTRASEÑA
                                </button>
                                <br>
                                <br>
                            </div>

                        </div>
                    </div>
                </div>
                <script>
                    function vrfCnt(event) {
                        event.preventDefault();
                        var cnt1 = document.getElementById("clave1").value;
                        var cnt2 = document.getElementById("password").value;
                        if (cnt2 === '' || cnt1 === '') {
                            customeError("ERROR", "INGRESAR VALOR FALTANTE");
                        } else if (cnt2 !== cnt1) {
                            customeError("ERROR", "LAS CONTRASEÑAS NO COINCIDEN");
                        } else {
                            // Envía el formulario
                            document.getElementById("formulario").submit();
                        }
                    }

                </script><br>
                <div class="d-none d-lg-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg"
                     style="background-color: #ff5000; color: white;">
                    <!-- Copyright -->
                    <div class="text-white mb-3 mb-md-0 stc">
                        STC © 2024.
                    </div>
                    <!-- Copyright -->

                    <!-- Right -->
                    <div class="text-white mb-3 mb-md-0 fontmsg stc">
                        PARA CUALQUIER DUDA O ACLARACIÓN, FAVOR DE COMUNICARSE A LA GERENCIA DE ORGANIZACIÓN Y SISTEMAS (GOS).
                    </div>
                    <!-- Right -->

                </div>
            </form>
        </main>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
        <!-- MDB -->
        <script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.1.0/mdb.umd.min.js"></script>
    </body>
    <div class="alert fade alert-fixed alert-danger show text-center stc" id="customAlert"
         style="display:none; width: 30%; top:5%; right: 10px; left: 50%;
         transform: translate(-50%); position: fixed;">
        <h5>
            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-exclamation-circle" viewBox="0 0 16 16">
            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
            <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>
            </svg>&nbsp;&nbsp;
            <span id="alertMessage"></span>
        </h5>
        <p id="alertDescription"></p>
    </div>
</html>
