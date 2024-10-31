<%-- 
    Document   : DatosContrasena.jsp
    Created on : 7 may 2024, 14:03:13
    Author     : Lezly Oliván
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="DAO.dao_Area"%>
<%@ page import="java.util.List"%>
<%@page import="Objetos.obj_Area"%>
<%! obj_Area area;%>
<%! List<obj_Area> arealista;%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DATOS CONTRASEÑA</title>
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
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/Diseño/img/LogoAhora.png">
    </head>
    <style>


        /* Estilos para el checkbox cuando está marcado */
        .form-check-input:checked {
            background-color: #ff5000 !important;
            border-color: #ff5000 !important;
        }

        /* Estilos adicionales para el enfoque del checkbox */
        .form-check-input:focus {
            box-shadow: 0 0 0 0.25rem #ff5000 !important;
        }

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

        .selected>td {
            box-shadow: inset 0 0 0 9999px #00669C !important;
            color: #fff !important;
            background-color: #0056b3 !important;
        }

        .selected:hover>td {
            box-shadow: inset 0 0 0 9999px #00669C !important;
            color: #fff !important;
            background-color: #0056b3 !important;
        }
        .mdb-input > select:focus + .form-label,
        .mdb-input > select:valid + .form-label,
        .mdb-input > input:focus + .form-label,
        .mdb-input > input:valid + .form-label {
            color: #3b71ca;
            transform: translate(0px, -12px) scale(0.8);
            z-index: 2;
            padding: 0px 2px;
            margin: 0px 2px;
            background: linear-gradient(to bottom, transparent 0%, transparent 50%, white 50%, white 70%, transparent 70%, transparent 100%) !important;
        }

        .mdb-input > select:valid + .form-label,
        .mdb-input > input:valid + .form-label {
            color: #4f4f4f;
            transform: translate(0px, -12px) scale(0.8);
            z-index: 2;
        }

        .mdb-input > input:focus,
        .mdb-input > select:focus {
            color: #000;
            border: 2px solid #3b71ca !important;
            background-color: inherit !important
        }

        .mdb-input > input:valid,
        .mdb-input > select:valid {
            background-color: inherit !important;
        }

        .mdb-input > input,
        .mdb-input > select {
            position: absolute;
            outline: none;
            border: 1px solid #aaa8a8 !important;
            background: transparent;
            transition: 0.2s ease;
            z-index: 1;
            background-color: white !important;
        }

        .mdb-input > .form-label {
            left: 1em !important;
            top: 0.1em !important;
            position: absolute;
            color: #6B6C6C;
            transition: 0.2s ease;
            z-index: 2;
            background-color: white;
            background: linear-gradient(to bottom, transparent 0%, transparent 100%) !important;
        }

        .mdb-input > input:focus + .form-label,
        .mdb-input > select:focus + .form-label {
            color: #3b71ca !important; /* Color cuando está enfocado */
            transform: translate(0px, -12px) scale(0.8);
            z-index: 2;
            padding: 0px 2px;
            margin: 0px 2px;
            background: linear-gradient(to bottom, transparent 0%, transparent 50%, white 50%, white 70%, transparent 70%, transparent 100%) !important;
        }

        .mdb-input > select:focus + .form-label,
        .mdb-input > input:focus + .form-label {
            color: #3b71ca !important; /* Color cuando está enfocado */
        }
    </style>
</style>
<img src="../../../../../AppData/Local/Temp/F-LOGO.png" alt=""/>

<body class="d-flex align-items-center py-4 bg-body-tertiary text-center">
    <main class="vh-100 w-100">
        <form class="vh-100 w-100 stc" id="formulario" action="Srv_User" method="POST" class="text-center" style="font-size: 85%; margin: 15px;">
            <div class="container-fluid h-custom">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-md-9 col-lg-6 col-xl-5">
                        <img src="https://i.ibb.co/KNtcx43/Datos-CP-Fact.png" class="img-fluid"
                             alt="Sample image">
                    </div>
                    <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1 text-center">
                        <div
                            class="d-none d-lg-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                            <img class="imglogo" src="https://i.ibb.co/BT9774z/MI-Metro.png" alt="MISTC"
                                 style="height: 6em; margin-left: 4px; margin-right: 15px;">
                            <h5 class="fontcontenido stc">
                                GERENCIA DE FINANZAS
                                SISTEMA DE FACTURACIÓN
                            </h5>

                        </div>
                        <!--Mensajes-->
                        <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                        </div>
                        <div class="divider d-flex align-items-center my-3">
                        </div>
                        <p class="fs-6 small fontcontenido stc mb-2">
                            INGRESE LOS DATOS SOLICITADOS PARA CONTINUAR CON EL PROCESO DE CAMBIO DE CONTRASEÑA
                        </p>

                        <br>
                        <!-- User input -->
                        <div class="form-floating stc fontcontenido mb-1">
                            <input style="font-weight: bold;" class="form-control" id="usuario" name="txtUsuario" placeholder="USUARIO" required="">
                            <label for="floatingInput">NOMBRE DE USUARIO</label>
                        </div>

                        <br>
                        <!-- Area input -->

                        <%
                        dao_Area dao= null; 
                        dao=new dao_Area();
                        arealista=dao.Listar();
                        %>   
                        <div class="row mb-4">
                            <div class="col">
                                <div class="form-outline mdb-input">
                                    <select style="font-weight: bold;" data-mdb-select-init id="area" name="txtArea" class="form-select" aria-label="Default select example" style="font-size: 105%;" required>
                                        <option value="" disabled selected style="display: none;" ></option>
                                        <% 
            if (arealista != null && !arealista.isEmpty()) {
                for(int i = 0; i < arealista.size(); i++) {
                    area = arealista.get(i);
                                        %>  
                                        <option value="<% out.print(area.getIdArea());%>"><% out.print(area.getNombre_area());%></option>
                                        <% 
                                                }
                                            } else {
                                        %>
                                        <option value="" disabled>NO SE ENCONTRARON LAS ÁREAS A SELECCIONAR</option>
                                        <% 
                                            }
                                        %>         
                                    </select>
                                    <label class="form-label" for="txtNombre">ÁREA A LA QUE PERTENECE</label>

                                </div>
                            </div>
                        </div>


                        <div class="divider d-flex align-items-center my-4">
                        </div>
                        <div class="text-center text-lg-start mt-4 pt-2 stc">
                            <button type="submit" name="boton" value="verifica_datos" class="btn btn-lg" style="padding-left: 2.5rem; padding-right: 2.5rem; background-color: #FF5000; color: white;">
                                CAMBIO DE CONTRASEÑA
                            </button>

                            <!--
                            <a  href="CmbPass.jsp">
                            </a>
                            -->
                            <p class="small fw-bold mt-2 pt-1 mb-0 stc fonttext">VOLVER A
                                <br>
                                <a href="index.jsp" method="POST" class="link-danger">INICIO DE SESIÓN</a>
                            </p>

                            <br>
                            <br>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="Mensaje.jsp"%>

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
</html>
