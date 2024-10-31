<%-- 
    Document   : ClientesSatDiseño
    Created on : 16 abr 2024, 12:32:14
    Author     : Lezly Olivan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="java.util.List"%>
<%@include file="../Encabezado.jsp"%>
<%@page import="DAO.dao_CltSat"%>
<%! int nocliente;%>
<%@ page import="java.util.List"%>

<%-- PERMISO--%>
<%@page import="Objetos.obj_Permiso"%>
<%! obj_Permiso permiso;%>
<%! List<obj_Permiso> listaPermiso;%>

<%-- REGIMEN FISCAL--%>
<%@page import="Objetos.obj_RegFiscal"%>
<%! obj_RegFiscal regimen;%>
<%! List<obj_RegFiscal> listaRegimen;%>

<%@page import="Objetos.obj_ClientesSAT"%>
<%! obj_ClientesSAT clienteSat;%>
<%! List<obj_ClientesSAT> listaClientesSat;%>

<%-- REFRERENCIAS--%>
<%@page import="Objetos.obj_referenciaPermiso"%>
<%! obj_referenciaPermiso referencia;%>
<%! List<obj_referenciaPermiso> referenciaLista;%>

<%
        System.out.println("---------------------CLIENTES SAT JSP---------------------");
        listaClientesSat = (List<obj_ClientesSAT>) request.getAttribute("cslista");
        // Simulación de obtener datos desde el servidor
        listaPermiso = (List<obj_Permiso>) request.getAttribute("permisolista");
        referenciaLista=(List<obj_referenciaPermiso>) request.getAttribute("referencialista");
        listaRegimen=(List<obj_RegFiscal>) request.getAttribute("rflista");
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

    /* Estilos para el checkbox cuando esta marcado */
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
<head>
    <script src="JS\customeMessage.js"></script>
    <script type="application/json" id="listaClientesSatData">
        <%= new Gson().toJson(listaClientesSat) %>
    </script>
    <script type="application/json" id="listaPermisoData">
        <%= new Gson().toJson(listaPermiso) %>
    </script>
    <script type="application/json" id="referenciaListaData">
        <%= new Gson().toJson(referenciaLista) %>
    </script>
    <script type="application/json" id="regimenListaData">
        <%= new Gson().toJson(listaRegimen) %>
    </script>
    <script src="JS\clientesSat_PermisosReferencias.js"></script>
    <script src="JS\clientesSat_Catalogo.js"></script>
    <script src="JS\clientesSat_ClientesConPermiso.js"></script>
</head>


