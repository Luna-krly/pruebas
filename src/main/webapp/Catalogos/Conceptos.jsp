<%-- 
    Document   : JSP_Conceptos
    Created on : 8/05/2023, 11:50:57 AM
    Author     : Ing. Evelyn Leilani Avendaño 
    Author     : Lezly Oliván
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<%
    System.out.println("---------------------CONCEPTOS JSP---------------------");
%>

<%@include file="../Encabezado.jsp"%>



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
        <h3>CATÁLOGO DE CONCEPTOS</h3>
    </div>

    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
    <form action="Srv_Concepto" method="POST" id="formulario" class="fontformulario" style="font-size: 80%; margin: 15px;">
        <!-- 2 column grid layout with text inputs for the first and last names -->
        <div class="row mb-4 ">
            <div class="col">
                <input type="text"  id="idConcepto" name="idConcepto" class="form-control " hidden="true"/>
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" style="font-weight: bold;"  id="nombreConcepto" name="nombreConcepto" class="form-control"  pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." style="font-weight: bold;" maxlength="100" onblur="this.value = this.value.trim()" required/>
                    <label class="form-label" for="nombreConcepto">NOMBRE DEL CONCEPTO</label>
                </div>
            </div>
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" style="font-weight: bold;" list="ListTipoIngreso" name="tingreso" id="tingreso" onChange="get_ti()"  class="form-control" required=""/>
                    <input type="hidden" name="tipoIngreso" id="tipoIngreso" value="">
                    <label class="form-label" for="clt">TIPO DE INGRESO</label>
                </div>
            </div>
        </div>

        <!-- 2 column grid layout with text inputs for the first and last names -->
        <div class="row mb-4">
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" style="font-weight: bold;" id="remitente" name="remitente" class="form-control"  pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." style="font-weight: bold;" onblur="this.value = this.value.trim()" required />
                    <label class="form-label" for="remitente">REMITENTE</label>
                </div>
            </div>
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" style="font-weight: bold;" id="destinatario" name="destinatario" class="form-control"  pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." style="font-weight: bold;" onblur="this.value = this.value.trim()" required/>
                    <label class="form-label" for="destinatario">DESTINATARIO</label>
                </div>
            </div>
        </div>

        <!-- Message input -->
        <div data-mdb-input-init class="form-outline mb-4" style="background-color: white;">
            <textarea class="form-control" style="font-weight: bold;" name="descripcionConcepto" id="descripcionConcepto" rows="2"  pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final."  style="font-weight: bold;"  onblur="this.value = this.value.trim()" required></textarea>
            <label class="form-label" for="descripcionConcepto">DESCRIPCIÓN DEL CONCEPTO</label>
        </div>

        <!-- 2 column grid layout with text inputs for the first and last names -->
        <div class="row mb-4">
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" style="font-weight: bold;" id="nombreVo" name="nombreVo"  class="form-control "  pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." style="font-weight: bold;" onblur="this.value = this.value.trim()" required />
                    <label class="form-label" for="nombreVo">NOMBRE DE LA PERSONA DE Vo. Bo.</label>
                </div>
            </div>
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" style="font-weight: bold;" id="nombreAtentamente" name="nombreAtentamente" class="form-control "  pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." style="font-weight: bold;" onblur="this.value = this.value.trim()" required />
                    <label class="form-label" for="nombreAtentamente">NOMBRE DE LA PERSONA ATENTAMENTE</label>
                </div>
            </div>
        </div>
        <!-- 2 column grid layout with text inputs for the first and last names -->
        <div class="row mb-4">
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" style="font-weight: bold;"  id="puestoVo" name="puestoVo"  class="form-control  "  pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." style="font-weight: bold;" onblur="this.value = this.value.trim()" required />
                    <label class="form-label" for="puestoVo">PUESTO DE LA PERSONA DE Vo. Bo.</label>
                </div>
            </div>
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" style="font-weight: bold;"  id="puestoAtentamente" name="puestoAtentamente" class="form-control "  pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." style="font-weight: bold;" onblur="this.value = this.value.trim()" required />
                    <label class="form-label" for="puestoAtentamente">PUESTO DE LA PERSONA ATENTAMENTE</label>
                </div>
            </div>
        </div>
        <br>
        <div class="stc" style="justify-content: center; display: flex;">
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
            <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="LIMPIAR"><!--Boton tipo reset-->
                <i class="fas fa-eraser"></i>
                <span class="btn-text">LIMPIAR</span>
            </button>

        </div>

    </form>
    <!--Input de Busqueda y boton imprimir-->
    <div class="row d-flex justify-content-center p-3 ">
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
                <th><button type="submit" name="action" value="201" title="IMPRIMIR EN PDF" class="btn btn-sm btn-rounded stc" style="color:white; background-color: purple;" data-mdb-ripple-init>
                        <i class="fas fa-print"></i>
                        <span class="d-none d-sm-inline">IMPRIMIR EN PDF</span> </button></th>
            </form>
            <button type="button" id="imprimir-btn" title="EXPORTAR A EXCEL" class="btn btn-outline-success btn-sm btn-rounded stc" data-mdb-ripple-init  data-mdb-ripple-color="dark" onclick="exportTableToExcel('concepto-table', 'conceptos.xls')" hidden="true">
                <i class="fas fa-file-excel"></i>
                <span class="d-none d-sm-inline">EXPORTAR A EXCEL</span>
            </button>
        </div>
    </div>
    <!--Termina aquí boton de busqueda e impresion         
  <button onclick="exportTableToExcel('concepto-table', 'datos.xls')">Exportar a Excel</button>
    -->    
    <div class="row d-flex justify-content-center p-3">
    <div class="text-center" style="position: relative; width: 100%;">
        <div class="table-responsive" style="height: 270px;">
            <c:if test="${not empty conceptolista}">
                <table id="concepto-table" class="fontformulario table table-hover table-bordered table-sm" style="font-size: 90%;background-color: #fff;">
                    <thead class="table-secondary">
                        <tr>
                            <th class="d-none">*</th>
                            <th class="fw-bold">NOMBRE CONCEPTO</th>
                            <th class="fw-bold">TIPO INGRESO</th>
                            <th class="fw-bold">REMITENTE</th>
                            <th class="fw-bold">DESTINATARIO</th>
                            <th class="fw-bold">DESCRIPCIÓN DEL CONCEPTO</th>
                            <th class="fw-bold">NOMBRE Vo.Bo.</th>
                            <th class="fw-bold">PUESTO Vo.</th>
                            <th class="fw-bold">NOMBRE ATENTAMENTE</th>
                            <th class="fw-bold">PUESTO ATENTAMENTE</th>
                        </tr>
                    </thead>
                    <tbody id="datos" style="font-size: 75%;">
                        <c:forEach var="concepto" items="${conceptolista}">
                            <tr>
                                <td class="text-center id-concepto d-none">${concepto.idConcepto}</td>
                                <td class="texto-largo">${concepto.nombre}</td>
                                <td class="texto-largo">${concepto.tipoIngreso}</td>
                                <td class="texto-largo">${concepto.remitente}</td>
                                <td class="texto-largo">${concepto.destinatario}</td>
                                <td class="texto-largo">${concepto.concepto}</td>
                                <td class="texto-largo">${concepto.nombreVo}</td>
                                <td class="texto-largo">${concepto.puestoVo}</td>
                                <td class="texto-largo">${concepto.nombreAtt}</td>
                                <td class="texto-largo">${concepto.puestoAtt}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty conceptolista}">
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

