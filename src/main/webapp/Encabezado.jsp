<%-- 
    Document   : Encabezado
    Created on : 16 feb 2024, 11:10:38
    Author     : Ing. Evelyn Leilani Avendaño 
    Author     : Lezly Oliván
--%>


<%@ page import="Objetos.obj_RepositorioImagenes" %>

<%
    // Crear una instancia de la clase de imágenes
    obj_RepositorioImagenes imagen = new obj_RepositorioImagenes();
    // Obtener la dirección de la imagen usando el método estático
    String inicio = imagen.getInicio();
    String logoConNombre = imagen.getLogoConNombre();
    String logoSinNombre = imagen.getLogoSinNombre();
    String perfil = imagen.getPerfil();
    String logoMovilidad = imagen.getLogoMovilidad();
    String fondo = imagen.getFondo();    
    String erroresGenerales = imagen.getErroresGenerales();   
%>

<%@ page import="java.io.*,java.util.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%
// Obtener la sesión actual o null si no existe
HttpSession sesionUsuario  = request.getSession(false);
// Verificar si la sesión existe y si hay un usuario en ella
if (sesionUsuario  != null && sesionUsuario .getAttribute("usuario") != null) {
    // La sesión y el usuario existen, no hacemos nada
    sesionUsuario.setMaxInactiveInterval(15 * 60);
} else {
    // No hay sesión o usuario en ella, redirigir al index.jsp
    response.sendRedirect("index.jsp");
}
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Facturación</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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
        <link rel="shortcut icon" href="<%=logoMovilidad%>">
        <script src="JS\customeMessage.js"></script>
    </head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body >
    <style>
        body {
            background-image: url(<%=fondo%>);
            background-size: cover;
        }
        .menuitem {
            font-size: 80%;
        }
        .menuop {
            font-size: 75%;
        }
        .nav-link:hover,
        .nav-link:focus,
        .nav-link.active {
            color: #FE5000;
            /* Cambia el color cuando se pasa el ratón, al hacer clic o cuando está activo */
        }
        /* Oculta la nueva imagen por defecto */
        #logo-nuevo {
            display: none;
        }

        /* Media query para mostrar la nueva imagen cuando el tamaño de la ventana sea menor de 1150px */
        @media (max-width: 1300px) {
            #logo {
                display: none; /* Oculta la imagen original */
            }
            #logo-nuevo {
                display: block; /* Muestra la nueva imagen */
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
            background-color: inherit !important;
        }

        .mdb-input > input:valid,
        .mdb-input > select:valid {
            background-color: inherit !important;
        }

        .mdb-input > input,
        .mdb-input > select {
            position: relative; /* changed from absolute to relative */
            outline: none;
            border: 1px solid #aaa8a8 !important;
            background: transparent;
            transition: 0.2s ease;
            z-index: 1;
            background-color: white !important;
            width: 100%; /* Ensure the input/select takes full width of the column */
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


        /*TABLA COLOR GRIS HASTA ARRIBA*/
        th{
            position: sticky;
            top: 0;
            z-index: 1;
            background-color: #DDDDDD !important;
            color:black;
        }
    </style>
    <header>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg bg-body fixed-top stc">
            <div class="container-fluid">
                <button
                    data-mdb-collapse-init
                    class="navbar-toggler"
                    type="button"
                    data-mdb-target="#navbarExample01"
                    aria-controls="navbarExample01"
                    aria-expanded="false"
                    aria-label="Toggle navigation">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarExample01">
                    <a class="navbar-brand" href="Srv_Controller?action=101">
                        <img
                            id="logo"
                            src="<%=logoConNombre%>"
                            height="45"
                            alt="Metro Logo"
                            />
                    </a>
                    <!-- Nueva imagen para pantallas pequeñas (menos de 1150px) -->
                    <a class="navbar-brand" href="Srv_Controller?action=101">
                        <img id="logo-nuevo" 
                             src="<%=logoSinNombre%>" 
                             height="45" 
                             alt="Nueva Logo" 
                             />
                    </a>
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 menuitem">
                        <li class="nav-item active">
                            <a class="nav-link" aria-current="page" href="Srv_Controller?action=101">Inicio</a>
                        </li>
                        <!-- Catálogos -->
                        <li class="nav-item dropdown">
                            <a
                                data-mdb-dropdown-init
                                class="nav-link dropdown-toggle"
                                href="#"
                                id="navbarDropdownMenuLink"
                                role="button"
                                aria-expanded="false"
                                >
                                Catálogos
                            </a>
                            <ul class="dropdown-menu menuop" aria-labelledby="navbarDropdownMenuLink">
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=201">CONCEPTOS</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=202">PERMISOS (PATRS)</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=203">DEPÓSITO BANCARIO</a>
                                </li>
                            </ul>
                        </li>
                        <!-- Catálogs SAT -->
                        <li class="nav-item dropdown">
                            <a
                                data-mdb-dropdown-init
                                class="nav-link dropdown-toggle"
                                href="#"
                                id="navbarDropdownMenuLink"
                                role="button"
                                aria-expanded="false"
                                >
                                CATÁLOGOS SAT
                            </a>
                            <ul class="dropdown-menu menuop" aria-labelledby="navbarDropdownMenuLink">
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=204">BANCOS</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=205">CLIENTES SAT</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=206">CÓDIGO POSTAL</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=208">FORMA PAGO</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=209">IMPUESTOS</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=210">MÉTODO PAGO</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=211">MONEDAS</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=212">OBJETO IMPUESTO</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=213">PAÍSES</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=214">PERIODICIDADES</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=215">PRODUCTOS Y SERVICIOS</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=216">REGIMEN FISCAL</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=207">TIPO COMPROBANTE</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=217">TIPO FACTOR</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=218">TIPO RELACIÓN</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=219">TIPO SERVICIO</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=220">UNIDAD DE MEDIDA</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=221">USO CFDI</a>
                                </li>
                            </ul>
                        </li>
                        <!-- Documentos -->
                        <li class="nav-item dropdown">
                            <a
                                data-mdb-dropdown-init
                                class="nav-link dropdown-toggle"
                                href="#"
                                id="navbarDropdownMenuLink"
                                role="button"
                                aria-expanded="false"
                                >
                                Documentos
                            </a>
                            <ul class="dropdown-menu menuop" aria-labelledby="navbarDropdownMenuLink">
                                <li>
                                    <a class="dropdown-item" method="POST"  href="Srv_Controller?action=222">MEMORÁNDUM GENERAL</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=223">MEMORÁNDUM ARRENDAMIENTO</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=224">FACTURACIÓN ELECTRÓNICA</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=225">FACTURACIÓN AUTOMÁTICA</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" method="POST" href="Srv_Controller?action=227">PAGOS</a>
                                </li>
                                <li>
                                    <a class="dropdown-item"  method="POST" href="Srv_Controller?action=228">CANCELAR FACTURAS</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="autorizaciones.jsp" data-mdb-ripple-init data-mdb-modal-init data-mdb-target="#myModal">Autorizaciones</a>
                        </li>
                        <!--  <li class="nav-item"> </li> -->
                        
                        <!-- CATALOGO ADMINISTRAR USUARIOS, el href debe ir redirigido al jsp correspondiente-->
                        <li class="nav-item">
                            <a class="nav-link" href="Admin/AdminUsuarios.jsp" >Administrar Usuarios</a>
                        </li>
                        <!---------------------------------------------------------------->
                        <li class="nav-item" id="timeset" hidden="true">
                            <div class="mx-5" style="color:red;font-size: 25px;">
                                <a id="minutes">15</a><a>:</a><a id="seconds">00</a>
                            </div>
                        </li>
                        <!-- Utilerias -->
                        <%--  <li class="nav-item dropdown">
                            <a
                                data-mdb-dropdown-init
                                class="nav-link dropdown-toggle"
                                href="#"
                                id="navbarDropdownMenuLink"
                                role="button"
                                aria-expanded="false"
                                >
                                Utilerías
                            </a>
                            <ul class="dropdown-menu menuop" aria-labelledby="navbarDropdownMenuLink">
                                <li>
                                    <a class="dropdown-item" href="copia_archivos.jsp">Copia de Archivos</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="cmb_pass.jsp">Cambio de Password</a>
                                </li>
                            </ul>
                        </li>
                        --%>
                    </ul>
                    <!-- Right elements hidden="false"  -->
                    <div class="d-flex align-items-center">
                        <!-- Notifications -->
                        <div class="dropdown">
                            <a
                                data-mdb-dropdown-init
                                class="nav-link dropdown-toggle hidden-arrow"
                                href="#"
                                id="navbarDropdownMenuLink"
                                role="button"
                                aria-expanded="false"
                                >
                                <i class="fas fa-user" style="font-size: 25px;"></i>
                                ${usuario.getUsuario()}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end menuop"
                                aria-labelledby="navbarDropdownMenuLink"
                                >
                                <li>
                                    <a class="dropdown-item" href="#" data-mdb-modal-init data-mdb-target="#exampleModal">PERFIL</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="#" data-mdb-modal-init data-mdb-target="#CmbPassword">CAMBIO DE CONTRASEÑA</a>
                                </li>
                                <li><hr class="dropdown-divider" /></li>
                                <li>
                                    <a class="dropdown-item" href="Srv_Salir">CERRAR SESIÓN</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- Right elements -->
                </div>
            </div>
        </nav>
        <br>
        <!-- Navbar -->
        <!-- Modal -->
        <div class="modal fade stc" id="myModal" data-mdb-backdrop="static" data-mdb-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true" style="font-size: 80%;">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">MÓDULO DE AUTORIZACIÓN DE FACTURAS</h5>
                        <button type="button" class="btn-close" data-mdb-ripple-init data-mdb-dismiss="modal" aria-label="Close" id="closeModalButton"></button>
                    </div>
                    <div class="modal-body">INGRESE LA CONTRASEÑA PARA PODER CONTINUAR</div>
                    <!-- Dentro de tu modal -->
                    <div class="modal-body">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="password" id="cnt" class="form-control"/>
                            <label class="form-label" for="cnt">CONTRASEÑA</label>
                        </div>
                        <!-- Mensaje de error oculto por defecto -->
                        <div id="errorMensaje" style="display: none; color: red; margin-top: 10px;">
                            CONTRASEÑA INCORRECTA
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="passwordSubmit" data-mdb-ripple-init>ENTRAR</button>
                    </div>
                </div>
            </div>
        </div>

        <style>
            .table-profile-th {
                padding: 4px 8px; /* Mantiene el padding reducido */
                font-weight: bold; /* Solo los encabezados en negrita */
                line-height: 1.1; /* Espaciado entre líneas reducido */
                color:black;
                background-color: white !important;
            }
            .table-profilet-td {
                padding: 4px 8px; /* Mantiene el padding reducido para las celdas de datos */
                font-weight: normal; /* Mantiene los datos en peso normal */
                line-height: 1.1; /* Espaciado entre líneas reducido */
                color:black;
                background-color: white !important;
            }
        </style>


        <!-- Modal Perfil -->
        <div class="modal top fade stc" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-mdb-backdrop="static" data-mdb-keyboard="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="exampleModalLabel">INFORMACIÓN DEL USUARIO</h4>
                        <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="font-size: 80%">
                        <div class="d-flex">
                            <!-- Columna para la imagen del usuario -->
                            <div class="flex-shrink-0">
                                <img src="<%=perfil%>" alt="Perfil del Usuario" class="img-fluid rounded-circle" style="width: 150px; height: 150px;">
                            </div>
                            <!-- Columna para la tabla de información -->
                            <div class="flex-grow-1 ms-3"> <!-- ms-3 proporciona un margen izquierdo -->
                                <br>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th class="table-profile-th" scope="row">USUARIO:</th>
                                            <td class="table-profilet-td">${usuario.getUsuario()}</td>
                                        </tr>
                                        <tr>
                                            <th class="table-profile-th" scope="row">NOMBRE:</th>
                                            <td class="table-profilet-td">${usuario.getNombre()}  ${usuario.getApellido_paterno()}</td>
                                        </tr>
                                        <tr>
                                            <th class="table-profile-th" scope="row">ÁREA:</th>
                                            <td class="table-profilet-td">${usuario.getArea()}</td>
                                        </tr>
                                        <tr>
                                            <th class="table-profile-th" scope="row">TIPO DE PERFIL:</th>
                                            <td class="table-profilet-td">${usuario.getPerfil()}</td>
                                        </tr>

                                        <!-- Agregar más filas según sea necesario -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Cambiar Contraseña -->
        <!-- Modal Cambiar Contraseña -->
        <div class="modal fade stc" id="CmbPassword" tabindex="-1" aria-labelledby="CmbPasswordLabel" aria-hidden="true" data-mdb-backdrop="static">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <form action="Srv_User" method="POST" id="CambioNuevaClave">
                        <div class="modal-header">
                            <h5 class="modal-title" id="CmbPasswordLabel">CAMBIAR CONTRASEÑA</h5>
                            <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" style="font-size: 80%">
                            <input type="text" style="font-weight: bold;" class="form-control" id="txtUsuarioCambio" name="txtUsuarioCambio"  required value="${usuario.getId()}" hidden>
                            <input type="text" style="font-weight: bold;" class="form-control" id="boton" name="boton" value="actualizar_clave" placeholder="Contraseña" hidden>
                            <!-- Input for Current Password -->
                            <div class="form-outline mb-4" data-mdb-input-init>
                                <input type="password" id="txtAnterior" name="txtAnterior" class="form-control" required/>
                                <label class="form-label" for="currentPassword">CONTRASEÑA ACTUAL</label>
                            </div>
                            <!-- Input for New Password -->
                            <div class="form-outline mb-4" data-mdb-input-init>
                                <input type="password" id="clave1" name="clave1" class="form-control" required/>
                                <label class="form-label" for="newPassword">NUEVA CONTRASEÑA</label>
                            </div>
                            <!-- Input for Confirm New Password -->
                            <div class="form-outline mb-4" data-mdb-input-init>
                                <input type="password" id="password" name="txtPassword" class="form-control" required/>
                                <label class="form-label" for="confirmNewPassword">CONFIRMAR NUEVA CONTRASEÑA</label>
                            </div>


                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary" onclick="vrfCnt(event)">GUARDAR CAMBIOS</button>
                        </div>
                    </form>

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
                                document.getElementById("CambioNuevaClave").submit();
                            }
                        }
                    </script>
                </div>
            </div>
        </div>
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

        <div class="alert alert-danger alert-dismissible fade show" role="alert" id="RecordatorioMensaje" 
             style="display:none; top:10%; left:50%; transform: translate(-50%, 0); z-index: 1050; position: fixed; width: auto; max-width: 90%; padding: 15px; box-sizing: border-box;">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="position: absolute; top: 10px; right: 10px;color:inherit;background-color: transparent;border: none;">
                <span aria-hidden="true" style="color:black;">&times;</span>
            </button>
            <h6><strong>¡Recordatorio!</strong> <br> Tienes que realizar una acción para que no se cierre la sesión</h6>
        </div>


        <script>
            // Variables para almacenar temporizadores
            let inactivityTimer;
            let reminderTimer;

            // Función para reiniciar los temporizadores de inactividad
            function resetTimers() {
                clearTimeout(inactivityTimer);
                clearTimeout(reminderTimer);

                // Configura el temporizador de inactividad de 1 minuto
                inactivityTimer = setTimeout(showReminder, 10 * 60 * 1000);
            }

            // Función para mostrar el recordatorio y configurar el temporizador para redirigir
            function showReminder() {
                // Mostrar un recordatorio al usuario
                document.getElementById('RecordatorioMensaje').style.display = 'block';

                // Configura el temporizador para redirigir después de 0.5 minutos
                reminderTimer = setTimeout(() => {
                    window.location.href = "Srv_Salir";
                }, 3 * 60 * 1000);
            }

            // Función para ocultar el recordatorio cuando se cierra manualmente
            function hideReminder() {
                document.getElementById('RecordatorioMensaje').style.display = 'none';
                clearTimeout(reminderTimer); // Cancelar el temporizador de redirección
            }

            // Agregar event listeners para detectar actividad del ratón y teclado
            window.addEventListener('mousemove', resetTimers);
            window.addEventListener('keydown', resetTimers);

            // Agregar un event listener para el botón de cierre de la alerta
            document.querySelector('.close').addEventListener('click', hideReminder);

            // Iniciar los temporizadores cuando se carga la página
            resetTimers();
        </script>

        <script>
            document.addEventListener('keydown', function (event) {
                if (event.key === 'Enter') {
                    event.preventDefault(); // Evita el comportamiento predeterminado (enviar el formulario, por ejemplo)
                }
            });
        </script>

        <script type="text/javascript">
            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('passwordSubmit').addEventListener('click', function () {
                    var password = document.getElementById('cnt').value; // Obtiene el valor ingresado en el campo de contraseña
                    if (password === 'qwerty' || password === 'QWERTY') {
                        // Si la contraseña es correcta, redirige a autorizaciones.jsp
                        document.getElementById('errorMensaje').style.display = 'none';
                        window.location.href = 'Srv_Controller?action=226';
                    } else {
                        // Si la contraseña es incorrecta, muestra el mensaje de error
                        document.getElementById('errorMensaje').style.display = 'block';
                    }
                });

                // Escuchar el evento de clic en los botones de cerrar para esconder el mensaje de error y cerrar el modal
                ['closeModalButton', 'closeModalButton1'].forEach(function (buttonId) {
                    let button = document.getElementById(buttonId);
                    if (button) {
                        button.addEventListener('click', function () {
                            let errorMensaje = document.getElementById('errorMensaje');
                            if (errorMensaje) {
                                errorMensaje.style.display = 'none'; // Esconde el mensaje de error al intentar cerrar
                            }
                        });
                    } else {
                        console.warn(`El elemento con ID '${buttonId}' no se encontró en el DOM.`);
                    }
                });
           });
</script>



