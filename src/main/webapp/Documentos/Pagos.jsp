<%-- 
    Document   : JSP_Pagos
    Created on : 20/06/2023, 12:47:28 PM
    Author     : Ing. Evelyn Leilani Avendaño 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@include file="../Encabezado.jsp"%>

<%-- CLIENTE--%>
<%@page import="Objetos.obj_ClientesSAT"%>
<%! List<obj_ClientesSAT> cslista;%>


<style>
    .centrado-verticalmente {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
    .input{
        text-transform: uppercase;
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
</style>
<!-- Cuerpo -->
<main class="col ps-md-2 pt-2 mx-3">
    <%@include file="../Mensaje.jsp"%>
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <div class="page-header pt-3 stc">
        <h3>PAGOS</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
    <!-- Tabs navs -->
    <ul class="nav nav-tabs nav-justified mb-3 stc" id="ex1" role="tablist">
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link active" id="ex3-tab-1" href="#ex3-tabs-1" role="tab" aria-controls="ex3-tabs-1" aria-selected="true">
                CAPTURA DE PAGO
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-2" href="#ex3-tabs-2" role="tab" aria-controls="ex3-tabs-2" aria-selected="false">
                DETALLE DE PAGO
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-3" href="#ex3-tabs-3" role="tab" aria-controls="ex3-tabs-3" aria-selected="false">
                IMPRESIÓN DE PAGO
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-4" href="#ex3-tabs-4" role="tab" aria-controls="ex3-tabs-4" aria-selected="false">
                REPORTES DE PAGO
            </a>
        </li>
    </ul>
    <!-- Tabs navs -->


    <!-- Tabs content -->
    <div class="tab-content" id="ex2-content">
        <div class="tab-pane fade show active" id="ex3-tabs-1" role="tabpanel" aria-labelledby="ex3-tab-1">
            <h5 class="stc" style="text-align: center;">DATOS DEL CLIENTE</h5>
            <hr>
            <div class="row mb-4">
                <div class="col">
                    <div class="form-outline mdb-input" >
                        <select style="font-weight: bold;" class="form-control form-control-sm" data-mdb-select-init class="form-select form-select-sm" id="idTipoComprobante" name="idTipoComprobante" aria-label="Default select example" style="font-size: 105%;" required>
                            <option value="" disabled selected style="display: none;"></option>
                            <c:forEach var="tcomprobante" items="${tclista}">
                                <option value="${tcomprobante.idTipoComprobante}">${tcomprobante.claveTipoComprobante} - ${tcomprobante.descripcionTipoComprobante}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label" for="idTipoComprobante">TIPO DE COMPROBANTE</label>
                    </div>
                </div>
                <%
                cslista = (List<obj_ClientesSAT>) request.getAttribute("cslista");
                ObjectMapper mapper = new ObjectMapper();
                String csJson = mapper.writeValueAsString(cslista);
                %>
                <div class="col">
                    <input type="text" id="idCliente" name="idCliente" class="form-control form-control-sm" hidden/>
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" list="ListClientesSat" id="cliente" name="cliente" onChange="get_idCliente(this.value)" class="form-control form-control-sm" required />
                        <datalist id="ListClientesSat">
                            <c:forEach var="cliente" items="${cslista}">
                                <c:choose>
                                    <c:when test="${cliente.rfc eq 'XAXX010101000' && cliente.nombreCliente ne 'PUBLICO EN GENERAL'}">
                                        <!-- No mostrar esta opción -->
                                    </c:when>
                                    <c:otherwise>
                                        <option data-value="${cliente.idCliente}" value="${cliente.rfc} - ${cliente.nombreCliente}"></option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </datalist>
                        <label class="form-label" for="cliente">RFC - NOMBRE</label>
                    </div>
                </div>
                <script>
                    function get_idCliente(cliente) {
                        var lista = document.getElementById('ListClientesSat').getElementsByTagName('option');
                        var found = false;
                        // Iterar sobre los elementos de la lista
                        for (var i = 0; i < lista.length; i++) {
                            if (cliente === lista[i].value) {
                                found = true;
                                // Obtener el valor del atributo 'data-value'
                                var dataValue = lista[i].getAttribute("data-value");
                                document.getElementById('idCliente').value = dataValue;
                                get_datosCliente(dataValue);
                                break;
                            }
                        }

                        // Si no se encontró el RFC en la lista, limpiar el input
                        if (!found) {
                            document.getElementById('cliente').value = '';
                            document.getElementById('idCliente').value = '';
                            document.getElementById("tipoPersona").value = "";
                            document.getElementById("calle").value = "";
                            document.getElementById("numeroExterior").value = "";
                            document.getElementById("numeroInterior").value = "";
                            document.getElementById("delegacion").value = "";
                            document.getElementById("estado").value = "";
                            document.getElementById("pais").value = "";
                            document.getElementById("codigoPostal").value = "";

                            document.getElementById("tipoPersona").focus();
                            document.getElementById("calle").focus();
                            document.getElementById("numeroExterior").focus();
                            document.getElementById("numeroInterior").focus();
                            document.getElementById("codigoPostal").focus();
                            document.getElementById("delegacion").focus();
                            document.getElementById("estado").focus();
                            document.getElementById("pais").focus();

                            document.getElementById("tipoPersona").blur();
                            document.getElementById("calle").blur();
                            document.getElementById("numeroExterior").blur();
                            document.getElementById("numeroInterior").blur();
                            document.getElementById("codigoPostal").blur();
                            document.getElementById("delegacion").blur();
                            document.getElementById("estado").blur();
                            document.getElementById("pais").blur();

                            customeError("ERROR", 'CLIENTE NO VÁLIDO');
                        }
                    }
                    var csData = <%= csJson %>;
                    function get_datosCliente(dataValue) {
                        var cliente = csData.find(cliente => cliente.idCliente == dataValue);
                        if (cliente) {
                            document.getElementById("tipoPersona").value = cliente.tipo;
                            document.getElementById("calle").value = cliente.calle;
                            document.getElementById("numeroExterior").value = cliente.numeroExterior;
                            document.getElementById("numeroInterior").value = cliente.numeroInterior;
                            document.getElementById("delegacion").value = cliente.delegacion;
                            document.getElementById("estado").value = cliente.estado;
                            document.getElementById("pais").value = cliente.pais;
                            document.getElementById("codigoPostal").value = cliente.codigo;

                            document.getElementById("tipoPersona").focus();
                            document.getElementById("calle").focus();
                            document.getElementById("numeroExterior").focus();
                            document.getElementById("numeroInterior").focus();
                            document.getElementById("codigoPostal").focus();
                            document.getElementById("delegacion").focus();
                            document.getElementById("estado").focus();
                            document.getElementById("pais").focus();

                        } else {
                            document.getElementById('cliente').value = '';
                            document.getElementById('idCliente').value = '';
                            document.getElementById("tipoPersona").value = "";
                            document.getElementById("calle").value = "";
                            document.getElementById("numeroExterior").value = "";
                            document.getElementById("numeroInterior").value = "";
                            document.getElementById("delegacion").value = "";
                            document.getElementById("estado").value = "";
                            document.getElementById("pais").value = "";
                            document.getElementById("codigoPostal").value = "";

                            document.getElementById("cliente").focus();
                            document.getElementById("idCliente").focus();
                            document.getElementById("tipoPersona").focus();
                            document.getElementById("calle").focus();
                            document.getElementById("numeroExterior").focus();
                            document.getElementById("numeroInterior").focus();
                            document.getElementById("codigoPostal").focus();
                            document.getElementById("delegacion").focus();
                            document.getElementById("estado").focus();
                            document.getElementById("pais").focus();

                            document.getElementById("cliente").blur();
                            document.getElementById("idCliente").blur();
                            document.getElementById("tipoPersona").blur();
                            document.getElementById("calle").blur();
                            document.getElementById("numeroExterior").blur();
                            document.getElementById("numeroInterior").blur();
                            document.getElementById("codigoPostal").blur();
                            document.getElementById("delegacion").blur();
                            document.getElementById("estado").blur();
                            document.getElementById("pais").blur();
                            customeError("ERROR", 'INFORMACIÓN NO ENCONTRADA');
                        }
                    }




                </script>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="tipoPersona" name="tipoPersona" class="form-control form-control-sm" readOnly/>
                        <label class="form-label" for="tipoPersona">TIPO DE PERSONA</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="calle" name="calle" class="form-control form-control-sm" readOnly/>
                        <label class="form-label" for="calle">CALLE</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="numeroExterior" name="numeroExterior" class="form-control form-control-sm" readOnly/>
                        <label class="form-label" for="numeroExterior">No. EXTERIOR</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="numeroInterior" name="numeroInterior" class="form-control form-control-sm" readOnly/>
                        <label class="form-label" for="numeroInterior">No. INTERIOR</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="codigoPostal" name="codigoPostal" class="form-control form-control-sm" readOnly/>
                        <label class="form-label" for="codigoPostal">CÓDIGO POSTAL</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="delegacion" name="delegacion" class="form-control form-control-sm" readOnly/>
                        <label class="form-label" for="delegacion">DELEGACIÓN</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="estado" name="estado" class="form-control form-control-sm" readOnly/>
                        <label class="form-label" for="estado">ESTADO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="pais" name="pais" class="form-control form-control-sm" readOnly/>
                        <label class="form-label" for="pais">PAÍS</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="date" class="form-control form-control-sm" name="fechaGeneracion" id="fechaGeneracion" required>
                        <label class="form-label" for="fechaGeneracion">FECHA GENERACIÓN</label>
                    </div>
                </div>
                <script>
                    // Establecer la fecha actual
                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0'); // Enero es 0
                    var yyyy = today.getFullYear();

                    // Formatear la fecha como yyyy-MM-dd para que sea compatible con el input type="date"
                    var formattedDate = yyyy + '-' + mm + '-' + dd;
                    console.log("*****************formated date " + formattedDate);
                    document.getElementById('fechaGeneracion').setAttribute('max', formattedDate);
                </script>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <!-- Message input -->
                    <div data-mdb-input-init class="form-outline mb-4" style="background-color: white;">
                        <textarea style="font-weight: bold;text-transform: uppercase;"  class="form-control form-control-sm" name="observaciones" id="observaciones" rows="3"></textarea>
                        <label class="form-label" for="observaciones">OBSERVACIONES</label>
                    </div>
                </div>
            </div>

            <h5 class="stc" style="text-align: center;">DATOS DEL DEPÓSITO</h5>
            <hr>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" id="form6Example1" class="form-control form-control-sm" disabled/>
                        <label class="form-label" for="form6Example1">No. FOLIO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="date" class="form-control form-control-sm" name="fechaPago" id="fechaPago" required>
                        <label class="form-label" for="fechaPago">FECHA DE PAGO</label>
                    </div>
                </div>
                <script>
                    document.getElementById('fechaPago').setAttribute('max', formattedDate);
                </script>
                <div class="col">
                    <div class="form-outline mdb-input" >
                        <select style="font-weight: bold;" class="form-control form-control-sm" onChange="get_rfcBanco(this.value)" data-mdb-select-init class="form-select form-select-sm" id="idBanco" name="idBanco" aria-label="Default select example" style="font-size: 105%;" required>
                            <option value="" disabled selected style="display: none;"></option>
                            <c:forEach var="banco" items="${bnlista}">
                                <option value="${banco.rfc}">
                                    ${banco.nombre}
                                </option>
                            </c:forEach>
                        </select>
                        <label class="form-label" for="idBanco">BANCO</label>
                    </div>
                </div>

                <script>
                    function get_rfcBanco(idBanco) {
                        if (idBanco) {
                            document.getElementById("rfcBanco").value = idBanco;
                            document.getElementById("rfcBanco").focus();
                        } else {
                            document.getElementById("rfcBanco").value = "";
                            document.getElementById("rfcBanco").blur();
                        }
                    }
                </script>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="rfcBanco" name="rfcBanco" class="form-control form-control-sm" readonly/>
                        <label class="form-label" for="rfcBanco">RFC BANCO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="cuentaCliente" name="cuentaCliente" class="form-control form-control-sm" />
                        <label class="form-label" for="cuentaCliente">N. Cta. CLIENTE</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div class="form-outline mdb-input" >
                        <select style="font-weight: bold;" class="form-control form-control-sm" data-mdb-select-init class="form-select form-select-sm" id="notaSTC" name="notaSTC" aria-label="Default select example" style="font-size: 105%;" required>
                            <option value="" disabled selected style="display: none;"></option>
                            <option value="">S</option>
                        </select>
                        <label class="form-label" for="notaSTC">NOTA STC</label>
                    </div>
                </div>
                <div class="col">
                    <input type="text" id="idFormaPago" name="idFormaPago" class="form-control form-control-sm" hidden/>
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" list="ListFormaPago" id="formaPago" name="formaPago" onChange="get_idFormaPago()" class="form-control form-control-sm" required />
                        <datalist id="ListFormaPago">
                            <c:forEach var="fpago" items="${fplista}">
                                <option data-value="${fpago.idFormaPago}" value="${fpago.claveFormaPago} - ${fpago.descripcionFormaPago}"></option>
                            </c:forEach>
                        </datalist>
                        <label class="form-label" for="formaPago">FORMA DE PAGO</label>
                    </div>
                </div>
                <script>
                    function get_idFormaPago() {
                        var input = document.getElementById('formaPago').value;
                        var lista = document.getElementById('ListFormaPago').getElementsByTagName('option');
                        var found = false;
                        // Iterar sobre los elementos de la lista
                        for (var i = 0; i < lista.length; i++) {
                            if (input === lista[i].value) {
                                found = true;
                                // Obtener el valor del atributo 'data-value'
                                var dataValue = lista[i].getAttribute("data-value");
                                document.getElementById('idFormaPago').value = dataValue;
                                break;
                            }
                        }
                        // Si no se encontró el RFC en la lista, limpiar el input
                        if (!found) {
                            document.getElementById('formaPago').value = '';
                            document.getElementById('idFormaPago').value = '';
                            document.getElementById("formaPago").focus();
                            document.getElementById("idFormaPago").focus();
                            document.getElementById("formaPago").blur();
                            document.getElementById("idFormaPago").blur();
                            customeError("ERROR", 'FORMA DE PAGO NO VÁLIDA');
                        }
                    }
                </script>
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" aria-label="Default select example" id="moneda" name="moneda" style="font-size: 105%;" required>
                            <option value="" disabled selected style="display: none;"></option>
                            <c:forEach var="moneda" items="${monlista}">
                                <option value="${moneda.idMoneda}">${moneda.claveMoneda} - ${moneda.descripcionMoneda}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label" for="moneda">MONEDA</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" id="tipoCambio" name="tipoCambio" value="1.0000" pattern="[A-Za-z0-9]+" class="form-control form-control-sm" disabled/>
                        <label class="form-label" for="tipoCambio">TIPO DE CAMBIO</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="numeroOperacion" name="numeroOperacion" class="form-control form-control-sm" />
                        <label class="form-label" for="numeroOperacion">No. OPERACIÓN</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" id="totalPago" name="totalPago" type="number" min="0" step="0.01"   value="0" class="form-control form-control-sm"/>
                        <label class="form-label" for="totalPago">TOTAL PAGO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" id="subtotalPago"name="subtotalPago" type="number" min="0" step="0.01"   value="0"  class="form-control form-control-sm"/>
                        <label class="form-label" for="subtotalPago">SUBTOTAL</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" id="ivaTraslado" name="ivaTraslado" type="number" min="0" step="0.01"   value="0" class="form-control form-control-sm"/>
                        <label class="form-label" for="ivaTraslado">I.V.A. TRASLADO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" id="ivaRetenido" name="ivaRetenido" type="number" min="0" step="0.01"   value="0" class="form-control form-control-sm"/>
                        <label class="form-label" for="ivaRetenido">I.V.A. RETENIDO</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <input type="text" id="idUsoCFDI" name="idUsoCFDI" class="form-control form-control-sm" hidden/>
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" list="ListUsoCFDI" id="usoCFDI" name="usoCFDI" onChange="get_idUsoCfdi()" class="form-control form-control-sm" required />
                        <datalist id="ListUsoCFDI">
                            <c:forEach var="usoCFDI" items="${cfdilista}">
                                <option data-value="${usoCFDI.idUsoCFDI}" value="${usoCFDI.claveUsoCFDI} - ${usoCFDI.descripcionUsoCFDI}"></option>
                            </c:forEach>
                        </datalist>
                        <label class="form-label" for="usoCFDI">USO DE LA FACTURA</label>
                    </div>
                </div>
                <script>
                    function get_idUsoCfdi() {
                        var input = document.getElementById('usoCFDI').value;
                        var lista = document.getElementById('ListUsoCFDI').getElementsByTagName('option');
                        var found = false;
                        // Iterar sobre los elementos de la lista
                        for (var i = 0; i < lista.length; i++) {
                            if (input === lista[i].value) {
                                found = true;
                                // Obtener el valor del atributo 'data-value'
                                var dataValue = lista[i].getAttribute("data-value");
                                document.getElementById('idUsoCFDI').value = dataValue;
                                break;
                            }
                        }
                        // Si no se encontró el RFC en la lista, limpiar el input
                        if (!found) {
                            document.getElementById('usoCFDI').value = '';
                            document.getElementById('idUsoCFDI').value = '';
                            document.getElementById("usoCFDI").focus();
                            document.getElementById("idUsoCFDI").focus();
                            document.getElementById("usoCFDI").blur();
                            document.getElementById("idUsoCFDI").blur();
                            customeError("ERROR", 'USO DE CFDI NO VÁLIDO');
                        }
                    }
                </script>
            </div>
        </div>

        <div class="tab-pane fade" id="ex3-tabs-2" role="tabpanel" aria-labelledby="ex3-tab-2">
            <div class="row">
                <h5 class="stc" style="text-align: center;">FACTURAS RELACIONADAS</h5>
                <hr>
                <!-- Contenido -->
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="folioFactura" name="folioFactura" class="form-control form-control-sm"/>
                            <label class="form-label" for="folioFactura">No. FACTURA</label>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-outline mdb-input" style="background-color: white;">
                            <select style="font-weight: bold;" class="form-control form-control-sm" data-mdb-select-init class="form-select form-select-sm" name="serie" id="serie" aria-label="Default select example" style="font-size: 105%;" required>
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
                            <input style="font-weight: bold;" type="date" name="fechaFactura" id="fechaFactura" class="form-control form-control-sm">
                            <label class="form-label" for="fechaFactura">FECHA DE FACTURA</label>
                        </div>
                    </div>
                    <script>
                        document.getElementById('fechaFactura').setAttribute('max', formattedDate);
                    </script>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="folioFiscal" name="folioFiscal" class="form-control form-control-sm"/>
                            <label class="form-label" for="folioFiscal">FOLIO FISCAL (UUID)</label>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-outline mdb-input" style="background-color: white;">
                            <select style="font-weight: bold;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" aria-label="Default select example" id="moneda" name="moneda" style="font-size: 105%;" required>
                                <option value="" disabled selected style="display: none;"></option>
                                <c:forEach var="moneda" items="${monlista}">
                                    <option value="${moneda.idMoneda}">${moneda.claveMoneda} - ${moneda.descripcionMoneda}</option>
                                </c:forEach>
                            </select>
                            <label class="form-label" for="moneda">MONEDA</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" id="tipoCambio" name="tipoCambio" value="1.0000" pattern="[A-Za-z0-9]+" class="form-control form-control-sm" disabled/>
                            <label class="form-label" for="tipoCambio">TIPO DE CAMBIO</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div class="form-outline mdb-input" style="background-color: white;">
                            <select style="font-weight: bold;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" id="metodoPago" name="metodoPago" aria-label="Default select example" style="font-size: 105%;" required>
                                <option value="" disabled selected style="display: none;"></option>
                                <c:forEach var="mpago" items="${mplista}">
                                    <option value="${mpago.idMetodoPago}">${mpago.claveMetodoPago} - ${mpago.descripcionMetodoPago}</option>
                                </c:forEach>
                            </select>
                            <label class="form-label" for="metodoPago">MÉTODO DE PAGO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="noParcial" name="noParcial" class="form-control form-control-sm"/>
                            <label class="form-label" for="noParcial">No. PARCIAL</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" id="saldoAnterior" name="saldoAnterior" type="number" min="0" step="0.01"  class="form-control form-control-sm" readonly/>
                            <label class="form-label" for="saldoAnterior">SALDO ANTERIOR</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" id="importePagado" name="importePagado" type="number" min="0" step="0.01"  class="form-control form-control-sm"/>
                            <label class="form-label" for="importePagado">IMPORTE PAGADO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" id="saldoInsoluto" name="saldoInsoluto" type="number" min="0" step="0.01"  class="form-control form-control-sm"/>
                            <label class="form-label" for="saldoInsoluto">SALDO INSOLUTO</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row d-flex justify-content-center p-3">
                <div class="table-responsive">
                    <table id="titulo" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-secondary">
                            <tr>
                                <th>RENGLÓN</th>
                                <th>No. FACTURA</th>
                                <th>SERIE</th>
                                <th>FECHA FACTURA (UUID)</th>
                                <th>MONEDA</th>
                                <th>TIPO CAMBIO</th>
                                <th>MÉTODO PAGO</th>
                                <th>No. PAGO</th>
                            </tr>
                        </thead>
                        <tbody id="datos" style="font-size: 85%;">
                        </tbody>
                    </table>
                </div>
            </div>                
            <hr>
            <h5 class="stc" style="text-align: center;">IMPUESTOS RELACIONADOS</h5>
            <br>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="noFolio" name="noFolio" class="form-control form-control-sm"/>
                        <label class="form-label" for="noFolio">No. FOLIO</label>
                    </div>
                </div>
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" name="serie" id="serie" aria-label="Default select example" style="font-size: 105%;" required>
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
                        <input style="font-weight: bold;" type="date" name="fechaFactura" id="fechaFactura" class="form-control form-control-sm">
                        <label class="form-label" for="fechaFactura">FECHA DE FACTURA</label>
                    </div>
                </div>
                <script>
                    document.getElementById('fechaFactura').setAttribute('max', formattedDate);
                </script>
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;" data-mdb-select-init class="form-control form-control-sm"  class="form-select form-select-sm" aria-label="Default select example" name="tipoImpuesto" id="tipoImpuesto" style="font-size: 105%;" required>
                            <option value="" disabled selected style="display: none;"></option>
                            <c:forEach var="impuesto" items="${implista}">
                                <option value="${impuesto.idImpuesto}" data-clave="${impuesto.claveImpuesto}" data-descripcion="${impuesto.descripcionImpuesto}">
                                    ${impuesto.claveImpuesto} - ${impuesto.descripcionImpuesto}
                                </option>
                            </c:forEach>
                        </select>
                        <label class="form-label" for="tipoImpuesto">TIPO DE IMPUESTO</label>
                    </div>
                </div>
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;" data-mdb-select-init class="form-control form-control-sm"  class="form-select form-select-sm" aria-label="Default select example" name="tipoFactor" id="tipoFactor" style="font-size: 105%;" required>
                            <option value="" disabled selected style="display: none;"></option>
                            <c:forEach var="tfact" items="${tflista}">
                                <option value="${tfact.idTipoFactor}" data-clave="${tfact.claveTipoFactor}">
                                    ${tfact.claveTipoFactor}
                                </option>
                            </c:forEach>
                        </select>
                        <label class="form-label" for="tipoFactor">TIPO DE FACTOR</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" min="1" step="0.01" id="tasa"  name="tasa"  class="form-control form-control-sm"/>
                        <label class="form-label" for="tasa">TASA O CUOTA</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" min="1" step="0.01" id="baseCalculo"  name="baseCalculo"  class="form-control form-control-sm"/>
                        <label class="form-label" for="baseCalculo">BASE CÁLCULO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" min="1" step="0.01" id="ivaTrasladado"  name="ivaTrasladado"  class="form-control form-control-sm"/>
                        <label class="form-label" for="ivaTrasladado">I.V.A. TRASLADADO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" min="1" step="0.01" id="ivaRetenido"  name="ivaRetenido"  class="form-control form-control-sm"/>
                        <label class="form-label" for="ivaRetenido">I.V.A. RETENIDO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" min="1" step="0.01" id="pago"  name="pago"  class="form-control form-control-sm"/>
                        <label class="form-label" for="pago">PAGO</label>
                    </div>
                </div>
            </div>
            <div class="row d-flex justify-content-center p-3">
                <div class="contenedortabla table-responsive">
                    <table id="titulo" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-secondary">
                            <tr>
                                <th>RENGLÓN</th>
                                <th>No. FOLIO</th>
                                <th>SERIE</th>
                                <th>FECHA FACTURA</th>
                                <th>TIPO IMPUESTO</th>
                                <th>TIPO FACTOR</th>
                                <th>TASA O CUOTA</th>
                                <th>BASE CÁLCULO</th>
                                <th>I.V.A. TRASLADADO</th>
                                <th>I.V.A. RETENIDO</th>
                                <th>PAGO</th>
                            </tr>
                        </thead>
                        <tbody id="datos" style="font-size: 85%;">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" min="1" step="0.01" id="totalSaldoAnterior"  name="totalSaldoAnterior"  class="form-control form-control-sm"/>
                        <label class="form-label" for="totalSaldoAnterior">TOTAL SALDO ANTERIOR</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" min="1" step="0.01" id="totalIvaTrasladado"  name="totalIvaTrasladado"  class="form-control form-control-sm"/>
                        <label class="form-label" for="totalIvaTrasladado">TOTAL I.V.A. TRASLADADO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" min="1" step="0.01" id="totalIvaRetenido"  name="totalIvaRetenido"  class="form-control form-control-sm"/>
                        <label class="form-label" for="totalIvaRetenido">TOTAL I.V.A. RETENIDO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="number" min="1" step="0.01" id="totalPago"  name="totalPago"  class="form-control form-control-sm"/>
                        <label class="form-label" for="totalPago">TOTAL PAGO</label>
                    </div>
                </div>
            </div>
            <div class="stc" style="justify-content: center; display: flex;">
                <button type="submit" id="buscar" name="action" value="104" style="color:white; background-color: #F1621F;font-size: 14px;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="MODIFICAR">
                    <i class="fa-brands fa-searchengin"></i>
                    <span class="btn-text">BUSCAR</span>
                </button>
                <button type="submit" id="Guardar" name="action" value="101" style="color:white;background-color: #008A13;" class="btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="GUARDAR">
                    <i class="fas fa-floppy-disk"></i>
                    <span class="btn-text">GUARDAR</span>
                </button>
                <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="LIMPIAR"><!--Boton tipo reset-->
                    <i class="fas fa-eraser"></i>
                    <span class="btn-text">LIMPIAR</span>
                </button>
            </div>
        </div>

        <div class="tab-pane fade" id="ex3-tabs-3" role="tabpanel" aria-labelledby="ex3-tab-3">
            <h5 class="stc" style="text-align: center;">IMPRESIÓN DE PAGOS</h5>
            <hr>
            <br>
            <div class="row mb-4">
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" name="seriePago" id="seriePago" aria-label="Default select example" style="font-size: 105%;" required>
                            <option value="" disabled selected style="display: none;"></option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="NC">NC</option>
                        </select>
                        <label class="form-label" for="seriePago">SERIE DE PAGO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="noFolioInicial" name="noFolioInicial" class="form-control form-control-sm"/>
                        <label class="form-label" for="noFolioInicial">No. FOLIO INICIAL</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="noFolioFinal" name="noFolioFinal" class="form-control form-control-sm"/>
                        <label class="form-label" for="noFolioFinal">No. FOLIO FINAL</label>
                    </div>
                </div>
            </div>
            <div>
                <div style="justify-content: center; display: flex;">
                    <button type="button" id="imprimir-btn" title="EXPORTAR A EXCEL" class="btn btn-outline-success btn-sm btn-rounded stc" data-mdb-ripple-init  data-mdb-ripple-color="dark">
                        <i class="fas fa-file-excel"></i>
                        <span class="d-none d-sm-inline">EXPORTAR A EXCEL</span>
                    </button>
                </div>
            </div>
            <div class="row d-flex justify-content-center p-3">
                <div class="contenedortabla table-responsive">
                    <table id="titulo" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-secondary">
                            <tr>
                                <th>RENGLÓN</th>
                                <th>SERIE</th>
                                <th>No. FACTURA</th>
                                <th>FECHA FACTURA</th>
                                <th>IMPORTE FACTURA</th>
                                <th>USUARIO AUTORIZÓ</th>
                                <th>FECHA ACTUALIZACIÓN</th>
                                <th>ESTADO DE LA FACTURA</th>
                            </tr>
                        </thead>
                        <tbody id="datos" style="font-size: 85%;">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <style>
            /* Cambiar el color de la bolita cuando el switch está desactivado */
            .form-check-input:not(:checked)::after {
                background-color: #6c757d; /* Bolita gris cuando no está activado */
            }
        </style>
        <div class="tab-pane fade" id="ex3-tabs-4" role="tabpanel" aria-labelledby="ex3-tab-4">
            <h5 class="stc" style="text-align: center;">REPORTE DE PAGOS</h5>
            <hr>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-check form-switch">
                        <input class="form-check-input btn-azul" type="checkbox" role="switch" name="rangoFechas" id="rangoFechas">
                        <label class="form-check-label fs-6" for="rangoFechas" style="font-weight: bold;color:black;">[ <span  id="spanNoRangoFechas" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiRangoFechas" hidden="true">SI</span> ] RANGO DE FECHAS</label>
                    </div>
                    <br>
                    <div class="card">
                        <div class="card-body">
                            <div class="col">
                                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                    <input style="font-weight: bold;" type="date" name="fechaInicio" id="fechaInicio" class="form-control form-control-sm" />
                                    <label class="form-label" for="fechaInicio">FECHA INICIO</label>
                                </div>
                            </div>
                            <script>
                                document.getElementById('fechaInicio').setAttribute('max', formattedDate);
                            </script>
                            <br>
                            <div class="col">
                                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                    <input style="font-weight: bold;" type="date" name="fechaFin" id="fechaFin" class="form-control form-control-sm" onchange="validateDates()" />
                                    <label class="form-label" for="fechaFin">FECHA TERMINO</label>
                                </div>
                            </div>
                            <script>
                                document.getElementById('fechaFin').setAttribute('max', formattedDate);
                            </script>
                            <br>
                            <div class="col">
                                <div class="form-outline mdb-input" style="background-color: white;">
                                    <select style="font-weight: bold;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" name="seriePago" id="seriePago" aria-label="Default select example" style="font-size: 105%;" required>
                                        <option value="" disabled selected style="display: none;"></option>
                                        <option value="A">A</option>
                                        <option value="B">B</option>
                                        <option value="NC">NC</option>
                                    </select>
                                    <label class="form-label" for="seriePago">SERIE DE PAGO</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-check form-switch">
                        <input class="form-check-input btn-azul" type="checkbox" role="switch" name="rangoClientes" id="rangoClientes">
                        <label class="form-check-label fs-6" for="rangoClientes" style="font-weight: bold;color:black;">[ <span  id="spanNoUno" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiUno" hidden="true">SI</span> ] RANGO DE CLIENTES</label>
                    </div>
                    <br>
                    <div class="card">
                        <div class="card-body">
                            <div class="col">
                                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                    <input style="font-weight: bold;" type="text" id="rangoInicia" name="rangoInicia"  list="ListMemorandumImpresion" class="form-control form-control-sm" onblur="this.value = this.value.trim()" />
                                    <label class="form-label" for="rangoInicia">EMPIEZA DE</label>
                                </div>
                            </div>
                            <br>
                            <div class="col">
                                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                    <input style="font-weight: bold;" type="text" id="rangoTermina" name="rangoTermina"  list="ListMemorandumImpresion"  class="form-control form-control-sm" onblur="this.value = this.value.trim()" />
                                    <label class="form-label" for="rangoTermina">LLEGA HASTA</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row">

                <div class="col-sm-4">
                    <div class="form-check form-switch">
                        <input class="form-check-input btn-azul" type="checkbox" role="switch" name="nombreBanco" id="nombreBanco">
                        <label class="form-check-label fs-6" for="nombreBanco" style="font-weight: bold;color:black;">[ <span  id="spanNoRangoFechas" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiRangoFechas" hidden="true">SI</span> ] NOMBRE DE BANCO</label>
                    </div>
                    <br>
                    <div class="card">
                        <div class="card-body">
                            <div class="col">
                                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                    <input style="font-weight: bold;" type="text" id="nombreBancoInput" name="nombreBancoInput"  list="ListMemorandumImpresion" class="form-control form-control-sm" onblur="this.value = this.value.trim()" />
                                    <label class="form-label" for="nombreBancoInput">NOMBRE DE BANCO</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="col-sm-4">
                    <div class="form-check form-switch">
                        <input class="form-check-input btn-azul" type="checkbox" role="switch" name="estatus" id="estatus">
                        <label class="form-check-label fs-6" for="estatus" style="font-weight: bold;color:black;">[ <span  id="spanNoUno" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiUno" hidden="true">SI</span> ] ESTATUS</label>
                    </div>
                    <br>
                    <div class="card">
                        <div class="card-body">
                            <div class="col">
                                <div class="form-outline mdb-input" style="background-color: white;">
                                    <select style="font-weight: bold;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" name="seriePago" id="seriePago" aria-label="Default select example" style="font-size: 105%;" required>
                                        <option value="" disabled selected style="display: none;"></option>
                                        <option value="X">CAPTURADA</option>
                                        <option value="A">AUTORIZADA</option>
                                        <option value="G">GENERADA</option>
                                        <option value="I">IMPRESA</option>
                                        <option value="C">CANCELADA</option>
                                    </select>
                                    <label class="form-label" for="seriePago">ESTATUS</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="form-check form-switch">
                        <input class="form-check-input btn-azul" type="checkbox" role="switch" name="formaPagoSwtich" id="formaPagoSwtich">
                        <label class="form-check-label fs-6" for="formaPagoSwtich" style="font-weight: bold;color:black;">[ <span  id="spanNoUno" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiUno" hidden="true">SI</span> ] FORMA DE PAGO</label>
                    </div>
                    <br>
                    <div class="card">
                        <div class="card-body">
                            <div class="col">
                                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                    <input style="font-weight: bold;" type="text" id="formaPagoInput" name="formaPagoInput"  list="ListMemorandumImpresion" class="form-control form-control-sm" onblur="this.value = this.value.trim()" />
                                    <label class="form-label" for="formaPagoInput">FORMA DE PAGO</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabs content -->
    <br>
</main>
<%@include file="../Pie.jsp"%>