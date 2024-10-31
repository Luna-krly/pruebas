<%-- 
    Document   : permisos
    Created on : 8/05/2023, 12:17:38 PM
    Author     : Lezly Oliván
    Author     : Ing. Evelyn Leilani Avendaño 
--%>
<%@page import="java.util.List"%>
<%@page import="DAO.dao_CltSat"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../Encabezado.jsp"%>

<%
    System.out.println("---------------------PERMISOS JSP---------------------");
%>

<style>
    .centrado-verticalmente {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }

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

    /* Pantallas grandes */
    @media (min-width: 576px) {
        .d-block {
            display: block !important;
        }

        .d-sm-none {
            display: none !important;
        }
    }

    /* Pantallas pequeñas */
    @media (max-width: 575.98px) {
        .d-block {
            display: none !important;
        }

        .d-sm-none {
            display: block !important;
        }

        .btn-text {
            display: none;
        }
    }

    input, textarea{
        text-transform: uppercase;
    }
</style>
<head>
    <script src="JS\customeMessage.js"></script>
</head>
<!-- Cuerpo -->
<main class="col ps-md-2 pt-2 mx-3">
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <div class="page-header pt-3 stc">
        <h3>CATÁLOGO DE PERMISOS (PATRS)</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
    <form id="formulario" action="Srv_Permisos" method="POST" class="fontformulario" style="font-size: 80%; margin: 15px;">
        <!-- 2 column grid layout with text inputs for the first and last names -->
        <div class="row mb-4">
            <div class="col">
                <input type="text"  id="idNumeroPermiso" name="idNumeroPermiso" class="form-control" value="" hidden="true"/>
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" id="numeroPermiso" name="numeroPermiso" class="form-control" required="" pattern="^[a-zA-Z0-9]{5,7}$" title="El campo debe tener entre 5 a 7 carcteres (numeros, letras o numeros con letras)" maxlength="7" onblur="this.value = this.value.trim()" style="font-weight: bold;"/>
                    <label class="form-label" for="numeroPermiso">NÚMERO DEL PERMISO</label>
                </div>
            </div>
            <div class="col">
                <!-- VALIDACION PATTERN PARA RFC QUE SE REMOVIO  pattern="^[A-Za-z]{3,4}\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])[A-Za-z0-9]{3}$" -->
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" style="font-weight: bold;" list="clientes" id="listaClientes" name="listaClientes" onChange="get_cl()"  class="form-control " required="" title="El rfc enviado es invalido"/>
                    <input type="hidden" name="rfcCliente" id="rfcCliente" value="">
                    <label class="form-label" for="clt">CLIENTE</label>
                </div>
                <datalist id="clientes">
                    <c:forEach var="csat" items="${cslista}">
                        <option data-value="${csat.idCliente}" value="${csat.rfc} - ${csat.nombreCliente}"></option>
                    </c:forEach>
                </datalist>
            </div>
        </div>

        <!-- Message input -->
        <div data-mdb-input-init class="form-outline mb-4" style="background-color: white;">
            <textarea style="font-weight: bold;" class="form-control" name="conceptoPermiso" id="conceptoPermiso" maxlength="1000" rows="2" onblur="validateTextarea()" required></textarea>
            <label class="form-label" for="conceptoPermiso">CONCEPTO DEL PERMISO</label>
        </div>
        <p id="error-message" class="error text-danger fw-bold"></p>

        <script>
            function validateTextarea() {
                const textarea = document.getElementById('conceptoPermiso');
                var value = textarea.value;
                const errorMessage = document.getElementById('error-message');
                const pattern = /^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$/;
                if (pattern.test(value)) {
                    // Valid input
                    textarea.setCustomValidity(''); // Clear any previous custom validity
                } else {
                    // Invalid input
                    errorMessage.textContent = '**NO DEBE TENER DOBLES ESPACIOS EL CONCEPTO DEL PERMISO**';
                    textarea.setCustomValidity('Invalid input');
                }
            }
        </script>


        <div style="justify-content: center; display: flex;" class="stc">
            <button type="submit" id="Guardar" name="action" value="101" style="color:white;background-color: #008A13;" class="btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="GUARDAR">
                <i class="fas fa-floppy-disk"></i>
                <span class="btn-text">GUARDAR</span>
            </button>
            <button type="submit" id="Modificar" name="action" value="102" style="display: none; color:white; background-color: #0370A7;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="MODIFICAR">
                <i class="fas fa-pen-to-square"></i>
                <span class="btn-text">MODIFICAR</span>
            </button>
            <button type="submit" id="Estatus" name="action" value="103" style="display: none; color:white; background-color: #A70303;" class="btn btn-danger btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="ELIMINAR">
                <i class="fas fa-trash"></i>
                <span class="btn-text">ELIMINAR</span>
            </button>
            <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="LIMPIAR">
                <i class="fas fa-eraser"></i>
                <span class="btn-text">LIMPIAR</span>
            </button>

        </div>
    </form>
    <!--Input de Busqueda y boton imprimir-->
    <div class="row d-flex justify-content-center p-3">
        <div class="col-md-3"></div>
        <div class="col-md-3" style="text-align: center;">
            <div data-mdb-input-init class="form-outline fontformulario">
                <input type="text" id="busqueda" class="form-control form-control-sm" style="font-weight: bold;"
                       style="background-color: white;" />
                <label class="form-label" for="busqueda">BUSCAR</label>
            </div>
        </div>
        <div class="col-md-4" style="text-align: left;">
            <%---TODO: AGREGAR EL VALUE CORRESPONDIENTE AL REPORTE ---%>
            <form action="${pageContext.request.contextPath}/Reportes/reportes_catalogos.jsp" id="formulario-impresion" method="post" target="_blank">
                <th><button type="submit" name="action" value="202" title="IMPRIMIR EN PDF" class="btn btn-sm btn-rounded stc" style="color:white; background-color: purple;" data-mdb-ripple-init>
                        <i class="fas fa-print"></i>
                        <span class="d-none d-sm-inline">IMPRIMIR EN PDF</span> </button></th>
            </form>
            <button type="button" id="imprimir-btn" title="EXPORTAR A EXCEL" class="btn btn-outline-success btn-sm btn-rounded stc" data-mdb-ripple-init  data-mdb-ripple-color="dark" onclick="exportTableToExcel('permission-table', 'permisos.xls')" hidden="true">
                <i class="fas fa-file-excel"></i>
                <span class="d-none d-sm-inline">EXPORTAR A EXCEL</span>
            </button>
        </div>
    </div>
    <!--Termina aquí boton de busqueda e impresion-->             





    <div class="row d-flex justify-content-center p-3">
        <div class="" style="position: relative; width: 80%;">
            <div class="table-responsive"  style="height: 270px;">
                <c:if test="${not empty perlista}">
                    <table id="permission-table" class="fontformulario table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-secondary text-center">
                            <tr>
                                <th class="d-none">#</th>
                                <th class="fw-bold">No. PERMISO</th>
                                <th class="fw-bold">CONSECUTIVO</th>
                                <th class="fw-bold">RFC DE CLIENTE</th> 
                                <th class="fw-bold">CONCEPTO</th>  
                            </tr>
                        </thead>
                        <tbody id="datos" style="font-size: 80%;">
                            <c:forEach var="permiso" items="${perlista}">
                                <tr>
                                    <td class="d-none id-permiso" style="width: 10%;">${permiso.idPermiso}</td>
                                    <td class="text-center texto-largo" style="width: 15%;">${permiso.numeroPermiso}</td>
                                    <td class="text-center texto-largo" style="width: 10%;">${permiso.consecutivo}</td>
                                    <td class="texto-largo" style="width: 30%;">${permiso.rfcCliente}</td>   
                                    <td class="texto-largo" style="width: 45%;">${permiso.concepto}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty perlista}">
                    <center>
                        <br>
                        <h3 class="text-center metro" style="color:#970000;">
                            <b> 
                                N O  <span style="padding-left:40px;"> </span> 
                                H A Y <span style="padding-left:40px;"> </span> 
                                R E G I S T R O S
                            </b>
                        </h3>
                    </center>
                </c:if>
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



    <%@include file="../Mensaje.jsp"%>

    <!-- Agrega el enlace a la biblioteca html2pdf -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
    <!-- Script para manejar el evento de clic en el botón de impresión -->
    <script>
                // Exporta una tabla HTML a excel
                function exportTableToExcel(tableID, filename) {
                    // Tipo de exportación
                    if (!filename)
                        filename = 'excel_data.xls';
                    let dataType = 'application/vnd.ms-excel';

                    // Origen de los datos
                    let tableSelect = document.getElementById(tableID);
                    let tableHTML = tableSelect.outerHTML;

                    // Convierte la tabla HTML a una cadena de texto codificada en UTF-16LE
                    let tableText = '\uFEFF' + tableHTML; // El prefijo \uFEFF indica la codificación UTF-16LE
                    let tableData = new Uint8Array(new TextEncoder('utf-16le').encode(tableText));

                    // Crea el archivo descargable
                    let blob = new Blob([tableData], {type: dataType});

                    // Crea un enlace de descarga en el navegador
                    if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                        // Descargar para IExplorer
                        window.navigator.msSaveOrOpenBlob(blob, filename);
                    } else {
                        // Descargar para Chrome, Firefox, etc.
                        let a = document.createElement("a");
                        document.body.appendChild(a);
                        a.style = "display: none";
                        let csvUrl = URL.createObjectURL(blob);
                        a.href = csvUrl;
                        a.download = filename;
                        a.click();
                        URL.revokeObjectURL(a.href)
                        a.remove();
                    }
                }

