
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Objetos.obj_Mensaje"%>
<%! obj_Mensaje mensaje;%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@page import="Objetos.obj_Usuario"%>
<%@page import="Objetos.Obj_ConceptoFactura"%>
<%@page import="Objetos.Obj_ImpuestoConcepto"%>
<%@page import="Objetos.Obj_FacturacionAutomatica"%>
<%! obj_Usuario usuario;%>
<%! List<obj_Usuario> usuarios;%>
<%! List<Obj_ImpuestoConcepto> impuestosConcepto;%>
<%! List<Obj_ConceptoFactura> conceptosFactura;%>
<%! List<Obj_FacturacionAutomatica> encabezadosFactura;%>

<%! List<Obj_ImpuestoConcepto> impuestosConceptoMeses;%>
<%! List<Obj_ConceptoFactura> conceptosFacturaMeses;%>
<%! List<Obj_FacturacionAutomatica> encabezadosFacturaMeses;%>

<%@include file="../Encabezado.jsp"%>
<%
         System.out.println("---------------------Facturas Automaticas JSP---------------------");
         usuarios = (List<obj_Usuario>) request.getAttribute("conceptolista");
         impuestosConcepto  = (List<Obj_ImpuestoConcepto>) request.getAttribute("impuestos");
         conceptosFactura = (List<Obj_ConceptoFactura>) request.getAttribute("detalles");
         encabezadosFactura = (List<Obj_FacturacionAutomatica>) request.getAttribute("facturacionesAutomaticas");
         
         encabezadosFacturaMeses = (List<Obj_FacturacionAutomatica>) request.getAttribute("facturacionesAutomaticasMeses");
         impuestosConceptoMeses  = (List<Obj_ImpuestoConcepto>) request.getAttribute("impuestosMeses");
         conceptosFacturaMeses = (List<Obj_ConceptoFactura>) request.getAttribute("detallesMeses");
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
</style>
<style>
    .custom-select {
        position: relative;
        width: auto;
        min-width: 200px;
        border: 1px solid #ced4da;
        border-radius: .25rem;
        cursor: pointer;
        transition: width 0.3s;
    }
    .custom-select select {
        display: none;
    }
    .select-selected {
        background-color: #ffffff;
        padding: 8px 32px 8px 16px; /* Añadido espacio entre texto e icono */
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .select-selected:after {
        position: absolute;
        content: '';
        top: 50%;
        right: 10px;
        width: 0;
        height: 0;
        border: 6px solid transparent;
        border-color: #000000 transparent transparent transparent;
        transform: translateY(-50%);
    }
    .select-items {
        display: none;
        position: absolute;
        background-color: #ffffff;
        border: 1px solid #ced4da;
        border-top: none;
        width: 100%;
        z-index: 99;
        max-height: 200px;
        overflow-y: auto;
    }
    .select-items div {
        padding: 8px 16px;
        cursor: pointer;
    }
    .select-items div:hover {
        background-color: #f1f1f1;
    }
    input[type="checkbox"] {
        margin-right: 8px;
        pointer-events: none; /* Evitar que el clic se propague al contenedor */
    }
    .select-items.visible {
        display: block;
    }
</style>
<!-- Cuerpo -->
<head>
    <script type="application/json" id="encabezados">
        <%= new Gson().toJson(encabezadosFactura) %>
    </script>
    <script type="application/json" id="impuestos">
        <%= new Gson().toJson(impuestosConcepto) %>
    </script>
    <script type="application/json" id="detalles">
        <%= new Gson().toJson(conceptosFactura) %>
    </script>
    
    <script type="application/json" id="encabezadosMeses">
        <%= new Gson().toJson(encabezadosFacturaMeses) %>
    </script>
    <script type="application/json" id="impuestosMeses">
        <%= new Gson().toJson(impuestosConceptoMeses) %>
    </script>
    <script type="application/json" id="detallesMeses">
        <%= new Gson().toJson(conceptosFacturaMeses) %>
    </script>
    
    <script src="JS\facturacionAutomatica.js"></script>
</head>
<main class="col ps-md-2 pt-2 mx-3">
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <div class="page-header pt-3 stc">
        <h3 class="stc">FACTURACIÓN AUTOMÁTICA</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
        <!-- Tabs navs -->
        <ul class="nav nav-tabs nav-justified mb-3 stc" id="ex1" role="tablist">
            <li class="nav-item" role="presentation">
                <a data-mdb-tab-init class="nav-link active" id="ex3-tab-1" href="#ex3-tabs-1" role="tab" aria-controls="ex3-tabs-1" aria-selected="true">
                    FACTURACIÓN AUTOMÁTICA DEL MES ACTUAL
                </a>
            </li>
            <li class="nav-item" role="presentation">
                <a data-mdb-tab-init class="nav-link" id="ex3-tab-2" href="#ex3-tabs-2" role="tab" aria-controls="ex3-tabs-2" aria-selected="false">
                    CONSULTA FACTURA
                </a>
            </li>
            <li class="nav-item" role="presentation" data-mdb-ripple-init data-mdb-modal-init data-mdb-target="#staticBackdropModal2">
                <a data-mdb-tab-init class="nav-link" id="ex3-tab-3" href="#ex3-tabs-3" role="tab" aria-controls="ex3-tabs-3" aria-selected="false">
                    FACTURACIÓN AUTOMÁTICA MESES ANTERIORES
                </a>
            </li>
        </ul>
        <!-- Tabs navs -->

        <!-- Tabs content -->
        <div class="tab-content" id="ex2-content">
        
            <div class="tab-pane fade show active" id="ex3-tabs-1" role="tabpanel" aria-labelledby="ex3-tab-1">
                <h5 class="stc" style="text-align: center;">FACTURACIÓN AUTOMÁTICA</h5>
                <hr>
                <form action="Srv_FacturacionAutomatica" id="facturasAutomaticasMes" method="POST" class="fontformulario" style="font-size: 75%; margin: 15px;">
                    <div class="row mb-4">
                        <div class="col">
                            <div class="form-outline mdb-input">
                                <select style="font-weight: bold;" style="font-weight: bold;" value="" id="usuarioResponsable" name="usuarioResponsable" class="form-select form-select-sm" aria-label="Default select example" required>
                                    <option value="" disabled selected style="display: none;" ></option>
                                        <c:forEach var="usuario" items="${usuarios}">
                                                <option value="${usuario.nombre}">${usuario.nombre}</option>
                                        </c:forEach>       
                                </select>
                                <label class="form-label" for="txtNombre">USUARIO RESPONSABLE</label>
                            </div>
                        </div>
                        <div class="col">
                            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                <input type="date" id="fechaGeneracion" name="fechaGeneracion" class="form-control form-select-sm" onchange="filtrarFacturas()"/>
                                <label class="form-label" for="fecha">FECHA DE GENERACIÓN</label>
                            </div>
                        </div>
                    </div>
                <div class="row d-flex justify-content-center p-3">
                    <h6 class="fw-bold">FACTURAS</h6>
                    <div class="contenedortabla table-responsive">
                        <table id="tablaEncabezado" class="fontformulario table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                            <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">No.R</th>
                                    <th class="fw-bold">Folio</th>
                                    <th class="fw-bold">Serie</th>
                                    <th class="fw-bold">Tipo Comprobante</th>
                                    <th class="fw-bold">R.F.C.</th>
                                    <th class="fw-bold">Cliente</th>
                                    <th class="fw-bold">Lugar Emisión</th>
                                    <th class="fw-bold">Uso Factura</th>
                                    <th class="fw-bold">Fecha Factura</th>
                                    <th class="fw-bold">Hora Factura</th>
                                    <th class="fw-bold">Moneda</th>
                                    <th class="fw-bold">Tipo de cambio</th>
                                    <th class="fw-bold">Forma de Pago</th>
                                    <th class="fw-bold">Cuenta de Banco</th>
                                    <th class="fw-bold">Metodo de Pago</th>
                                    <th class="fw-bold">Condiciones de Pago</th>
                                    <th class="fw-bold">Permiso</th>
                                    <th class="fw-bold">Sub total</th>
                                    <th class="fw-bold">IVA</th>
                                    <th class="fw-bold">Total Factura</th>
                                    <th class="fw-bold">Total en letras</th>
                                    <th class="fw-bold">Usuario responsable</th>
                                    <th class="fw-bold">Fecha de generacion</th>
                                    <th class="fw-bold">estatus</th>
                                    <th class="fw-bold">Concepto Facturacion</th>
                                    <th class="fw-bold">Fecha de pago</th>
                                    <th class="fw-bold">Saldo factura</th>
                                    <th class="fw-bold">Mes de factura</th>
                                    <th class="fw-bold">Tipo de servicio</th>
                                    
                                </tr>
                            
                            </thead>
                            <tbody id="datosEncabezado" style="font-size: 85%;">
                            <c:forEach var="facturaAutomatica" items="${facturacionesAutomaticas}" varStatus="status">
                                <tr>
                                    <td class="texto-largo">${status.index + 1}</td>
                                    <td class="texto-largo">${facturaAutomatica.folio}</td>
                                    <td class="texto-largo">${facturaAutomatica.serie}</td>
                                    <td class="texto-largo">${facturaAutomatica.tipoComprobante}</td>
                                    <td class="texto-largo">${facturaAutomatica.RFC}</td>
                                    <td class="texto-largo">${facturaAutomatica.cliente}</td>
                                    <td class="texto-largo">${facturaAutomatica.lugarEmision}</td>
                                    <td class="texto-largo">${facturaAutomatica.usoFactura}</td>
                                    <td class="texto-largo">${facturaAutomatica.fechaFactura}</td>
                                    <td class="texto-largo">${facturaAutomatica.horaFactura}</td>
                                    <td class="texto-largo">${facturaAutomatica.moneda}</td>
                                    <td class="texto-largo">${facturaAutomatica.tipoCambio}</td>
                                    <td class="texto-largo">${facturaAutomatica.formaPago}</td>
                                    <td class="texto-largo">${facturaAutomatica.cuentaBanco}</td>
                                    <td class="texto-largo">${facturaAutomatica.metodoPago}</td>
                                    <td class="texto-largo">${facturaAutomatica.condicionesPago}</td>
                                    <td class="texto-largo">${facturaAutomatica.noPermiso}</td>
                                    <td class="texto-largo">${facturaAutomatica.subTotal}</td>
                                    <td class="texto-largo">${facturaAutomatica.IVA}</td>
                                    <td class="texto-largo">${facturaAutomatica.totalFactura}</td>
                                    <td class="texto-largo">${facturaAutomatica.totalLetra}</td>
                                    <td class="texto-largo">${facturaAutomatica.usuarioResponsable}</td>
                                    <td class="texto-largo">${facturaAutomatica.fechaGeneracion}</td>
                                    <td class="texto-largo">${facturaAutomatica.estatus}</td>
                                    <td class="texto-largo">${facturaAutomatica.conceptoFactura}</td>
                                    <td class="texto-largo">${facturaAutomatica.fechaPago}</td>
                                    <td class="texto-largo">${facturaAutomatica.saldoFactura}</td>
                                    <td class="texto-largo">${facturaAutomatica.mesFactura}</td>
                                    <td class="texto-largo">${facturaAutomatica.tipoServicio}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row d-flex justify-content-center p-3">
                    <h6 class="fw-bold">CONCEPTOS DE FACTURAS</h6>
                    <div class="contenedortabla table-responsive">
                        <table id="tablaConceptos" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                            <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">N.R</th>
                                    <th class="fw-bold">Folio</th>
                                    <th class="fw-bold">Serie</th>
                                    <th class="fw-bold">Fecha Factura</th>
                                    <th class="fw-bold">Renglón</th>
                                    <th class="fw-bold">Producto Servicio</th>
                                    <th class="fw-bold">Cantidad</th>
                                    <th class="fw-bold">Unidad Medida</th>
                                    <th class="fw-bold">Descripcion Unidad Medida</th>
                                    <th class="fw-bold">Precio Unitario</th>
                                    <th class="fw-bold">Importe</th>
                                    <th class="fw-bold">Cuenta Predial</th>
                                    <th class="fw-bold">Concepto</th>
                                </tr>
                            </thead>
                            <tbody id="datosConcetos" style="font-size: 85%;">
                                     <c:forEach var="concepto" items="${detalles}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td>${concepto.folio}</td>
                                            <td>${concepto.serie}</td>
                                            <td>${concepto.fechaFactura}</td>
                                            <td>${concepto.renglon}</td>
                                            <td>${concepto.productoServicio}</td>
                                            <td>${concepto.cantidad}</td>
                                            <td>${concepto.unidadMedida}</td>
                                            <td>${concepto.descripcionUnidadMedida}</td>
                                            <td>${concepto.precioUnitario}</td>
                                            <td>${concepto.importeConcepto}</td>
                                            <td>${concepto.cuentaPredial}</td>
                                            <td>${concepto.concepto}</td>
                                        </tr>
                                       </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row d-flex justify-content-center p-3">
                    <h6 class="fw-bold">IMPUESTOS DE CONCEPTOS</h6>
                    <div class="contenedortabla table-responsive">
                        <table id="tablaImpuestos" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                            <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">N.R</th>
                                    <th class="fw-bold">Folio</th>
                                    <th class="fw-bold">Serie</th>
                                    <th class="fw-bold">Fecha Factura</th>
                                    <th class="fw-bold">Tipo Imp.</th>
                                    <th class="fw-bold">Tipo Factor</th>
                                    <th class="fw-bold">Tasa Imp.</th>
                                    <th class="fw-bold">Imp. Impuesto</th>
                                    <th class="fw-bold">Imp. Tras. Ret.</th>
                                    <th class="fw-bold">Renglón Impuesto</th>
                                    <th class="fw-bold">Imp. Base</th>
                                </tr>
                            </thead>
                            <tbody id="datosImpuestos" style="font-size: 85%;">
                                <c:forEach var="impuesto" items="${impuestos}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td>${impuesto.folio}</td>
                                            <td>${impuesto.serie}</td>
                                            <td>${impuesto.fechaFactura}</td>
                                            <td>${impuesto.tipoImpuesto}</td>
                                            <td>${impuesto.tipoFactor}</td>
                                            <td>${impuesto.tasaImpuesto}</td>
                                            <td>${impuesto.importeImpuesto}</td>
                                            <td>${impuesto.impTrasRet}</td>
                                            <td>${impuesto.renglonConcepto}</td>
                                            <td>${impuesto.impuestoBase}</td>
                                        </tr>
                                       </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div style="justify-content: center; display: flex;">                    
                    <button type="button" class="btn btn-outline-success btn-sm btn-rounded stc" data-bs-toggle="tooltip" data-bs-placement="top" title="Exportar" onclick="exportTableToExcel('tablaEncabezado','facturas.xlsx')">
                            <i class="bi bi-file-earmark-arrow-up-fill"></i>
                            <span class="btn-text">EXPORTAR</span>
                        </button>
                    <button type="button" class="stc btn btn-success btn-sm btn-rounded btn-lg" data-bs-toggle="tooltip" data-bs-placement="top" title="Guardar" onclick="guardarFacturas()" style="color:white;background-color: #008A13;">
                            <i class="bi bi-floppy-fill"></i>
                            <span class="btn-text">GUARDAR</span>
                        </button>
                    <button hidden type="submit" id="buscarFacurasAtomaticas" class="stc btn btn-info btn-rounded" name="action" value="104" data-bs-toggle="tooltip" data-bs-placement="top" title="Filtar">
                            <i class="bi bi-search"></i>
                            <span class="btn-text">BUSCAR</span>
                        </button>
                    <button type="reset" id="Limpiar" class="stc btn btn-dark btn-sm btn-rounded" data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar">
                            <i class="bi bi-eraser-fill"></i>
                            <span class="btn-text">LIMPIAR</span>
                    </button>
                    </div>
                </form>
            </div>
            
    <div class="tab-pane fade" id="ex3-tabs-2" role="tabpanel" aria-labelledby="ex3-tab-2">
                <div class="row">
                    <h5 class="stc" style="text-align: center;">CONSULTA DE FACTURAS</h5>
                    <hr>
                    <!-- Contenido -->
                    <div class="row d-flex justify-content-center p-3">
                        <h6 class="fw-bold">FACTURAS</h6>
                        <div class="contenedortabla table-responsive">
                            <table id="consultaEncabezado" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                                <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">No.R</th>
                                    <th class="fw-bold">Folio</th>
                                    <th class="fw-bold">Serie</th>
                                    <th class="fw-bold">Tipo Comprobante</th>
                                    <th class="fw-bold">R.F.C.</th>
                                    <th class="fw-bold">Cliente</th>
                                    <th class="fw-bold">Lugar Emisión</th>
                                    <th class="fw-bold">Uso Factura</th>
                                    <th class="fw-bold">Fecha Factura</th>
                                    <th class="fw-bold">Hora Factura</th>
                                    <th class="fw-bold">Moneda</th>
                                    <th class="fw-bold">Tipo de cambio</th>
                                    <th class="fw-bold">Forma de Pago</th>
                                    <th class="fw-bold">Cuenta de Banco</th>
                                    <th class="fw-bold">Metodo de Pago</th>
                                    <th class="fw-bold">Condiciones de Pago</th>
                                    <th class="fw-bold">Permiso</th>
                                    <th class="fw-bold">Sub total</th>
                                    <th class="fw-bold">IVA</th>
                                    <th class="fw-bold">Total Factura</th>
                                    <th class="fw-bold">Total en letras</th>
                                    <th class="fw-bold">Usuario responsable</th>
                                    <th class="fw-bold">Fecha de generacion</th>
                                    <th class="fw-bold">estatus</th>
                                    <th class="fw-bold">Concepto Facturacion</th>
                                    <th class="fw-bold">Fecha de pago</th>
                                    <th class="fw-bold">Saldo factura</th>
                                    <th class="fw-bold">Mes de factura</th>
                                    <th class="fw-bold">Tipo de servicio</th>
                                    
                                </tr>
                            
                            </thead>
                                <tbody id="datosConsultaEncabezado" style="font-size: 85%;">
                                    <tr>
                                        
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row d-flex justify-content-center p-3">
                        <h6 class="fw-bold">CONCEPTOS DE FACTURAS</h6>
                        <div class="contenedortabla table-responsive">
                            <table id="consultaDetalle" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                                <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">N.R</th>
                                    <th class="fw-bold">Folio</th>
                                    <th class="fw-bold">Serie</th>
                                    <th class="fw-bold">Fecha Factura</th>
                                    <th class="fw-bold">Renglón</th>
                                    <th class="fw-bold">Producto Servicio</th>
                                    <th class="fw-bold">Cantidad</th>
                                    <th class="fw-bold">Unidad Medida</th>
                                    <th class="fw-bold">Descripcion Unidad Medida</th>
                                    <th class="fw-bold">Precio Unitario</th>
                                    <th class="fw-bold">Importe</th>
                                    <th class="fw-bold">Cuenta Predial</th>
                                    <th class="fw-bold">Concepto</th>
                                </tr>
                            </thead>
                                <tbody id="datosConsultaDetalle" style="font-size: 85%;">
                                    <tr>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row d-flex justify-content-center p-3">
                        <h6 class="fw-bold">IMPUESTOS DE CONCEPTOS</h6>
                        <div class="contenedortabla table-responsive">
                            <table id="consultaImpuestos" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                                <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">N.R</th>
                                    <th class="fw-bold">Folio</th>
                                    <th class="fw-bold">Serie</th>
                                    <th class="fw-bold">Fecha Factura</th>
                                    <th class="fw-bold">Renglón</th>
                                    <th class="fw-bold">Tipo Imp.</th>
                                    <th class="fw-bold">Tipo Factor</th>
                                    <th class="fw-bold">Tasa Imp.</th>
                                    <th class="fw-bold">Imp. Impuesto</th>
                                    <th class="fw-bold">Imp. Tras. Ret.</th>
                                    <th class="fw-bold">Renglón</th>
                                    <th class="fw-bold">Imp. Base</th>
                                </tr>
                            </thead>
                                <tbody id="datosConsultaImpuestos" style="font-size: 85%;">
                                    <tr>
                                      
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="ex3-tabs-3" role="tabpanel" aria-labelledby="ex3-tab-3">
                <h5 class="stc" style="text-align: center;">FACTURACIÓN AUTOMÁTICA MESES ANTERIORES</h5>
                <hr>
            <form action="" id="facturasAutomaticasMesAnterior" method="POST" class="fontformulario" style="font-size: 75%; margin: 15px;">

                <div class="row mb-4">
                     <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="year" name="year" class="form-control form-select-sm"  pattern="^\d{4}$" title="El campo debe se en formato yyyy" onchange="verificarFecha()"/>
                            <label class="form-label" for="form6Example1">AÑO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-select-initdata-mdb-input-init class="custom-select" onclick="toggleSelect()">
                            <div class="select-selected ">SELECCIONE LOS MESES A CAPTURAR</div>
                            <div class="select-items" onclick="event.stopPropagation()" onchange="limpiarUsuario()"> <!-- Evitar que el clic se propague al contenedor -->
                                <div><label><input type="checkbox" name="months[]" value="01">Enero</label></div>
                                <div><label><input type="checkbox" name="months[]" value="02">Febrero</label></div>
                                <div><label><input type="checkbox" name="months[]" value="03">Marzo</label></div>
                                <div><label><input type="checkbox" name="months[]" value="04">Abril</label></div>
                                <div><label><input type="checkbox" name="months[]" value="05">Mayo</label></div>
                                <div><label><input type="checkbox" name="months[]" value="06">Junio</label></div>
                                <div><label><input type="checkbox" name="months[]" value="07">Julio</label></div>
                                <div><label><input type="checkbox" name="months[]" value="08">Agosto</label></div>
                                <div><label><input type="checkbox" name="months[]" value="09">Septiembre</label></div>
                                <div><label><input type="checkbox" name="months[]" value="10">Octubre</label></div>
                                <div><label><input type="checkbox" name="months[]" value="11">Noviembre</label></div>
                                <div><label><input type="checkbox" name="months[]" value="12">Diciembre</label></div>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select id="usuarioMeses" name="usuarioMeses" style="font-weight: bold;" style="font-weight: bold;" value="" data-mdb-select-init class="form-select form-select-sm" aria-label="Default select example" style="font-size: 105%;" onchange="obtenerClientesRef()" required>
                                <option value="" disabled selected style="display: none;" ></option>
                                    <c:forEach var="usuario" items="${usuarios}">
                                            <option value="${usuario.nombre}">${usuario.nombre}</option>
                                    </c:forEach>       
                            </select>
                            <label class="form-label" for="txtNombre">USUARIO RESPONSABLE</label>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select id="selectRfc" name="rfc" style="font-weight: bold;" style="font-weight: bold;" value="" data-mdb-select-init class="form-select form-select-sm" aria-label="Default select example" style="font-size: 105%;" onchange="manejarCambioRfc()" required>
                                <option id="encabezadoSelectRfc"  value="" disabled selected style="display: none;" ></option>  
                            </select>
                            <label class="form-label" for="txtNombre">RFC DEL USUARIO RESPONSABLE</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select id="selectPermiso" name="permiso" style="font-weight: bold;" style="font-weight: bold;" value="" data-mdb-select-init class="form-select form-select-sm" aria-label="Default select example" style="font-size: 105%;" required>
                                <option id="encabezadoSelectPermiso" value="" disabled selected style="display: none;" ></option>  
                            </select>
                            <label class="form-label" for="txtNombre">No. DE PERMISO</label>
                        </div>
                    </div>
                   <div class="col">
                            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                                <input type="date" id="fechaGeneracionMeses" name="fechaGeneracionMeses" class="form-control form-select-sm" onchange="obtenerFcaturasMesesAnteriores()"/>
                                <label class="form-label" for="fecha">FECHA DE GENERACIÓN</label>
                            </div>
                   </div>
                </div>
                <div class="row d-flex justify-content-center p-3">
                    <div class="contenedortabla table-responsive">
                        <h6 class="fw-bold">ENCABEZADO DE FACTURAS</h6>
                        <table id="tablaEncabezadoMesesAnteriores" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                            <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">No.R</th>
                                    <th class="fw-bold">Folio</th>
                                    <th class="fw-bold">Serie</th>
                                    <th class="fw-bold">Tipo Comprobante</th>
                                    <th class="fw-bold">R.F.C.</th>
                                    <th class="fw-bold">Cliente</th>
                                    <th class="fw-bold">Lugar Emisión</th>
                                    <th class="fw-bold">Uso Factura</th>
                                    <th class="fw-bold">Fecha Factura</th>
                                    <th class="fw-bold">Hora Factura</th>
                                    <th class="fw-bold">Moneda</th>
                                    <th class="fw-bold">Tipo de cambio</th>
                                    <th class="fw-bold">Forma de Pago</th>
                                    <th class="fw-bold">Cuenta de Banco</th>
                                    <th class="fw-bold">Metodo de Pago</th>
                                    <th class="fw-bold">Condiciones de Pago</th>
                                    <th class="fw-bold">Permiso</th>
                                    <th class="fw-bold">Sub total</th>
                                    <th class="fw-bold">IVA</th>
                                    <th class="fw-bold">Total Factura</th>
                                    <th class="fw-bold">Total en letras</th>
                                    <th class="fw-bold">Usuario responsable</th>
                                    <th class="fw-bold">Fecha de generacion</th>
                                    <th class="fw-bold">estatus</th>
                                    <th class="fw-bold">Concepto Facturacion</th>
                                    <th class="fw-bold">Fecha de pago</th>
                                    <th class="fw-bold">Saldo factura</th>
                                    <th class="fw-bold">Mes de factura</th>
                                    <th class="fw-bold">Tipo de servicio</th>
                                    
                                </tr>
                            
                            </thead>
                            <tbody id="datosEncabezadoMeses" style="font-size: 85%;">
                              <c:forEach var="facturacionesAutomaticasMeses" items="${facturacionesAutomaticasMeses}" varStatus="status">
                                <tr>
                                    <td class="texto-largo">${status.index + 1}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.folio}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.serie}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.tipoComprobante}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.RFC}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.cliente}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.lugarEmision}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.usoFactura}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.fechaFactura}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.horaFactura}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.moneda}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.tipoCambio}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.formaPago}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.cuentaBanco}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.metodoPago}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.condicionesPago}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.noPermiso}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.subTotal}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.IVA}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.totalFactura}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.totalLetra}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.usuarioResponsable}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.fechaGeneracion}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.estatus}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.conceptoFactura}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.fechaPago}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.saldoFactura}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.mesFactura}</td>
                                    <td class="texto-largo">${facturacionesAutomaticasMeses.tipoServicio}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row d-flex justify-content-center p-3">
                    <div class="contenedortabla table-responsive">
                        <h6 class="fw-bold">CONCEPTOS DE FACTURA</h6>
                        <table id="titulo" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                             <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">N.R</th>
                                    <th class="fw-bold">Folio</th>
                                    <th class="fw-bold">Serie</th>
                                    <th class="fw-bold">Fecha Factura</th>
                                    <th class="fw-bold">Renglón</th>
                                    <th class="fw-bold">Producto Servicio</th>
                                    <th class="fw-bold">Cantidad</th>
                                    <th class="fw-bold">Unidad Medida</th>
                                    <th class="fw-bold">Descripcion Unidad Medida</th>
                                    <th class="fw-bold">Precio Unitario</th>
                                    <th class="fw-bold">Importe</th>
                                    <th class="fw-bold">Cuenta Predial</th>
                                    <th class="fw-bold">Concepto</th>
                                </tr>
                            </thead>
                            <tbody id="datosConcetosMeses" style="font-size: 85%;">
                                 <c:forEach var="concepto" items="${detallesMeses}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td>${concepto.folio}</td>
                                            <td>${concepto.serie}</td>
                                            <td>${concepto.fechaFactura}</td>
                                            <td>${concepto.renglon}</td>
                                            <td>${concepto.productoServicio}</td>
                                            <td>${concepto.cantidad}</td>
                                            <td>${concepto.unidadMedida}</td>
                                            <td>${concepto.descripcionUnidadMedida}</td>
                                            <td>${concepto.precioUnitario}</td>
                                            <td>${concepto.importeConcepto}</td>
                                            <td>${concepto.cuentaPredial}</td>
                                            <td>${concepto.concepto}</td>
                                        </tr>
                                       </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row d-flex justify-content-center p-3">
                    <div class="contenedortabla table-responsive">
                        <h6 class="fw-bold">IMPUESTOS DE CONCEPTOS</h6>
                        <table id="titulo" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                            <thead class="table-secondary">
                                <tr>
                                    <th class="fw-bold">N.R</th>
                                    <th class="fw-bold">Folio</th>
                                    <th class="fw-bold">Serie</th>
                                    <th class="fw-bold">Fecha Factura</th>
                                    <th class="fw-bold">Renglón</th>
                                    <th class="fw-bold">Tipo Imp.</th>
                                    <th class="fw-bold">Tipo Factor</th>
                                    <th class="fw-bold">Tasa Imp.</th>
                                    <th class="fw-bold">Imp. Impuesto</th>
                                    <th class="fw-bold">Imp. Tras. Ret.</th>
                                    <th class="fw-bold">Renglón</th>
                                    <th class="fw-bold">Imp. Base</th>
                                </tr>
                            </thead>
                            <tbody id="datosImpuestosMeses" style="font-size: 85%;">
                                 <c:forEach var="impuesto" items="${impuestosMeses}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td>${impuesto.folio}</td>
                                            <td>${impuesto.serie}</td>
                                            <td>${impuesto.fechaFactura}</td>
                                            <td>${status.index + 1}</td>
                                            <td>${impuesto.tipoImpuesto}</td>
                                            <td>${impuesto.tipoFactor}</td>
                                            <td>${impuesto.tasaImpuesto}</td>
                                            <td>${impuesto.importeImpuesto}</td>
                                            <td>${impuesto.impTrasRet}</td>
                                            <td>${impuesto.renglonConcepto}</td>
                                            <td>${impuesto.impuestoBase}</td>
                                        </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div>
                    <div style="justify-content: center; display: flex;">
                        <button type="button" class="btn btn-outline-success btn-sm btn-rounded stc" data-bs-toggle="tooltip" data-bs-placement="top" title="Exportar" onclick="exportTableToExcel('tablaEncabezadoMesesAnteriores','Facturas_meses_ateriores.xlsx')">
                            <i class="bi bi-file-earmark-arrow-down-fill"></i>
                            <span class="btn-text">EXPORTAR</span>
                        </button>
                        <button type="button" style="color:white;background-color: #008A13;" class="stc btn btn-success btn-sm btn-rounded btn-lg" data-bs-toggle="tooltip" data-bs-placement="top" title="Guardar" onclick="guardarFacturasMesesAnteriores()">
                            <i class="bi bi-floppy-fill"></i>
                            <span class="btn-text">GUARDAR</span>
                        </button>
                        <button type="button" class="stc btn btn-dark btn-sm btn-rounded" data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar" id="LimpiarMeses" onclick="limpiarTablasMesesAnteriores()">
                            <i class="bi bi-eraser-fill"></i>
                            <span class="btn-text">LIMPIAR</span>
                        </button>
                        <button hidden type="submit" id="buscarFacurasAtomaticasMeses" class="btn btn-info btn-rounded" name="action" value="buscarInfoMesesAnteriores" data-bs-toggle="tooltip" data-bs-placement="top" title="Filtar">
                            <i class="bi bi-search"></i>
                            <span class="btn-text">BUSCAR</span>
                        </button>
                    </div>
                </div>
            </form>
            </div>
        </div>
        <!-- Tabs content -->
        <br>
