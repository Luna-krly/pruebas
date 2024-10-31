<%-- 
    Document   : JSP_Autorizaciones
    Created on : 7/06/2023, 12:36:41 PM
    Author     : Ing. Evelyn Leilani Avendaño 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@include file="../Encabezado.jsp"%>
<%--MENSAJE DE ERROR--%>
<%@include file="../Mensaje.jsp"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<%-- FACTURAS--%>
<%@page import="Objetos.obj_Autorizacion"%>
<%! obj_Autorizacion autorizacion;%>
<%! List<obj_Autorizacion> listaAutorizaciones;%>


<%
    System.out.println("---------------------AUTORIZACIONES JSP---------------------");
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
</style>

<!-- Cuerpo -->
<main class="col ps-md-2 pt-2 mx-3">
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <div class="page-header pt-3 stc">
        <h3>AUTORIZACIÓN DE FACTURAS</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
    <form action="Srv_Autorizacion" method="POST" id="formulario" class="fontformulario" style="font-size: 80%; margin: 15px;">
        <h5 class="fw-bold" style="text-align: center;">FACTURA PARA AUTORIZAR</h5>
        <br>
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <input hidden="true" type="text" id="id"  name="id" class="form-control form-control-sm" />
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="folio"  name="folio" class="form-control" readOnly/>
                            <label class="form-label" for="folio">FOLIO</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="serie"  name="serie" class="form-control" readOnly/>
                            <label class="form-label" for="serie">SERIE</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="fecha" name="fecha" class="form-control" readOnly/>
                            <label class="form-label" for="fecha">FECHA</label>
                        </div>
                    </div>
                    <div class="col">
                        <div data-mdb-input-init class="form-outline" style="background-color: white;">
                            <input style="font-weight: bold;" type="text" id="importe" name="importe" class="form-control" readOnly/>
                            <label class="form-label" for="importe">IMPORTE</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <div class="stc" style="justify-content: center; display: flex;">
            <button type="submit" name="action" value="revisar" class="btn btn-sm btn-outline-dark btn-rounded" data-bs-toggle="tooltip" data-bs-placement="top" title="Revisar Factura">
                <i class="bi bi-file-binary-fill"></i>
                <span class="btn-text">REVISAR FACTURA</span>
            </button>
            <button type="submit" name="action" value="autorizar" style="color:white; background-color: #0370A7;" class="stc btn btn-primary btn-sm btn-rounded" data-bs-toggle="tooltip" data-bs-placement="top" title="Autorizar">
                <i class="bi bi-file-earmark-check-fill"></i>
                <span class="btn-text">AUTORIZAR</span>
            </button>
            <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-bs-toggle="tooltip" data-bs-placement="top" title="Limpiar">
                <i class="bi bi-eraser-fill"></i>
                <span class="btn-text">LIMPIAR</span>
            </button>
        </div>
    </form>    
    <br>
    <!--Input de Busqueda y boton imprimir-->
    <div class="row d-flex justify-content-center p-2 ">
        <div class="col-md-3" style="text-align: center;">
            <div data-mdb-input-init class="form-outline fontformulario">
                <input type="text" id="busqueda" class="form-control form-control-sm" style="font-weight: bold;"
                       style="background-color: white;" />
                <label class="form-label" for="busqueda">BUSCAR</label>
            </div>
        </div>
        <div class="col-md-2">
            <div class="form-outline mdb-input">
                <select style="font-weight: bold;" class="form-control form-control-sm" onchange="filtraSerie(this.value)" data-mdb-select-init class="form-select form-select-sm" name="serieFiltrar" id="serieFiltrar" aria-label="Default select example" style="font-size: 105%;">
                    <option value="" disabled selected style="display: none;"></option>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="NC">NC</option>
                    <option value="ALL">TODAS</option>
                </select>
                <label class="form-label" for="serieFiltrar">SERIE</label>
            </div>
        </div>
    </div>

    <div class="row d-flex justify-content-center p-3">
        <h5 class="fw-bold">LISTADO DE FACTURAS POR AUTORIZAR</h5>
        <div class="text-center" style="position: relative; width: 100%;">
            <div class="table-responsive" style="height: 270px;">
                <table class="table table-hover fonthead table-bordered table-sm" style="font-size: 95%; background-color: #fff;">
                    <thead class="thead-dark">
                        <tr>
                            <th class="d-none">*</th>
                            <th class="fw-bold">SERIE</th>
                            <th class="fw-bold">FOLIO</th>
                            <th class="fw-bold">FECHA FACTURA</th>
                            <th class="fw-bold">IMPORTE</th>
                            <th class="fw-bold">USUARIO GENERA</th>
                        </tr>
                    </thead>
                    <tbody id="datos" style="font-size: 80%;">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <br>
</main>
<%
    listaAutorizaciones = (List<obj_Autorizacion>) request.getAttribute("autorizarLista");
    ObjectMapper mapper = new ObjectMapper();
    String csJson = mapper.writeValueAsString(listaAutorizaciones);
%>

