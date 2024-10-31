<%-- 
    Document   : AdminUsuarios
    Created on : 13 feb 2024, 13:21:19
    Author     : Ing. Evelyn Leilani Avendaño 
--%>
<%
    System.out.println("---------------------AdminUsuarios JSP---------------------");
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

<!-- Cuerpo del catalogo -->
<main class="col ps-md-2 pt-2 mx-3">
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i></a>
    <br>
    <div class="page-header pt-3 stc">
        <h3>ADMINISTRACIÓN DE USUARIOS</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;"></div>
    <hr>
<form id="formulario" action="PENDIENTE" method="POST" id="formulario" class="fontformulario" style="font-size: 80%; margin: 15px;">
    <div class="row mb-4">
        <div class="col">
             <div data-mdb-input-init class="form-outline" style="background-color: white;">
                <input type="text" style="font-weight: bold;" id="nombre" name="nombre" class="form-control"  pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." style="font-weight: bold;" onblur="this.value = this.value.trim()" required />
                <label class="form-label" for="nombre">NOMBRE</label>
             </div>
        </div>
        <div class="col mb-3">
            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                <input type="text" style="font-weight: bold;" id="apellido_paterno" name="apellido_paterno" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." onblur="this.value = this.value.trim()" required/>
                <label class="form-label" for="apellido_paterno">APELLIDO PATERNO</label>
            </div>
        </div>
        <div class="col mb-3">
            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                <input type="text" style="font-weight: bold;" id="apellido_materno" name="apellido_materno" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." onblur="this.value = this.value.trim()" required/>
                <label class="form-label" for="apellido_materno">APELLIDO MATERNO</label>
            </div>
        </div>
    </div>
    <!-- AQUI IRAN LOS SELECT DE AREA Y PERFIL ASI COMO EL INPUT DE USUARIO-->
     <div class="row mb-4">
        <div class="col">
            <div class="form-outline mdb-input">
                <select data-mdb-select-init class="form-select" id="area" name="area" style="font-size: 105%; font-weight: bold;" required>
                </select>
                <label class="form-label" for="area">ÁREA</label>
            </div>
        </div>
        <div class="col">
            <div class="form-outline mdb-input">
                <select data-mdb-select-init class="form-select" id="perfil" name="perfil" style="font-size: 105%; font-weight: bold;" required>
                </select>
                <label class="form-label" for="perfil">PERFIL</label>
            </div>
        </div>
        <div class="col">
            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                <input type="text" style="font-weight: bold;" id="usuario" name="usuario" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." onblur="this.value = this.value.trim()" readonly />
                <label class="form-label" for="usuario">USUARIO</label>
            </div>
        </div>
    </div>
    <!-- AQUI TERMINAN LOS SELECT DE AREA Y PERFIL ASI COMO EL INPUT DE USUARIO-->   
       <!-- seccion de botones -->
        <br>
        <div class="stc" style="justify-content: center; display: flex;" > 
            <button type="submit" id="Guardar" name="action" value="101" style="color:white;background-color: #008A13; margin-top: 2rem; margin-bottom: 2rem" class="btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="GUARDAR">
                <i class="fas fa-floppy-disk"></i>
                <span class="btn-text">GUARDAR</span>
            </button>
            <button type="submit" id="Modificar" name="action" value="102" style="display: none; color:white; background-color: #0370A7;  margin-top: 2rem; margin-bottom: 2rem; display:none;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="MODIFICAR">
                <i class="fas fa-pen-to-square"></i>
                <span class="btn-text">MODIFICAR</span>
            </button>
            <button type="submit" id="Estatus" name="action" value="103" style="display: none; color:white; background-color: #A70303;  margin-top: 2rem; margin-bottom: 2rem; display:none;" class="btn btn-danger btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="ELIMINAR">
                <i class="fas fa-trash"></i>
                <span class="btn-text">ELIMINAR</span>
            </button>
            <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="LIMPIAR" style="margin-top: 2rem; margin-bottom: 2rem" onclick="limpiarFormulario()"><!--Boton tipo reset-->
                <i class="fas fa-eraser"></i>
                <span class="btn-text">LIMPIAR</span>
            </button>
        </div>
        <!-- finaliza seccion de botones -->
</form>
    <!-- Input de Búsqueda y Botón Imprimir -->
    <div class="row justify-content-center mb-3">
        <div class="col-md-3">
            <div data-mdb-input-init class="form-outline fontformulario">
                <input type="text" id="busqueda" class="form-control form-control-sm" style="font-weight: bold; background-color: white; width: 800px;" oninput="filterTable()"/>
                <label class="form-label" for="busqueda">BUSCAR</label>
            </div>
        </div>
    </div>
    <!-- Botón Imprimir o Exportar si es necesario -->
    <!--<div class="col-md-4" style="text-align: left;">
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
    </div> -->  
<!--Termina aquí boton de busqueda e impresion -->

