<%-- 
    Document   : DepositoBancario
    Created on : 3 jul 2024, 15:14:13
    Author     : Ing. Evelyn Leilani Avendaño
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@include file="../Encabezado.jsp"%>
<%
    System.out.println("---------------------DEPÓSITO BANCARIO JSP---------------------");
%>

<style>
    .centrado-verticalmente {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
    input:focus {
        /* Color naranja */
        box-shadow: none !important;
        /* Efecto de sombra opcional */
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

    /* Estilos para el checkbox cuando está marcado */
    .form-check-input:checked {
        background-color: #ff5000 !important;
        border-color: #ff5000 !important;
    }

    /* Estilos adicionales para el enfoque del checkbox */
    .form-check-input:focus {
        box-shadow: 0 0 0 0.25rem #ff5000 !important;
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
        <h3>CATÁLOGO DE DEPÓSITO BANCARIO METRO</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
    <form  action="Srv_DepositoBancario" method="POST" id="formulario" class="fontformulario" style="font-size: 80%; margin: 15px;">
        <!-- 2 column grid layout with text inputs for the first and last names -->
        <div class="row mb-4">
            <div class="col">
                <input type="text" class="form-control form-control-sm" id="idDeposito" name="idDeposito" value="" hidden/>
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="text" style="font-weight: bold;" list="listaBancos" id="banco" name="banco" onChange="get_banco()"  class="form-control " onblur="this.value = this.value.trim()" required="true"/>
                    <input type="hidden" name="id_banco" id="id_banco" value="" required="true">
                    <datalist id="listaBancos">
                        <c:forEach var="banco" items="${bnlista}">
                            <option data-value="${banco.idBanco}" value="${banco.nombre}"></option>
                        </c:forEach>
                    </datalist>
                    <label class="form-label" for="banco">BANCO</label>
                </div>
            </div>
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input style="font-weight: bold;" type="text"id="cuentaBancaria" name="cuentaBancaria" onChange="validarCuentaBancaria()" maxlength="10" value="" class="form-control" onblur="this.value = this.value.trim()" required/>
                    <label class="form-label" for="cuentaBancaria">CUENTA BANCARIA</label>
                </div>
            </div>
             <script>
                        function validarCuentaBancaria() {
                        var input = document.getElementById('cuentaBancaria');
                        var value = input.value;
                        // Check if value is '0' or a 4-digit number
                        if (value === '0' || /^[0-9]{10}$/.test(value)) {
                            // Valid input
                            input.setCustomValidity(''); // Clear any previous custom validity
                        } else {
                            // Invalid input
                            customeError("ERROR","LA CUENTA BANCARIA TIENE QUE SER DE DIEZ DIGITOS");
                            input.setCustomValidity('Invalid input');
                        }
                    }
                    </script>
        </div>
        <br>
        <div style="justify-content: center; display: flex;" class="stc">
            <button type="submit" id="Guardar" value="101" name="action" style="color:white;background-color: #008A13;" class="btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Guardar" >
                <i class="fas fa-floppy-disk"></i>
                <span class="btn-text d-none d-sm-inline">GUARDAR</span>
            </button>
            <button type="submit" id="Modificar" value="102" name="action" style="display: none; color:white; background-color: #0370A7;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Modificar" >
                <i class="fas fa-pen-to-square"></i>
                <span class="btn-text d-none d-sm-inline">MODIFICAR</span>
            </button>
            <button type="submit" id="Baja"  value="103" name="action" style="display: none; color:white; background-color: #A70303;" class="btn btn-danger btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top"  title="Eliminar">
                <i class="fas fa-trash"></i>
                <span class="btn-text d-none d-sm-inline">ELIMINAR</span>
            </button>
            <button type="reset" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar" id="Limpiar"><!--Boton tipo reset-->
                <i class="fas fa-eraser"></i>
                <span class="btn-text d-none d-sm-inline">LIMPIAR</span>
            </button>
        </div>
    </form>


    <%--BUSCAR--%>
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
            <%---TODO: AGREGAR EL VALUE CORRESPONDIENTE AL REPORTE 
            <form action="${pageContext.request.contextPath}/Reportes/reportes_catalogos.jsp" id="formulario-impresion" method="post" target="_blank">
                <th><button disabled type="submit" name="action" value="208" title="IMPRIMIR EN PDF" class="stc btn btn-primary btn-sm btn-rounded" style="color:white; background-color: purple;" data-mdb-ripple-init>
                        <i class="fas fa-print"></i>
                        <span class="d-none d-sm-inline">IMPRIMIR EN PDF</span>
                    </button></th>
            </form>---%>
            <button type="button" id="imprimir-btn" title="EXPORTAR A EXCEL" class="btn btn-outline-success btn-sm btn-rounded stc" data-mdb-ripple-init  data-mdb-ripple-color="dark" onclick="exportTableToExcel('payType-table', 'DepositoBancario.xls')">
                <i class="fas fa-file-excel"></i>
                <span class="d-none d-sm-inline">EXPORTAR A EXCEL</span>
            </button>
        </div>
    </div>

    <!-- TABLA DE DATOS -->
    <div class="row d-flex justify-content-center p-3">
        <div class="text-center" style="position: relative; width: 80%;">
            <div class="table-responsive" style="height: 270px;">
                <c:if test="${not empty depositolista}">
                    <table id="payType-table" class="fontformulario table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-secondary">
                            <tr>
                                <th class="d-none">*</th>
                                <th class="d-none">*</th>
                                <th class="fw-bold">NOMBRE DEL BANCO</th>
                                <th class="fw-bold">CUENTA BANCARIA</th>
                            </tr>
                        </thead>
                        <tbody id="datos" style="font-size: 80%;">
                            <c:forEach var="depositoBancario" items="${depositolista}">
                                <tr>
                                    <td class="text-center id-depositobancario d-none">${depositoBancario.idDeposito}</td>
                                    <td class="texto-largo d-none">${depositoBancario.idBanco}</td>
                                    <td class="texto-largo">${depositoBancario.nombreBanco}</td>
                                    <td class="texto-largo">${depositoBancario.cuentaBancaria}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty depositolista}">
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
    </script>
    <br>
    <%@include file="../Mensaje.jsp"%>


</main>
<script  type="text/javascript">
    //********************obtener banco
    function get_banco() {
        var inputBanco = document.getElementById('banco').value.toUpperCase();
        var listaBanco = document.getElementById('listaBancos').getElementsByTagName('option');
        var found = false;

        // Iterar sobre los elementos de la lista
        for (var i = 0; i < listaBanco.length; i++) {
            if (inputBanco === listaBanco[i].value) {
                found = true;
                // Obtener el valor del atributo 'data-value'
                var dataValue = listaBanco[i].getAttribute("data-value");
                // Asignar el valor al campo oculto
                document.getElementById('id_banco').value = dataValue;
                break;
            }
        }

        // Si no se encontró el RFC en la lista, limpiar el input
        if (!found) {
            customeError("ERROR",'BANCO NO VÁLIDO');
            document.getElementById('banco').value = '';
            document.getElementById('id_banco').value = '';
        }
    }

//**************
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
                document.querySelector('#Baja').style.display = "block";


                // Obtener los datos de la fila
                let id = fila.querySelector('.id-depositobancario').innerText;
                let idBanco = fila.querySelector('.texto-largo:nth-child(2)').innerText;
                let nombreBanco = fila.querySelector('.texto-largo:nth-child(3)').innerText;
                let cuentaBancaria = fila.querySelector('.texto-largo:nth-child(4)').innerText;


                // Ingresa los valores a los cuadros de texto
                formulario.querySelector("#idDeposito").value = id;
                formulario.querySelector("#id_banco").value = idBanco;
                formulario.querySelector("#banco").value = nombreBanco;
                formulario.querySelector("#cuentaBancaria").value = cuentaBancaria;

                formulario.querySelector('#idDeposito').focus();
                formulario.querySelector('#id_banco').focus();
                formulario.querySelector('#banco').focus();
                formulario.querySelector('#cuentaBancaria').focus();
            }
        });
    });
    document.querySelector('#Baja').style.display = "none";
//****************

//*****************Funcion limpiar para quitar boton y estiñps en tabla 
    document.addEventListener('DOMContentLoaded', function () {
        // Agregar el event listener para el botón de limpiar
        document.querySelector('#Limpiar').addEventListener('click', function () {
            document.getElementById("idDeposito").blur();
            document.getElementById("id_banco").blur();
            document.getElementById("banco").blur();
            document.getElementById("cuentaBancaria").blur();
            
            // Esta función se ejecutará cuando se haga clic en el botón de limpiar
            document.querySelector('#Guardar').style.display = "block";
            document.querySelector('#Modificar').style.display = "none";
            document.querySelector('#Baja').style.display = "none";
            if (document.querySelector('.selected')) {
                document.querySelector('.selected').classList.remove('selected');
            }
        });
    });
//*******************************************************************


//*********************Para convertir las letras en mayúsculas al mandar datos
    document.getElementById('formulario').addEventListener('submit', function (event) {
        let inputs = document.getElementsByTagName('input');
        for (let i = 0; i < inputs.length; i++) {
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

    window.onload = function () {
        // Borrar los valores de los campos del formulario
        document.getElementById("formulario").reset();
    };
    history.forward();
</script>
</header>
<%@include file="../Pie.jsp"%>