</main>
<!-- Modal -->
<div class="modal fade stc" id="staticBackdropModal2" data-mdb-backdrop="static" data-mdb-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabelModal2" aria-hidden="true" style="font-size: 80%;">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabelModal2">MÓDULO DE FACTURACIÓN AUTOMÁTICA</h5>
                <button type="button" class="btn-close" data-mdb-ripple-init data-mdb-dismiss="modal" aria-label="Close" id="closeModalButtonModal2"></button>
            </div>
            <div class="modal-body">INGRESE LA CONTRASEÑA PARA PODER CONTINUAR</div>
            <!-- Dentro de tu modal -->
            <div class="modal-body">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input type="password" id="cntModal2" class="form-control"/>
                    <label class="form-label" for="cntModal2">CONTRASEÑA</label>
                </div>
                <!-- Mensaje de error oculto por defecto -->
                <div id="errorMensajeModal2" style="display: none; color: red; margin-top: 10px;">
                    CONTRASEÑA INCORRECTA
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="passwordSubmitModal2" data-mdb-ripple-init>ENTRAR</button>
            </div>
        </div>
    </div>
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

<!-- Background image -->
</header>
<script>
    // Obtiene la fecha de hoy en el formato YYYY-MM-DD
    
    let fechaGeneracion = document.getElementById('fechaGeneracion')
    let fechaGeneracionMeses = document.getElementById('fechaGeneracionMeses')
    var hoy = new Date().toISOString().split('T')[0];
    // Asigna la fecha de hoy al atributo max del input
    fechaGeneracion.setAttribute('max', hoy);
    fechaGeneracion.setAttribute('min', hoy);
    fechaGeneracionMeses.setAttribute('max', hoy);
    fechaGeneracionMeses.setAttribute('min', hoy);
    
    function toggleSelect() {
        var items = document.querySelector('.select-items');
        items.classList.toggle('visible');
    }

