<%-- 
    Document   : index
    Created on : 11/04/2023, 12:23:59 PM
    Author     : Ing. Evelyn Leilani Avendaño 
    Created on : 21 feb 2024, 12:20:50
    Author     : Lezly Oliván
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Objetos.obj_RepositorioImagenes" %>
<%
    // Crear una instancia de la clase de imágenes
    obj_RepositorioImagenes imagen = new obj_RepositorioImagenes();
    // Obtener la dirección de la imagen usando el método estático
    String logo = imagen.getLogo();
    String logoMovilidad = imagen.getLogoMovilidad();
    String logoSinNombre= imagen.getLogoSinNombre();
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Facturación</title>
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
    <body class="d-flex align-items-center py-4 bg-body-tertiary text-center">
        <main class="vh-100 w-100">
            <form class="vh-100 w-100" id="formulario" action="Srv_User" method="POST" class="text-center">
                <div class="container-fluid h-custom">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-md-9 col-lg-6 col-xl-5">
                            <img src="<%= logo %>" class="img-fluid" alt="Logo Facturación">
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
                            <p class="fontcontenido stc small mb-3 mt-1" style="color:blue;">
                                LA SESIÓN CADUCARÁ DESPUÉS DE 15 MINUTOS DE INACTIVIDAD
                            </p>

                            <!-- User input -->
                            <div class="form-floating fontcontenido">
                                <input style="font-weight: bold;text-transform: uppercase;" class="form-control fontformulario"  id="usuario" name="txtUsuario" placeholder="USUARIO" required="" onblur="this.value = this.value.trim()">
                                <label for="floatingInput" class="stc">USUARIO</label>
                            </div>

                            <br>

                            <!-- Password input -->
                            <div class="form-floating fontcontenido">
                                <input style="font-weight: bold;" type="password" class="form-control fontformulario" id="password" name="txtPassword" placeholder="CONTRASEÑA" required="" onblur="this.value = this.value.trim()">
                                <label for="floatingPassword" class="stc">CONTRASEÑA</label>
                            </div>
                            <div class="divider d-flex align-items-center my-1 d-none">
                            </div>
                            <div class="text-center text-lg-start mt-4 pt-2 stc">
                                <button type="submit" name="boton" value="inicio_sesion" class="btn btn-lg" style="padding-left: 2.5rem; padding-right: 2.5rem; background-color: #ff5000; color: white;">
                                    Iniciar Sesión
                                </button>

                                <br>
                                <br>
                            </div>
                        </div>
                    </div>
                </div>
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

        <%@include file="Mensaje.jsp"%>


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
        <script>
                                    window.onload = function () {
                                        // Borrar los valores de los campos del formulario
                                        document.getElementById("formulario").reset();
                                    };
                                    history.forward();

                                    function trimInput(input) {
                                        input.value = input.value.trim();
                                    }
        </script> 
    </body>

</html>