//**************Cambiar botones en input de busqueda para impresiones
                document.addEventListener('DOMContentLoaded', function () {
                    const busquedaInput = document.getElementById('busqueda');
                    const imprimirBtn = document.getElementById('imprimir-btn');
                    const formularioImpresion = document.getElementById('formulario-impresion');

                    // Función para manejar el evento de entrada en el campo de búsqueda
                    function handleInput() {
                        // Si el campo de búsqueda tiene algún valor
                        if (this.value.trim() !== '') {
                            // Mostrar el botón de imprimir
                            imprimirBtn.removeAttribute('hidden');
                            // Ocultar el formulario de impresión
                            formularioImpresion.style.display = 'none';
                        } else {
                            // Si el campo de búsqueda está vacío, ocultar el botón de imprimir
                            imprimirBtn.setAttribute('hidden', 'true');
                            // Mostrar el formulario de impresión
                            formularioImpresion.style.display = 'block';
                        }
                    }

                    // Escuchar el evento de entrada en el campo de búsqueda
                    busquedaInput.addEventListener('input', handleInput);
                });
//****************************************************
                document.addEventListener('DOMContentLoaded', function () {
                    // Obtener la tabla y el formulario
                    var tabla = document.getElementById('datos');
                    var formulario = document.getElementById('formulario');


                    // Añadir un evento de clic a las filas de la tabla
                    tabla.addEventListener('click', function (event) {
                        // Verificar si se hizo clic en una celda de la fila
                        if (event.target.tagName === 'TD') {
                            // Obtener la fila de la celda clicada
                            var fila = event.target.parentNode;


                            if (tabla.querySelector('.selected')) {
                                tabla.querySelector('.selected').classList.remove('selected');
                                formulario.querySelector("#rfcCliente").readonly = false;
                                formulario.querySelector("#listaClientes").disabled = false;
                            }
                            fila.classList.add("selected");


                            document.querySelector('#Guardar').style.display = "none";
                            document.querySelector('#Modificar').style.display = "block";
                            document.querySelector('#Estatus').style.display = "block";


                            // Obtener los datos de la fila
                            let idPermiso = fila.querySelector('.id-permiso').innerText;
                            let numeroPermiso = fila.querySelector('.texto-largo:nth-child(2)').innerText;
                            let conceptoPermiso = fila.querySelector('.texto-largo:nth-child(5)').innerText;
                            let rfcCliente = fila.querySelector('.texto-largo:nth-child(4)').innerText;

                            var dataValue = document.querySelector('#clientes option[value="' + rfcCliente + '"]').getAttribute("data-value");
                            var cliente = document.querySelector('#clientes option[data-value="' + dataValue + '"]').value;



                            // Ingresa los valores a los cuadros de texto
                            formulario.querySelector("#idNumeroPermiso").value = idPermiso;
                            formulario.querySelector("#numeroPermiso").value = numeroPermiso;
                            formulario.querySelector("#conceptoPermiso").value = conceptoPermiso;
                            formulario.querySelector("#listaClientes").value = cliente;
                            formulario.querySelector("#rfcCliente").value = dataValue;
                            formulario.querySelector("#idNumeroPermiso").focus();
                            formulario.querySelector('#numeroPermiso').focus();
                            formulario.querySelector('#conceptoPermiso').focus();
                            formulario.querySelector("#listaClientes").focus();
                            formulario.querySelector("#numeroPermiso").readOnly = true;
                            formulario.querySelector("#rfcCliente").readOnly = true;
                            formulario.querySelector("#listaClientes").readOnly = true;
                            console.log("Seleccionando el input rfcCliente:", formulario.querySelector("#rfcCliente"));

                        }
                    });
                });