// Función para actualizar el texto del select con las opciones seleccionadas
    document.querySelectorAll('.select-items input[type="checkbox"]').forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            var selectedOptions = Array.from(document.querySelectorAll('.select-items input[type="checkbox"]:checked')).map(function (checkbox) {
                return checkbox.value;
            });
            var selectedText = selectedOptions.length > 0 ? selectedOptions.join(', ') : 'Seleccione los meses a facturar';
            var select = document.querySelector('.select-selected');
            select.textContent = selectedText;
            select.style.width = 'auto';
            var computedStyle = window.getComputedStyle(select);
            var width = parseFloat(computedStyle.getPropertyValue('width'));
            select.style.width = (width + 5) + 'px'; // Adding 5px to account for padding
        });
    });
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        
        

        if(localStorage?.session){
            document.getElementById('passwordSubmitModal2').click();
        }

        document.getElementById('passwordSubmitModal2').addEventListener('click', function () {
            var passwordModal2 = document.getElementById('cntModal2').value; // Cambio de nombre de variable            
   
            if (passwordModal2 === '1234'  || localStorage?.session) {
               
                localStorage.setItem("session", true);
                // Si la contraseña es correcta, cierra el modal
                document.getElementById('errorMensajeModal2').style.display = 'none';
                $('#staticBackdropModal2').modal('hide');
                
            } else {
                localStorage.setItem("session", false);
                // Si la contraseña es incorrecta, muestra el mensaje de error
                document.getElementById('errorMensajeModal2').style.display = 'block';
            }
        });

        // Escuchar el evento de clic en los botones de cerrar para esconder el mensaje de error y potencial redirección
        ['closeModalButtonModal2', 'closeModalButton1Modal2'].forEach(function (buttonId) {
            document.getElementById(buttonId).addEventListener('click', function () {
                localStorage.setItem("session", false);
                document.getElementById('errorMensajeModal2').style.display = 'none'; // Esconde el mensaje de error al intentar cerrar
                window.location.href = 'Srv_FacturacionAutomatica'; // Opcionalmente redirige, dependiendo de tu flujo de usuario
            });
        });
       
        
        
    });
</script>
<script>

</script>
<script>
    function actualizarFechaYHora() {
        var ahora = new Date();
        var fechaHoraString = ahora.toLocaleString('es-ES');
        document.getElementById('datetime').innerHTML = fechaHoraString;
    }
    setInterval(actualizarFechaYHora, 1000); // Actualiza cada segundo
    actualizarFechaYHora(); // Llama a la función para mostrar la fecha y hora inicial

    // Activar tooltips de Bootstrap
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })
</script>
<script>
    // Initialization for ES Users
    import { Modal, Input, Ripple, Tab, initMDB } from "mdb-ui-kit";
    initMDB({Input, Ripple});</script>
                    
<%@include file="../Pie.jsp"%>