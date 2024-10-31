<%-- 
    Document   : bancos
    Created on : 1 mar 2024, 17:34:43
    Author     : Lezly Oliván
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@include file="../Encabezado.jsp"%>

<%
    System.out.println("---------------------BANCOS JSP---------------------");
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

    .error {
        color: red;
        display: none;
        font-size: 12px;
    }


</style>
<!-- Cuerpo -->
<main class="col ps-md-2 pt-2 mx-3">
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <div class="page-header pt-3 stc">
        <h3>CATÁLOGO DE BANCOS</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
    <form action="Srv_Bancos" method="POST" id="formulario" class="fontformulario" style="font-size: 80%; margin: 15px;">
        <!-- 2 column grid layout with text inputs for the first and last names -->
        <div class="row mb-4">
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <!--Añadir form-control-sm para los input-->
                    <input style="font-weight: bold;" type="text" id="nombreBanco" name="nombreBanco" class="form-control" pattern="(?<![^\s.,:;áéíóúÁÉÍÓÚ])[\p{L}\d.,:;áéíóúÁÉÍÓÚ]+(?:\s[\p{L}\d.,:;áéíóúÁÉÍÓÚ]+)*(?![^\s.,:;áéíóúÁÉÍÓÚ])" title="El campo debe contener solo letras y no espacios al principio o al final." maxlength="100" required="" onchange="validarNombreBanco()"/>
                    <label class="form-label" for="nombreBanco">NOMBRE DEL BANCO</label>
                </div>
            </div>
            <div class="col">
                <input type="text" class="form-control form-control-sm"  id="idBanco" name="idBanco" value="" hidden="true" />
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input style="font-weight: bold;" type="text" id="rfcBanco" name="rfcBanco" class="form-control" maxlength="12" required="" oninput="validarRFC()" pattern="^[A-Za-z]{3}\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])[A-Za-z0-9]{3}$" title="El RFC enviado es inválido"/>
                    <label class="form-label" for="descripcion">(12)  RFC DEL BANCO</label>
                </div>
                <small id="rfcBancoError" class="error form-text">RFC del banco inválido.</small>
            </div>
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
            <button type="reset" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar" id="Limpiar">
                <i class="fas fa-eraser"></i>
                <span class="btn-text d-none d-sm-inline">LIMPIAR</span>
            </button>

        </div>
    </form>
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
                <th><button type="submit" name="action" value="204" title="IMPRIMIR EN PDF" class="stc btn btn-primary btn-sm btn-rounded" style="color:white; background-color: purple;" data-mdb-ripple-init>
                        <i class="fas fa-print"></i>
                        <span class="d-none d-sm-inline">IMPRIMIR EN PDF</span>
                    </button>
                </th>
            </form>
            <button type="button" id="imprimir-btn" title="EXPORTAR A EXCEL" class="btn btn-outline-success btn-sm btn-rounded stc" data-mdb-ripple-init  data-mdb-ripple-color="dark" onclick="exportTableToExcel('bancoTabla', 'Bancos.xls')" hidden="true">
                <i class="fas fa-file-excel"></i>
                <span class="d-none d-sm-inline">EXPORTAR A EXCEL</span>
            </button>
        </div>
    </div>
    <div class="row d-flex justify-content-center p-3">
        <c:if test="${not empty bnlista}">
            <div class="text-center" style="position: relative; width: 80%;">
                <div class="table-responsive" style="height: 270px;">
                    <table id="bancoTabla" class="fontformulario table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-secondary">
                            <tr style="color:white;">
                                <th class="d-none">*</th>
                                <th class="fw-bold">RFC BANCO</th>
                                <th class="fw-bold">NOMBRE BANCO</th>
                            </tr>
                        </thead>
                        <tbody id="datos" style="font-size: 80%;">
                            <c:forEach var="banco" items="${bnlista}">
                                <tr>
                                    <td class="text-center id-banco d-none">${banco.idBanco}</td>
                                    <td class="texto-largo">${not empty banco.rfc ? banco.rfc : ""}</td>
                                    <td class="texto-largo">${banco.nombre}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
        <c:if test="${empty bnlista}">
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
    window.onload = function () {
        // Borrar los valores de los campos del formulario
        document.getElementById("formulario").reset();
    };


    function validarNombreBanco() {
        let nombreBanco = document.getElementById('nombreBanco').value;
        let rfcBancoInput = document.getElementById('rfcBanco');
        let nombreWithOutSpaces = nombreBanco.replace(/ /g, "");
        if (nombreWithOutSpaces.toUpperCase() === 'PAGOENCAJAGENERALDELSTC') {
            rfcBancoInput.required = false;
            rfcBancoInput.disabled = true;
        } else {

            rfcBancoInput.required = true;
            rfcBancoInput.disabled = false;
        }
    }

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
                formulario.querySelector("#rfcBancoError").innerText = "";


                document.querySelector('#Guardar').style.display = "none";
                document.querySelector('#Modificar').style.display = "block";
                document.querySelector('#Baja').style.display = "block";


                // Obtener los datos de la fila
                let idBanco = fila.querySelector('.id-banco').innerText;
                let rfcBanco = fila.querySelector('.texto-largo:nth-child(2)').innerText;
                let nombreBanco = fila.querySelector('.texto-largo:nth-child(3)').innerText;

                if (nombreBanco === "PAGO EN CAJA GENERAL DEL STC") {
                    formulario.querySelector("#rfcBanco").readOnly = true;
                    formulario.querySelector("#nombreBanco").readOnly = true;
                    document.querySelector('#Guardar').style.display = "none";
                    document.querySelector('#Modificar').style.display = "none";
                    document.querySelector('#Baja').style.display = "none";

                } else {
                    formulario.querySelector("#nombreBanco").readOnly = false;
                    formulario.querySelector("#idBanco").readOnly = false;
                    formulario.querySelector("#rfcBanco").readOnly = false;
                }

                // Ingresa los valores a los cuadros de texto
                formulario.querySelector("#idBanco").value = idBanco;
                formulario.querySelector("#rfcBanco").value = rfcBanco;
                formulario.querySelector("#nombreBanco").value = nombreBanco;



                formulario.querySelector('#idBanco').focus();
                formulario.querySelector('#rfcBanco').focus();
                formulario.querySelector('#nombreBanco').focus();
            }
        });
    });
    document.querySelector('#Baja').style.display = "none";
