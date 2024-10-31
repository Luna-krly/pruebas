<%-- 
    Document   : impuestos
    Created on : 1 mar 2024, 15:01:20
    Author     : Lezly Oliván
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@include file="../Encabezado.jsp"%>

<%
    System.out.println("---------------------IMPUESTOS JSP---------------------");
%>
<style>
    .centrado-verticalmente {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
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

    /* Estilos para botones activos */
    .btn-azul {
        color: #fff; /* Color del texto blanco */
    }

    .btn-azul:checked + .form-check-label::before {
        background-color: #007bff; /* Color de la "bolita" cuando el botón está activo */
        border-color: #007bff; /* Color del borde del checkbox cuando está activo */
    }

    /* Estilos para botones inactivos */
    .btn-azul:not(:checked) + .form-check-label::before {
        background-color: #6c757d; /* Color de la "bolita" cuando el botón no está activo */
        border-color: #6c757d; /* Color del borde del checkbox cuando no está activo */
    }

    /* Estilos comunes para la "bolita" */
    .form-check-label::before {
        border: 1px solid #007bff; /* Grosor y color del borde de la "bolita" */
    }

</style>
<!-- Cuerpo -->
<main class="col ps-md-2 pt-2 mx-3">
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <div class="page-header pt-3 stc">
        <h3>CATÁLOGO DE IMPUESTOS</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
    <form action="Srv_Imp" method="POST" class="fontformulario" id="formulario" style="font-size: 80%; margin: 15px;">
        <!-- 2 column grid layout with text inputs for the first and last names -->
        <div class="row mb-4">
            <div class="col">
                <input type="text" class="form-control form-control-sm"  id="idImpuestos" name="idImpuestos" value="" hidden/>
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input style="font-weight: bold;" type="text" id="claveImpuesto" name="claveImpuesto" class="form-control" maxlength="3" pattern="^[0-9]{3}$" title="La clave debe seguir el formato de tres digitos, por ejemplo 001" onblur="this.value = this.value.trim()" required/>
                    <label class="form-label" for="claveImpuesto">(3)  CLAVE</label>
                </div>
            </div>
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input style="font-weight: bold;" type="text" id="descripcionImpuesto" name="descripcionImpuesto" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." onblur="this.value = this.value.trim()" maxlength="5"/>
                    <label class="form-label" for="descripcionImpuesto">DESCRIPCIÓN IMPUESTO</label>
                </div>
            </div>
        </div>
        <style>
            /* Cambiar el color de la bolita cuando el switch está desactivado */
            .form-check-input:not(:checked)::after {
                background-color: #6c757d; /* Bolita gris cuando no está activado */
            }
        </style>
        <div style="justify-content: center; display: flex;" class="fontformulario">
            <div class="form-check form-switch">
                <input class="form-check-input btn-azul fs-6" type="checkbox" role="switch" id="esRetenido" name="esRetenido" value="RETENIDO">
                <label class="form-check-label fs-6" for="flexSwitchCheckDefault" style="font-weight: bold;"> [ <span  id="spanNoRetenido" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiRetenido" hidden="true">SI</span> ] RETENIDO</label>
            </div>
            <div class="form-check form-switch mx-4">
                <input class="form-check-input btn-azul fs-6" type="checkbox" role="switch" id="esTraslado" name="esTraslado" value="TRASLADO">
                <label class="form-check-label fs-6" for="flexSwitchCheckDefault" style="font-weight: bold;"> [ <span id="spanNoTraslado" style="color:#BA0000;">NO</span> <span style="color:#007505;" id="spanSiTraslado" hidden="true">SI</span> ] TRASLADADO</label>
            </div>
        </div>
        <br>
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
            <button type="submit" id="Baja"  value="103" name="action" style="display: none; color:white; background-color: #A70303;" class="btn btn-danger btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top"  title="Eliminar" >
                <i class="fas fa-trash"></i>
                <span class="btn-text d-none d-sm-inline">ELIMINAR</span>
            </button>
            <button type="reset" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar" id="Limpiar"><!--Boton tipo reset-->
                <i class="fas fa-eraser"></i>
                <span class="btn-text d-none d-sm-inline">LIMPIAR</span>
            </button>
        </div>
    </form>
    <div class="row d-flex justify-content-center p-3 stc">
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
                <th><button type="submit" name="action" value="209" title="IMPRIMIR EN PDF" class="stc btn btn-primary btn-sm btn-rounded" style="color:white; background-color: purple;" data-mdb-ripple-init>
                        <i class="fas fa-print"></i>
                        <span class="d-none d-sm-inline">IMPRIMIR EN PDF</span> </button></th>
            </form>
            <button type="button" id="imprimir-btn" title="EXPORTAR A EXCEL"  class="btn btn-outline-success btn-sm btn-rounded stc" data-mdb-ripple-init  data-mdb-ripple-color="dark" onclick="exportTableToExcel('tablaImpuestos', 'Impuestos.xls')" hidden="true">
                <i class="fas fa-file-excel"></i>
                <span class="d-none d-sm-inline">EXPORTAR A EXCEL</span>
            </button>
        </div>
    </div>
    <div class="row d-flex justify-content-center p-3">
        <div class="text-center" style="position: relative; width: 80%;">
            <div class="table-responsive" style="height: 270px;">
                <c:if test="${not empty implista}">
                    <table id="tablaImpuestos" class="fontformulario table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-secondary">
                            <tr>
                                <th class="fw-bold">CLAVE</th>
                                <th class="fw-bold">DESCRIPCIÓN IMPUESTO</th>
                                <th class="fw-bold">RETENCIÓN</th>
                                <th class="fw-bold">TRASLADO</th>
                            </tr>
                        </thead>
                        <tbody id="datos" style="font-size: 80%;">
                            <c:forEach var="impuesto" items="${implista}">
                                <tr>
                                    <td class="id-impuesto d-none">${impuesto.idImpuesto}</td>
                                    <td class="texto-largo">${impuesto.claveImpuesto}</td>
                                    <td class="texto-largo">${impuesto.descripcionImpuesto}</td>
                                    <td class="texto-largo">${impuesto.retencion}</td>
                                    <td class="texto-largo">${impuesto.traslado}</td> 
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty implista}">
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
    </script>
    <%@include file="../Mensaje.jsp"%>


</main>

<script  type="text/javascript">
    document.getElementById('esRetenido').addEventListener('change', function () {
        const spanNoRetenido = document.getElementById('spanNoRetenido');
        const spanSiRetenido = document.getElementById('spanSiRetenido');
        if (this.checked) {
            spanNoRetenido.hidden = true;
            spanSiRetenido.hidden = false;
        } else {
            spanNoRetenido.hidden = false;
            spanSiRetenido.hidden = true;
        }
    });

    document.getElementById('esTraslado').addEventListener('change', function () {
        const spanNoRetenido = document.getElementById('spanNoTraslado');
        const spanSiRetenido = document.getElementById('spanSiTraslado');
        if (this.checked) {
            spanNoRetenido.hidden = true;
            spanSiRetenido.hidden = false;
        } else {
            spanNoRetenido.hidden = false;
            spanSiRetenido.hidden = true;
        }
    });




//*****Funcion para cambiar botones de impresion al grupal y al filtrado
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
                let idImpuestos = fila.querySelector('.id-impuesto').innerText;
                let claveImpuesto = fila.querySelector('.texto-largo:nth-child(2)').innerText;
                let descripcionImpuesto = fila.querySelector('.texto-largo:nth-child(3)').innerText;
                let esRetenido = fila.querySelector('.texto-largo:nth-child(4)').innerText;
                let esTrasladado = fila.querySelector('.texto-largo:nth-child(5)').innerText;




                console.log(claveImpuesto);
                // Ingresa los valores a los cuadros de texto
                formulario.querySelector("#idImpuestos").value = idImpuestos;
                formulario.querySelector("#claveImpuesto").value = claveImpuesto;
                formulario.querySelector("#descripcionImpuesto").value = descripcionImpuesto;
                if (formulario.querySelector("#esRetenido").checked = esRetenido == "SI") {
                    document.getElementById('spanNoRetenido').hidden = true;
                    document.getElementById('spanSiRetenido').hidden = false;
                } else {
                    document.getElementById('spanNoRetenido').hidden = false;
                    document.getElementById('spanSiRetenido').hidden = true;
                }

                if (formulario.querySelector("#esTraslado").checked = esTrasladado == "SI") {
                    document.getElementById('spanNoTraslado').hidden = true;
                    document.getElementById('spanSiTraslado').hidden = false;
                } else {
                    document.getElementById('spanNoTraslado').hidden = false;
                    document.getElementById('spanSiTraslado').hidden = true;
                }

                formulario.querySelector("#claveImpuesto").readOnly = true;



                formulario.querySelector('#idImpuestos').focus();
                formulario.querySelector('#claveImpuesto').focus();
                formulario.querySelector('#descripcionImpuesto').focus();
            }
        });
    });
    document.querySelector('#Baja').style.display = "none";
