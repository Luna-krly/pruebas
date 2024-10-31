<%-- 
    Document   : MemoArrendamiento
    Created on : 2 may 2024, 12:57:39
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%--CONCEPTOS--%>
<%@page import="Objetos.obj_Conceptos"%>
<%! obj_Conceptos concepto;%>
<%! List<obj_Conceptos> conceptolista;%>

<%@page import="Objetos.obj_MArrendamiento"%>
<%! obj_MArrendamiento arrendamiento;%>

<%@page import="Objetos.obj_DepositoBancario"%>
<%! obj_DepositoBancario depositoBancario;%>
<%! List<obj_DepositoBancario> depositoBancariolista;%>

<%@page import="Objetos.obj_detalleArrendamiento"%>
<%! obj_detalleArrendamiento detalleArrendamiento;%>
<%! List<obj_detalleArrendamiento> detalleArrendamientolista;%>


<%@page import="Funciones.Convertir"%>

<%@include file="../Encabezado.jsp"%>


<%
    try{
     System.out.println("---------------------Memorandums Arrendamiento JSP---------------------");
    //Recibe los atributos si es que hay, dependiendo de lo que realice el SERVLET CodigoPostal.
    //En este caso si recibe un mensaje de error, uno de exito o ninguno.
    conceptolista = (List<obj_Conceptos>) request.getAttribute("conceptolista");
    if(conceptolista==null){
    System.out.println("Concepto vacio");
    }
    depositoBancariolista = (List<obj_DepositoBancario>) request.getAttribute("listDeposito");
    if(depositoBancariolista==null){
    System.out.println("Deposito bancario vacio");
    }
    detalleArrendamientolista = (List<obj_detalleArrendamiento>) request.getAttribute("detallelista");
    if(detalleArrendamientolista==null){
    System.out.println("Detalle arrendamiento vacio");
    }
    arrendamiento = (obj_MArrendamiento) request.getAttribute("memorandum"); 
    if(arrendamiento==null){
    System.out.println("Arrendamiento vacio");
    }
    
    }catch(Exception ex){
    // No hay sesión o usuario en ella, redirigir al index.jsp
    response.sendRedirect("ErroresGenerales.jsp");
    }
   
    
%>

<%
    Date dNow2 = new Date(); //Obtiene la fecha
    SimpleDateFormat ft2 = new SimpleDateFormat("dd/MM/yyyy"); //Convierte el formato
    String currentDate2 = ft2.format(dNow2); //La convierte en cadena
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
        <h3>MEMORÁNDUM ARRENDAMIENTO</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <p class="fw-bold text-center" id="muestraNumeroMemorandum" style="color: #1346B4;"></p>
    <hr>

    <!-- Tabs navs -->
    <ul class="nav nav-tabs nav-justified mb-3" id="ex1" role="tablist">
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link active stc" id="ex3-tab-1" href="#ex3-tabs-1" role="tab" aria-controls="ex3-tabs-1" aria-selected="true">
                CAPTURA DE MEMORÁNDUMS
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link stc" id="ex3-tab-2" href="#ex3-tabs-2" role="tab" aria-controls="ex3-tabs-2" aria-selected="false">
                REPORTES E IMPRESIÓN DE MEMORÁNDUMS
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link stc" id="ex3-tab-3" href="#ex3-tabs-3" role="tab" aria-controls="ex3-tabs-3" aria-selected="false">
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
            <h4 class="stc" style="text-align: center;">CAPTURA DE MEMORÁNDUMS DE ARRENDAMIENTO</h4>
            <hr>
            <c:if test="${not empty memorandum}">
                <p id="numeromemotexto">EL NÚMERO DE MEMORÁNDUM ES: ${memorandum.noMemorandum}</p>
            </c:if>

            <div class="row">
                <div class="col stc" style="justify-content: right; display: flex;">
                    <button type="button" id="Buscar" name="action" value="104" style="display: block; color:white; background-color: #F1621F;font-size: 15px;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-mdb-modal-init data-mdb-target="#modalArrendamiento" title="BUSCAR">
                        <i class="fa-brands fa-searchengin"></i>
                        <span class="btn-text">BUSCAR</span>
                    </button>
                </div>
            </div>
            <form class="fontformulario" id="capturaMemorandum" method="POST" style="font-size: 75%; margin: 15px;">

                <hr>
                <div class="row mb-4">
                    <input style="font-weight: bold;" type="text" id="idConcepto" name="idConcepto" class="form-control form-control-sm" hidden/>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="nombreConcepto" name="nombreConcepto" list="ListaConcepto" onChange="get_idConcepto()" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required/>
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
                            <input style="font-weight: bold;" type="text" id="remitente" name="remitente" value="" class="form-control form-control-sm" readonly/>
                            <label class="form-label" for="Rem">REMITENTE</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="destinatario" name="destinatario" class="form-control form-control-sm" value="" readonly/>
                            <label class="form-label" for="Dest">DESTINATARIO</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="date" name="fecha" id="fecha" class="form-control form-control-sm" required/>
                            <label class="form-label" for="fch">FECHA</label>
                        </div>
                    </div>
                    <script>
                        // Obtiene la fecha de hoy en el formato YYYY-MM-DD
                        var hoy = new Date().toISOString().split('T')[0];
                        // Asigna la fecha de hoy al atributo max del input
                        document.getElementById('fecha').setAttribute('max', hoy);
                    </script>
                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select style="font-weight: bold;" class="form-control form-control-sm" id="depositoBancario" name="depositoBancario" onChange="elegirCuentaBancaria()" data-mdb-select-init class="form-select" aria-label="Default select example" style="font-size: 105%;" required>
                                <option value="" disabled selected style="display: none;" ></option>
                                <%
                                 for (int i = 0; i < depositoBancariolista.size(); i++) {
                                     depositoBancario = depositoBancariolista.get(i); %>
                                <option value="<% out.print(depositoBancario.getCuentaBancaria());%>"> <% out.print(depositoBancario.getDepositoBancario());%> </option>
                                <%}%>
                            </select>
                            <label class="form-label" for="DBan">DEPÓSITO BANCARIO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="cuentaBancaria" name="cuentaBancaria" class="form-control form-control-sm" readonly/>
                            <label class="form-label" for="CBan">CUENTA BANCARIA</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <!-- Message input -->
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <textarea style="font-weight: bold;" class="form-control form-control-sm" name="conceptoGeneral" id="conceptoGeneral" rows="3" value=""></textarea>
                            <label class="form-label" for="GConc">CONCEPTO GENERAL</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="desgloseConcepto" name="desgloseConcepto" class="form-control form-control-sm"  />
                            <label class="form-label" for="DConc">DESGLOSE DE CONCEPTOS</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" step="0.01" min="0" step="any" id="importe" name="importe" class="form-control form-control-sm" min="0" pattern="\d*" />
                            <label class="form-label" for="Impt">IMPORTE</label>
                        </div>
                    </div>   
                    <div class="col">
                        <div style="justify-content: left; display: flex;">
                            <button type="button" id="insertar" style="color:white;background-color: #008A13;"  class="stc btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Guardar" onclick="insertRow()">
                                <i class="fas fa-floppy-disk"></i>
                                <span class="btn-text">INSERTAR</span>
                            </button>
                        </div>
                    </div>
                </div>
            <script>

    function updateRowNumbers() {
        var table = document.getElementById("tablaIMP").getElementsByTagName('tbody')[0];
        var rows = table.getElementsByTagName('tr');
        for (var i = 0; i < rows.length; i++) {
            rows[i].getElementsByTagName('td')[0].innerHTML = i + 1;
        }
    }

    // Function to insert a row in the table
    function insertRow() {
        
        let filaSeleccionada = document.querySelector('.selected');

        if (filaSeleccionada) {
            // Obtener todas las celdas de la fila seleccionada
            let celdas = filaSeleccionada.getElementsByTagName('td');
            var conceptoActualizar = document.getElementById("desgloseConcepto").value.toUpperCase();
            var importeActualizar = document.getElementById("importe").value;
            
            // Actualiza la celda 2
            celdas[1].innerHTML = conceptoActualizar;
            celdas[1].innerHTML += '<input type="hidden" name="concepto[]" value="' + conceptoActualizar + '">';

            // Actualiza la celda 3
            celdas[2].innerHTML = importeActualizar;
            celdas[2].innerHTML += '<input type="hidden" name="importe[]" value="' + importeActualizar + '">';

            // Clear input fields
            document.getElementById("desgloseConcepto").value = "";
            document.getElementById("importe").value = "";
            calcularTotales();
            document.querySelector('.selected').classList.remove('selected');
        } else {
            console.log('No hay ninguna fila seleccionada.');

            var concepto = document.getElementById("desgloseConcepto").value.toUpperCase();
            var importe = document.getElementById("importe").value;

            if (importe < 0) {
                customeError("ERROR","EL VALOR DEL IMPORTE DEBE SER MAYOR A 0");
            } else {
                if (concepto && importe) {
                    var table = document.getElementById("tablaIMP").getElementsByTagName('tbody')[0];
                    var newRow = table.insertRow(table.rows.length);

                    var cell1 = newRow.insertCell(0);
                    var cell2 = newRow.insertCell(1);
                    var cell3 = newRow.insertCell(2);
                    var cell4 = newRow.insertCell(3);

                    cell1.innerHTML = table.rows.length;
                    cell1.innerHTML += '<input type="hidden" name="renglon[]" value="' + table.rows.length + '">';
                    cell2.innerHTML = concepto;
                    cell2.innerHTML += '<input type="hidden" name="concepto[]" value="' + concepto + '">';
                    cell3.innerHTML = importe;
                    cell3.innerHTML += '<input type="hidden" name="importe[]" value="' + importe + '">';
                    cell4.innerHTML = '<button type="button" class="btn btn-danger btn-sm" onclick="deleteRow(this)"><i class="fas fa-trash"></i></button>';

                    // Clear input fields
                    document.getElementById("desgloseConcepto").value = "";
                    document.getElementById("importe").value = "";
                    calcularTotales();
                } else {
                    customeError("ERROR","POR FAVOR, COMPLETA TODOS LOS CAMPOS.");
                }
            }
        }
    }

    // Function to delete a row from the table
    function deleteRow(btn) {
        var row = btn.parentNode.parentNode;
        row.parentNode.removeChild(row);
        updateRowNumbers();
        calcularTotales();
    }
    
    