<!-- esto pertence a la tabla  -->
    <div class="row d-flex justify-content-center p-3">
    <div class="text-center" style="position: relative; width: 100%;">
        <div class="table-responsive" style="height: 270px;">
            <table id="concepto-table" class="fontformulario table table-hover table-bordered table-sm" style="font-size: 90%;background-color: #fff;">
                    <thead class="table-secondary">
                        <tr>
                            <th class="d-none">*</th>
                            <th class="fw-bold">NOMBRE</th>
                            <th class="fw-bold">APELLIDO PATERNO</th>
                            <th class="fw-bold">APELLIDO MATERNO</th>
                            <th class="fw-bold" style="display: none;">ÁREA</th>
                            <th class="fw-bold">NOMBRE ÁREA</th>
                            <th class="fw-bold" style="display: none;">PERFIL</th>
                            <th class="fw-bold">NOMBRE PERFIL</th>
                            <th class="fw-bold">USUARIO</th>
                        </tr>
                    </thead>
                    <tbody id="datos" style="font-size: 75%;">
                        <tr onclick="seleccionarFila(this)">
                           <td>Cristobal</td>
                           <td>Alvarez</td>
                           <td>Quintero</td>
                           <td style="display: none;">2</td>
                           <td>Sistemas</td>
                           <td style="display: none;">2</td>
                           <td>Sistemas</td>
                           <td>Cristobal</td>
                        </tr>
                        <tr>
                           <td>Diana</td>
                           <td>Orocio</td>
                           <td>Lucio</td>
                           <td style="display: none;">2</td>
                           <td>Administracion</td>
                           <td style="display: none;">2</td>
                           <td>Administrador</td>
                           <td>Diana</td>
                        </tr>
                    </tbody>
                </table>
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
          </div>
    </div>
</div>
<!-- hasta aqui pertence a la tabla  -->
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

    <!-- Agrega el enlace a la biblioteca html2pdf -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
    <!-- Script para manejar el evento de clic en el botón de impresión -->


<script>
    
window.onload = function() {
    var alert = document.getElementById('mensajeAlert');
    if (alert) {
        setTimeout(function() {
            alert.style.display = 'none';
        }, 2000);
    }
};
function filterTable() {
    const busqueda = document.getElementById('busqueda').value.toLowerCase();
    const rows = document.querySelectorAll('#datos tr');

    rows.forEach(row => {
        const cells = row.getElementsByTagName('td');
        let rowContainsSearchTerm = false;

        for (let cell of cells) {
            if (cell.textContent.toLowerCase().includes(busqueda)) {
                rowContainsSearchTerm = true;
                break;
            }
        }

        if (rowContainsSearchTerm) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

//Funcion para llenar el formulario cuando se hace clic en una fila 
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
                
                    // Obtener los datos de la fila
                    //let idConcepto = fila.querySelector('.id-concepto').innerText;
                    let nombre = fila.querySelector('.texto-largo:nth-child(1)').innerText;
                    let apellido_paterno = fila.querySelector('.texto-largo:nth-child(2)').innerText;
                    //let dataValue = document.querySelector('#ListTipoIngreso option[value="' + tipoIngreso + '"]').getAttribute("data-value");
                    let apellido_materno = fila.querySelector('.texto-largo:nth-child(3)').innerText;
                    let area = fila.querySelector('.texto-largo:nth-child(4)').innerText;
                    let perfil = fila.querySelector('.texto-largo:nth-child(5)').innerText;
                    let usuario = fila.querySelector('.texto-largo:nth-child(6)').innerText;

                    // Ingresa los valores a los cuadros de texto
                    //formulario.querySelector("#idConcepto").value = idConcepto;
                    formulario.querySelector("#nombre").value = nombre;
                    //formulario.querySelector("#nombreConcepto").readOnly = true;
                    //formulario.querySelector("#tipoIngreso").value = dataValue;
                    formulario.querySelector("#apellido_paterno").value = apellido_paterno;
                    formulario.querySelector("#apellido_materno").value = apellido_materno;
                    formulario.querySelector("#area").value = area;
                    formulario.querySelector("#perfil").value = perfil;
                    formulario.querySelector("#usuario").value = usuario;
                    formulario.querySelector("#usuario").readOnly = true;


                    //formulario.querySelector("#idConcepto").focus();
                    formulario.querySelector("#nombre").focus();
                    formulario.querySelector("#apellido_paterno").focus();
                    formulario.querySelector("#apellido_materno").focus();
                    formulario.querySelector("#area").focus();
                    formulario.querySelector("#perfil").focus();
                    formulario.querySelector("#usuario").focus();
                }
            });
        });
        document.querySelector('#Estatus').style.display = "none";
        //*****************Funcion limpiar para quitar boton y estiñps en tabla 
        document.addEventListener('DOMContentLoaded', function () {
            // Agregar el event listener para el botón de limpiar
            document.querySelector('#Limpiar').addEventListener('click', function () {
                //document.querySelector("#nombreConcepto").readOnly = false;
                document.getElementById("nombre").blur();
                document.getElementById("apellido_paterno").blur();
                document.getElementById("apellido_materno").blur();
                document.getElementById("area").blur();
                document.getElementById("perfil").blur();
                document.querySelector("#usuario").readOnly = false;
                // Esta función se ejecutará cuando se haga clic en el botón de limpiar
                document.querySelector('#Guardar').style.display = "block";
                document.querySelector('#Modificar').style.display = "none";
                document.querySelector('#Estatus').style.display = "none";
               // document.querySelector('#tipoIngreso').style.fontWeight = "normal";
                if (document.querySelector('.selected')) {
                    document.querySelector('.selected').classList.remove('selected');
                }
            });
        });
        //*******************************************************************



</script>
    <%@include file="../Pie.jsp"%>