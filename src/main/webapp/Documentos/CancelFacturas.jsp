<%-- 
    Document   : JSP_CFacturas
    Created on : 30/06/2023, 02:36:47 PM
    Author     : Serv_Social
--%>
<%@ page import="java.util.List"%>

<%@include file="../Encabezado.jsp"%>
<%
 System.out.println("---------------------Cancelacion de facturas JSP---------------------");
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
    .input-group-append {
        cursor: pointer;
    }
</style>
<style>
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
    /* Cambiar el color de la bolita cuando el switch está desactivado */
    .form-check-input:not(:checked)::after {
        background-color: #6c757d; /* Bolita gris cuando no está activado */
    }
</style>
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
        <h3>CANCELACIÓN DE FACTURAS</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
    <!-- Tabs navs -->
    <ul class="nav nav-tabs nav-justified mb-3 stc" id="ex1" role="tablist">
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link active" id="ex3-tab-1" href="#ex3-tabs-1" role="tab" aria-controls="ex3-tabs-1" aria-selected="true">
                CANCELACIÓN DE FACTURAS
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-2" href="#ex3-tabs-2" role="tab" aria-controls="ex3-tabs-2" aria-selected="false">
                 ARCHIVO DE EXCEL PARA CANCELACIÓN DE FACTURAS
            </a>
        </li>
    </ul>
    <!-- Tabs navs -->

    <!-- Tabs content -->
    <div class="tab-content" id="ex2-content">
         <div class="tab-pane fade show active" id="ex3-tabs-1" role="tabpanel" aria-labelledby="ex3-tab-1">
            <form>
            <h5 class="stc" style="text-align: center;">CANCELACIÓN DE FACTURAS</h5>
            <hr>
            <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" role="switch" id="cancelarFacturas">
                <label class="form-check-label" for="cancelarFacturas">CANCELAR FACTURAS</label>
            </div>
            <br>
            <div class="row mb-4">
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;background-color: gainsboro !important;" class="form-control form-control-sm" data-mdb-select-init class="form-select form-select-sm" name="serie" id="serie" aria-label="Default select example" style="font-size: 105%;" disabled required>
                            <option value="" disabled selected style="display: none;"></option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="NC">NC</option>
                        </select>
                        <label class="form-label" for="serie">SERIE</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="folio" name="folio" class="form-control form-control-sm"/>
                        <label class="form-label" for="folio">FOLIO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="date" name="fecha" id="fecha" disabled class="form-control form-control-sm"/>
                        <label class="form-label" for="fecha">FECHA</label>
                    </div>
                </div>
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;background-color: gainsboro !important;" class="form-control form-control-sm" data-mdb-select-init class="form-select form-select-sm" name="timbrada" id="timbrada" aria-label="Default select example" style="font-size: 105%;" disabled required>
                            <option value="" disabled selected style="display: none;"></option>
                            <option value="S">SI</option>
                            <option value="N">NO</option>
                        </select>
                        <label class="form-label" for="timbrada">FACTURA TIMBRADA</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="responsableCancelacion" name="responsableCancelacion" class="form-control form-control-sm"/>
                        <label class="form-label" for="responsableCancelacion">RESPONSABLE DE CANCELACIÓN</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                 <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="rfc" name="rfc" class="form-control form-control-sm"/>
                        <label class="form-label" for="rfc">RFC</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="nombre" name="nombre" class="form-control form-control-sm"/>
                        <label class="form-label" for="nombre">NOMBRE</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <!-- Message input -->
                    <div data-mdb-input-init class="form-outline mb-4" style="background-color: white;">
                        <textarea style="font-weight: bold;text-transform: uppercase;"  class="form-control form-control-sm" name="motivoCancelacion" id="motivoCancelacion" rows="3"></textarea>
                        <label class="form-label" for="motivoCancelacion">MOTIVO DE CANCELACIÓN</label>
                    </div>
                </div>
            </div>
           <div class="stc" style="justify-content: center; display: flex;">
                    <button type="submit" id="Estatus" name="action" value="103" style="color:white; background-color: #A70303;" class="btn btn-danger btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="ELIMINAR">
                    <i class="fas fa-trash"></i>
                    <span class="btn-text">CANCELAR</span>
                </button>
                <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar"><!--Boton tipo reset-->
                    <i class="fas fa-eraser"></i>
                    <span class="btn-text">LIMPIAR</span>
                </button>
            </div>     
                </form>
                <br>
                <br>
                
            <h5 class="stc" style="text-align: center;">LISTADO DE FACTURAS CANCELADAS</h5>
            <hr>
            <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
                <label class="form-check-label" for="flexSwitchCheckDefault">LISTADO DE FACTURAS CANCELADAS</label>
            </div>
            <br>
            <div class="row mb-4">
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;background-color: gainsboro !important;" class="form-control form-control-sm" data-mdb-select-init class="form-select form-select-sm" name="serieFactura" id="serieFactura" aria-label="Default select example" style="font-size: 105%;" disabled required>
                            <option value="" disabled selected style="display: none;"></option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="NC">NC</option>
                        </select>
                        <label class="form-label" for="serieFactura">SERIE DE FACTURA</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="date" name="fecha1" id="fecha1" disabled class="form-control form-control-sm"/>
                        <label class="form-label" for="fecha1">FECHA 1</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="date" name="fecha2" id="fecha2" disabled class="form-control form-control-sm"/>
                        <label class="form-label" for="fecha1">FECHA 2</label>
                    </div>
                </div>
            </div>
            <div class="stc" style="justify-content: center; display: flex;">
                <button type="submit" name="action" value="" title="Imprimir" class="btn btn-sm btn-rounded stc" style="color:white; background-color: purple;" data-mdb-ripple-init>
                    <i class="bi bi-printer-fill"></i>
                    <span class="btn-text">IMPRIMIR</span>
                </button>
                <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar"><!--Boton tipo reset-->
                    <i class="fas fa-eraser"></i>
                    <span class="btn-text">LIMPIAR</span>
                </button>
            </div>
        </div>


        
        
    <div class="tab-pane fade" id="ex3-tabs-2" role="tabpanel" aria-labelledby="ex3-tab-2">
        <div class="row">
            <h5 class="stc" style="text-align: center;">ARCHIVO DE EXCEL PARA CANCELACIÓN DE FACTURAS</h5>
            <hr>
            <div class="row mb-4 ">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" id="form6Example1" class="form-control" />
                        <label class="form-label" for="form6Example1">FOLIO FISCAL</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="date" id="form6Example1" class="form-control" />
                        <label class="form-label" for="form6Example1">FECHA</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" id="form6Example1" class="form-control" />
                        <label class="form-label" for="form6Example1">RFC</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="number" id="form6Example1" class="form-control" />
                        <label class="form-label" for="form6Example1">IMPORTE</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <select data-mdb-select-init class="form-select" aria-label="Default select example" style="font-size: 105%;">
                        <option selected>SERIE DE FACTURA</option>
                        <option value="1">Op 1</option>
                        <option value="2">Op 2</option>
                    </select>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" id="form6Example1" class="form-control" />
                        <label class="form-label" for="form6Example1">No. DE FACTURA</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" id="form6Example1" class="form-control" />
                        <label class="form-label" for="form6Example1">NOMBRE</label>
                    </div>
                </div>
            </div>
            <div class="row d-flex justify-content-center p-3">
                <div class="contenedortabla table-responsive">
                    <table id="titulo" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-dark">
                            <tr>
                                <th>RENGLÓN</th>
                                <th>SERIE</th>
                                <th>No. DE FACTURA</th>
                                <th>FOLIO FISCAL</th>
                                <th>FECHA FACTURA</th>
                                <th>RFC</th>
                                <th>IMPORTE FACTURA</th>
                                <th>USUARIO CANCELA</th>
                            </tr>
                        </thead>
                        <tbody id="datos" style="font-size: 85%;">
                            <tr>
                                <td>RENGLÓN</td>
                                <td>SERIE</td>
                                <td>No. DE FACTURA</td>
                                <td>FOLIO FISCAL</td>
                                <td>FECHA FACTURA</td>
                                <td>RFC</td>
                                <td>IMPORTE FACTURA</td>
                                <td>USUARIO CANCELA</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="stc" style="justify-content: center; display: flex;">
                <button type="button" title="Excel" id="imprimir-btn" title="Imprimir" class="btn btn-outline-success btn-sm btn-rounded stc" data-mdb-ripple-init  data-mdb-ripple-color="dark" onclick="exportTableToExcel('concepto-table', 'conceptos.xls')" >
                    <i class="bi bi-file-earmark-spreadsheet-fill"></i>
                    <span class="btn-text">ARCHIVO EXCEL</span>
                </button>

                <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar"><!--Boton tipo reset-->
                    <i class="fas fa-eraser"></i>
                    <span class="btn-text">LIMPIAR</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Tabs content -->