//*****************Funcion limpiar para quitar boton y estiñps en tabla 
                document.addEventListener('DOMContentLoaded', function () {
                    // Agregar el event listener para el botón de limpiar
                    document.querySelector('#Limpiar').addEventListener('click', function () {
                        // Esta función se ejecutará cuando se haga clic en el botón de limpiar
                        document.querySelector("#rfcCliente").readOnly = false;
                        document.querySelector("#listaClientes").readOnly = false;
                        document.querySelector("#numeroPermiso").readOnly = false;

                        document.querySelector('#Guardar').style.display = "block";
                        document.querySelector('#Modificar').style.display = "none";
                        document.querySelector('#Estatus').style.display = "none";
                        var errorMessage= document.getElementById('error-message');
                        errorMessage.textContent = '';
                        if (document.querySelector('.selected')) {
                            document.querySelector('.selected').classList.remove('selected');
                        }
                    });
                });
//*******************************************************************
//
//*********************Para convertir las letras en mayúsculas al mandar datos
                document.getElementById('formulario').addEventListener('submit', function (event) {
                    var inputs = document.getElementsByTagName('input');
                    var areas = document.getElementsByTagName('textarea');
                    for (var i = 0; i < areas.length; i++) {
                        areas[i].value = areas[i].value.toUpperCase();
                    }
                    for (var i = 0; i < inputs.length; i++) {
                        if (inputs[i].type === 'text') {
                            inputs[i].value = inputs[i].value.toUpperCase();
                        }
                    }
                });