<script  type="text/javascript">
    var listaJSON = <%= csJson %>;
    // Obtener la referencia al cuerpo de la tabla
    var tbody = document.getElementById("datos");

    function llenarTablaSerie(value) {
        tbody.innerHTML = "";
        // Recorrer la lista de autorizaciones
        listaJSON.forEach(function (autorizacion) {
            // Comprobar si la serie es igual al valor dado
            if (autorizacion.serie === value && autorizacion.estatus === 'X') {
                // Crear una nueva fila
                var row = document.createElement("tr");
                // Crear y agregar celdas a la fila
                var idCell = document.createElement("td");
                idCell.className = "d-none";
                idCell.textContent = autorizacion.id; // Cambia "serie" por el nombre de la propiedad en tu objeto
                row.appendChild(idCell);

                // Crear y agregar celdas a la fila
                var serieCell = document.createElement("td");
                serieCell.className = "texto-largo";
                serieCell.textContent = autorizacion.serie; // Cambia "serie" por el nombre de la propiedad en tu objeto
                row.appendChild(serieCell);

                var folioCell = document.createElement("td");
                folioCell.className = "texto-largo";
                folioCell.textContent = autorizacion.folio; // Cambia "folio" por el nombre de la propiedad en tu objeto
                row.appendChild(folioCell);

                var fechaCell = document.createElement("td");
                fechaCell.className = "texto-largo";
                fechaCell.textContent = autorizacion.fecha; // Cambia "fechaFactura" por el nombre de la propiedad en tu objeto
                row.appendChild(fechaCell);

                var importeCell = document.createElement("td");
                importeCell.className = "texto-largo";
                importeCell.textContent = autorizacion.importe; // Cambia "importe" por el nombre de la propiedad en tu objeto
                row.appendChild(importeCell);

                var usuarioCell = document.createElement("td");
                usuarioCell.className = "texto-largo";
                usuarioCell.textContent = autorizacion.usuarioGenero; // Cambia "usuarioGenera" por el nombre de la propiedad en tu objeto
                row.appendChild(usuarioCell);

                // Agregar la fila al cuerpo de la tabla
                tbody.appendChild(row);
            }
        });
    }

    function llenarTabla() {
        tbody.innerHTML = "";
        // Recorrer la lista de autorizaciones
        listaJSON.forEach(function (autorizacion) {
            // Validar si el estatus es "X"
            if (autorizacion.estatus === 'X') {
                // Crear una nueva fila
                var row = document.createElement("tr");

                // Crear y agregar celdas a la fila
                var idCell = document.createElement("td");
                idCell.className = "d-none";
                idCell.textContent = autorizacion.id;
                row.appendChild(idCell);

                var serieCell = document.createElement("td");
                serieCell.className = "texto-largo";
                serieCell.textContent = autorizacion.serie;
                row.appendChild(serieCell);

                var folioCell = document.createElement("td");
                folioCell.className = "texto-largo";
                folioCell.textContent = autorizacion.folio;
                row.appendChild(folioCell);

                var fechaCell = document.createElement("td");
                fechaCell.className = "texto-largo";
                fechaCell.textContent = autorizacion.fecha;
                row.appendChild(fechaCell);

                var importeCell = document.createElement("td");
                importeCell.className = "texto-largo";
                importeCell.textContent = autorizacion.importe;
                row.appendChild(importeCell);

                var usuarioCell = document.createElement("td");
                usuarioCell.className = "texto-largo";
                usuarioCell.textContent = autorizacion.usuarioGenero;
                row.appendChild(usuarioCell);

                // Agregar la fila al cuerpo de la tabla
                tbody.appendChild(row);
            }
        });

    }
    window.onload = llenarTabla;


    function filtraSerie(value) {
        if (value == 'ALL') {
            llenarTabla();
        } else {
            llenarTablaSerie(value);
        }
    }


</script>
<%@include file="../Pie.jsp"%>

<script  type="text/javascript">
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
    //*********Toma datos de tabla para moverlos arriba y cambiar los botones 
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

                // Obtener los datos de la fila
                let id = fila.querySelector('.d-none:nth-child(1)').innerText;
                let serie = fila.querySelector('.texto-largo:nth-child(2)').innerText;
                let folio = fila.querySelector('.texto-largo:nth-child(3)').innerText;
                let fecha = fila.querySelector('.texto-largo:nth-child(4)').innerText;
                let importe = fila.querySelector('.texto-largo:nth-child(5)').innerText;


                // Ingresa los valores a los cuadros de texto
                formulario.querySelector("#id").value = id;
                formulario.querySelector("#folio").value = folio;
                formulario.querySelector("#serie").value = serie;
                formulario.querySelector("#fecha").value = fecha;
                formulario.querySelector("#importe").value = importe;

                formulario.querySelector("#id").blur();
                formulario.querySelector("#folio").blur();
                formulario.querySelector("#serie").blur();
                formulario.querySelector("#fecha").blur();
                formulario.querySelector("#importe").blur();
                formulario.querySelector("#id").focus();
                formulario.querySelector("#folio").focus();
                formulario.querySelector("#serie").focus();
                formulario.querySelector("#fecha").focus();
                formulario.querySelector("#importe").focus();
            }
        });
    });


    //*****************Funcion limpiar para quitar boton y estiñps en tabla 
    document.addEventListener('DOMContentLoaded', function () {
        // Agregar el event listener para el botón de limpiar
        document.querySelector('#Limpiar').addEventListener('click', function () {
            document.getElementById("id").blur();
            document.getElementById("folio").blur();
            document.getElementById("serie").blur();
            document.getElementById("fecha").blur();
            document.getElementById("importe").blur();

            if (document.querySelector('.selected')) {
                document.querySelector('.selected').classList.remove('selected');
            }
        });
    });
    //*******************************************************************


</script>