//++++++++++++++++++++++++++++++




//*****************Funcion limpiar para quitar boton y estiñps en tabla 
    document.addEventListener('DOMContentLoaded', function () {
        // Agregar el event listener para el botón de limpiar
        document.querySelector('#Limpiar').addEventListener('click', function () {
            // Esta función se ejecutará cuando se haga clic en el botón de limpiar
            document.querySelector("#claveImpuesto").readOnly = false;
            document.querySelector("#idImpuestos").readOnly = false;
            document.querySelector("#claveImpuesto").readOnly = false;
            document.querySelector("#esRetenido").disabled = false;
            document.querySelector("#esTraslado").disabled = false;
            document.querySelector("#descripcionImpuesto").readOnly = false;
            document.getElementById('spanNoRetenido').hidden = false;
            document.getElementById('spanSiRetenido').hidden = true;
            document.getElementById('spanNoTraslado').hidden = false;
            document.getElementById('spanSiTraslado').hidden = true;


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
//***************************************FUNCION PARA MENSAJES 
// Espera a que se cargue completamente el DOM antes de ejecutar el script
    document.addEventListener("DOMContentLoaded", function () {
        // Cerrar la alerta después de 3.5 segundos
        setTimeout(function () {
            let alerta = document.querySelector("#myAlert");
            if (alerta) {
                alerta.style.display = "none";
            }
        }, 3500);
    });
//********************************************
    //********************************************
    window.onload = function () {
        // Borrar los valores de los campos del formulario
        document.getElementById("formulario").reset();
    };
</script>
<%@include file="../Pie.jsp"%>