<br>



<script  type="text/javascript">
//ACTIVAR CASILLAS IMPRESION MEMORANDUM
    var cance = document.getElementById("CFac");
    cance.addEventListener('click', function () {
        if (cance.checked) {
            document.getElementById("ser1").disabled = false;
            document.getElementById("NFac1").disabled = false;
            document.getElementById("fch11").disabled = false;
            document.getElementById("timbr").disabled = false;
            document.getElementById("Resp").disabled = false;
            document.getElementById("rfc").disabled = false;
            document.getElementById("Nom1").disabled = false;
            document.getElementById("MCan1").disabled = false;
            document.getElementById("btncancelar").disabled = false;
        } else {
            document.getElementById("ser1").disabled = true;
            document.getElementById("NFac1").disabled = true;
            document.getElementById("fch11").disabled = true;
            document.getElementById("timbr").disabled = true;
            document.getElementById("Resp").disabled = true;
            document.getElementById("rfc").disabled = true;
            document.getElementById("Nom1").disabled = true;
            document.getElementById("MCan1").disabled = true;
            document.getElementById("btncancelar").disabled = true;
        }
    });

//ACTIVAR CASILLAS LISTADO CANCELADO FACTURAS
    var LISTC = document.getElementById("LFCan");
    LISTC.addEventListener('click', function () {
        if (LISTC.checked) {
            document.getElementById("ser2").disabled = false;
            document.getElementById("fch21").disabled = false;
            document.getElementById("fch31").disabled = false;
            document.getElementById("btnimprimir").disabled = false;
        } else {
            document.getElementById("ser2").disabled = true;
            document.getElementById("fch21").disabled = true;
            document.getElementById("fch31").disabled = true;
            document.getElementById("btnimprimir").disabled = true;
        }
    });

    document.getElementById('formulario').addEventListener('submit', function (event) {
        var inputs = document.getElementsByTagName('input');
        var area = document.getElementsByTagName('textarea');
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].type === 'text') {
                inputs[i].value = inputs[i].value.toUpperCase();
            } else if (inputs[i].type === 'email') {
                inputs[i].value = inputs[i].value.toLowerCase();
            }
        }
        for (var i = 0; i < area.length; i++) {
            if (area[i].type === 'text') {
                area[i].value = area[i].value.toUpperCase();
            }
        }

    });

</script>


</main>
<%@include file="../Mensaje.jsp"%>
<%@include file="../Pie.jsp"%>



