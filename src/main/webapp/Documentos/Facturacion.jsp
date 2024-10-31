<%-- 
    Document   : JSP_Facturas
    Created on : 10/04/2023, 11:22:45 AM
    Author     : Ing. Evelyn Leilani Avendaño
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@include file="../Encabezado.jsp"%>

<%@include file="../Mensaje.jsp"%>

<%-- CLIENTE--%>
<%@page import="Objetos.obj_ClientesSAT"%>
<%! List<obj_ClientesSAT> cslista;%>

<%-- PERMISO--%>
<%@page import="Objetos.obj_Permiso"%>
<%! obj_Permiso permiso;%>
<%! List<obj_Permiso> listaPermiso;%>

<%-- FACTURAS--%>
<%@page import="Objetos.obj_Factura"%>
<%! obj_Factura factura;%>
<%! List<obj_Factura> listaFacturas;%>

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
    .error{
        font-size: 11.5px;
        font-weight: bold;
    }
</style>

<script src="JS\facturcionElectronica_catalogo.js"></script>
<script src="JS\facturacionElectronica_envioDatos.js"></script>
<!-- Cuerpo -->
<head>

</head>
<main class="col ps-md-2 pt-2 mx-3">
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <div class="page-header pt-3 stc">
        <h3>FACTURACIÓN ELECTRÓNICA</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>

    <!-- Tabs navs -->
    <ul class="nav nav-tabs nav-justified mb-3 stc" id="ex1" role="tablist">
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link active" id="ex3-tab-1" href="#ex3-tabs-1" role="tab" aria-controls="ex3-tabs-1" aria-selected="true">
                CAPTURA DE FACTURAS
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-2" href="#ex3-tabs-2" role="tab" aria-controls="ex3-tabs-2" aria-selected="false">
                DETALLE DE FACTURA
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-3" href="#ex3-tabs-3" role="tab" aria-controls="ex3-tabs-3" aria-selected="false">
                IMPRESIÓN DE FACTURAS
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-4" href="#ex3-tabs-4" role="tab" aria-controls="ex3-tabs-4" aria-selected="false">
                REPORTES DE FACTURAS
            </a>
        </li>
    </ul>
    <!-- Tabs content -->
    <div class="tab-content" id="ex2-content">
        <div class="tab-pane fade show active" id="ex3-tabs-1" role="tabpanel" aria-labelledby="ex3-tab-1">

            <div class="row">
                <div class="col stc" style="justify-content: right; display: flex;">
                    <button type="button" id="Buscar" name="action" value="104" style="display: block; color:white; background-color: #F1621F;font-size: 15px;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-mdb-modal-init data-mdb-target="#modalFactuacion" title="BUSCAR">
                        <i class="fa-brands fa-searchengin"></i>
                        <span class="btn-text">BUSCAR</span>
                    </button>
                </div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="modalFactuacion" data-mdb-backdrop="static" data-mdb-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true" style="font-size: 80%;">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <form action="" method="" id="">
                            <div class="modal-header">
                                <h5 class="modal-title stc" id="staticBackdropLabel">BUSCAR FACTURA</h5>
                                <button type="button" class="btn-close" data-mdb-ripple-init data-mdb-dismiss="modal" aria-label="Close" id="closeModalButton"></button>
                            </div>
                            <!-- Dentro de tu modal -->
                            <div class="modal-body mt-0">
                                <div data-mdb-input-init class="form-outline fw-bold" style="background-color: white;">
                                    <input type="text" id="folio" onChange="validateFactura()" name="folio" list="ListFacturaBuscar" class="form-control fw-bold" required/>
                                    <label class="form-label" for="cnt">NÚMERO DE FOLIO</label>
                                </div>
                            </div>
                            <datalist id="ListFacturaBuscar">
                                <c:forEach var="factura" items="${listaFacturas}">
                                    <c:if test="${factura.estatus == 'X'}">
                                        <option data-value="${factura.idFactura}" value="${factura.folio}"></option>
                                    </c:if>
                                </c:forEach>
                            </datalist>
                            <div class="modal-footer stc">
                                <button type="button" id="buscar"  style="display: block; color:white; background-color: #F1621F;font-size: 14px;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="MODIFICAR" onclick="searchFactura()">
                                    <i class="fa-brands fa-searchengin"></i>
                                    <span class="btn-text">BUSCAR</span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Modal -->
            <h5 class="stc" style="text-align: center;">DATOS DE RECEPTOR</h5>
            <hr>
            <div class="row mb-4">
                <input hidden="true" type="text" value="" class="form-control form-control-sm" id="folioEncontrado" name="folioEncontrado" />
                <div class="col">
                    <div class="form-outline mdb-input" >
                        <select style="font-weight: bold;" class="form-control form-control-sm" data-mdb-select-init class="form-select form-select-sm" id="idTipoComprobante" name="idTipoComprobante" onChange="get_tipoSerie()" aria-label="Default select example" style="font-size: 105%;" required>
                            <option value="" disabled selected style="display: none;"></option>
                            <c:forEach var="tcomprobante" items="${tclista}">
                                <option value="${tcomprobante.idTipoComprobante}">${tcomprobante.claveTipoComprobante} - ${tcomprobante.descripcionTipoComprobante}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label" for="idTipoComprobante">TIPO DE COMPROBANTE</label>
                    </div>
                </div>
                <div class="col">
                    <input type="text" id="idCliente" name="idCliente" class="form-control form-control-sm" hidden/>
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" list="ListClientesSat" id="cliente" name="cliente" onChange="get_idCliente()" class="form-control form-control-sm" required />
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
                <%
            cslista = (List<obj_ClientesSAT>) request.getAttribute("cslista");
            ObjectMapper mapper = new ObjectMapper();
            String csJson = mapper.writeValueAsString(cslista);
                %>
                <script>
                    function get_idCliente() {
                        var input = document.getElementById('cliente').value.toUpperCase();
                        var lista = document.getElementById('ListClientesSat').getElementsByTagName('option');
                        var found = false;
                        // Iterar sobre los elementos de la lista
                        for (var i = 0; i < lista.length; i++) {
                            if (input === lista[i].value) {
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
                            document.getElementById("calle").value = "";
                            document.getElementById("numeroExterior").value = "";
                            document.getElementById("numeroInterior").value = "";
                            document.getElementById("delegacion").value = "";
                            document.getElementById("estado").value = "";
                            document.getElementById("pais").value = "";
                            document.getElementById("codigoPostal").value = "";
                            document.getElementById("email").value = "";
                            document.getElementById("tipoPersona").value = "";
                            document.getElementById("regimenFiscal").value = "";
                            document.getElementById("condicionPago").value = "";

                            document.getElementById("calle").focus();
                            document.getElementById("numeroExterior").focus();
                            document.getElementById("numeroInterior").focus();
                            document.getElementById("delegacion").focus();
                            document.getElementById("estado").focus();
                            document.getElementById("pais").focus();
                            document.getElementById("codigoPostal").focus();
                            document.getElementById("email").focus();
                            document.getElementById("tipoPersona").focus();
                            document.getElementById("regimenFiscal").focus();
                            document.getElementById("condicionPago").focus();

                            document.getElementById("idCliente").blur();
                            document.getElementById("cliente").blur();
                            document.getElementById("calle").blur();
                            document.getElementById("numeroExterior").blur();
                            document.getElementById("numeroInterior").blur();
                            document.getElementById("delegacion").blur();
                            document.getElementById("estado").blur();
                            document.getElementById("pais").blur();
                            document.getElementById("codigoPostal").blur();
                            document.getElementById("email").blur();
                            document.getElementById("tipoPersona").blur();
                            document.getElementById("regimenFiscal").blur();
                            document.getElementById("condicionPago").blur();

                            document.getElementById("periodicidad").required = false;
                            document.getElementById("periodicidad").disabled = true;
                            document.getElementById("periodicidad").focus();
                            document.getElementById("periodicidad").blur();
                            addImportantStyle('periodicidad');

                            document.getElementById("cuentaBancaria").value = '';
                            document.getElementById("cuentaBancaria").readOnly = false;
                            document.getElementById("cuentaBancaria").focus();
                            document.getElementById("cuentaBancaria").blur();
                            get_ListaPermisos(0);
                            get_DetalleConcepto(0);
                            customeError("ERROR", 'CLIENTE NO VÁLIDO');
                        }
                    }
                    var csData = <%= csJson %>;
                    function get_datosCliente(dataValue) {
                        var cliente = csData.find(cliente => cliente.idCliente == dataValue);
                        var cuentaBancariaInput = document.getElementById('cuentaBancaria');
                        if (cliente) {
                            if (cliente.rfc == 'XAXX010101000') {
                                document.getElementById("periodicidad").disabled = false;
                                document.getElementById("periodicidad").required = true;
                                removeImportantStyle('periodicidad');
                                cuentaBancariaInput.value = '0';
                                cuentaBancariaInput.focus();
                                cuentaBancariaInput.readOnly = true;
                            } else {
                                document.getElementById("periodicidad").disabled = true;
                                document.getElementById("periodicidad").required = false;
                                addImportantStyle('periodicidad');
                                cuentaBancariaInput.readOnly = false;
                                cuentaBancariaInput.disabled = false;
                                cuentaBancariaInput.value = 0;
                                cuentaBancariaInput.focus();

                            }
                            document.getElementById("calle").value = cliente.calle;
                            document.getElementById("numeroExterior").value = cliente.numeroExterior;
                            document.getElementById("numeroInterior").value = cliente.numeroInterior;
                            document.getElementById("delegacion").value = cliente.delegacion;
                            document.getElementById("estado").value = cliente.estado;
                            document.getElementById("pais").value = cliente.pais;
                            document.getElementById("codigoPostal").value = cliente.codigo;
                            document.getElementById("email").value = cliente.email;
                            document.getElementById("tipoPersona").value = cliente.tipo;
                            document.getElementById("regimenFiscal").value = cliente.regimenFiscal;
                            document.getElementById("condicionPago").value = cliente.referencia;

                            document.getElementById("calle").focus();
                            document.getElementById("numeroExterior").focus();
                            document.getElementById("numeroInterior").focus();
                            document.getElementById("delegacion").focus();
                            document.getElementById("estado").focus();
                            document.getElementById("pais").focus();
                            document.getElementById("codigoPostal").focus();
                            document.getElementById("email").focus();
                            document.getElementById("tipoPersona").focus();
                            document.getElementById("regimenFiscal").focus();
                            document.getElementById("condicionPago").focus();
                            get_ListaPermisos(cliente.rfc);
                        } else {

                            document.getElementById("calle").value = "";
                            document.getElementById("numeroExterior").value = "";
                            document.getElementById("numeroInterior").value = "";
                            document.getElementById("delegacion").value = "";
                            document.getElementById("estado").value = "";
                            document.getElementById("pais").value = "";
                            document.getElementById("codigoPostal").value = "";
                            document.getElementById("email").value = "";
                            document.getElementById("tipoPersona").value = "";
                            document.getElementById("regimenFiscal").value = "";

                            document.getElementById("calle").blur();
                            document.getElementById("numeroExterior").blur();
                            document.getElementById("numeroInterior").blur();
                            document.getElementById("delegacion").blur();
                            document.getElementById("estado").blur();
                            document.getElementById("pais").blur();
                            document.getElementById("codigoPostal").blur();
                            document.getElementById("email").blur();
                            document.getElementById("tipoPersona").blur();
                            document.getElementById("regimenFiscal").blur();
                            addImportantStyle('periodicidad');
                            customeError("ERROR", 'INFORMACIÓN NO ENCONTRADA');
                            get_ListaPermisos(0);
                            get_DetalleConcepto(0);
                        }
                    }

                </script>
            </div>


            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="calle" name="calle" class="form-control form-control-sm" readonly/>
                        <label class="form-label" for="calle">CALLE</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="numeroExterior" name="numeroExterior" class="form-control form-control-sm" readonly/>
                        <label class="form-label" for="numeroExterior">No. EXTERIOR</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="numeroInterior" name="numeroInterior" class="form-control form-control-sm" readonly/>
                        <label class="form-label" for="numeroInterior">No. INTERIOR</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="delegacion" name="delegacion" class="form-control form-control-sm" readonly/>
                        <label class="form-label" for="delegacion">DELEGACIÓN</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="estado" name="estado" class="form-control form-control-sm" readonly/>
                        <label class="form-label" for="estado">ESTADO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="pais" name="pais" class="form-control form-control-sm"readonly/>
                        <label class="form-label" for="pais">PAIS</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="codigoPostal" name="codigoPostal" class="form-control form-control-sm" readonly/>
                        <label class="form-label" for="codigoPostal">CÓDIGO POSTAL</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" style="text-transform: lowercase;" id="email" name="email" class="form-control form-control-sm" readonly/>
                        <label class="form-label" for="email">CORREO ELECTRÓNICO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="tipoPersona" name="tipoPersona" class="form-control form-control-sm" readonly/>
                        <label class="form-label" for="tipoPersona">TIPO PERSONA</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" style="font-weight: bold;" id="regimenFiscal" name="regimenFiscal" class="form-control form-control-sm" readonly/>
                        <label class="form-label" for="regimenFiscal">RÉGIMEN FISCAL</label>
                    </div>
                </div>
            </div>    

            <h5 class="stc" style="text-align: center;">DATOS DE FACTURA</h5>
            <hr>
            <div class="row mb-4">
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold; background-color: gainsboro !important;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" aria-label="Default select example" style="font-size: 95%;" name="periodicidad" id="periodicidad" disabled>
                            <option disabled selected style="display: none;"></option>
                            <c:forEach var="periodo" items="${prdlista}">
                                <option value="${periodo.idPeriodo}">${periodo.clavePeriodo} - ${periodo.descripcionPeriodo}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label" for="periodicidad">PERIODICIDAD</label>
                    </div>
                </div>
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" aria-label="Default select example" style="font-size: 95%;" name="mes" id="mes" required>
                            <option value="" disabled selected style="display: none;"></option>
                            <option value="1">ENERO</option>
                            <option value="2">FEBRERO</option>
                            <option value="3">MARZO</option>
                            <option value="4">ABRIL</option>
                            <option value="5">MAYO</option>
                            <option value="6">JUNIO</option>
                            <option value="7">JULIO</option>
                            <option value="8">AGOSTO</option>
                            <option value="9">SEPTIEMBRE</option>
                            <option value="10">OCTUBRE</option>
                            <option value="11">NOVIEMBRE</option>
                            <option value="12">DICIEMBRE</option>
                        </select>
                        <label class="form-label" for="mes">MES</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;text-transform: uppercase;" type="text" id="conceptoFactura" name="conceptoFactura"  class="form-control form-control-sm" />
                        <label class="form-label" for="conceptoFactura">CONCEPTO FACTURA</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="date" class="form-control form-control-sm" name="fechaPago" id="fechaPago" required>
                        <label class="form-label" for="fechaPago">FECHA DE PAGO</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;text-transform: uppercase;" type="text" class="form-control form-control-sm" id="observaciones" name="observaciones" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$"/>
                        <label class="form-label" for="observaciones">OBSERVACIONES</label>
                    </div>
                </div>
            </div>                   
            <div class="row mb-4 ">
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
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="date" name="fechaFactura" id="fechaFactura" class="form-control form-control-sm" readonly>
                        <label class="form-label" for="fechaFactura">FECHA DE FACTURA</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" type="text" id="cpEmisorFactura" name="cpEmisorFactura" value="06070 CIUDAD DE MEXICO" class="form-control form-control-sm" disabled/>
                        <label class="form-label" for="cpEmisorFactura">C.P. EMISOR FACTURA</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;background-color: gainsboro !important;" class="form-control form-control-sm"  onChange="get_tipoServicio()" data-mdb-select-init class="form-select form-select-sm" name="serie" id="serie" aria-label="Default select example" style="font-size: 105%;" disabled required>
                            <option value="" disabled selected style="display: none;"></option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="NC">NC</option>
                        </select>
                        <label class="form-label" for="serie">SERIE</label>
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
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;" onchange="validarCuentaBancaria()" type="number" id="cuentaBancaria" name="cuentaBancaria" maxlength="4"  min="0" max="9999" class="form-control form-control-sm"/>
                        <label class="form-label" for="cuentaBancaria">No. CTA. BANCARIA</label>
                    </div>
                    <span id="error-message" class="error text-danger"></span>
                </div>      
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
                <style>
                    /* Cambiar el color de la bolita cuando el switch está desactivado */
                    .form-check-input:not(:checked)::after {
                        background-color: #6c757d; /* Bolita gris cuando no está activado */
                    }
                </style>
                <!-- checkbox -->
                <div class="col-auto">
                    <div class="form-check form-switch" style="background-color: white;">
                        <input class="form-check-input btn-azul" type="checkbox" role="switch" id="tipoRelacion" name="tipoRelacion">
                        <label style="font-weight: bold;font-size: medium;" class="form-check-label" for="tipoRelacion"> [ <span  id="spanNoTipoRelacion" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiTipoRelacion" hidden="true">SI</span> ] TIPO RELACIÓN</label>
                    </div>
                </div>
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;background-color: gainsboro !important;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" id="idTipoRelacion" name="idTipoRelacion" aria-label="Default select example" style="font-size: 105%;" disabled>
                            <option value="" disabled selected style="display: none;"></option>
                            <c:forEach var="trelacion" items="${trlista}">
                                <option value="${trelacion.idTipoRelacion}">${trelacion.claveTipoRelacion} - ${trelacion.descripcionTipoRelacion}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label" for="idTipoRelacion">TIPO DE RELACIÓN</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;background-color: gainsboro !important;" class="form-control form-control-sm"  data-mdb-select-init class="form-select form-select-sm" name="tipoServicio" id="tipoServicio" aria-label="Default select example" style="font-size: 105%;" disabled>
                            <option value="" disabled selected style="display: none;"></option>
                            <c:forEach var="tserv" items="${tslista}">
                                <option value="${tserv.idTServicio}">${tserv.clave} - ${tserv.descripcion}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label" for="tipoServicio">TIPO DE SERVICIO</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input style="font-weight: bold;text-transform: uppercase;" type="text" class="form-control form-control-sm" id="condicionPago" name="condicionPago" />
                        <label class="form-label" for="condicionPago">CONDICIONES DE PAGO</label>
                    </div>
                </div>
                <div class="col">
                    <input type="text" id="idPermiso" name="idPermiso" class="form-control form-control-sm" hidden/>
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input
                            style="font-weight: bold;"
                            type="text"
                            list="ListPermisos"
                            id="numeroPermiso"
                            name="numeroPermiso"
                            onChange="get_idPermiso()"
                            onkeydown="redirigir(event)"
                            class="form-control form-control-sm"
                            disabled
                            required
                            />
                        <datalist id="ListPermisos">
                            <!-- Options will be dynamically added here -->
                        </datalist>
                        <label class="form-label" for="numeroPermiso">PERMISOS</label>
                    </div>
                </div>

                <%
                    List<obj_Permiso> listaPermiso = (List<obj_Permiso>) request.getAttribute("permisolista");
                    ObjectMapper mapperdos = new ObjectMapper();
                    String permisoJSON = mapperdos.writeValueAsString(listaPermiso);
                %>

                <script>
                    // Asegúrate de que `permisoJSON` esté en formato JSON válido en el script
                    var permisoData = <%= permisoJSON %>;

                    function get_ListaPermisos(rfcCliente) {
                        console.log('Entra a lista permisos');
                        var inputPermiso = document.getElementById('numeroPermiso');
                        var dataList = document.getElementById('ListPermisos');
                        dataList.innerHTML = '';
                        var permisos = permisoData.filter(permiso => permiso.rfc === rfcCliente);
                        if (permisos.length > 0) {
                            inputPermiso.disabled = false;
                            permisos.forEach(permiso => {
                                var option = document.createElement('option');
                                option.value = permiso.numeroPermiso + ' - ' + permiso.consecutivo;
                                option.setAttribute('data-value', permiso.idPermiso);
                                dataList.appendChild(option);
                            });
                        } else {
                            dataList.innerHTML = '';
                            inputPermiso.value = '';
                            inputPermiso.focus();
                            inputPermiso.blur();
                            inputPermiso.disabled = true;
                        }
                    }

                    function get_idPermiso() {
                        console.log('get_idPermiso()');
                        var input = document.getElementById('numeroPermiso').value.toUpperCase();
                        var lista = document.getElementById('ListPermisos').getElementsByTagName('option');
                        var found = false;
                        // Iterar sobre los elementos de la lista
                        for (var i = 0; i < lista.length; i++) {
                            if (input === lista[i].value) {
                                found = true;
                                // Obtener el valor del atributo 'data-value'
                                var dataValue = lista[i].getAttribute("data-value");
                                document.getElementById('idPermiso').value = dataValue;
                                console.log('dataValue: ' + dataValue);
                                get_DetalleConcepto(dataValue);
                                break;
                            }
                        }
                        // Si no se encontró el RFC en la lista, limpiar el input
                        if (!found) {
                            get_DetalleConcepto(0);
                            document.getElementById('numeroPermiso').value = '';
                            document.getElementById('idPermiso').value = '';
                            document.getElementById("numeroPermiso").focus();
                            document.getElementById("idPermiso").focus();
                            document.getElementById("numeroPermiso").blur();
                            document.getElementById("idPermiso").blur();
                            customeError("ERROR", 'PERMISO NO VÁLIDO');
                        }
                    }

                </script>
            </div>
        </div>

        <div class="tab-pane fade" id="ex3-tabs-2" role="tabpanel" aria-labelledby="ex3-tab-2">
            <form>
                <div class="row">
                    <h5 class="stc" style="text-align: center;">DETALLE DE FACTURA</h5>
                    <hr>
                    <!-- Contenido -->
                    <div class="row mb-4">
                        <div class="col">
                            <input type="text" id="idProductoServicio" name="idProductoServicio" class="form-control form-control-sm" hidden/>
                            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                <input style="font-weight: bold;" type="text" list="ListProductoServicio" id="productoServicio" name="productoServicio" onChange="get_idProductoServicio()" class="form-control form-control-sm"  />
                                <datalist id="ListProductoServicio">
                                    <c:forEach var="prodser" items="${pslista}">
                                        <option data-value="${prodser.idProdServ}" value="${prodser.claveProdServ} - ${prodser.descripcionProdServ}"></option>
                                    </c:forEach>
                                </datalist>
                                <label class="form-label" for="productoServicio">PRODUCTOS Y SERVICIOS</label>
                            </div>
                        </div>
                        <div class="col">
                            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                <input style="font-weight: bold;" onchange="validarCantidad()" type="number" min="1" step="0.01"  id="cantidad" name="cantidad"   class="form-control form-control-sm"/>
                                <label class="form-label" for="cantidad">CANTIDAD</label>
                            </div>
                            <span id="error-cantidad" class="error text-danger"></span>
                        </div>
                        <div class="col">
                            <input type="text" id="idUnidadMedida" name="idUnidadMedida" class="form-control form-control-sm" hidden/>
                            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                <input style="font-weight: bold;" type="text" list="ListUnidadMedida" id="unidadMedida" name="unidadMedida" onChange="get_idUnidadMedida()" class="form-control form-control-sm"  />
                                <datalist id="ListUnidadMedida">
                                    <c:forEach var="umedida" items="${umlista}">
                                        <option data-value="${umedida.idUnidadMedida}" value="${umedida.claveUnidadMedida} - ${umedida.descripcionUnidadMedida}"></option>
                                    </c:forEach>
                                </datalist>
                                <label class="form-label" for="unidadMedida">UNIDAD DE MEDIDA</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <!-- Message input -->
                            <div data-mdb-input-init class="form-outline mb-4" style="background-color: white;">
                                <textarea style="font-weight: bold;text-transform: uppercase;"  class="form-control form-control-sm" name="detalleConcepto" id="detalleConcepto" rows="3"></textarea>
                                <label class="form-label" for="detalleConcepto">DESCRIPCIÓN DEL CONCEPTO</label>
                            </div>
                        </div>
                    </div>
                    <script>
                        function get_DetalleConcepto(dataValue) {
                            console.log('get_DetalleConcepto()');
                            var textarea = document.getElementById('detalleConcepto');
                            var permiso = permisoData.find(permiso => permiso.idPermiso == dataValue);
                            console.log('Permiso: ' + permiso);
                            if (permiso) {
                                textarea.blur();
                                textarea.value = permiso.concepto;
                                textarea.focus();
                            } else {
                                textarea.value = "";
                                textarea.blur();
                                textarea.blur();
                            }
                        }
                    </script>
                    <div id="nc_menu" style="display:none;">
                        <hr>
                        <div class="row mb-4" >
                            <p class="fs-6 fw-bold stc">CFDI RELACIONADO / NOTA CRÉDITO</p>
                            <div class="col">
                                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                    <input style="font-weight: bold;" type="text" id="nc_factura" name="nc_factura" class="form-control form-control-sm"/>
                                    <label class="form-label" for="nc_factura">FACTURA</label>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-outline mdb-input" style="background-color: white;">
                                    <select style="font-weight: bold;" data-mdb-select-init class="form-control form-control-sm"  class="form-select form-select-sm" aria-label="Default select example" name="nc_serie" id="nc_serie" style="font-size: 105%;" >
                                        <option value="" disabled selected style="display: none;"></option>
                                        <option value="A">A</option>
                                        <option value="B">B</option>
                                        <option value="NC">NC</option>
                                    </select>
                                    <label class="form-label" for="nc_serie">SERIE</label>
                                </div>
                            </div>
                            <div class="col">
                                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                    <input style="font-weight: bold;" type="date"  id="nc_fecha" name="nc_fecha" class="form-control form-control-sm"/>
                                    <label class="form-label" for="nc_fecha">FECHA</label>
                                </div>
                            </div>
                            <div class="col">
                                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                    <input style="font-weight: bold;" type="text" id="nc_folioFiscal" name="nc_folioFiscal" class="form-control form-control-sm"/>
                                    <label class="form-label" for="nc_folioFiscal">FOLIO FISCAL</label>
                                </div>
                            </div>
                        </div>
                        <hr>
                    </div>
                    <div class="row mb-4">
                        <div class="col">
                            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                <input style="font-weight: bold;" type="number" id="precioUnitario" type="number" min="1" step="0.01"   name="precioUnitario" onChange="CalcularImporte()"  class="form-control form-control-sm"/>
                                <label class="form-label" for="precioUnitario">PRECIO UNITARIO</label>
                            </div>
                        </div>
                        <div class="col">
                            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                <input style="font-weight: bold;" type="number" min="1" step="0.01" id="importeConcepto"  name="importeConcepto" class="form-control form-control-sm" readOnly/>
                                <label class="form-label" for="importeConcepto">IMPORTE CONCEPTO</label>
                            </div>
                        </div>
                        <div class="col-auto">
                            <div class="form-check form-switch" style="background-color: white;">
                                <input class="form-check-input btn-azul" type="checkbox" role="switch" id="cuentaPredial" name="cuentaPredial">
                                <label style="font-weight: bold;font-size: medium;" class="form-check-label" for="cuentaPredial"> [ <span  id="spanNoCuentaPredial" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiCuentaPredial" hidden="true">SI</span> ] CUENTA PREDIAL</label>
                            </div>
                        </div>
                        <div class="col">
                            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                <input style="font-weight: bold;" type="text" id="numeroCuentaPredial" name="numeroCuentaPredial" class="form-control form-control-sm" disabled/>
                                <label class="form-label" for="numeroCuentaPredial">CUENTA PREDIAL</label>
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="button" id="Guardar" onclick="insertProducto()" style="color:white;background-color: #008A13;" class="btn btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="INSERTAR">
                                <i class="fas fa-floppy-disk"></i>
                                <span class="btn-text">INSERTAR PRODUCTO / SERVICIO</span>
                            </button>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-auto">
                            <div class="form-check form-switch" style="background-color: white;">
                                <input class="form-check-input btn-azul" type="checkbox" role="switch" id="impuestoTrasladado" name="impuestoTrasladado">
                                <label style="font-weight: bold;font-size: medium;" class="form-check-label" for="impuestoTrasladado"> [ <span  id="spanNoImpuestoTrasladado" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiImpuestoTrasladado" hidden="true">SI</span> ] IMPUESTO TRASLADADO</label>
                            </div>
                        </div>
                        <div class="col-auto">
                            <div class="form-check form-switch" style="background-color: white;">
                                <input class="form-check-input btn-azul" type="checkbox" role="switch" id="impuestoRetenido" name="impuestoTrasladado">
                                <label style="font-weight: bold;font-size: medium;" class="form-check-label" for="impuestoRetenido"> [ <span  id="spanNoImpuestoRetenido" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiImpuestoRetenido" hidden="true">SI</span> ] IMPUESTO RETENIDO</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-outline mdb-input" style="background-color: white;">
                                <select style="font-weight: bold;" data-mdb-select-init class="form-control form-control-sm"  class="form-select form-select-sm" aria-label="Default select example" name="impuesto" id="impuesto" style="font-size: 105%;" >
                                    <option value="" disabled selected style="display: none;"></option>
                                    <c:forEach var="impuesto" items="${implista}">
                                        <option value="${impuesto.idImpuesto}" data-clave="${impuesto.claveImpuesto}" data-descripcion="${impuesto.descripcionImpuesto}">
                                            ${impuesto.claveImpuesto} - ${impuesto.descripcionImpuesto}
                                        </option>
                                    </c:forEach>
                                </select>
                                <label class="form-label" for="impuesto">IMPUESTO</label>
                            </div>
                        </div>

                        <div class="col">
                            <div class="form-outline mdb-input" style="background-color: white;">
                                <select style="font-weight: bold;" data-mdb-select-init class="form-control form-control-sm"  class="form-select form-select-sm" aria-label="Default select example" name="tipoFactor" id="tipoFactor" style="font-size: 105%;" >
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
                                <input style="font-weight: bold;" type="number" min="0.00001" step="0.00001" id="porcentajeImpuesto"  name="porcentajeImpuesto"  onChange="calcularImporteImpuesto()" class="form-control form-control-sm"/>
                                <label class="form-label" for="porcentajeImpuesto">% IMPUESTO</label>
                            </div>
                        </div>
                        <div class="col">
                            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                <input style="font-weight: bold;" type="number" min="1" step="0.01" id="importeImpuesto"  name="importeImpuesto"  class="form-control form-control-sm"/>
                                <label class="form-label" for="importeImpuesto">IMPORTE IMPUESTO</label>
                            </div>
                        </div>
                        <div class="col">
                            <button type="button" id="Guardar" onclick="insertImpuesto()" style="color:white;background-color: #008A13;" class="btn btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="INSERTAR">
                                <i class="fas fa-floppy-disk"></i>
                                <span class="btn-text">INSERTAR IMPUESTO</span>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="row d-flex justify-content-center p-3">
                    <div class="contenedortabla table-responsive">
                        <table id="tablaImpuestos" class="table table-hover fonthead table-bordered table-sm" style="font-size: 80%; background-color: #fff;">
                            <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">RENGLÓN IMPUESTO</th>
                                    <th class="fw-bold">IMPUESTO</th>
                                    <th class="fw-bold">TIPO IMPUESTO</th>
                                    <th class="fw-bold">TIPO FACTOR</th>
                                    <th class="fw-bold">% IMPUESTO</th>
                                    <th class="fw-bold">IMPORTE IMPUESTO</th>
                                    <th class="fw-bold">IMPORTE BASE</th>
                                    <th class="fw-bold">RENGLÓN PRODUCTO SERVICIO</th>
                                    <th class="fw-bold">ELIMINAR</th>
                                </tr>
                            </thead>
                            <tbody id="datos" class="text-center" style="font-size: 85%;">
                            </tbody>
                        </table>
                    </div>
                </div>
                <br>
                <h5 class="stc" style="text-align: center;">CONCEPTOS DE FACTURA</h5>
                <br>
                <div class="row d-flex justify-content-center p-3">
                    <div class="contenedortabla table-responsive">
                        <table id="tablaProductosServicios" class="table table-hover fonthead table-bordered table-sm" style="font-size: 75%; background-color: #fff;">
                            <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">RENGLON</th>
                                    <th class="fw-bold">CLAVE PRODUCTO O SERVICIO</th>
                                    <th class="fw-bold">CANTIDAD</th>
                                    <th class="fw-bold">UNIDAD MEDIDA</th>
                                    <th class="fw-bold">CONCEPTO</th>
                                    <th class="fw-bold">PRECIO UNITARIO</th>
                                    <th class="fw-bold">IMPORTE CONCEPTO</th>
                                    <th class="fw-bold">CUENTA PREDIAL</th>
                                    <th class="fw-bold">SERIE</th>
                                    <th class="fw-bold">FECHA FACTURA</th>
                                    <th class="fw-bold d-none">FACTURA_NC</th>
                                    <th class="fw-bold d-none">SERIE_NC</th>
                                    <th class="fw-bold d-none">FECHA_NC</th>
                                    <th class="fw-bold d-none">FOLIOFISCAL_NC</th>
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
                            <input style="font-weight: bold;" type="number" id="Subtotal"name="Subtotal" type="number" min="0" step="0.01"   value="0"  class="form-control form-control-sm"/>
                            <label class="form-label" for="Subtotal">SUBTOTAL</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" id="IVA" name="IVA" type="number" min="0" step="0.01"   value="0" class="form-control form-control-sm"/>
                            <label class="form-label" for="IVA">I.V.A.</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="number" id="Total" name="Total" type="number" min="0" step="0.01"   value="0" class="form-control form-control-sm"/>
                            <label class="form-label" for="Total">TOTAL FACTURA</label>
                        </div>
                    </div>
                </div>
                <!-- checkbox
                <div class="col-auto">
                    <div class="form-check form-switch" style="background-color: white;">
                        <input class="form-check-input btn-azul" type="checkbox" role="switch" id="conLetras" name="conLetras">
                        <label style="font-weight: bold;font-size: medium;" class="form-check-label" for="conLetras"> [ <span  id="spanNoTotalLetras" style="color:#BA0000;">NO</span> <span style="color:#007505;"  id="spanSiTotalLetras" hidden="true">SI</span> ] CON TOTAL EN LETRAS</label>
                    </div>
                </div>
                 
            
                <!--
                <div class="row mb-4">
                    <div class="col" id="columnaTotalLetras" style="display:none;">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="totalLetras"  type="text" name="totalLetras" class="form-control form-control-sm" readOnly/>
                            <label class="form-label" for="totalLetras">IMPORTE TOTAL EN LETRAS</label>
                        </div>
                    </div>
                </div>-->
                <div class="stc" style="justify-content: center; display: flex;">
                    <button type="button" id="GuardarFactura" name="action" value="101" style="color:white;background-color: #008A13;" onclick="sendData('101')" class="btn btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Guardar">
                        <i class="fas fa-floppy-disk"></i>
                        <span class="btn-text">GUARDAR</span>
                    </button>
                    <button type="button" id="ModificarFactura" value="102" name="action" onclick="sendData('102')" style="display: none; color:white; background-color: #0370A7;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Modificar" >
                        <i class="fas fa-pen-to-square"></i>
                        <span class="btn-text d-none d-sm-inline">MODIFICAR</span>
                    </button>
                    <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar"><!--Boton tipo reset-->
                        <i class="fas fa-eraser"></i>
                        <span class="btn-text">LIMPIAR</span>
                    </button>
                </div>
            </form>
        </div>


        <div class="tab-pane fade" id="ex3-tabs-3" role="tabpanel" aria-labelledby="ex3-tab-3">
            <h5 class="stc" style="text-align: center;">IMPRESIÓN DE FACTURAS</h5>
            <hr>
            <div class="row mb-4">
                <div class="col" style="text-align: center;">
                    <div data-mdb-input-init class="form-outline fontformulario">
                        <input type="text" id="busquedaFacturas" class="form-control" style="font-weight: bold; text-transform: uppercase;"
                               style="background-color: white;" />
                        <label class="form-label" for="busquedaFacturas">FOLIO</label>
                    </div>
                </div>
                <div class="col">
                    <div class="form-outline mdb-input" style="background-color: white;">
                        <select style="font-weight: bold;" data-mdb-select-init class="form-control" onchange="filtraSerie(this.value)"  class="form-select" aria-label="Default select example" id="serie_Factura" style="font-size: 105%;" >
                            <option value="" disabled selected style="display: none;"></option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="NC">NC</option>
                            <option value="ALL">TODAS</option>
                        </select>
                        <label class="form-label" for="nc_serie">SERIE</label>
                    </div>
                </div>
                <div class="col">
                    <button type="button" id="Reimprimir" class="stc btn btn-dark btn-rounded" style="background-color: #1e539b; color:white;" data-bs-toggle="tooltip" data-bs-placement="top" title="Reimprimir">
                        <i class="bi bi-printer-fill"></i>
                        <span class="btn-text">RE-IMPRIMIR FACTURA</span>
                    </button>                   
                </div>
            </div>
            <div class="row d-flex justify-content-center p-3">
                <div class="contenedortabla table-responsive">
                    <table id="titulo" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-secondary text-center">
                            <tr>
                                <th class="d-none">RENGLON</th>
                                <th>SERIE</th>
                                <th>FOLIO</th>
                                <th>FECHA FACTURA</th>
                                <th>IMPORTE FACTURA</th>
                                <th>USUARIO AUTORIZÓ</th>
                                <th>FECHA AUTORIZACIÓN</th>
                                <th>ESTADO DE LA FACTURA</th>
                            </tr>
                        </thead>
                        <tbody id="datosFacturas" class="text-center" style="font-size: 85%;">
                        </tbody>
                    </table>
                </div>
            </div>

            <%
    listaFacturas = (List<obj_Factura>) request.getAttribute("listaFacturas");
    ObjectMapper mapper2 = new ObjectMapper();
    String csJson2 = mapper2.writeValueAsString(listaFacturas);
            %>

            <script>
                var listaJSON = <%= csJson2 %>;
                // Obtener la referencia al cuerpo de la tabla
                var tbodyFacturas = document.getElementById("datosFacturas");

                function llenarTablaSerieFactura(value) {
                    tbodyFacturas.innerHTML = "";
                    // Recorrer la lista de autorizaciones
                    listaJSON.forEach(function (factura) {
                        // Comprobar si la serie es igual al valor dado y el estatus es "X" o "A"
                        if (factura.serie === value && (factura.estatus === 'X' || factura.estatus === 'A')) {
                            // Crear una nueva fila
                            var row = document.createElement("tr");

                            // Crear y agregar celdas a la fila
                            var idCell = document.createElement("td");
                            idCell.className = "d-none"; // Clase para ocultar
                            idCell.textContent = factura.idFactura;
                            idCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(idCell);

                            var serieCell = document.createElement("td");
                            serieCell.className = "texto-largo";
                            serieCell.textContent = factura.serie;
                            serieCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(serieCell);

                            var folioCell = document.createElement("td");
                            folioCell.className = "texto-largo";
                            folioCell.textContent = factura.folio;
                            folioCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(folioCell);

                            var fechaFacturaCell = document.createElement("td");
                            fechaFacturaCell.className = "texto-largo";
                            fechaFacturaCell.textContent = factura.fechaFactura;
                            fechaFacturaCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(fechaFacturaCell);

                            var importeCell = document.createElement("td");
                            importeCell.className = "texto-largo";
                            importeCell.textContent = factura.total;
                            importeCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(importeCell);

                            var usuarioCell = document.createElement("td");
                            usuarioCell.className = "texto-largo";
                            usuarioCell.textContent = factura.usuarioAutorizo;
                            usuarioCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(usuarioCell);

                            var fechaAutorizoCell = document.createElement("td");
                            fechaAutorizoCell.className = "texto-largo";
                            fechaAutorizoCell.textContent = factura.fechaAutorizo;
                            fechaAutorizoCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(fechaAutorizoCell);

                            var estadoCell = document.createElement("td");
                            estadoCell.className = "texto-largo";
                            estadoCell.textContent = factura.estatus;
                            estadoCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(estadoCell);

                            // Agregar la fila al cuerpo de la tabla
                            tbodyFacturas.appendChild(row);
                        }
                    });
                }

                function llenarTablaFacturas() {
                    tbodyFacturas.innerHTML = "";
                    // Recorrer la lista de autorizaciones
                    listaJSON.forEach(function (factura) {
                        // Comprobar si el estatus es "X" o "A"
                        if (factura.estatus === "X" || factura.estatus === "A") {
                            // Crear una nueva fila
                            var row = document.createElement("tr");

                            // Crear y agregar celdas a la fila
                            var idCell = document.createElement("td");
                            idCell.className = "d-none"; // Clase para ocultar
                            idCell.textContent = factura.idFactura;
                            idCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(idCell);

                            var serieCell = document.createElement("td");
                            serieCell.className = "texto-largo";
                            serieCell.textContent = factura.serie;
                            serieCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(serieCell);

                            var folioCell = document.createElement("td");
                            folioCell.className = "texto-largo";
                            folioCell.textContent = factura.folio;
                            folioCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(folioCell);

                            var fechaCell = document.createElement("td");
                            fechaCell.className = "texto-largo";
                            fechaCell.textContent = factura.fechaFactura;
                            fechaCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(fechaCell);

                            var importeCell = document.createElement("td");
                            importeCell.className = "texto-largo";
                            importeCell.textContent = factura.total;
                            importeCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(importeCell);

                            var usuarioCell = document.createElement("td");
                            usuarioCell.className = "texto-largo";
                            usuarioCell.textContent = factura.usuarioAutorizo;
                            usuarioCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(usuarioCell);

                            var fechaAutorizoCell = document.createElement("td");
                            fechaAutorizoCell.className = "texto-largo";
                            fechaAutorizoCell.textContent = factura.fechaAutorizo;
                            fechaAutorizoCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(fechaAutorizoCell);

                            var estadoCell = document.createElement("td");
                            estadoCell.className = "texto-largo";
                            estadoCell.textContent = factura.estatus;
                            estadoCell.style.color = factura.estatus === "X" ? "#a01c00" : "black";
                            row.appendChild(estadoCell);

                            // Agregar la fila al cuerpo de la tabla
                            tbodyFacturas.appendChild(row);
                        }
                    });

                }
                window.onload = llenarTablaFacturas;

                // Función de búsqueda
                function buscarFacturas() {
                    var value = $("#busquedaFacturas").val().toLowerCase();
                    $("#datosFacturas tr").filter(function () {
                        var found = $(this).find("td:nth-child(3)").text().toLowerCase().indexOf(value) > -1;
                        $(this).toggle(found);
                    });
                }

                // Evento keyup
                $("#busquedaFacturas").on("keyup", buscarFacturas);

                function filtraSerie(value) {
                    if (value == 'ALL') {
                        llenarTablaFacturas();
                        buscarFacturas();
                    } else {
                        llenarTablaSerieFactura(value);
                        buscarFacturas();
                    }
                }
            </script>
            <form id="formulario_impresion" >
                <div>
                    <input hidden="true" type="text" value="" id="folio_impresion" name="folio_impresion" class="form-control" style="text-transform: uppercase;" required/>
                    <input hidden="true" type="text" value="" id="serie_impresion" name="serie_impresion" class="form-control" style="text-transform: uppercase;" required/>
                </div>
                <div>
                    <div class="stc" style="justify-content: center; display: flex;">
                        <button type="submit" id="Generar" name="action" value="Generar" style="color:white; background-color: #0370A7;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="MODIFICAR">
                            <i class="fas fa-pen-to-square"></i>
                            <span class="btn-text">GENERAR FACTURA</span>
                        </button>
                        <button type="submit" name="action" value="" title="Imprimir" class="btn btn-sm btn-rounded stc" style="color:white; background-color: purple;" data-mdb-ripple-init>
                            <i class="bi bi-printer-fill"></i>
                            <span class="btn-text">VISUALIZAR PDF</span>
                        </button>
                        <button type="reset" id="LimpiarTablaFacturas" class="btn btn-dark btn-sm btn-rounded" data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar">
                            <i class="bi bi-eraser-fill"></i>
                            <span class="btn-text">LIMPIAR</span>
                        </button>
                    </div>
                </div>
            </form> 
        </div>
        <script>
            //*****************Funcion limpiar para quitar boton y estiñps en tabla 
            document.addEventListener('DOMContentLoaded', function () {
                // Agregar el event listener para el botón de limpiar
                document.querySelector('#LimpiarTablaFacturas').addEventListener('click', function () {
                    document.getElementById("serie_Factura").value = "";
                    document.getElementById("serie_Factura").focus();
                    document.getElementById("serie_Factura").blur();
                    document.getElementById("folio_impresion").value = "";
                    document.getElementById("serie_impresion").value = "";
                    document.getElementById("busquedaFacturas").value = "";
                    document.getElementById("busquedaFacturas").blur();

                    llenarTablaFacturas();
                    if (document.querySelector('.selected')) {
                        document.querySelector('.selected').classList.remove('selected');
                    }
                });
            });
            //*********Toma datos de tabla para moverlos arriba y cambiar los botones 
            document.addEventListener('DOMContentLoaded', function () {
                // Obtener la tabla y el formulario
                var tabla = document.getElementById('datosFacturas');
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
                        // Obtener los datos de la fila
                        let serieFactura = fila.querySelector('.texto-largo:nth-child(2)').innerText;
                        let folioFactura = fila.querySelector('.texto-largo:nth-child(3)').innerText;
                        console.log("foliooooooooooooooooo" + folioFactura);
                        console.log("serieeeeeeeeeeeeeeeee" + serieFactura);
                        // Ingresa los valores a los cuadros de texto
                        document.getElementById('folio_impresion').value = folioFactura;
                        document.getElementById('serie_impresion').value = serieFactura;
                    }
                });
            });
        </script>



        <div class="tab-pane fade" id="ex3-tabs-4" role="tabpanel" aria-labelledby="ex3-tab-4">
            <h5 class="stc" style="text-align: center;">REPORTE DE FACTURAS</h5>
            <hr>
            <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
                <label class="form-check-label" for="flexSwitchCheckDefault">REPORTE DE FACTURA</label>
            </div>
            <br>
            <div class="row mb-4">
                <div class="col">
                    <select data-mdb-select-init class="form-select" aria-label="Default select example" style="font-size: 105%;" name="serfact2" id="serfact2" disabled>
                        <option selected>SERIE DE FACTURA</option>
                        <option value="1">Op 1</option>
                        <option value="2">Op 2</option>
                    </select>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="date" name="ranfch" id="ranfch1" disabled class="form-control "/>
                        <label class="form-label" for="ranfch">RANGO DE FECHA 1</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="date" name="ranfch2" id="ranfch2" disabled class="form-control "/>
                        <label class="form-label" for="ranfch2">RANGO DE FECHA 2</label>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row mb-4">
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" role="switch"  name="repfac" id="repfac2">
                    <label class="form-check-label" for="repfac">ESTATUS</label>
                </div>

                <div class="col">
                    <br>
                    <select data-mdb-select-init class="form-select" aria-label="Default select example" id="estfa1" name="estfa" value="" placeholder="Estatus" disabled style="font-size: 105%;">
                        <option selected>ESTATUS</option>
                        <option value="1">X</option>
                        <option value="2">A</option>
                        <option value="3">G</option>
                        <option value="4">I</option>
                        <option value="5">C</option>
                    </select>
                </div>
                <div class="col">
                    <p>
                        X = CAPTURADA
                    </p>
                    <p>
                        A = AUTORIZADA
                    </p>
                    <p>
                        G = GENERADA
                    </p>
                </div>
                <div class="col">
                    <p>
                        I = IMPRESA
                    </p>
                    <p>
                        C = CANCELADA
                    </p>
                </div>
            </div>
            <br>
            <hr>
            <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" role="switch" name="pdffac" id="repfac3">
                <label class="form-check-label" for="pdffac">FACTURA PDF (REVISIÓN DE FACTURA)</label>
            </div>
            <br>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" id="nfactr1" name="nfactr" value="" placeholder="N. Factura" disabled class="form-control "/>
                        <label class="form-label" for="nfactr">No. FACTURA</label>
                    </div>
                </div>
                <div class="col">
                    <select data-mdb-select-init class="form-select" name="serfact3" id="serfact3" disabled aria-label="Default select example" style="font-size: 105%;">
                        <option selected>SERIE DE FACTURA</option>
                        <option value="1">Op 1</option>
                        <option value="2">Op 2</option>
                    </select>
                </div>
            </div>
            <br>
            <hr>
            <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
                <label class="form-check-label" for="flexSwitchCheckDefault">REGENERA FACTURA O COMPROBANTE DE PAGO (SOLO NO TIMBRADAS)</label>
            </div>
            <br>
            <div class="row mb-4">
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" id="form6Example1" class="form-control "/>
                        <label class="form-label" for="form6Example1">No. DE DOCMENTO</label>
                    </div>
                </div>
                <div class="col">
                    <select data-mdb-select-init class="form-select" aria-label="Default select example" style="font-size: 105%;">
                        <option selected>SERIE</option>
                        <option value="1">Op 1</option>
                        <option value="2">Op 2</option>
                    </select>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="password" id="form6Example1" class="form-control "/>
                        <label class="form-label" for="form6Example1">CONTRASEÑA</label>
                    </div>
                </div>
            </div>
        </div>
    </div>                                                         
    <!-- Tabs content -->
    <br>

</main>




<script  type="text/javascript">
    //-------------------------------------------------INSERTAR EN TABLA IMPUESTOS
    var impTAR = 0;
    var impRET = 0;
    var contadorEnter2 = 0;
    function InsertarImpuesto(event) {
        if (event.keyCode === 13) { // Si se presiona la tecla Enter
            contadorEnter2++;
            if (contadorEnter2 >= 2) { // Si se presiona dos veces
                event.preventDefault();

                /*
                 // Limpiar los valores del formulario
                 document.getElementById("impt1").checked=false;
                 document.getElementById("impr1").checked=false;
                 document.getElementById("TImp1").value = "";
                 document.getElementById("TFact1").value ="";
                 document.getElementById("PImp1").value = "";
                 document.getElementById("IImp1").value = "";
                 
                 
                 */
                document.getElementById("Guardar1").disabled = false;
                var iva = document.getElementById('Iva1').value;
                var subtotal = document.getElementById('Stot1').value;
                var total = document.getElementById('Total1').value;
                alert("iva" + iva);
                alert("subtotal" + subtotal);
                alert("total:" + total);
                var suma = parseFloat(subtotal) + parseFloat(iva);
                var casillas = parseFloat(total) + suma;
                var formatosuma = casillas.toFixed(2);
                alert("suma total " + formatosuma);
                document.getElementById('Total1').value = formatosuma;
            }//Termina if dos enter

        } else {
            contadorEnter2 = 0; // Reiniciar el contador si se presiona otra tecla diferente de Enter
        }

    }

    //------------------------------------------------CONVERTIR TODAS EN MAYUSCULAS MENOS EMAIL
    document.getElementById('formulario').addEventListener('submit', function (event) {
        var inputs = document.getElementsByTagName('input');
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].type === 'text') {
                inputs[i].value = inputs[i].value.toUpperCase();
            } else if (inputs[i].type === 'email') {
                inputs[i].value = inputs[i].value.toLowerCase();
            }
        }

    });
    //------------------------ACTIVA CASILLAS DE REPORTES
    //RANGO FECHAS
    var rfactura = document.getElementById("repfac1");
    rfactura.addEventListener('click', function () {
        if (rfactura.checked) {
            document.getElementById("serfact2").disabled = false;
            document.getElementById("ranfch1").disabled = false;
            document.getElementById("ranfch2").disabled = false;
        } else {
            document.getElementById("serfact2").disabled = true;
            document.getElementById("ranfch1").disabled = true;
            document.getElementById("ranfch2").disabled = true;
        }
    });
    //ESTATUS
    var rfactura2 = document.getElementById("repfac2");
    rfactura2.addEventListener('click', function () {
        if (rfactura2.checked) {
            document.getElementById("estfa1").disabled = false;
        } else {
            document.getElementById("estfa1").disabled = true;
        }
    });
    //FACTURA PDF
    var rfactura3 = document.getElementById("repfac3");
    rfactura3.addEventListener('click', function () {
        if (rfactura3.checked) {
            document.getElementById("nfactr1").disabled = false;
            document.getElementById("serfact3").disabled = false;
        } else {
            document.getElementById("nfactr1").disabled = true;
            document.getElementById("serfact3").disabled = true;
        }
    });
    //Es para poder ingresar los valores a los cuadros de texto en cuanto hagan click
    $("table tbody tr").click(function () {
        //Obtiene los valores de la tabla a la cual se da click
        var sr = $(this).find("td:eq(0)").text();
        var fl = $(this).find("td:eq(1)").text();
        //Ingresa los valores a los cuadros de texto
        document.getElementById("serfact1").value = sr;
        document.getElementById("folini1").value = fl;
        document.getElementById("folfin1").value = "";
    });
    //Habilitar Casillas Impuestro Trasladado y Retenido (Detalles de Factura)
    var dfimptra = document.getElementById("impt1");
    var dfimpret = document.getElementById("impr1");
    dfimptra.addEventListener('click', function () {
        if (dfimptra.checked) {
            document.getElementById("impr1").disabled = true;
            document.getElementById("impr1").checked = false;
        } else {
            document.getElementById("impr1").disabled = false;
        }
    });
    dfimpret.addEventListener('click', function () {
        if (dfimpret.checked) {
            document.getElementById("impt1").disabled = true;
            document.getElementById("impt1").checked = false;
        } else {
            document.getElementById("impt1").disabled = false;
        }
    });
</script>

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

<%@include file="../Pie.jsp"%>