<main class="col ps-md-2 pt-2 mx-3 ">
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
    
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <div class="page-header pt-3 stc">
        <h3>CLIENTES SAT</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
    <!-- Tabs navs -->
    <ul class="nav nav-tabs nav-justified mb-3 stc" id="ex1" role="tablist">
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link active" id="ex3-tab-1" href="#ex3-tabs-1" role="tab" aria-controls="ex3-tabs-1" aria-selected="true">
                CATÁLOGO DE CLIENTES
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-2" href="#ex3-tabs-2" role="tab" aria-controls="ex3-tabs-2" aria-selected="false">
                CAPTURA DE PERMISO Y REFERENCIA
            </a>
        </li>
        <li class="nav-item" role="presentation" style="display:block;">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-3" href="#ex3-tabs-3" role="tab" aria-controls="ex3-tabs-3" aria-selected="false">
                CLIENTES CON PERMISO
            </a>
        </li>
        <li class="nav-item" role="presentation" style="display:none;">
            <a data-mdb-tab-init class="nav-link" id="ex3-tab-4" href="#ex3-tabs-4" role="tab" aria-controls="ex3-tabs-4" aria-selected="false">
                FACTURAS POR USUARIO
            </a>
        </li>
    </ul>
    <!-- Tabs navs -->

    <!-- Tabs content -->
    <div class="tab-content" id="ex2-content">
        <div class="tab-pane fade show active" id="ex3-tabs-1" role="tabpanel" aria-labelledby="ex3-tab-1">
            <h5 class="stc" style="text-align: center;">CATÁLOGO DE CLIENTES</h5>
            <hr>
            <form action="Srv_CSat" method="POST" id="formulario" class="fontformulario" style="font-size: 80%; margin: 15px;">
                <div class="row mb-4">
                    <%
                       dao_CltSat select=null;
                       select=new dao_CltSat();
                       nocliente=select.ultimo();
                       nocliente=nocliente+1;
                    %>  
                    <div class="col" hidden="true"  >
                        <div data-mdb-input-init class="form-outline "style="background-color: white;">
                            <input type="text"  id="idCliente" name="idCliente" class="form-control" />
                            <input style="font-weight: bold;" type="number" id="numeroCliente" name="numeroCliente" value="<%=nocliente%>" class="form-control" style="font-weight: bold; background-color: white;" required autofocus/>
                            <label class="form-label" for="numeroCliente">No. DE CLIENTE</label>
                        </div>
                    </div>

                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select data-mdb-select-init class="form-select" id="tipoPersona" name="tipoPersona" onchange="getListaRegimen(this.value)" aria-label="Default select example" style="font-size: 105%; font-weight: bold;" required>
                                <option value="" disabled selected style="display: none;" ></option>
                                <option value="FISICA">FISICA</option>
                                <option value="MORAL">MORAL</option>

                            </select>
                            <label class="form-label" for="txtNombre"> TIPO DE PERSONA</label>
                        </div>
                    </div>
                    <script>
                     function getListaRegimen(tipoPersona){
                         console.log("Entra a getListaRegimen con valor: "+tipoPersona)
                        const regimenFiscalSelect = document.getElementById('regimenFiscal');

                        // Limpiar opciones existentes
                        regimenFiscalSelect.innerHTML = '<option value="" disabled selected style="display: none;"></option>';
                        
                        const listaRegimenOriginal = JSON.parse(document.getElementById('regimenListaData').textContent);
                        var cuandoEsSI= listaRegimenOriginal.filter(regimen => regimen.fisica=="SI");
                        var cuandoEsNO= listaRegimenOriginal.filter(regimen => regimen.moral=="SI");
                        // Obtener la lista de régimen fiscal desde el JSON
                       
                         // Obtener la lista de régimen fiscal desde el JSON
                        if (tipoPersona == 'FISICA') {
                            cuandoEsSI.forEach(regimenFiscal => {
                                const option = document.createElement('option');
                                option.value = regimenFiscal.idRegimen;
                                option.textContent = regimenFiscal.claveRegimen + ' - ' + regimenFiscal.descripcionRegimen;
                                regimenFiscalSelect.appendChild(option);
                            });
                        } else if (tipoPersona == 'MORAL') {
                            cuandoEsNO.forEach(regimenFiscal => {
                                const option = document.createElement('option');
                                option.value = regimenFiscal.idRegimen;
                                option.textContent = regimenFiscal.claveRegimen  + ' - ' + regimenFiscal.descripcionRegimen;
                                regimenFiscalSelect.appendChild(option);
                            });
                        }
                         
                     }
                    </script>        
                            
                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select data-mdb-select-init class="form-select" id="regimenFiscal" name="regimenFiscal" aria-label="Default select example" style="font-size: 105%; font-weight: bold;" required>
                            </select>
                            <label class="form-label" for="regimenFiscal">RÉGIMEN FISCAL</label>
                        </div>
                    </div>

                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="rfcCliente" name="rfcCliente" class="form-control" style="font-weight: bold; background-color: white;" oninput="validarRFC()"  pattern="^[A-Za-z&Ñ]{3,4}[0-9]{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[A-Za-z0-9]{3}$" title="El rfc envaido es invalido" required/>
                            <label class="form-label" for="rfcCliente">R.F.C</label>
                        </div>
                        <small id="rfcBancoError" class="error form-text"></small>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="nombreCliente" name="nombreCliente" class="form-control" style="font-weight: bold; background-color: white;" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." required/>
                            <label class="form-label" for="nombreCliente">NOMBRE</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="calle" name="calle" class="form-control " style="font-weight: bold; background-color: white;" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." required/>
                            <label class="form-label" for="calle">CALLE</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="numeroExterior" name="numeroExterior"  class="form-control " style="font-weight: bold; background-color: white;"  pattern="^[1-9]\d*$" title="Por favor, ingrese un número entero positivo." required/>
                            <label class="form-label" for="numeroExterior">No. EXTERIOR</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="numeroInterior" name="numeroInterior" class="form-control " style="font-weight: bold; background-color: white;" />
                            <label class="form-label" for="numeroInterior">No. INTERIOR</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" class="form-control " list="ListaCP" id="colonia" name="colonia" onChange="get_cp()"  value="" placeholder="CP-- Colonia" required/>
                            <input style="font-weight: bold;"  name="codigoPostal" id="codigoPostal" value="" hidden>
                            <label class="form-label" for="codigoPostal">CÓDIGO POSTAL</label>
                        </div> 
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="delegacion" name="delegacion" class="form-control" style="font-weight: bold; background-color: white;" readonly="true"/>
                            <label class="form-label" for="delegacion">ALCALDÍA</label>
                        </div> 
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="estado" name="estado" class="form-control" style="font-weight: bold; background-color: white;" readonly="true"/>
                            <label class="form-label" for="Estado">ESTADO</label>
                        </div> 
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select data-mdb-select-init class="form-select" id="pais" name="pais" aria-label="Default select example" style="font-size: 105%; font-weight: bold;" required>
                               <!-- <option value="" disabled selected style="display: none;"></option>-->
                                <c:forEach var="pais" items="${paislista}">
                                    <option selected value="${pais.idPais}">
                                        ${pais.clavePais} - ${pais.descripcionPais}
                                    </option>
                                </c:forEach>
                            </select>
                            <label class="form-label" for="pais">PAÍS</label>
                            <input type="text" id="idPais" name="idPais" class="form-control" hidden/>
                        </div>
                    </div>

                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="email" id="email" name="email" class="form-control" style="font-weight: bold; background-color: white;"/>
                            <label class="form-label" for="email">CORREO ELECTRÓNICO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="condicionPago" name="condicionPago" class="form-control" style="font-weight: bold; background-color: white;" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final."/>
                            <label class="form-label" for="condicionPago">CONDICIONES DE PAGO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="number" id="cuentaBancaria" min="0" name="cuentaBancaria" onChange="validarCuentaBancaria()" class="form-control" style="font-weight: bold; background-color: white;"/>
                            <label class="form-label" for="cuentaBancaria">Cta. BANCARIA</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="referenciaBancaria" name="referenciaBancaria" class="form-control" style="font-weight: bold; background-color: white;"/>
                            <label class="form-label" for="referenciaBancaria">REFERENCIA BANCARIA (QR PAGO)</label>
                        </div>
                    </div>
                </div>
                <div class="stc" style="justify-content: center; display: flex;">
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
                    <button type="reset" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="LIMPIAR" id="Limpiar"><!--Boton tipo reset-->
                        <i class="bi bi-eraser-fill"></i>
                        <span class="btn-text d-none d-sm-inline">LIMPIAR</span>
                    </button>
                </div>

            </form>
            <div class="row d-flex justify-content-center p-3">
                <div class="col-md-3"></div>
                <div class="col-md-3" style="text-align: center;">
                    <div data-mdb-input-init class="form-outline">
                        <input type="text" id="busqueda" class="form-control form-control-sm" style="font-weight: bold;"
                               style="background-color: white;" />
                        <label class="form-label" for="busqueda">BUSCAR</label>
                    </div>
                </div>
                <div class="col-md-4" style="text-align: left;">
                    <%---TODO: AGREGAR EL VALUE CORRESPONDIENTE AL REPORTE ---%>
                    <form action="${pageContext.request.contextPath}/Reportes/reportes_catalogos.jsp" id="formulario-impresion" method="post" target="_blank">
                        <th><button type="submit" name="action" value="205" title="IMPRIMIR EN PDF" class="stc btn btn-sm btn-rounded" style="color:white; background-color: purple;" data-mdb-ripple-init><i class="bi bi-printer-fill"></i>
                                <span class="d-none d-sm-inline">IMPRIMIR EN PDF</span> </button></th>
                    </form>
                    <button type="button" id="imprimir-btn" title="Imprimir" class="stc btn btn-outline-success btn-sm btn-rounded" data-mdb-ripple-init  data-mdb-ripple-color="dark" onclick="imprimirTabla()" hidden="true">
                        <i class="bi bi-printer-fill"></i>
                        <span class="d-none d-sm-inline">EXPORTAR A EXCEL</span>
                    </button>
                </div>
            </div>
            <br>
            
            <datalist id="ListRFC">
                <% 
                    for(int i = 0; i < listaClientesSat.size(); i++){
                        clienteSat = listaClientesSat.get(i);%> 
                <option data-value="<% out.print(clienteSat.getIdCliente());%>"> <% out.print(clienteSat.getRfc());%></option>
                <% } %>    
            </datalist>

            <datalist id="ListaDelegacion">
                <c:forEach var="codigoPostal" items="${cpostlista}">
                    <option data-value="${codigoPostal.idCodigo}">${codigoPostal.delegacion}</option>
                </c:forEach>
            </datalist>

            <datalist id="ListaEstado">
                <c:forEach var="codigoPostal" items="${cpostlista}">
                    <option data-value="${codigoPostal.idCodigo}">${codigoPostal.estado}</option>
                </c:forEach>
            </datalist>

            <datalist id="ListaCP">
                <c:forEach var="codigoPostal" items="${cpostlista}">
                    <option data-value="${codigoPostal.idCodigo}" value="${codigoPostal.codigo} - ${codigoPostal.colonia}"></option>
                </c:forEach>
            </datalist>

             <div class="row d-flex justify-content-center p-3">
                <div class="text-center" style="position: relative; width: 100%;">
                    <div class="table-responsive" style="height: 270px;">
                        <% 
                            int pageSize = 500;
                            int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                            int startIndex = (currentPage - 1) * pageSize;
                            int endIndex = Math.min(startIndex + pageSize, listaClientesSat != null ? listaClientesSat.size() : 0);
                            if(listaClientesSat != null && listaClientesSat.size() > 0){
                        %>
                        <table id="tablaCatalogoClientes" class="table table-hover fonthead table-bordered table-sm" style="font-size: 70%; background-color: #fff;">
                            <thead class="table-secondary">
                                <tr>
                                    <th class="d-none">*</th>
                                    <th class="fw-bold">N. CLIENTE</th>
                                    <th class="fw-bold">PERSONA</th>
                                    <th class="d-none"> </th>
                                    <th class="fw-bold">RÉGIMEN FISCAL</th>
                                    <th class="fw-bold">R.F.C</th>
                                    <th class="fw-bold">NOMBRE</th>
                                    <th class="fw-bold">CALLE</th>
                                    <th class="fw-bold">No. Ext.</th>
                                    <th class="fw-bold">No. Int.</th>
                                    <th class="d-none"></th>
                                    <th class="fw-bold">C.P. COLONIA</th>
                                    <th class="d-none"> </th>
                                    <th class="fw-bold">PAÍS</th>
                                    <th class="fw-bold">CORREO ELECTRÓNICO</th>
                                    <th class="fw-bold">CONDICIONES DE PAGO</th>
                                    <th class="fw-bold">CUENTA BANCARIA</th>
                                    <th class="fw-bold">REFERENCIA BANCARIA BANCARIA (QR PAGO)</th>
                                </tr>
                            </thead>
                            <tbody id="datos" style="font-size: 80%;">
                                 <%
                                    for (int i = startIndex; i < endIndex; i++) {
                                         clienteSat = listaClientesSat.get(i);
                                 %>
                                <tr>
                                    <td class="text-center id-cliente d-none"><% out.print(clienteSat.getIdCliente());%></td>
                                    <td class="texto-largo"><%out.print(clienteSat.getNumeroCliente());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getTipo());%></td>
                                    <td class="texto-largo d-none"><% out.print(clienteSat.getIdRegimen());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getRegimenFiscal());%></td>
                                    <td class="texto-largo"> <% out.print(clienteSat.getRfc());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getNombreCliente());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getCalle());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getNumeroExterior());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getNumeroInterior());%></td>
                                    <td class="texto-largo d-none"><% out.print(clienteSat.getIdCodigo());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getCodigo());%></td>
                                    <td class="texto-largo d-none"><% out.print(clienteSat.getIdPais());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getPais());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getEmail());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getReferencia());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getCuentaBanco());%></td>
                                    <td class="texto-largo"><% out.print(clienteSat.getCodigoQr());%></td>
                                </tr>
                                <% } %>   
                            </tbody>
                        </table>
                        <%}else{%>
                        <center>
                            <BR>
                            <h3 class="text-center metro" style="color:#970000;">
                                <b> 
                                    N O  <span style="padding-left:40px;"> </span> 
                                    H A Y <span style="padding-left:40px;"> </span> 
                                    R E G I S T R O S
                                </b>
                            </h3>
                        </center>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <!-- Paginación -->
            <div class="row">
                <div class="col-md-12 text-center">
                    <ul class="pagination justify-content-center">
                        <% if (currentPage > 1) { %>
                        <li class="page-item">
                            <a class="page-link" href="?page=<%= currentPage - 1 %>">Anterior</a>
                        </li>
                        <% } else { %>
                        <li class="page-item disabled">
                            <a class="page-link" href="#">Anterior</a>
                        </li>
                        <% } %>
                        <% 
                        int totalPages = (int) Math.ceil((double) listaClientesSat.size() / pageSize);
                        for (int i = 1; i <= totalPages; i++) { 
                        %>
                        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                            <a class="page-link" href="?page=<%= i %>"><%= i %></a>
                        </li>
                        <% } %>
                        <% if (currentPage < totalPages) { %>
                        <li class="page-item">
                            <a class="page-link" href="?page=<%= currentPage + 1 %>">Siguiente</a>
                        </li>
                        <% } else { %>
                        <li class="page-item disabled">
                            <a class="page-link" href="#">Siguiente</a>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>
           
        </div>

        <div class="tab-pane fade" id="ex3-tabs-2" role="tabpanel" aria-labelledby="ex3-tab-2">
            <h5 class="stc" style="text-align: center;">CAPTURA DE PERMISOS Y REFERENCIA BANCARIA QR</h5>
            <hr>
            <form method="POST" id="formularioPermiso" style="font-size: 75%; margin: 15px;">
                <div class="row mb-4">
                    <div class="col">
                        <input type="text"  id="idPermisoReferenciaBancaria" name="idPermisoReferenciaBancaria" class="form-control" value="" hidden="true"/>
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="rfcArrendatario" name="rfcArrendatario" value="" class="form-control" style="font-weight: bold; background-color: white;" readonly/>
                            <label class="form-label" for="rfcArrendatario">R. F. C.</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="nombreArrendatario" name="nombreArrendatario" value=""  class="form-control" style="font-weight: bold; background-color: white;" readonly/>
                            <label class="form-label" for="nombreArrendatario">NOMBRE</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select data-mdb-select-init class="form-select" id="select-permiso" name="permiso" aria-label="Default select example" onchange="actualizarConsecutivos()" style="font-size: 105%; font-weight: bold;" required>
                                <option value="" disabled selected style="display: none;"></option>
                            </select>
                            <label class="form-label" for="select-permiso">PERMISO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select data-mdb-select-init class="form-select" id="select-numero" name="numeroConcepto" aria-label="Default select example" onchange="actualizarDescripcion()" style="font-size: 105%; font-weight: bold;" required>
                                <option value="" disabled selected style="display: none;"></option>
                            </select>
                            <label class="form-label" for="select-numero">No. CONCEPTO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select data-mdb-select-init class="form-select" id="select-descripcion" name="descripcionConcepto" aria-label="Default select example" style="font-size: 105%; font-weight: bold;" required>
                                <option value="" disabled selected style="display: none;"></option>
                            </select>
                            <label class="form-label" for="select-descripcion">DESCRIPCIÓN DE CONCEPTO</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="referenciaqr" name="referenciaqr" class="form-control" style="font-weight: bold; background-color: white;"/>
                            <label class="form-label" for="referenciaqr">REFERENCIA BANCARIA QR</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="numeroPART" name="numeroPART" class="form-control" style="font-weight: bold; background-color: white;"/>
                            <label class="form-label" for="numeroPART">No. P.A.T.R.</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="date" id="iniciaVigencia" name="iniciaVigencia" class="form-control" style="font-weight: bold; background-color: white;" value="" required/>
                            <label class="form-label" for="iniciaVigencia">INICIA VIGENCIA</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="date" id="finVigencia" name="finVigencia" class="form-control" style="font-weight: bold; background-color: white;" value="" required/>
                            <label class="form-label" for="finVigencia">FIN VIGENCIA</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">                            
                            <input style="font-weight: bold;" type="text" list="ListUsuarios" id="usuarioResponsable" onfocus="validarFechas()" name="usuarioResponsable" onChange="get_validarUsuario()" class="form-control" required />
                            <datalist id="ListUsuarios">
                                <c:forEach var="usuario" items="${usuarios}">
                                    <option data-value="${usuario.id}" value="${usuario.nombre}"></option>
                                </c:forEach>
                            </datalist>
                            <label class="form-label" for="usuarioResponsable">USUARIO RESPONSABLE</label>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-outline mdb-input">
                            <select data-mdb-select-init class="form-select" id="sefactura" name="sefactura" aria-label="Default select example" style="font-size: 105%; font-weight: bold;" required>
                              <option value="" disabled selected style="display: none;"></option>
                              <option value="S">SI</option>
                              <option value="N">NO</option>
                            </select>
                            <label class="form-label" for="sefactura">¿SE FACTURA?</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="importeConcepto" name="importeConcepto" class="form-control" style="font-weight: bold; background-color: white;" pattern="\d+(\.\d{1,2})?" title="Debe ser un número positivo con dos decimales" onblur="calcularImportes()" required/>
                            <label class="form-label" for="importeConcepto">IMPORTE DE CONCEPTO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="importeIva" name="importeIva" class="form-control" style="font-weight: bold; background-color: white;" required/>
                            <label class="form-label" for="importeIva">IMPORTE I.V.A.</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input type="text" id="importeRenta" name="importeRenta" class="form-control" style="font-weight: bold; background-color: white;" required/>
                            <label class="form-label" for="importeRenta">IMPORTE RENTA</label>
                        </div>
                    </div>
                </div>

                <div class="stc" style="justify-content: center; display: flex;">
                    <button type="button" onclick="insertRow()" class="btn btn-sm btn-rounded btn-lg" style="color:white;background-color: #0370A7;" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Insertar en tabla" id="Guardar_permisos" value="101" name="action">
                        <i class="fa-solid fa-right-to-bracket"></i>
                        <span class="btn-text d-none d-sm-inline">INSERTAR EN TABLA</span>
                    </button>
                    <button type="button" onclick="sendData('101')" class="btn btn-sm btn-rounded" style="color:white; background-color: #008A13;" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Enviar Datos" name="action" >
                        <i class="fas fa-floppy-disk"></i>
                        <span class="btn-text d-none d-sm-inline">GUARDAR PERMISOS</span>
                    </button>
                    <button type="reset" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar" id="limpiarPermisos"><!--Boton tipo reset-->
                        <i class="fas fa-eraser"></i>
                        <span class="btn-text d-none d-sm-inline">Limpiar</span>
                    </button>
                </div>
            </form>
       
                
            <br>

            <div class="row d-flex justify-content-center p-3">
                <div class="col-md-4" style="text-align: left;">
                    <h5 class="stc mx-4">PERMISOS DE ARRENDATARIO</h5>
                </div>
                <div class="col-md-5">
                    
                </div>
                <div class="col-md-3" style="text-align: right;">
                    <button style="color: #008A13;background-color: white;" onclick="exportTableToExcel('permisosReferencias', 'PermisosConReferencias.xls')" class="btn stc btn-outline-success btn-sm btn-rounded" data-mdb-ripple-init  data-mdb-ripple-color="dark">
                        <i class="fas fa-file-excel"></i>
                        <span class="btn-text d-none d-sm-inline">EXPORTAR A EXCEL</span>
                    </button>
                </div>
            </div>
                  <!--INSERT INTO ejemplo_mes (mes) VALUES (LPAD(MONTH(NOW()), 2, '0')); -->
            
            <div class="row d-flex justify-content-center p-3">
                <div class="table-responsive">
                    <table id="permisosReferencias" class="table table-hover fontformulario fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff; overflow-x: auto; overflow-y: auto; max-height: 400px; max-width: 100%; ">
                        <thead class="table-secondary">
                            <tr>
                                <th class="fw-bold">RENGLON</th>
                                <th class="fw-bold">R.F.C.</th>
                                <th class="fw-bold">NOMBRE</th>
                                <th class="fw-bold">PERMISO</th>
                                <th class="fw-bold">CONSECUTIVO</th>
                                <th class="fw-bold">CONCEPTO</th>
                                <th class="fw-bold">REFERENCIA BANCARIA</th>
                                <th class="fw-bold">No. P.A.T.R.</th>
                                <th class="fw-bold">INICIO VIDENCIA</th>
                                <th class="fw-bold">FIN VIGENCIA</th>
                                <th class="fw-bold">USUARIO RESPOSABLE</th>
                                <th class="fw-bold">¿SE FACTURA?</th>
                                <th class="fw-bold">IMPORTE CONCEPTO</th>
                                <th class="fw-bold">IMPORTE I.V.A.</th>
                                <th class="fw-bold">IMPORTE RENTA</th>
                                <th class="fw-bold">ELIMINAR</th>
                            </tr>
                        </thead>
                        <tbody id="datos-permisos" style="font-size: 80%;">
                        </tbody>
                    </table>
                    <center  id="no-records-message">
                        <BR>
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
                    
<div class="tab-pane fade" id="ex3-tabs-3" role="tabpanel" aria-labelledby="ex3-tab-3">
            <h5 class="stc" style="text-align: center;">CLIENTES CON PERMISO</h5>
            <hr>
            <div style="justify-content: center; display: flex;">
                <button onclick="insertClientesconPermiso()" style="color:#0370A7; background-color: white;" class="btn stc btn-outline-primary btn-sm btn-rounded" data-mdb-ripple-init  data-mdb-ripple-color="dark">
                    <i class="fas fa-table-list"></i>
                    <span class="btn-text d-none d-sm-inline">LLENAR CLIENTES</span>
                </button>
                <button id="limpiarClientesConPermiso" onclick="limpiarTabla('datos-clientes-permisos')" class="btn stc btn-outline-dark btn-sm btn-rounded" data-mdb-ripple-init data-mdb-ripple-color="dark">
                    <i class="fas fa-eraser"></i>
                    <span class="btn-text d-none d-sm-inline">LIMPIAR TABLA</span>
                </button>
                <button style="color: #008A13;background-color: white;" onclick="exportTableToExcel('ClientesConPermisos', 'ClientesConPermiso.xls')" class="btn stc btn-outline-success btn-sm btn-rounded" data-mdb-ripple-init  data-mdb-ripple-color="dark">
                    <i class="fas fa-file-excel"></i>
                    <span class="btn-text d-none d-sm-inline">EXPORTAR A EXCEL</span>
                </button>
                
            </div>
            <br>
            <div class="row d-flex justify-content-center p-3">
                <div class="table-responsive" style="height: 500px;">
                    <table id="ClientesConPermisos" class="table table-hover fonthead table-bordered table-sm" style="font-size: 80%; background-color: #fff;">
                        <thead class="table-secondary">
                            <tr>
                                <th class="fw-bold">RENGLÓN</th>
                                <th class="fw-bold">PERMISO</th>
                                <th class="fw-bold">NÚMERO PERMISO</th>
                                <th class="fw-bold">CONCEPTO</th>
                                <th class="fw-bold">REFERENCIA QR</th>
                                <th class="fw-bold">PATR</th>
                                <th class="fw-bold">INICIO VIGENCIA</th>
                                <th class="fw-bold">FIN VIGENCIA</th>
                                <th class="fw-bold">SE FACTURA</th>
                                <th class="fw-bold">USUARIO RESPONSABLE</th>
                                <th class="fw-bold">IMPORTE</th>
                                <th class="fw-bold">IVA</th>
                                <th class="fw-bold">RENTA</th>
                                <th class="fw-bold">N. CLIENTE</th>
                                <th class="fw-bold">PERSONA</th>
                                <th class="fw-bold">RÉGIMEN FISCAL</th>
                                <th class="fw-bold">R.F.C</th>
                                <th class="fw-bold">NOMBRE</th>
                                <th class="fw-bold">CALLE</th>
                                <th class="fw-bold">No. Ext.</th>
                                <th class="fw-bold">No. Int.</th>
                                <th class="fw-bold">C.P. COLONIA</th>
                                <th class="fw-bold">PAÍS</th>
                                <th class="fw-bold">CORREO ELECTRÓNICO</th>
                                <th class="fw-bold">CONDICIONES DE PAGO</th>
                                <th class="fw-bold">CUENTA BANCARIA</th>
                            </tr>
                        </thead>
                        <tbody id="datos-clientes-permisos"  style="font-size: 85%;">
                        </tbody>
                    </table>
                </div>
            </div>
            <br>
</div>
                    
                    
                    
                    
        <div class="tab-pane fade" id="ex3-tabs-4" role="tabpanel" aria-labelledby="ex3-tab-4">
            <h5 style="text-align: center;">Clientes con Permiso</h5>
            <hr>
            <div class="row mb-4">
                <div class="col-auto">
                    <input class="form-check-input" type="checkbox" id="checkboxNoLabel" value="" aria-label="..." />
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" id="form6Example1" class="form-control" style="font-weight: bold; background-color: white;"/>
                        <label class="form-label" for="form6Example1">R F C</label>
                    </div>
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" id="form6Example1" class="form-control" style="font-weight: bold; background-color: white;"/>
                        <label class="form-label" for="form6Example1">Nombre</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col-auto">
                    <input class="form-check-input" type="checkbox" id="checkboxNoLabel" value="" aria-label="..." />
                </div>
                <div class="col">
                    <div data-mdb-input-init class="form-outline" style="background-color: white;">
                        <input type="text" id="form6Example1" class="form-control" style="font-weight: bold; background-color: white;"/>
                        <label class="form-label" for="form6Example1">Permiso</label>
                    </div>
                </div>
                <div class="col">
                    <select data-mdb-select-init class="form-select" aria-label="Default select example" style="font-size: 105%; font-weight: bold;">
                        <option selected>No. Concepto</option>
                        <option value="1">One</option>
                        <option value="2">Two</option>
                        <option value="3">Three</option>
                        <option value="4">Four</option>
                        <option value="5">Five</option>
                        <option value="6">Six</option>
                        <option value="7">Seven</option>
                        <option value="8">Eight</option>
                    </select>
                </div>
                <div class="col">
                    <select data-mdb-select-init class="form-select" aria-label="Default select example" style="font-size: 105%; font-weight: bold;">
                        <option selected>Se Factura?</option>
                        <option value="1">S</option>
                        <option value="2">N</option>
                    </select>
                </div>
            </div>
            <div style="justify-content: center; display: flex;">
                <button class="btn btn-outline-success btn-sm btn-rounded" data-mdb-ripple-init  data-mdb-ripple-color="dark">
                    <i class="fas fa-file-excel"></i>
                    <span class="btn-text d-none d-sm-inline">Cargar</span>
                </button>
                <button type="reset" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar" id="Limpiar"><!--Boton tipo reset-->
                    <i class="bi bi-eraser-fill"></i>
                    <span class="btn-text d-none d-sm-inline">Limpiar</span>
                </button>
            </div>
            <h5>Permisos de Arrendatario</h5>
            <div class="row d-flex justify-content-center p-3">
                <div class="contenedortabla table-responsive">
                    <table id="titulo" class="table table-hover fonthead table-bordered table-sm" style="font-size: 90%; background-color: #fff;">
                        <thead class="table-dark">
                            <tr>
                                <th>Renglón</th>
                                <th>R.F.C.</th>
                                <th>Permiso</th>
                                <th>No. Concepto</th>
                                <th>Se Factura?</th>
                            </tr>
                        </thead>
                        <tbody style="font-size: 85%;">
                            <tr> 
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    <center>
                        <BR>
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
            <div style="justify-content: center; display: flex;">
                <button type="submit" class="btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Guardar" id="Guardar" value="Guardar" name="action">
                    <i class="bi bi-floppy-fill"></i>
                    <span class="btn-text d-none d-sm-inline">Guardar</span>
                </button>
            </div>
        </div>
    </div>
</main>
<%@include file="../Pie.jsp"%>
