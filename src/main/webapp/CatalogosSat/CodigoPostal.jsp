<%-- 
    Document   : cp
    Created on : 1 mar 2024, 14:49:41
    Author     : Lezly Oliván
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@page import="Objetos.obj_CodigoPostal"%>
<%! obj_CodigoPostal codigoPostal;%>
<%! List<obj_CodigoPostal> codigoPostalLista;%>
<%@include file="../Encabezado.jsp"%>
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


</style>
<!-- Cuerpo -->
<main class="col ps-md-2 pt-2 mx-3">
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <div class="page-header pt-3 stc">
        <h3>CATÁLOGO DE CÓDIGOS POSTALES</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;"></div>
    <hr>
    <form action="Srv_CPostal" method="POST" class="fontformulario" id="formulario" style="font-size: 75%; margin: 15px;">
        <!-- 2 column grid layout with text inputs for the first and last names -->
        <div class="row mb-4">
            <div class="col">
                <div data-mdb-input-init class="form-outline">
                    <input type="text" style="font-weight: bold;" list="datalist-estado" name="estado" id="estado" class="form-control" onchange="filterData()" required />
                    <datalist id="datalist-estado">
                        <option value="Aguascalientes"></option>
                        <option value="Baja California"></option>
                        <option value="Baja California Sur"></option>
                        <option value="Campeche"></option>
                        <option value="Coahuila"></option>
                        <option value="Colima"></option>
                        <option value="Chiapas"></option>
                        <option value="Chihuahua"></option>
                        <option value="Ciudad de México"></option>
                        <option value="Durango"></option>
                        <option value="Guanajuato"></option>
                        <option value="Guerrero"></option>
                        <option value="Hidalgo"></option>
                        <option value="Jalisco"></option>
                        <option value="Estado de México"></option>
                        <option value="Michoacán"></option>
                        <option value="Morelos"></option>
                        <option value="Nayarit"></option>
                        <option value="Nuevo León"></option>
                        <option value="Oaxaca"></option>
                        <option value="Puebla"></option>
                        <option value="Querétaro"></option>
                        <option value="Quintana Roo"></option>
                        <option value="San Luis Potosí"></option>
                        <option value="Sinaloa"></option>
                        <option value="Sonora"></option>
                        <option value="Tabasco"></option>
                        <option value="Tamaulipas"></option>
                        <option value="Tlaxcala"></option>
                        <option value="Veracruz"></option>
                        <option value="Yucatán"></option>
                        <option value="Zacatecas"></option>
                    </datalist>
                    <label class="form-label" for="estado">ESTADO</label>
                </div>
            </div>

            <div class="col">
                <input style="font-weight: bold;" class="form-control" type="text" id="idCodigoPostal" name="idCodigoPostal" value="" hidden>
                <div data-mdb-input-init class="form-outline ">
                    <input type="text" style="font-weight: bold;" list="datalist-codigoPostal" id="codigoPostal" name="codigoPostal" class="form-control" maxlength="5" pattern="[0-9]*" title="El valor debe ser un numerico" onchange="actualizarCiudades()" onblur="this.value = this.value.trim()" required />
                    <datalist id="datalist-codigoPostal"></datalist>
                    <label class="form-label" for="codigoPostal">CÓDIGO POSTAL</label>
                </div>
            </div>

            <div class="col">
                <div data-mdb-input-init class="form-outline ">
                    <input type="text" style="font-weight: bold;" list="datalist-ciudad" id="ciudad" name="ciudad" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." onchange="actualizarMunicipio()" onblur="this.value = this.value.trim()" required />
                    <datalist id="datalist-ciudad"></datalist>
                    <label class="form-label" for="ciudad">CIUDAD</label>
                </div>
            </div>
        </div>

        <!-- 2 column grid layout with text inputs for the first and last names -->
        <div class="row mb-4">
            <div class="col">
                <div data-mdb-input-init class="form-outline ">
                    <input type="text" style="font-weight: bold;" list="datalist-municipio" id="municipio" name="municipio" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." onchange="actualizarColonia()" onblur="this.value = this.value.trim()" required />
                    <datalist id="datalist-municipio"></datalist>
                    <label class="form-label" for="municipio">MUNICIPIO / ALCALDÍA</label>
                </div>
            </div>
            <div class="col">
                <div data-mdb-input-init class="form-outline ">
                    <input type="text" style="font-weight: bold;" list="datalist-colonia" id="colonia" name="colonia" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final."  onblur="this.value = this.value.trim()" required />
                    <datalist id="datalist-colonia"></datalist>
                    <label class="form-label" for="colonia">COLONIA</label>
                </div>
            </div>
            <div class="col">
                <div data-mdb-input-init class="form-outline" style="background-color: white;">
                    <input style="font-weight: bold;" type="text" id="estadoSat" name="estadoSat" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." onblur="this.value = this.value.trim()" readonly />
                    <label class="form-label" for="estadoSat">ESTADO SAT</label>
                </div>
            </div>
        </div>
        <br>
        <div style="justify-content: center; display: flex;" class="stc">
            <button type="submit" id="Guardar" value="101" name="action" style="color:white;background-color: #008A13;" class="btn btn-success btn-sm btn-rounded btn-lg" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Guardar">
                <i class="fas fa-floppy-disk"></i>
                <span class="btn-text d-none d-sm-inline">GUARDAR</span>
            </button>
            <button type="submit" id="Modificar" value="102" name="action" style="display: none; color:white; background-color: #0370A7;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Modificar">
                <i class="fas fa-pen-to-square"></i>
                <span class="btn-text d-none d-sm-inline">MODIFICAR</span>
            </button>
            <button type="submit" id="Baja" value="103" name="action" style="display: none; color:white; background-color: #A70303;" class="btn btn-danger btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="Eliminar">
                <i class="fas fa-trash"></i>
                <span class="btn-text d-none d-sm-inline">ELIMINAR</span>
            </button>
            <button type="reset" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="LIMPIAR" id="Limpiar">
                <i class="fas fa-eraser"></i>
                <span class="btn-text d-none d-sm-inline">LIMPIAR</span>
            </button>
        </div>
    </form>

    <!-- Input de búsqueda y botón imprimir -->
    <div class="row d-flex justify-content-center p-3">
        <div class="col-md-3"></div>
        <div class="col-md-3" style="text-align: center;">
            <div data-mdb-input-init class="form-outline">
                <input type="text" id="busqueda" class="form-control form-control-sm" style="font-weight: bold;" />
                <label class="form-label" for="busqueda">BUSCAR</label>
            </div>
        </div>
        <div class="col-md-4" style="text-align: left;">
            <form action="${pageContext.request.contextPath}/Reportes/reportes_catalogos.jsp" id="formulario-impresion" method="post" target="_blank">
                <th>
                    <button type="submit" name="action" value="206" title="IMPRIMIR EN PDF" class="stc btn btn-primary btn-sm btn-rounded" style="color:white; background-color: purple;" data-mdb-ripple-init>
                        <i class="fas fa-print"></i>
                        <span class="d-none d-sm-inline">IMPRIMIR EN PDF</span>
                    </button>
                </th>
            </form>
            <button type="button" id="imprimir-btn" title="EXPORTAR A EXCEL" class="stc btn btn-outline-success btn-sm btn-rounded" data-mdb-ripple-init data-mdb-ripple-color="dark" onclick="exportTableToExcel('codigoPostalTable', 'CodigoPostal.xls')" hidden="true">
                <i class="fas fa-file-excel"></i>
                <span class="d-none d-sm-inline">EXPORTAR A EXCEL</span>
            </button>
        </div>
    </div>

    <!-- Tabla de códigos postales -->
    <div class="row d-flex justify-content-center p-3">
        <div class="text-center fontformulario" style="position: relative; width: 90%;">
            <div class="table-responsive" style="height: 270px;">
                <% 
                     codigoPostalLista = (List<obj_CodigoPostal>) request.getAttribute("cpostlista");
                     int pageSize = 1000;
                     int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                     int startIndex = (currentPage - 1) * pageSize;
                     int endIndex = Math.min(startIndex + pageSize, codigoPostalLista != null ? codigoPostalLista.size() : 0);
                     if (codigoPostalLista != null && codigoPostalLista.size() > 0) {
                %>
                <table id="codigoPostalTable" class="table table-hover table-sm fonthead table-bordered" style="font-size: 90%; background-color: #fff;">
                    <thead class="table-secondary">
                        <tr>
                            <th class="d-none">*</th>
                            <th class="fw-bold">CÓDIGO POSTAL</th>
                            <th class="fw-bold">COLONIA</th>
                            <th class="fw-bold">CIUDAD</th>
                            <th class="fw-bold">MUNICIPIO / ALCALDÍA</th>
                            <th class="fw-bold">ESTADO</th>
                            <th class="fw-bold">ESTADO SAT</th>
                        </tr>
                    </thead>
                    <tbody id="datos" style="font-size: 80%;">
                        <%
                         for (int i = startIndex; i < endIndex; i++) {
                             codigoPostal = codigoPostalLista.get(i);
                        %>
                        <tr>
                            <td class="text-center id-codigo d-none"><%=codigoPostal.getIdCodigo()%></td>
                            <td class="texto-largo"><%=codigoPostal.getCodigo() != null ? codigoPostal.getCodigo() : ""%></td>
                            <td class="texto-largo"><%= codigoPostal.getColonia() != null ? codigoPostal.getColonia() : ""%></td>
                            <td class="texto-largo"><%= codigoPostal.getCiudad() != null ? codigoPostal.getCiudad() : ""%></td>
                            <td class="texto-largo"><%= codigoPostal.getDelegacion() != null ? codigoPostal.getDelegacion() : ""%></td>
                            <td class="texto-largo"><%= codigoPostal.getEstado() != null ? codigoPostal.getEstado() : ""%></td>
                            <td class="texto-largo"><%= codigoPostal.getEstadoSAT() != null ? codigoPostal.getEstadoSAT() : ""%></td>   
                        </tr>
                        <% }%> 
                    </tbody>
                </table>
                <%} else {%>
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
                int totalPages = (int) Math.ceil((double) codigoPostalLista.size() / pageSize);
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
    <%@include file="../Mensaje.jsp"%>
    <!-- Agrega el enlace a la biblioteca html2pdf -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
    <!-- Script para manejar el evento de clic en el botón de impresión -->
    <script>
        
        // Exporta una tabla HTML a excel
        function exportTableToExcel(tableID, filename) {
            if (!filename) filename = 'excel_data.xls';
            let dataType = 'application/vnd.ms-excel';
            let tableSelect = document.getElementById(tableID);
            let tableHTML = tableSelect.outerHTML;
            let tableText = '\uFEFF' + tableHTML;
            let tableData = new Uint8Array(new TextEncoder('utf-16le').encode(tableText));
            let blob = new Blob([tableData], {type: dataType});
            if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                window.navigator.msSaveOrOpenBlob(blob, filename);
            } else {
                let a = document.createElement("a");
                document.body.appendChild(a);
                a.style = "display: none";
                let csvUrl = URL.createObjectURL(blob);
                a.href = csvUrl;
                a.download = filename;
                a.click();
                URL.revokeObjectURL(a.href);
                a.remove();
            }
        }

        const codigoPostalLista = <%= new Gson().toJson(codigoPostalLista) %>;
        
         function resetSelects() {
            const inputs = ['codigoPostal', 'ciudad', 'municipio', 'colonia'];
            inputs.forEach(id => {
                const input = document.getElementById(id);
                const datalist = document.getElementById(`datalist-${id}`);
                input.value = '';
            });
        }

        function filterData() {
            resetSelects();
            validarEstadoSat();
            actualizarCodigosPostales();
        }

        function actualizarLista(idInput, idDatalist, key) {
            let estado = document.getElementById("estado").value;
            estado = estado.toUpperCase();
            const input = document.getElementById(idInput);
            const datalist = document.getElementById(idDatalist);
            datalist.innerHTML = '';
            const uniqueValues = [...new Set(codigoPostalLista
                .filter(cp => cp.estado === estado)
                .map(cp => cp[key])
                .filter(value => value))];
            uniqueValues.forEach(value => {
                const option = document.createElement("option");
                option.value = value;
                datalist.appendChild(option);
            });
        }
        
     function actualizarCodigosPostales() {
        let estado = document.getElementById("estado").value;
        estado = estado.toUpperCase();
        const ciudadesDataList = document.getElementById("datalist-codigoPostal");
        ciudadesDataList.innerHTML = ''; // Limpia todas las opciones del select

        const ciudadesUnicas = [...new Set(codigoPostalLista
                    .filter(cp => cp.estado === estado)
                    .map(cp => cp.codigo)
                    .filter(codigo => codigo))]; // Filtrar ciudades únicas no nulas

        ciudadesUnicas.forEach(ciudad => {
            const option = document.createElement("option");
            option.value = ciudad;
            ciudadesDataList.appendChild(option);
        });
    }


    function actualizarCiudades() {
        let estado = document.getElementById("estado").value;
        estado = estado.toUpperCase();
        const codigoPostal = document.getElementById("codigoPostal").value;
        const ciudadesDataList = document.getElementById("datalist-ciudad");
        ciudadesDataList.innerHTML = '';
        
        const ciudadesUnicas = [...new Set(codigoPostalLista
                    .filter(cp => cp.estado == estado && cp.codigo == codigoPostal)
                    .map(cp => cp.ciudad)
                    .filter(ciudad => ciudad))]; // Filtrar ciudades únicas no nulas
        ciudadesUnicas.forEach(ciudad => {
            const option = document.createElement("option");
            option.value = ciudad;
            ciudadesDataList.appendChild(option);
        });
    }

    function actualizarMunicipio() {
        let estado = document.getElementById("estado").value;
        estado = estado.toUpperCase();
        const codigoPostal = document.getElementById("codigoPostal").value;
        const ciudad = document.getElementById("ciudad").value;
        const municipioDataList = document.getElementById("datalist-municipio");
        municipioDataList.innerHTML = ''; // Limpia todas las opciones del select
        
        const municipiosUnicos = [...new Set(codigoPostalLista
                    .filter(cp => cp.estado == estado && cp.codigo == codigoPostal && cp.ciudad == ciudad)
                    .map(cp => cp.delegacion)
                    .filter(delegacion => delegacion))]; // Filtrar municipios únicos no nulas

        municipiosUnicos.forEach(municipio => {
            const option = document.createElement("option");
            option.value = municipio;
            municipioDataList.appendChild(option);
        });
    }

    function actualizarColonia() {
        let estado = document.getElementById("estado").value;
        estado = estado.toUpperCase();
        const coloniaDataList = document.getElementById("datalist-colonia");
        const codigoPostal = document.getElementById("codigoPostal").value;
        const ciudad = document.getElementById("ciudad").value;
        const municipio = document.getElementById("municipio").value;
        coloniaDataList.innerHTML = ''; // Limpia todas las opciones del select
        
        codigoPostalLista.forEach(data=>{
            if(data.estado == estado && data.codigo == codigoPostal && data.ciudad == ciudad) console.log(data.delegacion)
        })
        
        const coloniasUnicas = [...new Set(codigoPostalLista
                    .filter(cp => cp.estado == estado && cp.codigo == codigoPostal && cp.ciudad == ciudad && cp.delegacion == municipio)
                    .map(cp => cp.colonia)
                    .filter(colonia => colonia))]; // Filtrar colonias únicas no nulas

        coloniasUnicas.forEach(colonia => {
            const option = document.createElement("option");
            option.value = colonia;
            coloniaDataList.appendChild(option);
        });
    }


       

        function validarEstadoSat() {
            let estado = document.getElementById('estado').value;
            estado = estado.toUpperCase();
            const estadoSat = document.getElementById('estadoSat');
            const estadoSatMapping = {
                'AGUASCALIENTES': 'AGU',
                'BAJA CALIFORNIA': 'BCN',
                'BAJA CALIFORNIA SUR': 'BCS',
                'CAMPECHE': 'CAM',
                'COAHUILA': 'COA',
                'COLIMA': 'COL',
                'CHIAPAS': 'CHP',
                'CHIHUAHUA': 'CHH',
                'CIUDAD DE MÉXICO': 'CMX',
                'DURANGO': 'DUR',
                'GUANAJUATO': 'GUA',
                'GUERRERO': 'GRO',
                'HIDALGO': 'HID',
                'JALISCO': 'JAL',
                'ESTADO DE MÉXICO': 'MEX',
                'MICHOACÁN': 'MIC',
                'MORELOS': 'MOR',
                'NAYARIT': 'NAY',
                'NUEVO LEÓN': 'NLE',
                'OAXACA': 'OAX',
                'PUEBLA': 'PUE',
                'QUERÉTARO': 'QUE',
                'QUINTANA ROO': 'ROO',
                'SAN LUIS POTOSÍ': 'SLP',
                'SINALOA': 'SIN',
                'SONORA': 'SON',
                'TABASCO': 'TAB',
                'TAMAULIPAS': 'TAM',
                'TLAXCALA': 'TLA',
                'VERACRUZ': 'VER',
                'YUCATÁN': 'YUC',
                'ZACATECAS': 'ZAC'
            };
            estadoSat.value = estadoSatMapping[estado] || '';
            estadoSat.focus();
        }

        document.addEventListener('DOMContentLoaded', function() {
            const busquedaInput = document.getElementById('busqueda');
            const imprimirBtn = document.getElementById('imprimir-btn');
            const formularioImpresion = document.getElementById('formulario-impresion');

            function handleInput() {
                if (this.value.trim() !== '') {
                    imprimirBtn.removeAttribute('hidden');
                    formularioImpresion.style.display = 'none';
                } else {
                    imprimirBtn.setAttribute('hidden', 'true');
                    formularioImpresion.style.display = 'block';
                }
            }
            busquedaInput.addEventListener('input', handleInput);

            const tabla = document.getElementById('datos');
            const formulario = document.getElementById('formulario');

            tabla.addEventListener('click', function(event) {
                if (event.target.tagName === 'TD') {
                    const fila = event.target.parentNode;
                    if (tabla.querySelector('.selected')) {
                        tabla.querySelector('.selected').classList.remove('selected');
                    }
                    fila.classList.add("selected");

                    document.querySelector('#Guardar').style.display = "none";
                    document.querySelector('#Modificar').style.display = "block";
                    document.querySelector('#Baja').style.display = "block";

                    let idCodigoPostal = fila.querySelector('.id-codigo').innerText;
                    let codigoPostal = fila.querySelector('.texto-largo:nth-child(2)').innerText;
                    let colonia = fila.querySelector('.texto-largo:nth-child(3)').innerText;
                    let ciudad = fila.querySelector('.texto-largo:nth-child(4)').innerText;
                    let municipio = fila.querySelector('.texto-largo:nth-child(5)').innerText;
                    let estado = fila.querySelector('.texto-largo:nth-child(6)').innerText;
                    let estadoSat = fila.querySelector('.texto-largo:nth-child(7)').innerText;

                    formulario.querySelector("#estado").value = estado;
                    filterData();

                    formulario.querySelector("#idCodigoPostal").value = idCodigoPostal;
                    formulario.querySelector("#codigoPostal").value = codigoPostal;
                    formulario.querySelector("#municipio").value = municipio;
                    formulario.querySelector("#ciudad").value = ciudad;
                    formulario.querySelector("#colonia").value = colonia;
                    formulario.querySelector("#estadoSat").value = estadoSat;

                    formulario.querySelector('#codigoPostal').focus();
                    formulario.querySelector('#ciudad').focus();
                    formulario.querySelector('#municipio').focus();
                    formulario.querySelector('#colonia').focus();
                    formulario.querySelector("#estado").focus();
                    formulario.querySelector("#estadoSat").focus();
                }
            });

            document.querySelector('#Limpiar').addEventListener('click', function() {
                document.querySelector('#Guardar').style.display = "block";
                document.querySelector('#Modificar').style.display = "none";
                document.querySelector('#Baja').style.display = "none";
                if (document.querySelector('.selected')) {
                    document.querySelector('.selected').classList.remove('selected');
                }
            });

            document.getElementById('formulario').addEventListener('submit', function(event) {
                let inputs = document.getElementsByTagName('input');
                for (let i = 0; i < inputs.length; i++) {
                    if (inputs[i].type === 'text') {
                        inputs[i].value = inputs[i].value.toUpperCase();
                    }
                }
            });

    $(document).ready(function() {
        var allData = <%= new Gson().toJson(codigoPostalLista) %>;

        function renderTable(data) {
            var tbody = $("#datos");
            tbody.empty();
            $.each(data, function(index, codigoPostal) {
                var row = $("<tr>");
                row.append($("<td>").addClass("text-center id-codigo d-none").text(codigoPostal.idCodigo));
                row.append($("<td>").addClass("texto-largo").text(codigoPostal.codigo || ""));
                row.append($("<td>").addClass("texto-largo").text(codigoPostal.colonia || ""));
                row.append($("<td>").addClass("texto-largo").text(codigoPostal.ciudad || ""));
                row.append($("<td>").addClass("texto-largo").text(codigoPostal.delegacion || ""));
                row.append($("<td>").addClass("texto-largo").text(codigoPostal.estado || ""));
                row.append($("<td>").addClass("texto-largo").text(codigoPostal.estadoSAT || ""));
                tbody.append(row);
            });
        }
        
        function debounce(func, wait) {
            var timeout;
            return function() {
                var context = this, args = arguments;
                clearTimeout(timeout);
                timeout = setTimeout(function() {
                    func.apply(context, args);
                }, wait);
            };
        }

            $("#busqueda").on("keyup", debounce(function() {
                    var value = $(this).val().toLowerCase();
                    var filteredData = allData.filter(function(codigoPostal) {
                        return Object.values(codigoPostal).some(function(val) {
                            return val != null && val.toString().toLowerCase().includes(value);
                        });
                    });
                    renderTable(filteredData);
                },200));

                renderTable(allData.slice(<%= startIndex %>, <%= endIndex %>));
            });

            document.addEventListener("DOMContentLoaded", function() {
                setTimeout(function() {
                    let alerta = document.querySelector("#myAlert");
                    if (alerta) {
                        alerta.style.display = "none";
                    }
                }, 3500);
            });

            window.onload = function() {
                document.getElementById("formulario").reset();
            };
        });
    </script>
    <%@include file="../Pie.jsp"%>
</main>