<datalist id="ListTipoIngreso">
    <c:forEach var="ingresoc" items="${ingresosclista}">
        <option data-value="${ingresoc.idTipoIngresoC}" value="${ingresoc.claveTipoInrgesoC} - ${ingresoc.descripcionTipoIngresoC}"></option>
    </c:forEach>
</datalist>

    <!-- Agrega el enlace a la biblioteca html2pdf -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
    <!-- Script para manejar el evento de clic en el botón de impresión -->
    <%@include file="../Mensaje.jsp"%>

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
    </script>

    <script  type="text/javascript">
        //********************************************

        function get_ti() {
            var inputTI = document.getElementById('tingreso').value.toUpperCase();
            var listaTIs = document.getElementById('ListTipoIngreso').getElementsByTagName('option');
            var found = false;

            // Iterar sobre los elementos de la lista
            for (var i = 0; i < listaTIs.length; i++) {
                if (inputTI === listaTIs[i].value) {
                    found = true;
                    // Obtener el valor del atributo 'data-value'
                    var dataValue = listaTIs[i].getAttribute("data-value");
                    // Asignar el valor al campo oculto
                    document.getElementById('tipoIngreso').value = dataValue;
                    break;
                }
            }

            // Si no se encontró el RFC en la lista, limpiar el input
            if (!found) {
                customeError("ERROR",'TIPO DE INGRESO NO VÁLIDO');
                document.getElementById('tingreso').value = '';
                document.getElementById('tipoIngreso').value = '';
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


        //*******Hace el input en letra bold
        document.addEventListener('DOMContentLoaded', function () {
            const select = document.getElementById('tipoIngreso');

            // Agrega el evento change al select
            select.addEventListener('change', function () {
                // Verifica si se ha seleccionado alguna opción
                if (this.value.trim() !== '') {
                    this.style.fontWeight = 'bold'; // Aplica el estilo bold
                } else {
                    this.style.fontWeight = 'normal'; // Aplica el estilo normal
                }
            });
        });
        //*********Toma datos de tabla para moverlos arriba y cambiar los botones 
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
                    }
                    fila.classList.add("selected");


                    document.querySelector('#Guardar').style.display = "none";
                    document.querySelector('#Modificar').style.display = "block";
                    document.querySelector('#Estatus').style.display = "block";
                    document.querySelector('#tipoIngreso').style.fontWeight = "bold";


                    // Obtener los datos de la fila
                    let idConcepto = fila.querySelector('.id-concepto').innerText;
                    let nombreConcepto = fila.querySelector('.texto-largo:nth-child(2)').innerText;
                    let tipoIngreso = fila.querySelector('.texto-largo:nth-child(3)').innerText;
                    let dataValue = document.querySelector('#ListTipoIngreso option[value="' + tipoIngreso + '"]').getAttribute("data-value");
                    let remitente = fila.querySelector('.texto-largo:nth-child(4)').innerText;
                    let destinatario = fila.querySelector('.texto-largo:nth-child(5)').innerText;
                    let descripcionConcepto = fila.querySelector('.texto-largo:nth-child(6)').innerText;
                    let nombreVo = fila.querySelector('.texto-largo:nth-child(7)').innerText;
                    let puestoVo = fila.querySelector('.texto-largo:nth-child(8)').innerText;
                    let nombreAtentamente = fila.querySelector('.texto-largo:nth-child(9)').innerText;
                    let puestoAtentamente = fila.querySelector('.texto-largo:nth-child(10)').innerText;


                    // Ingresa los valores a los cuadros de texto
                    formulario.querySelector("#idConcepto").value = idConcepto;
                    formulario.querySelector("#nombreConcepto").value = nombreConcepto;
                    formulario.querySelector("#nombreConcepto").readOnly = true;
                    formulario.querySelector("#tipoIngreso").value = dataValue;
                    formulario.querySelector("#tingreso").value = tipoIngreso;
                    formulario.querySelector("#remitente").value = remitente;
                    formulario.querySelector("#destinatario").value = destinatario;
                    formulario.querySelector("#descripcionConcepto").value = descripcionConcepto;
                    formulario.querySelector("#nombreVo").value = nombreVo;
                    formulario.querySelector("#nombreAtentamente").value = nombreAtentamente;
                    formulario.querySelector("#puestoVo").value = puestoVo;
                    formulario.querySelector("#puestoAtentamente").value = puestoAtentamente;



                    formulario.querySelector("#idConcepto").focus();
                    formulario.querySelector("#nombreConcepto").focus();
                    formulario.querySelector("#tipoIngreso").focus();
                    formulario.querySelector("#tingreso").focus();
                    formulario.querySelector("#remitente").focus();
                    formulario.querySelector("#destinatario").focus();
                    formulario.querySelector("#descripcionConcepto").focus();
                    formulario.querySelector("#nombreVo").focus();
                    formulario.querySelector("#nombreAtentamente").focus();
                    formulario.querySelector("#puestoVo").focus();
                    formulario.querySelector("#puestoAtentamente").focus();
                }
            });
        });
        document.querySelector('#Estatus').style.display = "none";
        //*****************Funcion limpiar para quitar boton y estiñps en tabla 
        document.addEventListener('DOMContentLoaded', function () {
            // Agregar el event listener para el botón de limpiar
            document.querySelector('#Limpiar').addEventListener('click', function () {
                document.querySelector("#nombreConcepto").readOnly = false;
                document.getElementById("nombreConcepto").blur();
                document.getElementById("tipoIngreso").blur();
                document.getElementById("remitente").blur();
                document.getElementById("destinatario").blur();
                document.getElementById("descripcionConcepto").blur();
                document.getElementById("nombreVo").blur();
                document.getElementById("nombreAtentamente").blur();
                document.getElementById("puestoVo").blur();
                document.getElementById("puestoVo").blur();
                // Esta función se ejecutará cuando se haga clic en el botón de limpiar
                document.querySelector('#Guardar').style.display = "block";
                document.querySelector('#Modificar').style.display = "none";
                document.querySelector('#Estatus').style.display = "none";
                document.querySelector('#tipoIngreso').style.fontWeight = "normal";
                if (document.querySelector('.selected')) {
                    document.querySelector('.selected').classList.remove('selected');
                }
            });
        });
        //*******************************************************************


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
        //    $(document).ready(function () {
        //      $("#busqueda").on("keyup", function () {
        //         var value = $(this).val().toLowerCase();
        //        $("#datos td.texto-largo:nth-child(2)").filter(function () {
        //           $(this).parent().toggle($(this).text().toLowerCase().indexOf(value) > -1);
        //      });
        //  });
        //});
        //********************************************
        $(document).ready(function () {
            $("#busqueda").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#datos tr").filter(function () {
                    // Comprobamos si alguna de las columnas contiene el valor de búsqueda
                    var found = $(this).find("td:nth-child(2)").text().toLowerCase().indexOf(value) > -1 ||
                            $(this).find("td:nth-child(3)").text().toLowerCase().indexOf(value) > -1 ||
                            $(this).find("td:nth-child(6)").text().toLowerCase().indexOf(value) > -1;

                    $(this).toggle(found);
                });
            });
        });

//**********


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