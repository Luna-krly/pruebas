<%-- 
    Document   : memo_gen
    Created on : 4 mar 2024, 16:38:01
    Author     : Lezly Oliván
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@include file="../Encabezado.jsp"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>

<%-- CLIENTE--%>
<%@page import="Objetos.obj_MGeneral"%>
<%! List<obj_MGeneral> memorandumLista;%>


<%
   System.out.println("---------------------Memorandum General JSP---------------------");
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
        <h3>MEMORÁNDUM GENERAL</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <p class="fw-bold text-center" style="color: #1346B4;">${mensaje.getDescripcion()}</p>
    <hr>

    <!-- Tabs navs -->
    <ul class="nav nav-tabs nav-justified mb-3 stc" id="ex1" role="tablist">
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link active" id="ex3-tab-1" href="#ex3-tabs-1" role="tab" aria-controls="ex3-tabs-1" aria-selected="true">
                CAPTURA DE MEMORÁNDUMS
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-2" href="#ex3-tabs-2" role="tab" aria-controls="ex3-tabs-2" aria-selected="false">
                REPORTES E IMPRESIÓN DE MEMORÁNDUMS
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-3" href="#ex3-tabs-3" role="tab" aria-controls="ex3-tabs-3" aria-selected="false">
                CANCELACIÓN Y ACTIVACIÓN DE MEMORÁNDUMS
            </a>
        </li>
    </ul>
    <!-- Tabs navs -->
    <script>
        // Función para agregar estilo con !important
        function addImportantStyle(nombreInput) {
            var sheet = document.createElement('style');
            sheet.id = 'importantStyle-' + nombreInput;
            sheet.innerHTML = '#' + nombreInput + ' { background-color: gainsboro !important; }';
            document.head.appendChild(sheet);
        }

        // Función para eliminar estilo con !important y agregar uno nuevo
        function removeImportantStyle(nombreInput) {
            // Eliminar el estilo anterior
            var sheet = document.getElementById('importantStyle-' + nombreInput);
            if (sheet) {
                sheet.parentNode.removeChild(sheet);
            }

            // Agregar un nuevo estilo con !important para sobrescribir el anterior
            var newSheet = document.createElement('style');
            newSheet.id = 'overrideStyle-' + nombreInput;
            newSheet.innerHTML = '#' + nombreInput + ' { background-color: white !important; }';
            document.head.appendChild(newSheet);
            document.getElementById(nombreInput).style.backgroundColor = 'White';
        }
    </script>
    <!-- Tabs content -->
    <div class="tab-content" id="ex2-content">
        <div class="tab-pane fade show active" id="ex3-tabs-1" role="tabpanel" aria-labelledby="ex3-tab-1">
            <h5 class="stc" style="text-align: center;">CAPTURA DE MEMORÁNDUMS</h5>
            <hr>
            <form action="Srv_MGeneral" method="POST" id="formularioMemorandum" class="fontformulario" style="font-size: 75%; margin: 15px;">
                <div class="row mb-4">
                    <input style="font-weight: bold;" type="text" id="noMemorandum" name="noMemorandum" class="form-control form-control-sm" hidden/>
                    <input style="font-weight: bold;" type="text" id="idMemorandum" name="idMemorandum" class="form-control form-control-sm" hidden/>
                    <input style="font-weight: bold;" type="text" id="idConcepto" name="idConcepto" class="form-control form-control-sm" hidden/>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="nombreConcepto" name="nombreConcepto" list="ListaConcepto" onchange="get_idConcepto()" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required/>
                            <datalist id="ListaConcepto">
                                <c:forEach var="concepto" items="${conceptolista}">
                                    <option data-value="${concepto.idConcepto}" value="${concepto.nombre}"></option>
                                </c:forEach>
                            </datalist>
                            <label class="form-label" for="nombreConcepto">NOMBRE DEL CONCEPTO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="remitente" name="remitente" class="form-control form-control-sm" readOnly onblur="this.value = this.value.trim()" required/>
                            <label class="form-label" for="remitente">REMITENTE</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="destinatario" name="destinatario" class="form-control form-control-sm" readOnly onblur="this.value = this.value.trim()" required/>
                            <label class="form-label" for="destinatario">DESTINATARIO</label>
                        </div>
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="date" id="fecha" name="fecha" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required />
                            <label class="form-label" for="fecha">FECHA</label>
                        </div>
                    </div>
                    <script>
                        // Obtiene la fecha de hoy en el formato YYYY-MM-DD
                        var hoy = new Date().toISOString().split('T')[0];
                        // Asigna la fecha de hoy al atributo max del input
                        document.getElementById('fecha').setAttribute('max', hoy);
                    </script>
                    
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" style="font-weight: bold;" list="ListTipoIngreso" name="tingreso" id="tingreso" onChange="get_ti()"  class="form-control form-control-sm" onblur="this.value = this.value.trim()" required/>
                            <input type="hidden" style="font-weight: bold;"  name="tipoIngreso" id="tipoIngreso" onblur="this.value = this.value.trim()" value="">
                            <label class="form-label" for="clt">TIPO DE INGRESO</label>
                            <datalist id="ListTipoIngreso">
                                <c:forEach var="ingresoc" items="${ingresosclista}">
                                    <option data-value="${ingresoc.idTipoIngresoC}" value="${ingresoc.claveTipoInrgesoC} - ${ingresoc.descripcionTipoIngresoC}"></option>
                                </c:forEach>
                            </datalist>
                            <label class="form-label" for="tipoIngreso">TIPO DE INGRESO</label>
                        </div>
                    </div>
                </div>


                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <textarea style="font-weight: bold;" class="form-control form-control-sm" id="conceptoGeneral" name="conceptoGeneral" rows="3" onblur="this.value = this.value.trim()" required></textarea>
                            <label class="form-label" for="conceptoGeneral">CONCEPTO GENERAL</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" step="0.01" min="0" type="number" id="total" name="total"  onchange="CalcularImporte()"  class="form-control form-control-sm" onblur="this.value = this.value.trim()" required />
                            <label class="form-label" for="total">TOTAL</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" step="0.000001" min="0" id="retenido" name="retenido" onchange="CalcularImporte()" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required/>
                            <label class="form-label" for="retenido">RETENIDO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" step="0.000001" min="0" type="number" id="IVA" name="IVA" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required/>
                            <label class="form-label" for="IVA">I.V.A.</label>
                        </div>
                    </div>

                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" step="0.01" min="0" id="subtotal" name="subtotal" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required/>
                            <label class="form-label" for="subtotal">SUBTOTAL</label>
                        </div>
                    </div>
                    <script>
                        //--------------------------------CALCULA TOTAL
                    function CalcularImporte() {
                    console.log("CalcularImporte");
                    // Obtener valores de los elementos y convertir a números
                    let retenido = parseFloat(document.getElementById("retenido").value) || 0;
                    let total = parseFloat(document.getElementById("total").value) || 0;
                    
                    
        
                    let subtotal =(total/1.16);
                    let iva = (subtotal*0.16);


                    // Calcular subtotal
                    subtotal = (subtotal+retenido);

                    // Formatear y asignar valores a los elementos del DOM
                    document.getElementById("total").value = total.toFixed(2);
                    document.getElementById("retenido").value = retenido.toFixed(6);
                    document.getElementById("IVA").value = iva.toFixed(6);
                    document.getElementById("subtotal").value = subtotal.toFixed(2);

                    // Convertir total a letras
                    let totalLetras = convertirNumero(total);
                    document.getElementById("importeTotalLetras").value = totalLetras;

                    // Enfocar los elementos
                    document.getElementById("total").focus();
                    document.getElementById("retenido").focus();
                    document.getElementById("IVA").focus();
                    document.getElementById("importeTotalLetras").focus(); 
                    document.getElementById("subtotal").focus();
                }
                    
                    function convertirNumero(num) {
                    // Función para convertir la parte entera a palabras
                    function convertirParteEntera(num) {
                        const unidades = ["", "UN", "DOS", "TRES", "CUATRO", "CINCO", "SEIS", "SIETE", "OCHO", "NUEVE"];
                        const decenas = ["", "DIEZ", "VEINTE", "TREINTA", "CUARENTA", "CINCUENTA", "SESENTA", "SETENTA", "OCHENTA", "NOVENTA"];
                        const centenas = ["", "CIENTO", "DOSCIENTOS", "TRESCIENTOS", "CUATROCIENTOS", "QUINIENTOS", "SEISCIENTOS", "SETECIENTOS", "OCHOCIENTOS", "NOVECIENTOS"];

                        if (num === 0) return "CERO";
                        if (num === 100) return "CIEN";
                        if (num === 1000) return "MIL";
                        if (num === 1000000) return "UN MILLÓN";
                        if (num === 1000000000) return "UN BILLÓN";

                        let palabras = "";

                        if (num < 10) return unidades[num];
                        if (num < 20) return ["ONCE", "DOCE", "TRECE", "CATORCE", "QUINCE"][num - 11] || "DIECI" + unidades[num - 10];
                        if (num < 30) return num === 20 ? "VEINTE" : "VEINTI" + unidades[num - 20];
                        if (num < 100) return decenas[Math.floor(num / 10)] + (num % 10 ? " Y " + unidades[num % 10] : "");
                        if (num < 1000) return centenas[Math.floor(num / 100)] + (num % 100 ? " " + convertirParteEntera(num % 100) : "");

                        if (num < 1000000) {
                            let miles = Math.floor(num / 1000);
                            let resto = num % 1000;
                            palabras = (miles === 1 ? "MIL" : convertirParteEntera(miles) + " MIL");
                            if (resto > 0) palabras += " " + convertirParteEntera(resto);
                            return palabras;
                        }

                        if (num < 1000000000) {
                            let millones = Math.floor(num / 1000000);
                            let resto = num % 1000000;
                            palabras = (millones === 1 ? "UN MILLÓN" : convertirParteEntera(millones) + " MILLONES");
                            if (resto > 0) palabras += " " + convertirParteEntera(resto);
                            return palabras;
                        }

                        let billones = Math.floor(num / 1000000000);
                        let resto = num % 1000000000;
                        palabras = (billones === 1 ? "UN BILLÓN" : convertirParteEntera(billones) + " BILLONES");
                        if (resto > 0) palabras += " " + convertirParteEntera(resto);
                        return palabras;
                    }

                    // Función para convertir la parte decimal a palabras
                    function convertirParteDecimal(num) {
                        return " " + num + "/100";
                    }

                    // Separar la parte entera y decimal del número
                    let partes = String(num).split('.');
                    let parteEntera = partes[0];
                    let parteDecimal = partes[1];

                    // Convertir la parte entera a palabras
                    let resultado = convertirParteEntera(parseInt(parteEntera));

                    // Si hay parte decimal, convertirla a palabras
                    if (parteDecimal) {
                        resultado += " PESOS " + convertirParteDecimal(parteDecimal);
                    } else {
                        resultado += " PESOS";
                    }

                    // Agregar la parte de la moneda mexicana
                    resultado += " M.N.";

                    return resultado.toUpperCase();
                }
                    </script>
                    
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="importeTotalLetras" name="importeTotalLetras" class="form-control form-control-sm" readOnly onblur="this.value = this.value.trim()" required/>
                            <label class="form-label" for="importeTotalLetras">IMPORTE TOTAL EN LETRAS</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="nombreVo" name="nombreVo" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required/>
                            <label class="form-label" for="nombreVo">NOMBRE Vo.Bo.</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="puestoVo" name="puestoVo" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required/>
                            <label class="form-label" for="puestoVo">PUESTO Vo.Bo.</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="nombreAtentamente" name="nombreAtentamente" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required/>
                            <label class="form-label" for="nombreAtentamente">NOMBRE ATENTAMENTE</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="puestoAtentamente" name="puestoAtentamente" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required/>
                            <label class="form-label" for="puestoAtentamente">PUESTO ATENTAMENTE</label>
                        </div>
                    </div>
                </div>
                <div class="stc" style="justify-content: center; display: flex;">
                    <button type="submit" id="GuardarMemo" name="action" value="101" style="color:white;background-color: #008A13;" class="btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="GUARDAR">
                        <i class="fas fa-floppy-disk"></i>
                        <span class="btn-text">GUARDAR</span>
                    </button>
                    <button type="submit" id="ModificarMemo" name="action" value="102" style="display: none; color:white; background-color: #0370A7;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="MODIFICAR">
                        <i class="fas fa-pen-to-square"></i>
                        <span class="btn-text">MODIFICAR</span>
                    </button>
                    <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="LIMPIAR"><!--Boton tipo reset-->
                        <i class="fas fa-eraser"></i>
                        <span class="btn-text">LIMPIAR</span>
                    </button>
                </div>
            <script>
            document.querySelector('#Limpiar').addEventListener('click', function () {
                document.getElementById("fecha").value = '';
                document.getElementById("fecha").focus();
                document.getElementById("fecha").blur();

                // Esta función se ejecutará cuando se haga clic en el botón de limpiar
                document.querySelector('#GuardarMemo').style.display = "block";
                document.querySelector('#ModificarMemo').style.display = "none";
                document.querySelector('#tipoIngreso').style.fontWeight = "normal";
                document.querySelector('#tingreso').style.fontWeight = "normal";
                if (document.querySelector('.selected')) {
                    document.querySelector('.selected').classList.remove('selected');
                }
            });

            </script>
            </form>
            <!--Input de Busqueda y boton imprimir-->
            <div class="row d-flex justify-content-center p-3 ">
                <div class="col-md-3" style="text-align: center;">
                    <div data-mdb-input-init class="form-outline fontformulario">
                        <input type="text" id="busquedaMemorandum" class="form-control form-control-sm" style="font-weight: bold;"
                               style="background-color: white;" />
                        <label class="form-label" for="busquedaMemorandum">BUSCAR</label>
                    </div>
                </div>
            </div>
            <script>
                $(document).ready(function () {
                    $("#busquedaMemorandum").on("keyup", function () {
                        var value = $(this).val().toLowerCase();
                        $("#datosMemorandum tr").filter(function () {
                            //Empieza en 1
                            // Comprobamos si alguna de las columnas contiene el valor de búsqueda
                            var found = $(this).find("td:nth-child(2)").text().toLowerCase().indexOf(value) > -1 ||
                                    $(this).find("td:nth-child(3)").text().toLowerCase().indexOf(value) > -1;
                            $(this).toggle(found);
                        });
                    });
                });
            </script>
            <!--Termina aquí boton de busqueda e impresion         
          <button onclick="exportTableToExcel('concepto-table', 'datos.xls')">Exportar a Excel</button>
            -->    

            <!--Termina aquí boton de busqueda e impresion-->   
            <div class="row d-flex justify-content-center p-3">
                <div class="text-center" style="position: relative; width: 90%;">
                    <div class="table-responsive" style="height: 250px;">
                       <c:choose>
                <c:when test="${not empty memlista && memlista.stream().anyMatch(memo -> 'A'.equals(memo.estatus))}">
                    <table id="tablaMemorandums" class="fontformulario table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-secondary">
                            <tr>
                                <th class="d-none">ID MEMORÁNDUM</th>
                                <th class="fw-bold">No MEMORÁNDUM</th>
                                <th class="fw-bold">NOMBRE CONCEPTO</th>
                                <th class="fw-bold">CON FACTURA</th>
                                <th class="fw-bold">FECHA</th>
                                <th class="fw-bold">REMITENTE</th>
                                <th class="fw-bold">DESTINATARIO</th>
                                <th class="fw-bold">TIPO INGRESO</th>
                                <th class="fw-bold">CONCEPTO GENERAL</th>
                                <th class="fw-bold">TOTAL</th>
                                <th class="fw-bold">RETENIDO</th>
                                <th class="fw-bold">IVA</th>
                                <th class="fw-bold">SUBTOTAL</th>
                                <th class="fw-bold">TOTAL LETRAS</th>
                                <th class="fw-bold">NOMBRE Vo. Bo.</th>
                                <th class="fw-bold">PUESTO Vo Bo.</th>
                                <th class="fw-bold">NOMBRE Att.</th>
                                <th class="fw-bold">PUESTO Att.</th>
                            </tr>
                        </thead>
                        <tbody id="datosMemorandum" style="font-size: 80%;">
                            <c:forEach var="memo" items="${memlista}">
                                <c:if test="${memo.estatus == 'A'}">
                                    <tr>
                                        <td class="text-center id-memorandum d-none">${memo.idMemorandum}</td>
                                        <td class="texto-largo">${memo.noMemorandum}</td>
                                        <td class="texto-largo">${memo.nombreConcepto}</td>
                                        <td class="texto-largo">${memo.fecha}</td>
                                        <td class="texto-largo">${memo.remitente}</td>
                                        <td class="texto-largo">${memo.destinatario}</td>
                                        <td class="texto-largo">${memo.tipoIngreso}</td>
                                        <td class="texto-largo">${memo.conceptoGeneral}</td>
                                        <td class="texto-largo">${memo.total}</td>
                                        <td class="texto-largo">${memo.retenido}</td>
                                        <td class="texto-largo">${memo.iva}</td>
                                        <td class="texto-largo">${memo.subtotal}</td>
                                        <td class="texto-largo">${memo.totalLetras}</td>
                                        <td class="texto-largo">${memo.nombreVo}</td>
                                        <td class="texto-largo">${memo.puestoVo}</td>
                                        <td class="texto-largo">${memo.nombreAtt}</td>
                                        <td class="texto-largo">${memo.puestoAtt}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <center>
                        <br>
                        <h3 class="text-center metro" style="color:#970000;">
                            <b> 
                                N O  <span style="padding-left:40px;"></span> 
                                H A Y <span style="padding-left:40px;"></span> 
                                R E G I S T R O S
                            </b>
                        </h3>
                    </center>
                </c:otherwise>
            </c:choose>
                    </div>
                </div>
            </div>                
        </div>

        <datalist id="DescConc">
            <c:forEach var="concepto" items="${conceptolista}">
                <option data-value="${concepto.idConcepto}" value="${concepto.concepto}"></option>
            </c:forEach>
        </datalist>

        <datalist id="RemCon">
            <c:forEach var="concepto" items="${conceptolista}">
                <option data-value="${concepto.idConcepto}" value="${concepto.remitente}"></option>
            </c:forEach>
        </datalist>

        <datalist id="DestiCon">
            <c:forEach var="concepto" items="${conceptolista}">
                <option data-value="${concepto.idConcepto}" value="${concepto.destinatario}"></option>
            </c:forEach>
        </datalist>

        <datalist id="nomVO">
            <c:forEach var="concepto" items="${conceptolista}">
                <option data-value="${concepto.idConcepto}" value="${concepto.nombreVo}"></option>
            </c:forEach>
        </datalist>

        <datalist id="nomATT">
            <c:forEach var="concepto" items="${conceptolista}">
                <option data-value="${concepto.idConcepto}" value="${concepto.nombreAtt}"></option>
            </c:forEach>
        </datalist>

        <datalist id="pstVO">
            <c:forEach var="concepto" items="${conceptolista}">
                <option data-value="${concepto.idConcepto}" value="${concepto.puestoVo}"></option>
            </c:forEach>
        </datalist>

        <datalist id="pstATT">
            <c:forEach var="concepto" items="${conceptolista}">
                <option data-value="${concepto.idConcepto}" value="${concepto.puestoAtt}"></option>
            </c:forEach>
        </datalist>        

        <datalist id="tiping">
            <c:forEach var="concepto" items="${conceptolista}">
                <option data-value="${concepto.idConcepto}" value="${concepto.tipoIngreso}"></option>
            </c:forEach>
        </datalist>       


        <script  type="text/javascript">
    // Establecer la fecha actual
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); // Enero es 0
    var yyyy = today.getFullYear();

    // Formatear la fecha como yyyy-MM-dd para que sea compatible con el input type="date"
    var formattedDate = yyyy + '-' + mm + '-' + dd;
    
    
            //*********Toma datos de tabla para moverlos arriba y cambiar los botones 
            document.addEventListener('DOMContentLoaded', function () {
                // Obtener la tabla y el formulario
                var tabla = document.getElementById('datosMemorandum');
                var formulario = document.getElementById('formularioMemorandum');


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


                        document.querySelector('#GuardarMemo').style.display = "none";
                        document.querySelector('#ModificarMemo').style.display = "block";
                        document.querySelector('#tipoIngreso').style.fontWeight = "bold";
                        document.querySelector('#tingreso').style.fontWeight = "bold";


                        // Obtener los datos de la fila

                        let idMemorandum = fila.querySelector('.id-memorandum').innerText;
                        let noMemorandum = fila.querySelector('.texto-largo:nth-child(2)').innerText;
                        let nombreConcepto = fila.querySelector('.texto-largo:nth-child(3)').innerText;
                        let idConcepto = document.querySelector('#ListaConcepto option[value="' + nombreConcepto + '"]').getAttribute("data-value");

                        let fecha = fila.querySelector('.texto-largo:nth-child(4)').innerText;
                        let remitente = fila.querySelector('.texto-largo:nth-child(5)').innerText;
                        let destinatario = fila.querySelector('.texto-largo:nth-child(6)').innerText;
                        let tipoIngreso = fila.querySelector('.texto-largo:nth-child(7)').innerText;
                        let idTipoIngreso = document.querySelector('#ListTipoIngreso option[value="' + tipoIngreso + '"]').getAttribute("data-value");

                        let conceptoGeneral = fila.querySelector('.texto-largo:nth-child(8)').innerText;
                        let total = fila.querySelector('.texto-largo:nth-child(9)').innerText;
                        let retenido = fila.querySelector('.texto-largo:nth-child(10)').innerText;
                        let iva = fila.querySelector('.texto-largo:nth-child(11)').innerText;
                        let subtotal = fila.querySelector('.texto-largo:nth-child(12)').innerText;
                        let totalLetras = fila.querySelector('.texto-largo:nth-child(13)').innerText;
                        let nombreVo = fila.querySelector('.texto-largo:nth-child(14)').innerText;
                        let puestoVo = fila.querySelector('.texto-largo:nth-child(15)').innerText;
                        let nombreAtt = fila.querySelector('.texto-largo:nth-child(16)').innerText;
                        let puestoAtt = fila.querySelector('.texto-largo:nth-child(17)').innerText;


                        // Ingresa los valores a los cuadros de texto
                        formulario.querySelector("#idConcepto").value = idConcepto;
                        formulario.querySelector("#nombreConcepto").value = nombreConcepto;
                        formulario.querySelector("#noMemorandum").value = noMemorandum;
                        formulario.querySelector("#idMemorandum").value = idMemorandum;
                        formulario.querySelector("#fecha").value = fecha;
                        formulario.querySelector("#remitente").value = remitente;
                        formulario.querySelector("#destinatario").value = destinatario;
                        formulario.querySelector("#tingreso").value = tipoIngreso;
                        formulario.querySelector("#tipoIngreso").value = idTipoIngreso;
                        formulario.querySelector("#conceptoGeneral").value = conceptoGeneral;
                        formulario.querySelector("#total").value = total;
                        formulario.querySelector("#retenido").value = retenido;
                        formulario.querySelector("#IVA").value = iva;
                        formulario.querySelector("#subtotal").value = subtotal;
                        formulario.querySelector("#importeTotalLetras").value = totalLetras;
                        formulario.querySelector("#nombreVo").value = nombreVo;
                        formulario.querySelector("#puestoVo").value = puestoVo;
                        formulario.querySelector("#nombreAtentamente").value = nombreAtt;
                        formulario.querySelector("#puestoAtentamente").value = puestoAtt;


                        formulario.querySelector("#idConcepto").focus();
                        formulario.querySelector("#nombreConcepto").focus();
                        formulario.querySelector("#noMemorandum").focus();
                        formulario.querySelector("#idMemorandum").focus();
                        formulario.querySelector("#fecha").focus();
                        formulario.querySelector("#remitente").focus();
                        formulario.querySelector("#destinatario").focus();
                        formulario.querySelector("#tingreso").focus();
                        formulario.querySelector("#tipoIngreso").focus();
                        formulario.querySelector("#conceptoGeneral").focus();
                        formulario.querySelector("#total").focus();
                        formulario.querySelector("#retenido").focus();
                        formulario.querySelector("#IVA").focus();
                        formulario.querySelector("#subtotal").focus();
                        formulario.querySelector("#importeTotalLetras").focus();
                        formulario.querySelector("#nombreVo").focus();
                        formulario.querySelector("#puestoVo").focus();
                        formulario.querySelector("#nombreAtentamente").focus();
                        formulario.querySelector("#puestoAtentamente").focus();

                    }
                });
            });
           
            //*********************Para convertir las letras en mayúsculas al mandar datos
            document.getElementById('formularioMemorandum').addEventListener('submit', function (event) {
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

            //**********************************************
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
            //**********************************************************
            function get_idConcepto() {
                var input = document.getElementById('nombreConcepto').value.toUpperCase();
                var lista = document.getElementById('ListaConcepto').getElementsByTagName('option');
                var found = false;
                // Iterar sobre los elementos de la lista
                for (var i = 0; i < lista.length; i++) {
                    if (input === lista[i].value) {
                        found = true;
                        // Obtener el valor del atributo 'data-value'
                        var dataValue = lista[i].getAttribute("data-value");
                        document.getElementById('idConcepto').value = dataValue;
                        // Asignar el valor al campo oculto
                        get_DescripcionGen(dataValue);
                        break;
                    }
                }
                // Si no se encontró el RFC en la lista, limpiar el input
                if (!found) {
                    customeError("ERROR",'CONCEPTO NO VÁLIDO');
                    document.getElementById('idConcepto').value = '';
                    document.getElementById('nombreConcepto').value = '';
                    document.getElementById("remitente").value = '';
                    document.getElementById("destinatario").value = '';
                    document.getElementById("tipin").value = '';
                    document.getElementById("tipoIngreso").value = '';
                    document.getElementById("conceptoGeneral").value = '';
                    document.getElementById("nombreVo").value = '';
                    document.getElementById("puestoVo").value = '';
                    document.getElementById("nombreAtentamente").value = '';
                    document.getElementById("puestoAtentamente").value = '';

                }
            }


            function get_DescripcionGen(idcon) {
                var dataValue = document.querySelector('#DescConc option[data-value="' + idcon + '"]').getAttribute("value");
                var dconcp = document.getElementById("conceptoGeneral");
                dconcp.value = dataValue;
                dconcp.focus();

                var remi = document.querySelector('#RemCon option[data-value="' + idcon + '"]').getAttribute("value");
                var casremi = document.getElementById("remitente");
                casremi.value = remi;
                casremi.focus();

                var dest = document.querySelector('#DestiCon option[data-value="' + idcon + '"]').getAttribute("value");
                var casdest = document.getElementById("destinatario");
                casdest.value = dest;
                casdest.focus();

                var nvo = document.querySelector('#nomVO option[data-value="' + idcon + '"]').getAttribute("value");
                var casnvo = document.getElementById("nombreVo");
                casnvo.value = nvo;
                casnvo.focus();

                var natt = document.querySelector('#nomATT option[data-value="' + idcon + '"]').getAttribute("value");
                var casnatt = document.getElementById("nombreAtentamente");
                casnatt.value = natt;
                casnatt.focus();

                var psVO = document.querySelector('#pstVO option[data-value="' + idcon + '"]').getAttribute("value");
                var caspvo = document.getElementById("puestoVo");
                caspvo.value = psVO;
                caspvo.focus();


                var psATT = document.querySelector('#pstATT option[data-value="' + idcon + '"]').getAttribute("value");
                var caspatt = document.getElementById("puestoAtentamente");
                caspatt.value = psATT;
                document.getElementById("puestoAtentamente").focus();


                var psTI = document.querySelector('#tiping option[data-value="' + idcon + '"]').getAttribute("value");
                var idTI = document.querySelector('#ListTipoIngreso option[value="' + psTI + '"]').getAttribute("data-value");
                console.log("TINGRESO " + psTI);
                var casTI = document.getElementById("tingreso");
                casTI.value = psTI;
                document.getElementById("tingreso").focus();
                document.getElementById("tipoIngreso").value = idTI;
                // Establecer el valor del campo de fecha como la fecha actual
                document.getElementById('fecha').value = formattedDate;
                document.getElementById("fecha").focus();
            }
        </script>



        <!-- IMPRESIÓN DE MEMORÁNDUMS -->
        <div class="tab-pane fade" id="ex3-tabs-2" role="tabpanel" aria-labelledby="ex3-tab-2">
            <form action="Srv_MGeneral" target="_blank" method="POST" id="formularioImpresion" style="font-size: 75%; margin: 15px;">
                <div class="row">
                    <h5 class="stc" style="text-align: center;">IMPRESIÓN DE MEMORÁNDUMS</h5>
                    <hr>
                    <div class="col-sm-6">
                        <style>
                            /* Cambiar el color de la bolita cuando el switch está desactivado */
                            .form-check-input:not(:checked)::after {
                                background-color: #6c757d; /* Bolita gris cuando no está activado */
                            }
                        </style>
                        <div class="form-check form-switch">
                            <input class="form-check-input btn-azul" type="checkbox" role="switch" name="imprimirMemorandum" id="imprimirMemorandum"imprimirMemorandum>
                            <label class="form-check-label fs-6" for="imprimirMemorandum" style="font-weight: bold;color:black;">[ <span  id="spanNoUno" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiUno" hidden="true">SI</span> ] IMPRIMIR MEMORÁNDUM</label>
                        </div>
                        <br>
                        <div class="card">
                            <div class="card-body">
                                <input type="hidden" name="noMemorandumImpresion" id="noMemorandumImpresion" onblur="this.value = this.value.trim()" value="">
                                <div class="col">
                                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                        <input style="font-weight: bold;" type="text" id="listaMemorandumImpresion" name="listaMemorandumImpresion"  list="ListMemorandumImpresion" onchange="get_nmi()" class="form-control" onblur="this.value = this.value.trim()" required disabled/>
                                        <datalist id="ListMemorandumImpresion">
                                            <c:forEach var="memo" items="${memlista}">
                                                <c:if test="${memo.estatus == 'A' || memo.estatus == 'I'}">
                                                    <option data-value="${memo.idMemorandum}" value="${memo.noMemorandum}"></option>
                                                </c:if>
                                            </c:forEach>
                                        </datalist>  
                                        <label class="form-label" for="noMemorandumImpresion">No. MEMORÁNDUM</label>
                                    </div>
                                </div>

                                <br>
                                <div class="form-check form-switch">
                                    <input class="form-check-input btn-azul" type="checkbox" role="switch" name="gerenciaRecursosFinancieros" id="gerenciaRecursosFinancieros" disabled>
                                    <label class="form-check-label" for="gerenciaRecursosFinancieros">[ <span  id="spanNoGRF" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiGRF" hidden="true">SI</span> ] GERENCIA DE RECURSOS FINANCIEROS</label>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input btn-azul" type="checkbox" role="switch" name="areaEmisora" id="areaEmisora"  disabled>
                                    <label class="form-check-label" for="areaEmisora">[ <span  id="spanNoAE" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiAE" hidden="true">SI</span> ] ÁREA EMISORA</label>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input btn-azul" type="checkbox" role="switch" name="gerenciaPresupuestos" id="gerenciaPresupuestos"  disabled>
                                    <label class="form-check-label" for="gerenciaPresupuestos">[ <span  id="spanNoGP" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiGP" hidden="true">SI</span> ] GERENCIA DE PRESUPUESTOS</label>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input btn-azul" type="checkbox" role="switch" name="gerenciaContabilidad" id="gerenciaContabilidad"  disabled>
                                    <label class="form-check-label" for="gerenciaContabilidad">[ <span  id="spanNoGC" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiGC" hidden="true">SI</span> ] GERENCIA DE CONTABILIDAD</label>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input btn-azul" type="checkbox" role="switch" name="cliente" id="cliente"  disabled>
                                    <label class="form-check-label" for="cliente">[ <span  id="spanNoCLT" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiCLT" hidden="true">SI</span> ] CLIENTE</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-check form-switch">
                            <input class="form-check-input btn-azul" type="checkbox" role="switch" name="imprimirListadoMemorandum" id="imprimirListadoMemorandum">
                            <label class="form-check-label fs-6" for="imprimirListadoMemorandum" style="font-weight: bold;color:black;">[ <span  id="spanNoLista" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiLista" hidden="true">SI</span> ] IMPRIMIR LISTADO DE MEMORÁNDUM</label>
                        </div>
                        <br>
                        <div class="card">
                            <div class="card-body">
                                <div class="col">
                                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                        <input style="font-weight: bold;background-color: gainsboro !important;" type="date" name="fechaInicio" id="fechaInicio" class="form-control form-control-sm" disabled/>
                                        <label class="form-label" for="fechaInicio">FECHA INICIO</label>
                                    </div>
                                </div>
                                <br>
                                <div class="col">
                                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                        <input style="font-weight: bold;background-color: gainsboro !important;" type="date" name="fechaFin" id="fechaFin" class="form-control form-control-sm" onchange="validateDates()" disabled/>
                                        <label class="form-label" for="fechaFin">FECHA TERMINO</label>
                                    </div>
                                </div>
                                <br>
                                <div class="col">
                                    <div class="form-outline mdb-input">
                                        <select style="font-weight: bold;background-color: gainsboro !important;" disabled data-mdb-select-init id="estatusImpresion" name="estatusImpresion" class="form-select form-select-sm" aria-label="Default select example" style="font-size: 105%;" onblur="this.value = this.value.trim()" required>
                                            <option value="" disabled selected style="display: none;" ></option>
                                            <option value="A">ACTIVOS</option>
                                            <option value="I">IMPRESOS</option>     
                                            <option value="T">TODOS</option>  
                                        </select>
                                        <label class="form-label" for="estatusImpresion">ESTATUS</label>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <br><br>
                        <%--
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-check form-switch">
                            <input class="form-check-input btn-azul" type="checkbox" role="switch" name="imprimirRangoMemorandum" id="imprimirRangoMemorandum">
                            <label class="form-check-label fs-6" for="imprimirRangoMemorandum" style="font-weight: bold;color:black;">[ <span  id="spanNoRango" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiRango" hidden="true">SI</span> ] IMPRIMIR POR RANGOS DE MEMORÁNDUM</label>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <input type="hidden" name="rangoInicialMemo" id="rangoInicialMemo" onblur="this.value = this.value.trim()" value="">
                                    <input type="hidden" name="rangoFinalMemo" id="rangoFinalMemo" onblur="this.value = this.value.trim()" value="">
                                    <div class="col">
                                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                            <input style="font-weight: bold;" type="text" id="inicioMemorandum" onchange="validacionRangos(this.value)" list="ListMemorandumImpresionRangos"  name="inicioMemorandum" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required disabled/>
                                            <label class="form-label" for="inicioMemorandum">INICIO MEMORÁNDUM</label>
                                            <datalist id="ListMemorandumImpresionRangos">
                                                <c:forEach var="memo" items="${memlista}">
                                                    <c:if test="${memo.estatus == 'A' || memo.estatus == 'I'}">
                                                        <option data-value="${memo.idMemorandum}" value="${memo.noMemorandum}"></option>
                                                    </c:if>
                                                </c:forEach>
                                            </datalist> 
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                            <input style="font-weight: bold;" type="text" list="ListMemorandumImpresionRangoFinal" id="finMemorandum" name="finMemorandum" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required disabled/>
                                            <label class="form-label" for="finMemorandum">HASTA MEMORÁNDUM</label>
                                            <datalist id="ListMemorandumImpresionRangoFinal">
                                            </datalist> 
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>    --%>

                <br><br>
                <div style="justify-content: center; display: flex;">
                    <button type="submit" disabled name="action" id="imprimir" value="105" title="Imprimir" class="stc btn btn-sm btn-rounded" style="color:white; background-color: purple;" data-mdb-ripple-init>
                        <i class="fas fa-print"></i>
                        <span class="d-none d-sm-inline">IMPRIMIR EN PDF</span> </button>
                    <button type="reset" class="btn btn-dark btn-sm btn-rounded stc" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar" id="limpiar2">
                        <i class="fas fa-eraser"></i>
                        <span class="btn-text d-none d-sm-inline">LIMPIAR</span>
                    </button>
                </div>
            </form>

            <%
            memorandumLista = (List<obj_MGeneral>) request.getAttribute("memlista");
            ObjectMapper mapper = new ObjectMapper();
            String csJson = mapper.writeValueAsString(memorandumLista);
                %>
                
            <script  type="text/javascript">
    //*********************************** FECHAS    
        document.getElementById('fechaInicio').setAttribute('max', hoy);
        document.getElementById('fechaFin').setAttribute('max', hoy);
        function validateDates() {
        let fechaInicio = document.getElementById("fechaInicio");
        let fechaFin = document.getElementById("fechaFin");

        if (fechaInicio.value > fechaFin.value) {
            customeError("ERROR","LA FECHA DE INICIO NO PUEDE SER POSTERIOR A LA FECHA DE TÉRMINO.");
            fechaInicio.value = "";
            fechaFin.value = "";
        }
    }
    

//Validacion de rangos impresión
var memoData = <%= csJson %>;
/*
function validacionRangos(valorInicial) {
    var inputInicial = valorInicial.toUpperCase();
    var listaMemorandum = document.getElementById('ListMemorandumImpresionRangos').getElementsByTagName('option');
    var found = false;
    var dataValue;
    var dataList = document.getElementById('ListMemorandumImpresionRangoFinal');
        
    // Iterar sobre los elementos de la lista
    for (var i = 0; i < listaMemorandum.length; i++) {
        if (inputInicial === listaMemorandum[i].value) {
            found = true;
            // Obtener el valor del atributo 'data-value'
            dataValue = listaMemorandum[i].getAttribute("data-value");
            document.getElementById('rangoInicialMemo').value = dataValue;
            break;
        }
    }
    // Si no se encontró el MemorandumImpresión en la lista, limpiar el input
    if (!found) {
        if(valorInicial!=0){
            customeError("ERROR", 'MEMORÁNDUM NO VÁLIDO');
        }
        document.getElementById('inicioMemorandum').value = '';
        document.getElementById('finMemorandum').value = '';
        document.getElementById("inicioMemorandum").focus();
        document.getElementById("finMemorandum").focus();
        document.getElementById("inicioMemorandum").blur();
        document.getElementById("finMemorandum").blur();
        dataList.innerHTML = '';
    }else{
        dataList.innerHTML = '';
        var memorandumSegundaLista = memoData.filter(memorandum => 
        memorandum.idMemorandum > inputInicial &&
        (memorandum.estatus === 'A' || memorandum.estatus === 'I')
        );

        var segundoInput=document.getElementById("finMemorandum");
        if (memorandumSegundaLista.length > 0) {
            segundoInput.disabled = false;
            memorandumSegundaLista.forEach(memorandum => {
                var option = document.createElement('option');
                option.value = memorandum.noMemorandum;
                option.setAttribute('data-value', memorandum.idMemorandum);
                dataList.appendChild(option);
            });
        } else {
            dataList.innerHTML = '';
            segundoInput.value = '';
            segundoInput.focus();
            segundoInput.blur();
            segundoInput.disabled = true;
        }
        
    }
    
}*/

        //**********************************************
        function get_nmi() {
            var input = document.getElementById('listaMemorandumImpresion').value.toUpperCase();
            var lista = document.getElementById('ListMemorandumImpresion').getElementsByTagName('option');
            var found = false;
            // Iterar sobre los elementos de la lista
            for (var i = 0; i < lista.length; i++) {
                if (input === lista[i].value) {
                    found = true;
                    // Obtener el valor del atributo 'data-value'
                    var dataValue = lista[i].getAttribute("value");
                    // Asignar el valor al campo oculto
                    document.getElementById('noMemorandumImpresion').value = dataValue;
                    break;
                }
            }
                // Si no se encontró el RFC en la lista, limpiar el input
                if (!found) {
                    customeError("ERROR",'NÚMERO DE MEMORÁNDUM NO VÁLIDO');
                    document.getElementById('noMemorandumImpresion').value = '';
                    document.getElementById('listaMemorandumImpresion').value = '';

                }
            }

            //*****************     
            document.getElementById('imprimirMemorandum').addEventListener('change', function () {
                const spanNoUno = document.getElementById('spanNoUno');
                const spanSiUno = document.getElementById('spanSiUno');
                if (this.checked) {
                    spanNoUno.hidden = true;
                    spanSiUno.hidden = false;
                } else {
                document.getElementById('spanNoGRF').hidden = false;
                document.getElementById('spanSiGRF').hidden = true;
                document.getElementById('spanNoAE').hidden = false;
                document.getElementById('spanSiAE').hidden = true;
                document.getElementById('spanNoGP').hidden = false;
                document.getElementById('spanSiGP').hidden = true;
                document.getElementById('spanNoGC').hidden = false;
                document.getElementById('spanSiGC').hidden = true;
                document.getElementById('spanNoCLT').hidden = false;
                document.getElementById('spanSiCLT').hidden = true;
                    spanNoUno.hidden = false;
                    spanSiUno.hidden = true;
                }
            });

            document.getElementById('imprimirListadoMemorandum').addEventListener('change', function () {
                const spanNoLista = document.getElementById('spanNoLista');
                const spanSiLista = document.getElementById('spanSiLista');
                if (this.checked) {
                    spanNoLista.hidden = true;
                    spanSiLista.hidden = false;
                } else {
                    spanNoLista.hidden = false;
                    spanSiLista.hidden = true;
                }
            });
            
           /* document.getElementById('imprimirRangoMemorandum').addEventListener('change', function () {
                const spanNoRango = document.getElementById('spanNoRango');
                const spanSiRango = document.getElementById('spanSiRango');
                if (this.checked) {
                    spanNoRango.hidden = true;
                    spanSiRango.hidden = false;
                } else {
                    spanNoRango.hidden = false;
                    spanSiRango.hidden = true;
                }
            });
*/
            document.getElementById('gerenciaRecursosFinancieros').addEventListener('change', function () {
                const spanNoGRF = document.getElementById('spanNoGRF');
                const spanSiGRF = document.getElementById('spanSiGRF');
                if (this.checked) {
                    spanNoGRF.hidden = true;
                    spanSiGRF.hidden = false;
                } else {
                    spanNoGRF.hidden = false;
                    spanSiGRF.hidden = true;
                }
            });

            document.getElementById('areaEmisora').addEventListener('change', function () {
                const spanNoAE = document.getElementById('spanNoAE');
                const spanSiAE = document.getElementById('spanSiAE');
                if (this.checked) {
                    spanNoAE.hidden = true;
                    spanSiAE.hidden = false;
                } else {
                    spanNoAE.hidden = false;
                    spanSiAE.hidden = true;
                }
            });

            document.getElementById('gerenciaPresupuestos').addEventListener('change', function () {
                const spanNoGP = document.getElementById('spanNoGP');
                const spanSiGP = document.getElementById('spanSiGP');
                if (this.checked) {
                    spanNoGP.hidden = true;
                    spanSiGP.hidden = false;
                } else {
                    spanNoGP.hidden = false;
                    spanSiGP.hidden = true;
                }
            });

            document.getElementById('gerenciaContabilidad').addEventListener('change', function () {
                const spanNoGC = document.getElementById('spanNoGC');
                const spanSiGC = document.getElementById('spanSiGC');
                if (this.checked) {
                    spanNoGC.hidden = true;
                    spanSiGC.hidden = false;
                } else {
                    spanNoGC.hidden = false;
                    spanSiGC.hidden = true;
                }
            });

            document.getElementById('cliente').addEventListener('change', function () {
                const spanNoCLT = document.getElementById('spanNoCLT');
                const spanSiCLT = document.getElementById('spanSiCLT');
                if (this.checked) {
                    spanNoCLT.hidden = true;
                    spanSiCLT.hidden = false;
                } else {
                    spanNoCLT.hidden = false;
                    spanSiCLT.hidden = true;
                }
            });


        //**********************ACTIVAR CASILLAS IMPRESION MEMORANDUM
        var impmem = document.getElementById("imprimirMemorandum");
        var implist = document.getElementById("imprimirListadoMemorandum");
        //var imprango = document.getElementById("imprimirRangoMemorandum");

        impmem.addEventListener('click', function () {
           // validacionRangos(0);
            if (impmem.checked) {
                document.getElementById("noMemorandumImpresion").disabled = false;
                document.getElementById("noMemorandumImpresion").required = true;

                document.getElementById("listaMemorandumImpresion").disabled = false;
                document.getElementById("listaMemorandumImpresion").required = true;


                document.getElementById("gerenciaRecursosFinancieros").disabled = false;

                document.getElementById("areaEmisora").disabled = false;

                document.getElementById("gerenciaPresupuestos").disabled = false;

                document.getElementById("gerenciaContabilidad").disabled = false;

                document.getElementById("cliente").disabled = false;

                document.getElementById("imprimir").disabled = false;
                implist.disabled = true;
              //  imprango.disabled = true;
            } else {
                implist.disabled = false;
              //  imprango.disabled = false;
                document.getElementById("imprimir").disabled = true;

                document.getElementById("noMemorandumImpresion").disabled = true;
                document.getElementById("noMemorandumImpresion").value = '';
                document.getElementById("noMemorandumImpresion").required = false;


                document.getElementById("listaMemorandumImpresion").value = '';
                document.getElementById("listaMemorandumImpresion").required = false;
                document.getElementById("listaMemorandumImpresion").focus();
                document.getElementById("listaMemorandumImpresion").blur();
                document.getElementById("listaMemorandumImpresion").disabled = true;

                document.getElementById("gerenciaRecursosFinancieros").disabled = true;
                document.getElementById("gerenciaRecursosFinancieros").checked = false;

                document.getElementById("areaEmisora").disabled = true;
                document.getElementById("areaEmisora").checked = false;

                document.getElementById("gerenciaPresupuestos").disabled = true;
                document.getElementById("gerenciaPresupuestos").checked = false;

                document.getElementById("gerenciaContabilidad").disabled = true;
                document.getElementById("gerenciaContabilidad").checked = false;

                document.getElementById("cliente").disabled = true;
                document.getElementById("cliente").checked = false;
            }
        });

        //ACTIVAR CASILLAS IMPRESION LISTA DE MEMORANDUMS
        implist.addEventListener('click', function () {
          //  validacionRangos(0);
            if (implist.checked) {
                document.getElementById("fechaInicio").disabled = false;
                document.getElementById("fechaInicio").required = true;
                removeImportantStyle('fechaInicio');

                document.getElementById("fechaFin").disabled = false;
                document.getElementById("fechaFin").required = true;
                removeImportantStyle('fechaFin');

                document.getElementById("estatusImpresion").disabled = false;
                document.getElementById("estatusImpresion").required = true;                        
                removeImportantStyle('estatusImpresion');


                document.getElementById("imprimir").disabled = false;
                impmem.disabled = true;
               // imprango.disabled = true;
            } else {
                document.getElementById("fechaInicio").disabled = true;
                document.getElementById("fechaInicio").value = '';
                document.getElementById("fechaInicio").required = false;
                addImportantStyle('fechaInicio');

                document.getElementById("fechaFin").disabled = true;
                document.getElementById("fechaFin").value = '';
                document.getElementById("fechaFin").required = false;
                addImportantStyle('fechaFin');

                document.getElementById("estatusImpresion").disabled = true;
                document.getElementById("estatusImpresion").value = '';
                document.getElementById("estatusImpresion").required = false;
                addImportantStyle('estatusImpresion');

                document.getElementById("imprimir").disabled = true;
                impmem.disabled = false;
               // imprango.disabled = false;
            }
        });
        //ACTIVAR CASILLAS IMPRESION RANGO DE MEMORANDUMS
   /*     imprango.addEventListener('click', function () {
            validacionRangos(0);
            if (imprango.checked) {
                document.getElementById("inicioMemorandum").disabled = false;
                document.getElementById("inicioMemorandum").required = true;

                document.getElementById("finMemorandum").disabled = false;
                document.getElementById("finMemorandum").required = true;

                document.getElementById("imprimir").disabled = false;
                impmem.disabled = true;
                implist.disabled = true;
            } else {
                document.getElementById("inicioMemorandum").disabled = true;
                document.getElementById("inicioMemorandum").value = '';
                document.getElementById("inicioMemorandum").required = false;
             
                document.getElementById("finMemorandum").disabled = true;
                document.getElementById("finMemorandum").value = '';
                document.getElementById("finMemorandum").required = false;

                document.getElementById("imprimir").disabled = true;
                impmem.disabled = false;
                implist.disabled = false;
            }
        });*/
      
//*********************************
        document.querySelector('#limpiar2').addEventListener('click', function () {
            document.getElementById('spanNoUno').hidden = false;
            document.getElementById('spanSiUno').hidden = true;
            document.getElementById('spanNoLista').hidden = false;
            document.getElementById('spanSiLista').hidden = true;
         //   document.getElementById('spanNoRango').hidden = false;
           // document.getElementById('spanSiRango').hidden = true;
            document.getElementById('spanNoGRF').hidden = false;
            document.getElementById('spanSiGRF').hidden = true;
            document.getElementById('spanNoAE').hidden = false;
            document.getElementById('spanSiAE').hidden = true;
            document.getElementById('spanNoGP').hidden = false;
            document.getElementById('spanSiGP').hidden = true;
            document.getElementById('spanNoGC').hidden = false;
            document.getElementById('spanSiGC').hidden = true;
            document.getElementById('spanNoCLT').hidden = false;
            document.getElementById('spanSiCLT').hidden = true;
            document.getElementById("imprimirMemorandum").disabled = false;
            document.getElementById("imprimirListadoMemorandum").disabled = false;
          //  document.getElementById("imprimirRangoMemorandum").disabled = false;

            document.getElementById("fechaInicio").value = '';
            document.getElementById("fechaInicio").required = false;
            document.getElementById("fechaInicio").focus();
            document.getElementById("fechaInicio").blur();
            document.getElementById("fechaInicio").disabled = true;
            addImportantStyle('fechaInicio');
            
            document.getElementById("fechaFin").value = '';
            document.getElementById("fechaFin").required = false;
            document.getElementById("fechaFin").focus();
            document.getElementById("fechaFin").blur();
            document.getElementById("fechaFin").disabled = true;
            addImportantStyle('fechaFin');

            document.getElementById("estatusImpresion").disabled = true;
            document.getElementById("estatusImpresion").value = '';
            document.getElementById("estatusImpresion").required = false;
            addImportantStyle('estatusImpresion');

            document.getElementById("imprimir").disabled = true;
            document.getElementById("noMemorandumImpresion").disabled = true;
            document.getElementById("noMemorandumImpresion").value = '';
            document.getElementById("noMemorandumImpresion").required = false;
            document.getElementById("listaMemorandumImpresion").disabled = true;
            document.getElementById("listaMemorandumImpresion").value = '';
            document.getElementById("listaMemorandumImpresion").required = false;

            document.getElementById("gerenciaRecursosFinancieros").disabled = true;
            document.getElementById("gerenciaRecursosFinancieros").checked = false;

            document.getElementById("areaEmisora").disabled = true;
            document.getElementById("areaEmisora").checked = false;

            document.getElementById("gerenciaPresupuestos").disabled = true;
            document.getElementById("gerenciaPresupuestos").checked = false;

            document.getElementById("gerenciaContabilidad").disabled = true;
            document.getElementById("gerenciaContabilidad").checked = false;

            document.getElementById("cliente").disabled = true;
            document.getElementById("cliente").checked = false;
            
            
            document.getElementById("inicioMemorandum").value = '';
            document.getElementById("inicioMemorandum").required = false;
            document.getElementById("inicioMemorandum").focus();
            document.getElementById("inicioMemorandum").blur();
            document.getElementById("inicioMemorandum").disabled = true;
            
            document.getElementById("finMemorandum").value = '';
            document.getElementById("finMemorandum").required = false;
            document.getElementById("finMemorandum").focus();
            document.getElementById("finMemorandum").blur();
            document.getElementById("finMemorandum").disabled = true;
         //   validacionRangos(0);

        });

        //*********************Para convertir las letras en mayúsculas al mandar datos
        document.getElementById('formularioImpresion').addEventListener('submit', function (event) {
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
            </script>
        </div>

        <div class="tab-pane fade" id="ex3-tabs-3" role="tabpanel" aria-labelledby="ex3-tab-3">
            <h5 class="stc" style="text-align: center;">CANCELACIÓN DE MEMORÁNDUMS</h5>
            <hr>
            <form action="Srv_MGeneral" method="POST" id="formularioCancelacion" style="font-size: 75%; margin: 15px;">
            <div class="form-check form-switch">
                <input class="form-check-input btn-azul" type="checkbox" role="switch" name="cancelacionMemorandums" id="cancelacionMemorandums">
                <label class="form-check-label fs-6" for="cancelacionMemorandums" style="font-weight: bold;color:black;">
                    [ <span id="spanNoCancelar" style="color:#BA0000;">NO</span> <span id="spanSiCancelar" style="color:#007505;" hidden>SI</span> ] CANCELACIÓN DE MEMORÁNDUMS
                </label>
            </div>
            <br>
            <div class="row mb-4">
                <div class="col">
                    <small id="listaCancelacionVacia" class="error fw-bold fs-6 form-text" style="display:none;color: #810808;">NO HAY MEMORÁNDUMS PARA CANCELAR</small>
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="listaMemorandumCancelacion" name="noMemorandum" list="ListMemorandumCancelacion" onchange="get_nmcan()" class="form-control" onblur="this.value = this.value.trim()" required disabled/>
                        <datalist id="ListMemorandumCancelacion">
                            <c:forEach var="memo" items="${memlista}">
                                <c:if test="${memo.estatus == 'A'}">
                                    <option data-value="${memo.idMemorandum}" value="${memo.noMemorandum}"></option>
                                </c:if>
                            </c:forEach>
                        </datalist>
                        <label class="form-label" for="listaMemorandumCancelacion">No. MEMORANDUM</label>
                    </div>
                </div>
            </div>
            <script>
            // Función para verificar si el datalist tiene opciones
            function checkDatalistCancelacion() {
                const datalist = document.getElementById('ListMemorandumCancelacion');
                const options = datalist.querySelectorAll('option');
                if (options.length === 0) {
                    document.getElementById("listaCancelacionVacia").style.display="block";
                }
            }
            </script>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline mb-4" style="background-color: white;">
                        <textarea style="font-weight: bold;" class="form-control form-control-sm" id="motivoCancelacion" name="conceptoCancelacion" rows="3" disabled></textarea>
                        <label class="form-label" for="motivoCancelacion">MOTIVO DE LA CANCELACIÓN</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="stc" style="justify-content: center; display: flex;">
                    <button type="submit" id="cancelacion" name="action" value="103" style="color:white; background-color: #A70303;" class="btn btn-danger btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Eliminar" disabled onclick="changeStatusMemorandum('103')">
                        <i class="fas fa-trash"></i>
                        <span class="btn-text">CANCELACIÓN</span>
                    </button>
                    <button type="reset" id="LimpiarCancelacion" class="btn btn-dark btn-sm btn-rounded stc" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar">
                        <i class="fas fa-eraser"></i>
                        <span class="btn-text">LIMPIAR</span>
                    </button>
                </div>
            </div>
        </form>
            <script>
         //**************************************CANCELACION
function get_nmcan() {
    console.log("Entra a get_nmcan");
        let input = document.getElementById('listaMemorandumCancelacion').value.toUpperCase();

        var listaCanacelacion=document.getElementById('ListMemorandumCancelacion').getElementsByTagName('option');
        var foundCancelado=false;

        // Iterar sobre las opciones para buscar el valor de entrada
        for (var i = 0; i < listaCanacelacion.length; i++) {
            if (input === listaCanacelacion[i].value) {
                foundCancelado = true;
                break;
            }
        }
        
         // Si no se encontró el valor en la lista, limpiar el input y mostrar alerta
       if(!foundCancelado){
            customeError("ERROR","NÚMERO DE MEMORÁNDUM NO VÁLIDO");
            // Limpiar el campo de entrada según el tipo
            document.getElementById('listaMemorandumCancelacion').value = '';
        }
              
}
 //**************************************ACTIVACION
function get_nmact() {
        let input = document.getElementById('listaMemorandumActivacion').value.toUpperCase();

        var listaActivacion=document.getElementById('ListMemorandumActivacion').getElementsByTagName('option');
        var foundActivado=false;

        // Iterar sobre las opciones para buscar el valor de entrada
        for (var i = 0; i < listaActivacion.length; i++) {
            if (input === listaActivacion[i].value) {
                foundActivado = true;
                break;
            }
        }
        // Si no se encontró el valor en la lista, limpiar el input y mostrar alerta
       if(!foundActivado){
            customeError("ERROR","NÚMERO DE MEMORÁNDUM NO VÁLIDO");
            // Limpiar el campo de entrada según el tipo
            document.getElementById('listaMemorandumActivacion').value = '';
        }
    }
    
            </script>   
            <br>
            <h5 class="stc" style="text-align: center;">ACTIVACIÓN DE MEMORÁNDUMS</h5>
            <hr>
             <form action="Srv_MGeneral" method="POST" id="formularioActivacion" style="font-size: 75%; margin: 15px;">
            <div class="form-check form-switch">
                <input class="form-check-input btn-azul" type="checkbox" role="switch" name="activacionMemorandums" id="activacionMemorandums">
                <label class="form-check-label fs-6" for="activacionMemorandums" style="font-weight: bold;color:black;">
                    [ <span id="spanNoActivacion" style="color:#BA0000;">NO</span> <span id="spanSiActivacion" style="color:#007505;" hidden>SI</span> ] ACTIVACIÓN DE MEMORÁNDUMS
                </label>
            </div>
            <br>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="java.util.Date" %>

    <%
        // Obtener la fecha actual en formato YYYY-MM-DD
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String today = sdf.format(new Date());
        pageContext.setAttribute("today", today);
    %>
            <div class="row mb-4">
                <div class="col">
                    <small id="listaActivacionVacia" class="error fw-bold fs-6 form-text" style="display:none;color: #810808;">NO HAY MEMORÁNDUMS PARA ACTIVAR</small>
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="listaMemorandumActivacion" name="noMemorandum" list="ListMemorandumActivacion" onchange="get_nmact()" class="form-control" onblur="this.value = this.value.trim()" required disabled/>
                        <datalist id="ListMemorandumActivacion"><!--Se muestran los dados de baja-->
                                <c:forEach var="memo" items="${memlista}">
                                    <c:choose>
                                        <c:when test="${(memo.estatus == 'A' || memo.estatus == 'I') &&
                                                        memo.fechaCapturado != null &&
                                                        (memo.fechaCapturado.substring(0, 10) == today)}">
                                            <option data-value="${memo.idMemorandum}" value="${memo.noMemorandum}"></option>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </datalist>
                        <label class="form-label" for="listaMemorandumActivacion">No. MEMORANDUM</label>
                    </div>
                </div>
                <script>
                // Función para verificar si el datalist tiene opciones
                function checkDatalistActivacion() {
                    const datalist = document.getElementById('ListMemorandumActivacion');
                    const options = datalist.querySelectorAll('option');
                    if (options.length === 0) {
                        document.getElementById("listaActivacionVacia").style.display="block";
                    }
                }
                
                // Función combinada para ejecutar ambas verificaciones
                function checkAllDatalists() {
                    checkDatalistCancelacion();
                    checkDatalistActivacion();
                }

                // Ejecutar la función combinada al cargar la página
                window.onload = checkAllDatalists;
                </script>
            </div>
            <div>
                <div class="stc" style="justify-content: center; display: flex;">
                    <button type="submit" id="GuardarActivacion" name="action" value="106" style="color:white; background-color: #008A13;" class="btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Guardar" disabled onclick="changeStatusMemorandum('106')">
                        <i class="fas fa-floppy-disk"></i>
                        <span class="btn-text">ACTIVAR</span>
                    </button>
                    <button type="reset" id="LimpiarActivacion" class="btn btn-dark btn-sm btn-rounded stc" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar">
                        <i class="fas fa-eraser"></i>
                        <span class="btn-text">LIMPIAR</span>
                    </button>
                </div>
            </div>
        </form>
                
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Limpiar Cancelación
    document.querySelector('#LimpiarCancelacion').addEventListener('click', function() {
        console.log("entra a LimpiarCancelacion");
        document.getElementById('spanNoCancelar').hidden = false;
        document.getElementById('spanSiCancelar').hidden = true;
        document.getElementById("cancelacionMemorandums").disabled = false;
        document.getElementById("activacionMemorandums").disabled = false;
        document.getElementById("cancelacion").disabled = true;

        const cancelacionElems = ["listaMemorandumCancelacion", "motivoCancelacion"];
        cancelacionElems.forEach(id => {
            let elem = document.getElementById(id);
            elem.value = '';
            elem.required = false;
            elem.disabled = true;
        });
    });

    // Limpiar Activación
    document.querySelector('#LimpiarActivacion').addEventListener('click', function() {
        console.log("entra a LimpiarActivacion");
        document.getElementById('spanNoActivacion').hidden = false;
        document.getElementById('spanSiActivacion').hidden = true;

        document.getElementById("cancelacionMemorandums").disabled = false;
        document.getElementById("activacionMemorandums").disabled = false;
        document.getElementById("GuardarActivacion").disabled = true;

        document.getElementById("listaMemorandumActivacion").value = '';
        document.getElementById("listaMemorandumActivacion").required = false;
        document.getElementById("listaMemorandumActivacion").disabled = true;
    });

    // Activación o desactivación de memorandum
    function handleCheckboxChange(checkboxId, spanNoId, spanSiId, elemsToManage) {
        document.getElementById(checkboxId).addEventListener('change', function() {
            console.log(`entra a ${checkboxId}change`);
            const spanNo = document.getElementById(spanNoId);
            const spanSi = document.getElementById(spanSiId);
            if (this.checked) {
                spanNo.hidden = true;
                spanSi.hidden = false;
                elemsToManage.forEach(id => {
                    let elem = document.getElementById(id);
                    elem.disabled = false;
                    elem.required = true;
                });
            } else {
                spanNo.hidden = false;
                spanSi.hidden = true;
                elemsToManage.forEach(id => {
                    let elem = document.getElementById(id);
                    elem.disabled = true;
                    elem.required = false;
                    elem.value = '';
                });
            }
        });
    }

    handleCheckboxChange('activacionMemorandums', 'spanNoActivacion', 'spanSiActivacion', ['listaMemorandumActivacion']);
    handleCheckboxChange('cancelacionMemorandums', 'spanNoCancelar', 'spanSiCancelar', ['listaMemorandumCancelacion', 'motivoCancelacion']);

    // Evento click para manejar la lógica de activación y cancelación
    function handleClick(checkboxId, elemsToManage, otherCheckboxId) {
        document.getElementById(checkboxId).addEventListener('click', function() {
            const isChecked = this.checked;
            elemsToManage.forEach(id => {
                let elem = document.getElementById(id);
                elem.disabled = !isChecked;
                elem.required = isChecked;
                if (!isChecked) {
                    elem.value = '';
                }
            });
            document.getElementById(otherCheckboxId).disabled = isChecked;
        });
    }

    handleClick('activacionMemorandums', ['listaMemorandumActivacion', 'GuardarActivacion'], 'cancelacionMemorandums');
    handleClick('cancelacionMemorandums', ['listaMemorandumCancelacion', 'motivoCancelacion', 'cancelacion'], 'activacionMemorandums');

    // Función para verificar el número de memorándum
    function validateNumber(id, listId) {
        let input = document.getElementById(id).value;
        let options = Array.from(document.getElementById(listId).getElementsByTagName('option'));
        let isValid = options.some(option => option.value === input);

        if (!isValid) {
            customError("ERROR", "NÚMERO DE MEMORÁNDUM NO VÁLIDO");
            document.getElementById(id).value = '';
        }
    }

    document.getElementById('listaMemorandumCancelacion').addEventListener('change', function() {
        validateNumber('listaMemorandumCancelacion', 'ListMemorandumCancelacion');
    });

    document.getElementById('listaMemorandumActivacion').addEventListener('change', function() {
        validateNumber('listaMemorandumActivacion', 'ListMemorandumActivacion');
    });

    // Convertir las letras a mayúsculas al enviar el formulario
    document.getElementById('formularioCancelacion').addEventListener('submit', function() {
        ['input[type="text"]', 'textarea'].forEach(selector => {
            document.querySelectorAll(selector).forEach(elem => {
                elem.value = elem.value.toUpperCase();
            });
        });
    });
});
</script>

    </div>
    <!-- Tabs content -->
    <br>



</main>
<%@include file="../Mensaje.jsp"%>


<%@include file="../Pie.jsp"%>