//***********************

//*****************FUNCION PARA CAMPO DE BUSQUEDA 
                // Script para filtrar la tabla al escribir en el campo de búsqueda
                $(document).ready(function () {
                    $("#busqueda").on("keyup", function () {
                        var value = $(this).val().toLowerCase();
                        $("#datos tr").filter(function () {
                            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                        });
                    });
                });
//********************************************

                function get_cl() {
                    var inputRFC = document.getElementById('listaClientes').value.toUpperCase();
                    var listaRFCs = document.getElementById('clientes').getElementsByTagName('option');
                    var found = false;

                    // Iterar sobre los elementos de la lista
                    for (var i = 0; i < listaRFCs.length; i++) {
                        if (inputRFC === listaRFCs[i].value) {
                            found = true;
                            // Obtener el valor del atributo 'data-value'
                            var dataValue = listaRFCs[i].getAttribute("data-value");
                            // Asignar el valor al campo oculto
                            document.getElementById('rfcCliente').value = dataValue;
                            break;
                        }
                    }

                    // Si no se encontró el RFC en la lista, limpiar el input
                    if (!found) {
                        customeError("ERROR", 'CLIENTE NO VÁLIDO');
                        document.getElementById('listaClientes').value = '';
                        document.getElementById('rfcCliente').value = '';
                    }
                }

//***************************************FUNCION PARA MENSAJES 
// Espera a que se cargue completamente el DOM antes de ejecutar el script
                document.addEventListener("DOMContentLoaded", function () {
                    // Cerrar la alerta después de 3.5 segundos
                    setTimeout(function () {
                        var alerta = document.querySelector("#myAlert");
                        if (alerta) {
                            alerta.style.display = "none";
                        }
                    }, 3500);
                });
//********************************************

                window.onload = function () {
                    // Borrar los valores de los campos del formulario
                    document.getElementById("formulario").reset();
                };
                history.forward();
    </script>
</main>
<%@include file="../Pie.jsp"%>