//++++++++++++++++++++++++++++++




//*****************Funcion limpiar para quitar boton y estiñps en tabla 
    document.addEventListener('DOMContentLoaded', function () {
        // Agregar el event listener para el botón de limpiar
        document.querySelector('#Limpiar').addEventListener('click', function () {
            document.querySelector("#rfcBanco").readOnly = false;
            formulario.querySelector("#idBanco").readOnly = false;
            formulario.querySelector("#nombreBanco").readOnly = false;
            formulario.querySelector("#rfcBanco").readOnly = false;

            document.getElementById("idBanco").blur();
            document.getElementById("rfcBanco").blur();
            document.getElementById("nombreBanco").blur();
            formulario.querySelector("#rfcBancoError").innerText = "";
            // Esta función se ejecutará cuando se haga clic en el botón de limpiar
            document.querySelector('#Guardar').style.display = "block";
            document.querySelector('#Modificar').style.display = "none";
            document.querySelector('#Baja').style.display = "none";
            if (document.querySelector('.selected')) {
                document.querySelector('.selected').classList.remove('selected');
            }
        });
    });



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


    function validarRFC() {
        const rfcInput = document.getElementById('rfcBanco');
        const rfcError = document.getElementById('rfcBancoError');
        const rfc = rfcInput.value.toUpperCase();

        const letras = rfc.substr(0, 3);
        const año = rfc.substr(3, 2);
        const mes = rfc.substr(5, 2);
        const dia = rfc.substr(7, 2);
        const homoclave = rfc.substr(9, 3);

        // Validar las primeras 3 letras
        const letrasPattern = /^[A-ZÑ&]{3}$/;
        if (!letrasPattern.test(letras)) {
            rfcError.innerText = 'Las primeras 3 letras deben ser letras mayúsculas.';
            rfcError.style.display = 'block';
            return;
        }

        // Validar año
        const añoPattern = /^\d{2}$/;
        if (!añoPattern.test(año)) {
            rfcError.innerText = 'El año debe ser 2 dígitos (00-99).';
            rfcError.style.display = 'block';
            return;
        }

        // Validar mes
        const mesPattern = /^(0[1-9]|1[0-2])$/;
        if (!mesPattern.test(mes)) {
            rfcError.innerText = 'El mes debe ser entre 01 y 12.';
            rfcError.style.display = 'block';
            return;
        }

        // Validar día
        const diaPattern = /^(0[1-9]|[12]\d|3[01])$/;
        if (!diaPattern.test(dia)) {
            rfcError.innerText = 'El día debe ser válido para el mes seleccionado.';
            rfcError.style.display = 'block';
            return;
        }

        // Validar homoclave
        const homoclavePattern = /^[A-Z0-9]{3}$/;
        if (!homoclavePattern.test(homoclave)) {
            rfcError.innerText = 'La homoclave debe ser 3 caracteres (letras o números).';
            rfcError.style.display = 'block';
            return;
        }

        // Si todo está bien, ocultar el mensaje de error
        rfcError.style.display = 'none';
    }

    function validateForm(event) {
        validarRFC();
        const rfcError = document.getElementById('rfcBancoError');
        if (rfcError.style.display === 'block') {
            event.preventDefault();
        }
    }

    document.getElementById('formulario').addEventListener('submit', validateForm);


    //********************************************
    window.onload = function () {
        // Borrar los valores de los campos del formulario
        document.getElementById("formulario").reset();
    };

</script>
<script>
    const nombreBancoInput = document.getElementById('nombreBanco');
    const rfcBancoInput = document.getElementById('rfcBanco');

    nombreBancoInput.addEventListener('blur', () => {
        nombreBancoInput.value = nombreBancoInput.value.trim();
    });

    rfcBancoInput.addEventListener('blur', () => {
        rfcBancoInput.value = rfcBancoInput.value.trim();
    });
</script>
<%@include file="../Pie.jsp"%>