document.addEventListener('DOMContentLoaded', function() {
    let tablaDesglose = document.getElementById('datos');
    
    tablaDesglose.addEventListener('click', function (event) {
        if (event.target.tagName === 'TD' || event.target.tagName === 'BUTTON') {
            var fila = event.target.closest('tr'); // Asegúrate de obtener la fila correcta

            if (tablaDesglose.querySelector('.selected')) {
                tablaDesglose.querySelector('.selected').classList.remove('selected');
            }
            fila.classList.add("selected");

            // Obtener los datos de la fila por posición
            let celdas = fila.querySelectorAll('td'); // Obtiene todas las celdas en la fila
            let desgloseConcepto = celdas[1] ? celdas[1].innerText : ''; // Segunda celda (índice 1)
            let importe = celdas[2] ? celdas[2].innerText : ''; // Tercera celda (índice 2)

            // Obtener el botón de eliminación
            let botonEliminar = fila.querySelector('td:last-child button');
            if (botonEliminar) {
                console.log("Se encontró el botón eliminar");
                // Simula un clic en el botón (opcional)
             //    botonEliminar.click(); 
            } else {
                console.log("No se encontró el botón");
            }

            // Actualizar el formulario con los datos de la fila
            document.getElementById("desgloseConcepto").value = desgloseConcepto;
            document.getElementById("importe").value = importe;

            // Enfocar en los campos del formulario
            document.getElementById("desgloseConcepto").focus();
            document.getElementById("importe").focus();
        }
    });
});
            </script>
                <br>
                <div class="row d-flex justify-content-center p-3">
                    <div class="contenedortabla table-responsive">
                        <table id="tablaIMP" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                            <thead class="table-secondary">
                                <tr class="text-center" style="font-weight: bold;">
                                    <th class="fw-bold">RENGLÓN</th>
                                    <th class="fw-bold">CONCEPTO</th>
                                    <th class="fw-bold">IMPORTE</th>
                                    <th class="fw-bold">ELIMINAR</th>
                                </tr>
                            </thead>
                            <tbody id="datos" class="text-center" style="font-size: 85%;">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" step="0.01" min="0" id="monto" name="monto" class="form-control form-control-sm" onchange="calcularTotales()"/>
                            <label class="form-label" for="Mon1">MONTO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" step="0.000001" min="0" id="iva" name="iva" class="form-control form-control-sm" onchange="calcularTotales()"/>
                            <label class="form-label" for="iva1">I.V.A.</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" step="0.01" min="0" id="trasladado" name="trasladado" class="form-control form-control-sm" onchange="calcularTotales()"/>
                            <label class="form-label" for="trasladado">TRASLADADO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" step="0.01" min="0" id="total" name="total" class="form-control form-control-sm" onchange="calcularTotales()"/>
                            <label class="form-label" for="tot1">TOTAL</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="totalLetras"  type="text" name="totalLetras" class="form-control form-control-sm" readonly/>
                            <label class="form-label" for="TotalL">IMPORTE TOTAL EN LETRAS</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="nombreVo" name="nombreVo" class="form-control form-control-sm" />
                            <label class="form-label" for="NPer">NOMBRE Vo.Bo.</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="puestoVo" name="puestoVo" class="form-control form-control-sm" />
                            <label class="form-label" for="PstoVoBo">PUESTO Vo.Bo.</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="nombreAtentamente" name="nombreAtentamente" class="form-control form-control-sm" />
                            <label class="form-label" for="NPerAtt">NOMBRE ATENTAMENTE</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="puestoAtentamente" name="puestoAtentamente" class="form-control form-control-sm" />
                            <label class="form-label" for="PstoAtt">PUESTO ATENTAMENTE</label>
                        </div>
                    </div>
                </div>
                <div style="justify-content: center; display: flex;">
                    <button type="button" id="Guardar" name="action" style="color:white;background-color: #008A13;" value="101" class="stc btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Guardar" onclick="sendDataToArredamiento('101')">
                        <i class="fas fa-floppy-disk"></i>
                        <span class="btn-text">GUARDAR</span>
                    </button>
                    <button type="submit" id="Modificar" name="action" value="102" style="display: none; color:white; background-color: #0370A7;" class="stc btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="MODIFICAR" onclick="sendDataToArredamiento('102')">
                        <i class="fas fa-pen-to-square"></i>
                        <span class="btn-text">MODIFICAR</span>
                    </button>
                    <button type="reset" id="Limpiar" class="stc btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar" onclick="resetFecha()"><!--Boton tipo reset-->
                        <i class="fas fa-eraser"></i>
                        <span class="btn-text">LIMPIAR</span>
                    </button>
                </div>
            </form>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="modalArrendamiento" data-mdb-backdrop="static" data-mdb-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true" style="font-size: 80%;">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <form action="Srv_MArrendamiento" method="POST" id="formularioBuscar">
                        <div class="modal-header">
                            <h5 class="modal-title stc" id="staticBackdropLabel">BUSCAR MEMORÁNDUM ARRENDAMIENTO</h5>
                            <button type="button" class="btn-close" data-mdb-ripple-init data-mdb-dismiss="modal" aria-label="Close" id="closeModalButton"></button>
                        </div>
                        <!-- Dentro de tu modal -->
                        <div class="modal-body mt-0">
                            <div data-mdb-input-init class="form-outline fw-bold" style="background-color: white;">
                                <input type="text" id="memorandum" onChange="validateMemo()" name="memorandum" list="ListMemorandumCancelacion" class="form-control fw-bold" required/>
                                <label class="form-label" for="cnt">NÚMERO DE MEMORÁNDUM</label>
                            </div>
                        </div>
                        <script>
      function validateMemo() {
         var input = document.getElementById('memorandum').value.toUpperCase();
         var lista = document.getElementById('ListMemorandumCancelacion').getElementsByTagName('option');
         var found = false;

         // Iterar sobre los elementos de la lista
         for (var i = 0; i < lista.length; i++) {
             if (input === lista[i].value) {
                 found = true;
                 break;
             }
         }

         // Si no se encontró el RFC en la lista, limpiar el input
         if (!found) {
             customeError("ERROR",'MEMORÁNDUM NO VÁLIDO');
             document.getElementById('memorandum').value = '';
         }
     }     
                        </script>
                        <div class="modal-footer stc">
                            <button type="submit" id="buscaMemo" name="action" value="104" style="display: block; color:white; background-color: #F1621F;font-size: 14px;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="MODIFICAR">
                                <i class="fa-brands fa-searchengin"></i>
                                <span class="btn-text">BUSCAR</span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <style>
            /* Cambiar el color de la bolita cuando el switch está desactivado */
            .form-check-input:not(:checked)::after {
                background-color: #6c757d; /* Bolita gris cuando no está activado */
            }
        </style>
        <div class="tab-pane fade" id="ex3-tabs-2" role="tabpanel" aria-labelledby="ex3-tab-2">
            <form action="Srv_MArrendamiento" target="_blank" method="POST" class="fontformulario" id="impresionMemorandum" style="font-size: 75%; margin: 15px;">
                <div class="row">
                    <h5 class="stc" style="text-align: center;">IMPRESIÓN DE MEMORÁNDUMS DE ARRENDAMIENTO</h5>
                    <hr>

                    <div class="col-sm-6">
                        <br>
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
                                        <label class="form-label" for="listaMemorandumImpresion">No. MEMORÁNDUM</label>
                                    <datalist id="ListMemorandumImpresion">
                                        <c:forEach var="memo" items="${memlista}">
                                            <c:if test="${memo.estatus == 'A' || memo.estatus == 'I'}">
                                                <option data-value="${memo.idMemorandum}" value="${memo.noMemorandum}"></option>
                                            </c:if>
                                        </c:forEach>
                                    </datalist>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <br>
                        <div class="form-check form-switch">
                            <input class="form-check-input btn-azul" type="checkbox" role="switch" name="imprimirListadoMemorandum" id="imprimirListadoMemorandum">
                            <label class="form-check-label fs-6" for="imprimirListadoMemorandum" style="font-weight: bold;color:black;">[ <span  id="spanNoLista" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiLista" hidden="true">SI</span> ] IMPRIMIR LISTADO DE MEMORÁNDUM</label>
                        </div>
                        <br>
                        <div class="card">
                            <div class="card-body">
                                <div class="col">
                                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                        <input type="date" name="fechaInicio" id="fechaInicio" class="form-control form-control-sm" disabled/>
                                        <label class="form-label" for="fechaInicio">FECHA INICIO</label>
                                    </div>
                                </div>
                                <br>
                                <div class="col">
                                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                        <input type="date" name="fechaFin" id="fechaFin" class="form-control form-control-sm" onchange="validateDates()" disabled/>
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
                                    <div class="col">
                                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                            <input style="font-weight: bold;" type="text" id="inicioMemorandum" name="inicioMemorandum" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required disabled/>
                                            <label class="form-label" for="inicioMemorandum">INICIO MEMORÁNDUM</label>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                            <input style="font-weight: bold;" type="text" id="finMemorandum" name="finMemorandum" class="form-control form-control-sm" onblur="this.value = this.value.trim()" required disabled/>
                                            <label class="form-label" for="finMemorandum">HASTA MEMORÁNDUM</label>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>                       
                <br><br>
                <script>
                document.getElementById('imprimirRangoMemorandum').addEventListener('change', function () {
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
                </script>
                --%>
                <div style="justify-content: center; display: flex;">
                    <button type="submit" disabled name="action" id="imprimir" value="105" title="Imprimir" class="stc btn btn-sm btn-rounded" style="color:white; background-color: purple;" data-mdb-ripple-init>
                        <i class="fas fa-print"></i>
                        <span class="d-none d-sm-inline">IMPRIMIR EN PDF</span> </button>
                    <button type="reset" class="btn btn-dark btn-sm btn-rounded stc" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar" id="limpiarImpresion">
                        <i class="fas fa-eraser"></i>
                        <span class="btn-text d-none d-sm-inline">LIMPIAR</span>
                    </button>
                </div>
            </form>
        </div>


        <div class="tab-pane fade" id="ex3-tabs-3" role="tabpanel" aria-labelledby="ex3-tab-3">
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page import="java.text.SimpleDateFormat" %>
        <%@ page import="java.util.Date" %>

        <%
            // Obtener la fecha actual en formato YYYY-MM-DD
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String today = sdf.format(new Date());
            pageContext.setAttribute("today", today);
        %>

            <form class="fontformulario" id="cancelacionMemorandum" method="POST" style="font-size: 75%; margin: 15px;">
                <h5 class="stc" style="text-align: center;">CANCELACIÓN DE MEMORANDUMS</h5>
                <hr>
                <div class="form-check form-switch">
                    <input class="form-check-input btn-azul" type="checkbox" role="switch"  name="cancelacionMemorandums" id="cancelacionMemorandums">
                    <label class="form-check-label fs-6" for="cancelacionMemorandums" style="font-weight: bold;color:black;">[ <span  id="spanNoCancelar" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiCancelar" hidden="true">SI</span> ] CANCELACIÓN DE MEMORÁNDUMS</label>
                </div>
                <br>
                <div class="row mb-4">
                    <small id="listaCancelacionVacia" class="error fw-bold fs-6 form-text" style="display:none;color: #810808;">NO HAY MEMORÁNDUMS PARA CANCELAR</small>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="listaMemorandumCancelacion" name="listaMemorandumCancelacion"  list="ListMemorandumCancelacion" onchange="get_nmcan()" class="form-control" onblur="this.value = this.value.trim()" required disabled/>  
                            <label class="form-label" for="listaMemorandumCancelacion">No. MEMORANDUM</label>
                            <datalist id="ListMemorandumCancelacion">
                                <c:forEach var="memo" items="${memlista}">
                                    <c:if test="${memo.estatus == 'A'}">
                                        <option data-value="${memo.idMemorandum}" value="${memo.noMemorandum}"></option>
                                    </c:if>
                                </c:forEach>
                            </datalist>
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
                        <!-- Message input -->
                        <div data-mdb-input-init class="form-outline mb-4" style="background-color: white;">
                            <textarea style="font-weight: bold;" class="form-control form-control-sm" id="motivoCancelacion" name="motivoCancelacion" rows="3" disabled></textarea>
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
                        <button type="reset" id="LimpiarCancelacion" class="btn btn-dark btn-sm btn-rounded stc" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar"><!--Boton tipo reset-->
                            <i class="fas fa-eraser"></i>
                            <span class="btn-text">LIMPIAR</span>
                        </button>
                    </div>
                </div>
                <br>
                <h5 class="stc" style="text-align: center;">ACTIVACIÓN DE MEMORÁNDUMS</h5>
                <hr>
                <div class="form-check form-switch">
                    <input class="form-check-input btn-azul" type="checkbox" role="switch"  name="activacionMemorandums" id="activacionMemorandums">
                    <label class="form-check-label fs-6" for="activacionMemorandums" style="font-weight: bold;color:black;">[ <span  id="spanNoActivacion" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiActivacion" hidden="true">SI</span> ] ACTIVACIÓN DE MEMORANDUMS DE ARRENDAMIENTO</label>
                </div>
                <br>
                <div class="row mb-4">
                      <small id="listaActivacionVacia" class="error fw-bold fs-6 form-text" style="display:none;color: #810808;">NO HAY MEMORÁNDUMS PARA ACTIVAR</small>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="listaMemorandumActivacion" name="listaMemorandumActivacion"  list="ListMemorandumActivacion" onchange="get_nmact()" class="form-control" onblur="this.value = this.value.trim()" required disabled/>  
                            <label class="form-label" for="Nmem">No. MEMORANDUM</label>
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
                    <div  class="stc" style="justify-content: center; display: flex;">
                        <button type="submit" id="GuardarActivacion" name="action" value="106" style="color:white;background-color: #008A13;" class="btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Guardar" disabled onclick="changeStatusMemorandum('106')">
                            <i class="fas fa-floppy-disk"></i>
                            <span class="btn-text">ACTIVAR</span>
                        </button>
                        <button type="reset" id="LimpiarActivacion" class="btn btn-dark btn-sm btn-rounded stc" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar"><!--Boton tipo reset-->
                            <i class="fas fa-eraser"></i>
                            <span class="btn-text">LIMPIAR</span>
                        </button>
                    </div>
                </div>
            </form>
        </div>

    </div>

  <br>
         

</main>



                            
                            

                            

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


<div class="alert fade alert-fixed alert-success show text-center stc" id="MensajeExito"
     style="display:none; width: 30%; top:5%; right: 10px; left: 50%;
     transform: translate(-50%); position: fixed;">
    <h5><svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
            <path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"/>
            <path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"/>
        </svg>&nbsp;&nbsp;
    <span id="TituloMensajeExito"></span>
    </h5>
    <p id="DescripcionMensajeExito"></p>
</div>

<%@include file="../Mensaje.jsp"%>

<script  type="text/javascript">
    // Establecer la fecha actual
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); // Enero es 0
    var yyyy = today.getFullYear();

    // Formatear la fecha como yyyy-MM-dd para que sea compatible con el input type="date"
    var formattedDate = yyyy + '-' + mm + '-' + dd;

    const jsonArrendamiento = <%= new Gson().toJson(arrendamiento) %>;
    const listaArendamiento = <%= new Gson().toJson(detalleArrendamientolista) %>;

    if (jsonArrendamiento) {
        document.getElementById("idConcepto").value = jsonArrendamiento.idConcepto;
        document.getElementById("nombreConcepto").value = jsonArrendamiento.nombreConcepto;
        document.getElementById("conceptoGeneral").value=jsonArrendamiento.conceptoGeneral;
        document.getElementById("nombreVo").value=jsonArrendamiento.nombreVo;
        document.getElementById("puestoVo").value=jsonArrendamiento.puestoVo;
        document.getElementById("nombreAtentamente").value=jsonArrendamiento.nombreAtt;
        document.getElementById("puestoAtentamente").value=jsonArrendamiento.puestoAtt;

       // get_Descripcion();
        document.getElementById("fecha").value = jsonArrendamiento.fecha;

        document.getElementById("remitente").value = jsonArrendamiento.remitente;

        
        document.getElementById("destinatario").value = jsonArrendamiento.destinatario;


        document.getElementById("depositoBancario").value = jsonArrendamiento.cuentaBancaria;
        elegirCuentaBancaria();
        document.querySelector('#Guardar').style.display = "none";
        document.querySelector('#Modificar').style.display = "block";

    }

    if (listaArendamiento) {
        let table = document.getElementById("tablaIMP").getElementsByTagName('tbody')[0];

        listaArendamiento.forEach(detalle => {
            var newRow = table.insertRow(table.rows.length);

            var cell1 = newRow.insertCell(0);
            var cell2 = newRow.insertCell(1);
            var cell3 = newRow.insertCell(2);
            var cell4 = newRow.insertCell(3);
            cell1.innerHTML = detalle.consecutivo;
            cell1.innerHTML += '<input type="hidden" name="renglon[]" value="' + detalle.consecutivo + '">';
            cell2.innerHTML = detalle.concepto_desglose;
            cell2.innerHTML += '<input type="hidden" name="concepto[]" value="' + detalle.concepto_desglose + '">';
            cell3.innerHTML = detalle.importe;
            cell3.innerHTML += '<input type="hidden" name="importe[]" value="' + detalle.importe + '">';
            cell4.innerHTML = '<button type="button" class="btn btn-danger btn-sm" onclick="deleteRow(this)"><i class="fas fa-trash"></i></button>';
        });
        calcularTotales();

    }

    function sendDataToArredamiento(action) {
        let tabla = document.getElementById("tablaIMP");
        let filas = tabla.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
        let body = {};
        let datos = [];

        for (let i = 0; i < filas.length; i++) {
            let celdas = filas[i].getElementsByTagName("td");
            let filaDatos = {};
            for (let j = 0; j < celdas.length; j++) {
                let input = celdas[j].getElementsByTagName("input")[0];
                if (input) {
                    if ((j + 1) == 1)
                        filaDatos["renglon"] = input.value;
                    if ((j + 1) == 2)
                        filaDatos["concepto"] = input.value;
                    if ((j + 1) == 3)
                        filaDatos["importe"] = input.value;

                }
            }
            datos.push(filaDatos);
        }

     
        let idConcepto = document.getElementById("idConcepto");        
        let nombreConcepto = document.getElementById("nombreConcepto");
        let fecha = document.getElementById("fecha");
        let remitente = document.getElementById("remitente");
        let destinatario = document.getElementById("destinatario");
        let depositoBancario = document.getElementById("depositoBancario");
        let cuentaBancaria = document.getElementById("cuentaBancaria");
        let conceptoGenral = document.getElementById("conceptoGeneral");
        let monto = document.getElementById("monto");
        let iva = document.getElementById("iva");
        let trasladado = document.getElementById("trasladado");
        let total = document.getElementById("total");
        let importeLetras = document.getElementById("totalLetras");
        let nombreVo = document.getElementById("nombreVo");
        let puestoVo = document.getElementById("puestoVo");
        let nombreAtt = document.getElementById("nombreAtentamente");
        let puestoAtt = document.getElementById("puestoAtentamente");

// Validación de los campos requeridos
 // Array de los campos a validar
    let campos = [
    importeLetras,
    puestoAtt,
    nombreAtt,
    puestoVo,
    nombreVo,
    total,
    trasladado,
    iva,
    monto,
    conceptoGenral,
    cuentaBancaria,
    depositoBancario,
    destinatario,
    remitente,
    fecha,
    nombreConcepto,
    idConcepto
    
];

    let todosLlenos = true; // Bandera para verificar si todos los campos están llenos

    // Validación de los campos requeridos
     campos.forEach(campo => {
        if (!campo.value) {
            campo.setCustomValidity('Invalid input'); // Establece el mensaje de error
            campo.focus();
            todosLlenos = false; // Un campo está vacío
        } else {
            campo.setCustomValidity(''); // Limpia el mensaje de error
        }
    });

    if (!todosLlenos) {
        customeError("", "Por favor, completa todos los campos requeridos.");
        return;
    }
    
        body.idConcepto = idConcepto.value;
        body.concepto = nombreConcepto.value.toUpperCase();
        body.fecha = fecha.value.toUpperCase();
        body.remitente = remitente.value.toUpperCase();
        body.destinatario = destinatario.value.toUpperCase();
        body.Deposito = depositoBancario.value.toUpperCase();
        body.Cuenta = cuentaBancaria.value.toUpperCase();
        body.GConcepto = conceptoGenral.value.toUpperCase();
        body.monto = monto.value;
        body.iva = iva.value;
        body.trasladado = trasladado.value;
        body.total = total.value;
        body.voNombre = nombreVo.value.toUpperCase();
        body.attNombre = nombreAtt.value.toUpperCase();
        body.voPuesto = puestoVo.value.toUpperCase();
        body.attPuesto = puestoAtt.value.toUpperCase();
        body.importes = datos;
        body.importeLetras = importeLetras.value.toUpperCase();
        body.action = action;

        if (jsonArrendamiento?.idMemorandum)
            body.idMemorandum = jsonArrendamiento.idMemorandum;
        if (jsonArrendamiento?.noMemorandum)
            body.memorandum = jsonArrendamiento.noMemorandum;

        console.log(body);
       var xhr = new XMLHttpRequest();
        xhr.open("POST", "Srv_MArrendamiento", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xhr.onload = function() {
            if (xhr.status == 200) {
            try {
               
                let mensajeExito=document.getElementById("MensajeExito");
                let tituloExito=document.getElementById("TituloMensajeExito");
                let descripcionExito= document.getElementById("DescripcionMensajeExito");
                
                var response = JSON.parse(xhr.responseText);
                var dataList = document.getElementById('ListMemorandumImpresion');
                dataList.innerHTML = '';  // Limpia el datalist antes de llenarlo
                if (response.datalistImpresion) {
                    response.datalistImpresion.forEach(function (memo) {
                        if (memo.estatus === 'A' || memo.estatus === 'I') {
                            var option = document.createElement('option');
                            option.value = memo.noMemorandum;
                            option.setAttribute('data-value', memo.idMemorandum);
                            dataList.appendChild(option);
                        }
                    });
                }
            var dataList2 = document.getElementById('ListMemorandumCancelacion');
            dataList2.innerHTML = '';  // Limpia el datalist antes de llenarlo

            if (response.datalistImpresion) {
                response.datalistImpresion.forEach(function (memo) {
                    if (memo.estatus === 'A') {
                        var option = document.createElement('option');
                        option.value = memo.noMemorandum;
                        option.setAttribute('data-value', memo.idMemorandum);
                        dataList2.appendChild(option);
                    }
                });
            }
            
                if(response.tipomensaje=="Exito"){
                    response.messages.forEach(function(message) {
                        tituloExito.innerText =response.tipomensaje;
                        descripcionExito.innerText =message;
                        mensajeExito.style.display="block";
                        document.getElementById("muestraNumeroMemorandum").innerText =message;
                        // Ocultar el mensaje de alerta después de unos segundos
                    setTimeout(function () {
                        mensajeExito.style.display = 'none';
                    }, 3500);
                        });
                    //window.location.href = "Srv_MArrendamiento";
                }else if (response.tipomensaje=="Error"){
                    response.messages.forEach(function(message) {
                        customeError("ERROR", message);
                    });
                }
                
            } catch (e) {
                customeError("ERROR", "ERROR AL PROCESAR LA RESPUESTA JSON: " + e);
                console.error("Error al procesar la respuesta JSON: ", e);
            }
        } else {
            customeError("ERROR",'ERROR EN LA SOLICITUD AJAX.');
            console.error("Error en la solicitud AJAX.");
        }
        };
        xhr.send(JSON.stringify(body));

        document.getElementById("Limpiar").click();
        limpiarTabla();
    }

    function changeStatusMemorandum(action) {
        let body = {};
    body.action = action;
    
    // Validación de los campos
    let isValid = true;
    if (action == "103") {
        let noMemorandum = document.getElementById("listaMemorandumCancelacion").value;
        let motivoCancelacion = document.getElementById("motivoCancelacion").value.toUpperCase();
        if (!noMemorandum || !motivoCancelacion) {
            isValid = false;
            customeError("ERROR", "POR FAVOR, COMPLETA TODOS LOS CAMPOS REQUERIDOS.");
        } else {
            body.memorandum = noMemorandum;
            body.motivoCancelacion = motivoCancelacion;
        }
    } else if (action == "106") {
        let noMemorandum = document.getElementById("listaMemorandumActivacion").value;
        if (!noMemorandum) {
            isValid = false;
            customeError("ERROR", "POR FAVOR, COMPLETA TODOS LOS CAMPOS REQUERIDOS.");
        } else {
            body.memorandum = noMemorandum;
        }
    }

    if (!isValid) {
        return; // Si no es válido, no enviar la solicitud
    }
        
        
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "Srv_MArrendamiento", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xhr.onload = function() {
            if (xhr.status == 200) {
            try {
               
                let mensajeExito=document.getElementById("MensajeExito");
                let tituloExito=document.getElementById("TituloMensajeExito");
                let descripcionExito= document.getElementById("DescripcionMensajeExito");
                
                var response = JSON.parse(xhr.responseText);
                var dataList = document.getElementById('ListMemorandumImpresion');
                dataList.innerHTML = '';  // Limpia el datalist antes de llenarlo
                if (response.datalistImpresion) {
                    response.datalistImpresion.forEach(function (memo) {
                        if (memo.estatus === 'A' || memo.estatus === 'I') {
                            var option = document.createElement('option');
                            option.value = memo.noMemorandum;
                            option.setAttribute('data-value', memo.idMemorandum);
                            dataList.appendChild(option);
                        }
                    });
                }
                var dataList2 = document.getElementById('ListMemorandumCancelacion');
            dataList2.innerHTML = '';  // Limpia el datalist antes de llenarlo

            if (response.datalistImpresion) {
                response.datalistImpresion.forEach(function (memo) {
                    if (memo.estatus === 'A') {
                        var option = document.createElement('option');
                        option.value = memo.noMemorandum;
                        option.setAttribute('data-value', memo.idMemorandum);
                        dataList2.appendChild(option);
                    }
                });
            }
                if(response.tipomensaje=="Exito"){
                    response.messages.forEach(function(message) {
                        tituloExito.innerText =response.tipomensaje;
                        descripcionExito.innerText =message;
                        mensajeExito.style.display="block";
                        document.getElementById("muestraNumeroMemorandum").innerText =message;
                        // Ocultar el mensaje de alerta después de unos segundos
                setTimeout(function () {
                    mensajeExito.style.display = 'none';
                }, 3500);
                    });
                    //window.location.href = "Srv_MArrendamiento";
                }else if (response.tipomensaje=="Error"){
                    response.messages.forEach(function(message) {
                        customeError("ERROR", message);
                    });
                }
                
            } catch (e) {
                customeError("ERROR", "ERROR AL PROCESAR LA RESPUESTA JSON: " + e);
                console.error("Error al procesar la respuesta JSON: ", e);
            }
        } else {
            customeError("ERROR",'ERROR EN LA SOLICITUD AJAX.');
            console.error("Error en la solicitud AJAX.");
        }
        };
        xhr.send(JSON.stringify(body));
        document.getElementById("LimpiarCancelacion").click();
        document.getElementById("LimpiarActivacion").click();
    }


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
            get_Descripcion(dataValue);
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


//***************


    function get_Descripcion(idcon) {
        var dataValue = document.querySelector('#DescConc option[data-value="' + idcon + '"]').getAttribute("value");
        var dconcp = document.getElementById("conceptoGeneral");
        dconcp.value = dataValue;

        var remi = document.querySelector('#RemCon option[data-value="' + idcon + '"]').getAttribute("value");
        var casremi = document.getElementById("remitente");
        casremi.value = remi;
        document.getElementById("remitente").focus();

        var dest = document.querySelector('#DestiCon option[data-value="' + idcon + '"]').getAttribute("value");
        var casdest = document.getElementById("destinatario");
        casdest.value = dest;

        var nvo = document.querySelector('#nomVO option[data-value="' + idcon + '"]').getAttribute("value");
        var casnvo = document.getElementById("nombreVo");
        casnvo.value = nvo;

        var natt = document.querySelector('#nomATT option[data-value="' + idcon + '"]').getAttribute("value");
        var casnatt = document.getElementById("nombreAtentamente");
        casnatt.value = natt;

        var psVO = document.querySelector('#pstVO option[data-value="' + idcon + '"]').getAttribute("value");
        var caspvo = document.getElementById("puestoVo");
        caspvo.value = psVO;

        var psATT = document.querySelector('#pstATT option[data-value="' + idcon + '"]').getAttribute("value");
        var caspatt = document.getElementById("puestoAtentamente");
        caspatt.value = psATT;



        // Establecer el valor del campo de fecha como la fecha actual
        document.getElementById('fecha').value = formattedDate;

        // Ahora, el contenido de la segunda función
        var formulario = document.getElementById('capturaMemorandum');
        formulario.querySelector('#conceptoGeneral').focus();
        formulario.querySelector('#remitente').focus();
        formulario.querySelector('#fecha').focus();
        formulario.querySelector('#destinatario').focus();
        formulario.querySelector('#nombreVo').focus();
        formulario.querySelector('#nombreAtentamente').focus();
        formulario.querySelector('#puestoVo').focus();
        formulario.querySelector('#puestoAtentamente').focus();
         // Al final de la función, enfocar el select y mostrar las opciones
        const selectElement = formulario.querySelector('#depositoBancario');
        selectElement.focus();
        selectElement.click(); // Esto despliega la lista de opciones

    }


//Funcion para limpiar tabla de importes
    function limpiarTabla() {
        var tabla = document.getElementById("tablaIMP");
        var cuerpoTabla = tabla.getElementsByTagName("tbody")[0];

        // Elimina todas las filas del cuerpo de la tabla
        while (cuerpoTabla.rows.length > 0) {
            cuerpoTabla.deleteRow(0);
        }
    }
///////////////////////////////////
    //*****************Funcion limpiar para quitar boton y estiñps en tabla 
    document.addEventListener('DOMContentLoaded', function () {
        // Agregar el event listener para el botón de limpiar
        document.querySelector('#Limpiar').addEventListener('click', function () {
            document.getElementById("fecha").value = '';
            document.getElementById("fecha").focus();
            document.getElementById("fecha").blur();
            limpiarTabla();
            document.getElementById("numeromemotexto").innerHTML = "";
            document.querySelector('#Guardar').style.display = "block";
            document.querySelector('#Modificar').style.display = "none";
        });
    });
//******************************************************************

    function elegirCuentaBancaria() {
        let BancoCuenta = document.getElementById("depositoBancario").value;
        let cuentaBancaria = document.getElementById("cuentaBancaria");
        cuentaBancaria.value = BancoCuenta;
        cuentaBancaria.focus();
        cuentaBancaria.blur();
        cuentaBancaria.focus();
        document.getElementById('depositoBancario').focus();
        document.getElementById('depositoBancario').blur();
        document.getElementById('depositoBancario').focus();
        document.getElementById('depositoBancario').focus();
    }


    function calcularTotales() {
        let filas = document.querySelectorAll("#tablaIMP tbody tr");


        let sumaImporte = 0;
       // let monto = document.getElementById("monto").value ? document.getElementById("monto").value : 0;
        let monto = parseFloat(document.getElementById("monto").value) || 0;
        let iva = parseFloat(document.getElementById("iva").value) || 0;
        let trasladado = parseFloat(document.getElementById("trasladado").value) || 0;
        let total = parseFloat(document.getElementById("total").value) || 0;
        filas.forEach(fila => {
            let importe = parseFloat(fila.querySelector("td:nth-child(3) input").value);
            console.log("//////////////////////  "+ importe);
            sumaImporte += importe;
            console.log("/////**************/  "+ sumaImporte);
        });
        monto=sumaImporte;
        iva = monto * 0.16;  // Suponiendo un IVA del 16%
        //trasladado = sumaImporte * 0.04;  // Suponiendo un trasladado del 4%
       total = monto + iva + trasladado;
       total=total.toFixed(2);

        document.getElementById("monto").value = monto;
        document.getElementById("iva").value = iva;
        document.getElementById("trasladado").value = trasladado;
        document.getElementById("total").value = total;
        let totalLetras = convertirNumero(total);
        document.getElementById("totalLetras").value = totalLetras;

        document.getElementById("totalLetras").focus();
        document.getElementById("totalLetras").blur();
        document.getElementById("total").focus();
        document.getElementById("total").blur();
        document.getElementById("monto").focus();
        document.getElementById("monto").blur();
        document.getElementById("iva").focus();
        document.getElementById("iva").blur();
        document.getElementById("trasladado").focus();
        document.getElementById("trasladado").blur();

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
        if (num === 10000) return "DIEZ MIL";
        if (num === 1000000) return "UN MILLÓN";
        if (num === 1000000000) return "UN BILLÓN";

        let palabras = "";

        if (num < 10) return unidades[num];
        if (num < 20) return ["ONCE", "DOCE", "TRECE", "CATORCE", "QUINCE"][num - 11] || "DIECI" + unidades[num - 10];
        if (num < 30) return num === 20 ? "VEINTE" : "VEINTI" + unidades[num - 20];
        if (num < 100) return decenas[Math.floor(num / 10)] + (num % 10 ? " Y " + unidades[num % 10] : "");
        if (num < 1000) return centenas[Math.floor(num / 100)] + (num % 100 ? " " + convertirParteEntera(num % 100) : "");

        if (num < 1000000) {
           // if (num === 10000) return palabras="DIEZ MIL"; // Añadir esta comprobación
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



//************************************************ Impresion de memorandum    
    function get_nmi(type) {
        let input;

        // Obtener el valor de entrada según el tipo
        switch (type) {
            default:
                input = document.getElementById('listaMemorandumImpresion').value.toUpperCase();
                break;
        }
        // Obtener la lista de opciones
        var lista = document.getElementById('ListMemorandumImpresion').getElementsByTagName('option');
        var found = false;

        // Iterar sobre las opciones para buscar el valor de entrada
        for (var i = 0; i < lista.length; i++) {
            if (input === lista[i].value) {
                found = true;
                // Obtener el valor del atributo 'data-value'
                var dataValue = lista[i].getAttribute("data-value");
                // Asignar el valor al campo oculto
                document.getElementById('noMemorandumImpresion').value = dataValue;
                break;
            }
        }



        // Si no se encontró el valor en la lista, limpiar el input y mostrar alerta
        if (!found) {
            customeError("ERROR","NÚMERO DE MEMORÁNDUM NO VÁLIDO");
            document.getElementById('noMemorandumImpresion').value = '';
            document.getElementById('listaMemorandumImpresion').value = '';

        }
    }
    
    
        //**************************************CANCELACION
function get_nmcan() {
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
    
    
    //***********************************    
    document.getElementById('fechaInicio').setAttribute('max', formattedDate);
    document.getElementById('fechaFin').setAttribute('max', formattedDate);
    //*****************     
    document.getElementById('imprimirMemorandum').addEventListener('change', function () {
        const spanNoUno = document.getElementById('spanNoUno');
        const spanSiUno = document.getElementById('spanSiUno');
        if (this.checked) {
            spanNoUno.hidden = true;
            spanSiUno.hidden = false;
        } else {
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

    //**********************ACTIVAR CASILLAS IMPRESION MEMORANDUM
    var impmem = document.getElementById("imprimirMemorandum");
    var implist = document.getElementById("imprimirListadoMemorandum");
    var imprango = document.getElementById("imprimirRangoMemorandum");
    impmem.addEventListener('click', function () {
        if (impmem.checked) {
            document.getElementById("noMemorandumImpresion").disabled = false;
            document.getElementById("noMemorandumImpresion").required = true;

            document.getElementById("listaMemorandumImpresion").disabled = false;
            document.getElementById("listaMemorandumImpresion").required = true;
            document.getElementById("imprimir").disabled = false;
            implist.disabled = true;
            imprango.disabled = true;
        } else {
            implist.disabled = false;
            imprango.disabled = false;
            document.getElementById("imprimir").disabled = true;

            document.getElementById("noMemorandumImpresion").disabled = true;
            document.getElementById("noMemorandumImpresion").value = '';
            document.getElementById("noMemorandumImpresion").required = false;


            document.getElementById("listaMemorandumImpresion").value = '';
            document.getElementById("listaMemorandumImpresion").required = false;
            document.getElementById("listaMemorandumImpresion").focus();
            document.getElementById("listaMemorandumImpresion").blur();
            document.getElementById("listaMemorandumImpresion").disabled = true;
        }
    });

    //ACTIVAR CASILLAS IMPRESION LISTA DE MEMORANDUMS
    implist.addEventListener('click', function () {
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
            imprango.disabled = true;
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
            imprango.disabled = false;
        }
    });
    
    //ACTIVAR CASILLAS IMPRESION RANGO DE MEMORANDUMS
    imprango.addEventListener('click', function () {
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
    });


    document.querySelector('#limpiarImpresion').addEventListener('click', function () {
        document.getElementById('spanNoUno').hidden = false;
        document.getElementById('spanSiUno').hidden = true;
        document.getElementById('spanNoLista').hidden = false;
        document.getElementById('spanSiLista').hidden = true;
        document.getElementById("imprimirMemorandum").disabled = false;
        document.getElementById("imprimirListadoMemorandum").disabled = false;
        document.getElementById("imprimirRangoMemorandum").disabled = false;

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

    });

    document.querySelector('#LimpiarCancelacion').addEventListener('click', function () {
        document.getElementById('spanNoCancelar').hidden = false;
        document.getElementById('spanSiCancelar').hidden = true;
        document.getElementById("cancelacionMemorandums").disabled = false;
        document.getElementById("activacionMemorandums").disabled = false;
        document.getElementById("cancelacion").disabled = true;

        document.getElementById("listaMemorandumCancelacion").value = '';
        document.getElementById("listaMemorandumCancelacion").required = false;
        document.getElementById("listaMemorandumCancelacion").disabled = true;

        document.getElementById("motivoCancelacion").value = '';
        document.getElementById("motivoCancelacion").required = false;
        document.getElementById("motivoCancelacion").disabled = true;

    });


    document.querySelector('#LimpiarActivacion').addEventListener('click', function () {
        document.getElementById('spanNoActivacion').hidden = false;
        document.getElementById('spanSiActivacion').hidden = true;
        
        document.getElementById("cancelacionMemorandums").disabled = false;
        document.getElementById("activacionMemorandums").disabled = false;
        document.getElementById("GuardarActivacion").disabled = true;

        document.getElementById("listaMemorandumActivacion").value = '';
        document.getElementById("listaMemorandumActivacion").required = false;
        document.getElementById("listaMemorandumActivacion").disabled = true;


    });
    
    function validateDates() {
        let fechaInicio = document.getElementById("fechaInicio");
        let fechaFin = document.getElementById("fechaFin");

        if (fechaInicio.value > fechaFin.value) {
            customeError("ERROR","LA FECHA DE INCIO NO PUEDE SER POSTERIOR A LA FECHA DE TÉRMINO.");
            fechaInicio.value = "";
            fechaFin.value = "";
        }
    }

//************************************************ Activacion o desactivar de memorandum  
    document.getElementById('cancelacionMemorandums').addEventListener('change', function () {
        const spanNoCancelar = document.getElementById('spanNoCancelar');
        const spanSiCancelar = document.getElementById('spanSiCancelar');
        if (this.checked) {
            spanNoCancelar.hidden = true;
            spanSiCancelar.hidden = false;
        } else {
            spanNoCancelar.hidden = false;
            spanSiCancelar.hidden = true;
        }
    });

    document.getElementById('activacionMemorandums').addEventListener('change', function () {
        const spanNoCancelar = document.getElementById('spanNoActivacion');
        const spanSiCancelar = document.getElementById('spanSiActivacion');
        if (this.checked) {
            spanNoCancelar.hidden = true;
            spanSiCancelar.hidden = false;
        } else {
            spanNoCancelar.hidden = false;
            spanSiCancelar.hidden = true;
        }
    });


    const seccionActivacion = document.getElementById("activacionMemorandums");
    const seccionCancelacion = document.getElementById("cancelacionMemorandums");

    seccionActivacion.addEventListener('click', function () {
        if (seccionActivacion.checked) {
            document.getElementById("listaMemorandumActivacion").disabled = false;
            document.getElementById("listaMemorandumActivacion").required = true;
            document.getElementById("GuardarActivacion").disabled = false;
            seccionCancelacion.disabled = true;
        } else {
            seccionCancelacion.disabled = false;
            document.getElementById("GuardarActivacion").disabled = true;
            document.getElementById("listaMemorandumActivacion").value = '';
            document.getElementById("listaMemorandumActivacion").required = false;
            document.getElementById("listaMemorandumActivacion").focus();
            document.getElementById("listaMemorandumActivacion").blur();
            document.getElementById("listaMemorandumActivacion").disabled = true;
        }
    });


    seccionCancelacion.addEventListener('click', function () {
        if (seccionCancelacion.checked) {
            document.getElementById("listaMemorandumCancelacion").disabled = false;
            document.getElementById("listaMemorandumCancelacion").required = true;

            document.getElementById("motivoCancelacion").disabled = false;
            document.getElementById("motivoCancelacion").required = true;
            document.getElementById("cancelacion").disabled = false;

            seccionActivacion.disabled = true;
        } else {
            seccionActivacion.disabled = false;
            document.getElementById("cancelacion").disabled = true;

            document.getElementById("listaMemorandumCancelacion").value = '';
            document.getElementById("listaMemorandumCancelacion").required = false;
            document.getElementById("listaMemorandumCancelacion").focus();
            document.getElementById("listaMemorandumCancelacion").blur();
            document.getElementById("listaMemorandumCancelacion").disabled = true;

            document.getElementById("motivoCancelacion").value = '';
            document.getElementById("motivoCancelacion").required = false;
            document.getElementById("motivoCancelacion").focus();
            document.getElementById("motivoCancelacion").blur();
            document.getElementById("motivoCancelacion").disabled = true;

        }
    });

</script>
<%@include file="../Pie.jsp"%>