<%-- 
    Document   : AdminUsuarios
    Created on : 13 feb 2024, 13:21:19
    Author     : Ing. Evelyn Leilani AvendaÃ±o 
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../Encabezado.jsp"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="Objetos.Obj_Admin_usuario"%>
<%@page import="Objetos.obj_Mensaje"%>
<%@page import="Objetos.obj_Area"%>
<%@page import="Objetos.obj_Perfil"%>
<%! obj_Mensaje mensaje;%>
<%! obj_Perfil perfil;%>
<%! obj_Area area;%>
<%! Obj_Admin_usuario admin;%>
<%! List<Obj_Admin_usuario> admuser;%>
<%! List<obj_Area> listaAreas;%>
<%! List<obj_Perfil> listaPerfil;%>
<%
    // Obtener las listas desde los atributos del request
   admuser  =(List<Obj_Admin_usuario>)request.getAttribute("lista");
   listaAreas = (List<obj_Area>) request.getAttribute("listaAreas");
   listaPerfil = (List<obj_Perfil>) request.getAttribute("listaPerfil");
   %>
 
 
   <% 
    mensaje = (obj_Mensaje) session.getAttribute("mensaje");
    if (mensaje != null) {
        System.out.println("Hay un mensaje en mensaje.jsp");
        if(mensaje.getTipo() == true) { 
%>
            <div id="mensajeAlert" class="alert alert-success" role="alert" style="width:30rem; margin: 0 auto;margin-top: 3rem;">
                <% out.print(mensaje.getTitulo()); %>
                <% out.print(mensaje.getDescripcion()); %>
            </div>
<%      } else { %>


<div id="mensajeAlert" class="alert alert-danger" role="alert" style="width:30rem; margin: 0 auto;margin-top: 3rem;"><% out.print(mensaje.getTitulo()); %>
    <% out.print(mensaje.getDescripcion()); %></div>
    
<%      }
    }
%>
<% 
System.out.print("----------------------------------------Entrendo al JSP de Admin----------------------------");
%>


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

    .fila-seleccionada {
        background-color: #ff5000 !important;
        color: white; /* Cambia el color del texto si es necesario */
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
        <h3>ADMINISTRACION DE USUARIOS</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;"></div>
    <hr>
<form id="formulario" action="Srv_Administrar_usr" method="POST" onsubmit="return AdministrarUsuario()" id="formulario" class="fontformulario" style="font-size: 80%; margin: 15px;">
    <div class="row mb-4">
           <div class="col">
    <div data-mdb-input-init class="form-outline" style="background-color: white;">
        <input type="text" style="font-weight: bold;" id="usuario" name="usuario" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." onblur="this.value = this.value.trim()"/>
        <label class="form-label" for="usuario">USUARIO</label>
    </div>
           </div>
        <div class="col">
             <div data-mdb-input-init class="form-outline" style="background-color: white;">
                <input type="text" style="font-weight: bold;" id="nombre" name="nombre" class="form-control"  pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." style="font-weight: bold;" onblur="this.value = this.value.trim()" required />
                <label class="form-label" for="nombre">NOMBRE</label>
             </div>
        </div>
        
        <div class="col mb-3">
            <div data-mdb-input-init class="form-outline" style="background-color: white;">
                <input type="text" style="font-weight: bold;" id="apellido_paterno" name="apaterno" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." onblur="this.value = this.value.trim()" required/>
                <label class="form-label" for="apellido_paterno">APELLIDO PATERNO</label>
            </div>
        </div>
        <div class="col mb-3">
            <div data-mdb-input-init class="form-outline " style="background-color: white;">
                <input type="text" style="font-weight: bold;" id="apellido_materno" name="amaterno" class="form-control" pattern="^(?!\s)[^\s]+(?:\s[^\s]+)*(?<!\s)$" title="El campo debe contener solo letras y no espacios al principio o al final." onblur="this.value = this.value.trim()" required/>
                <label class="form-label" for="apellido_materno">APELLIDO MATERNO</label>
            </div>
        </div>
    </div>
    <!-- Email input -->
    <div class="col mb-3">
         <div data-mdb-input-init class="form-outline mb-4" style="background-color: white;">
            <input type="email" style="font-weight: bold;" id="email" name="correo" class="form-control" onblur="this.value = this.value.trim()" required/>
            <label class="form-label" for="email">CORREO ELECTRONICO</label>
         </div>
     </div>
    <!-- Email input -->
    <!-- AQUI IRAN LOS SELECT DE AREA Y PERFIL ASI COMO EL INPUT DE USUARIO-->
     <div class="row mb-4">
         <div class="col">  
   <div class="form-outline mdb-input">
                         <select style="font-weight: bold;" style="font-weight: bold;" value="" id="area" name="id_area" class="form-select form-select-sm" aria-label="Default select example" required>
                          <option value="" disabled selected style="display: none;" ></option>
                     <c:forEach var="area" items="${listaAreas}">
                   <option value="${area.idArea}">${area.nombre_area}</option>
               </c:forEach>     
          </select>
      <label class="form-label" for="txtNombre">SELECCIONA UNA AREA</label>
   </div>
</div>
    <div class="col">
             <div data-mdb-input-init class="form-outline mdb-input">
                          <select style="font-weight: bold;" style="font-weight: bold;" value="" id="perfil" name="id_perfil" class="form-select form-select-sm" aria-label="Default select example" required>
                              <option value="" disabled selected style="display: none;" ></option>
                                <c:forEach var="perfil" items="${listaPerfil}">
             <option value="${perfil.idPerfil}">${perfil.nombre_perfil}</option>
                       </c:forEach>
                                </select>
                    <label class="form-label" for="txtNombre">SELECCIONA UN PERFIL</label>
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
             <button type="submit" id="ALTA" name="action" value="104"style="display: none;color:white; background-color: #0370A7;  margin-top: 2rem; margin-bottom: 2rem; display:none;" class="btn btn-primary btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="ALTA">
                <i class="fas fa-pen-to-square"></i>
                <span class="btn-text">ALTA</span>
            </button>
            <button type="submit" id="Estatus" name="action" value="103" style="display: none; color:white; background-color: #A70303;  margin-top: 2rem; margin-bottom: 2rem; display:none;" class="btn btn-danger btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="ELIMINAR">
                <i class="fas fa-trash"></i>
                <span class="btn-text">ELIMINAR</span>
            </button>
            <button type="reset" id="Limpiar" class="btn btn-dark btn-sm btn-rounded" data-mdb-ripple-init data-bs-toggle="tooltip" data-bs-placement="top" title="LIMPIAR" style="margin-top: 2rem; margin-bottom: 2rem" onclick="limpiarFormulario()">
    <i class="fas fa-eraser"></i>
    <span class="btn-text">LIMPIAR</span>
</button>
        </div>
        <!-- finaliza seccion de botones -->
</form>

   <div class="row justify-content-center mb-3 d-felx">
        <div class="col-md-3">
            <div data-mdb-input-init class="form-outline fontformulario">
                <input type="text" id="busqueda" class="form-control form-control-sm" style="font-weight: bold;  width: 80%;" oninput="filterTable()"/>
                <label class="form-label" for="busqueda">BUSCAR</label>
            </div>
        </div>
    </div>
  

<%
if(admuser != null && admuser.size() > 0){
%>

<!-- esto pertence a la tabla  -->
<h1>OU YEA</h1>
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
                            <th class="fw-bold">CORREO ELECTRONICO</th>
                            <th class="fw-bold" style="display: none;">AREA</th>
                            <th class="fw-bold">NOMBRE AREA</th>
                            <th class="fw-bold" style="display: none;">PERFIL</th>
                            <th class="fw-bold">NOMBRE PERFIL</th>
                            <th class="fw-bold">USUARIO</th>
                            <th class="fw-bold">ESTATUS</th>
                        </tr>
                    </thead>
                    <tbody id="datos" style="font-size: 75%;">
                        <%
                           for (int i = 0; i < admuser.size(); i++) {
                            admin = admuser.get(i);
                        %>
                        <tr>
                            <td><%out.print(admin.getNombre());%></td>
                            <td><%out.print(admin.getAp_p());%></td>
                            <td><%out.print(admin.getAp_m());%></td>
                            <td><%out.print(admin.getEmail());%></td>
                            <td style="display: none;"><%out.print(admin.getId_area());%></td>
                            <td style="display: none;"><%out.print(admin.getId_perfil());%></td>
                            <td><%out.print(admin.getNombre_area());%></td>
                            <td><%out.print(admin.getNombre_perfil());%></td>
                            <td><%out.print(admin.getUsuario());%></td>
                            <% if(admin.getEstatus().equals("A")){%>
                            <td style="color:white; background-color: #169c00;"><%out.print(admin.getEstatus());%></td>
                            <%}else{%>
                            <td style="color:white; background-color: #9c1a00;"><%out.print(admin.getEstatus());%></td>
                            <% }
                            %>
                        </tr>
                        <% }%>  
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%}else{%>
    <!-- <h3>NO HAY USUARIOS</h3> -->
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
    <%}%>

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
    <!-- Script para manejar el evento de clic en el botÃ³n de impresiÃ³n -->


<script>
function AdministrarUsuario() {
    const nombre = document.getElementById("nombre").value.trim();
    const apellidoPaterno= document.getElementById("apellido_paterno").value.trim();
    const apellidoMaterno = document.getElementById("apellido_materno").value.trim();
    const email = document.getElementById("email").value.trim();
    const area = document.getElementById("area").value;
    const perfil = document.getElementById("perfil").value;
    const usuario = document.getElementById("usuario").value.trim();
    // ValidaciÃ³n de campos vacÃ­os
    if (!nombre || !apellidoPaterno|| !apellidoMaterno || !email || !area || !perfil || !usuario) {
        alert("Por favor, completa todos los campos.");
        return false;
    }
    return true;
}   
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
    var tabla = document.getElementById('concepto-table');
    var formulario = document.getElementById('formulario');

    // Añadir un evento de clic a las filas de la tabla
    tabla.addEventListener('click', function (event) {
        // Verificar si se hizo clic en una celda de la fila
        if (event.target.tagName === 'TD') {
            // Obtener la fila de la celda clicada
            var fila = event.target.parentNode;

            // Limpiar la selección previa
            if (tabla.querySelector('.selected')) {
                tabla.querySelector('.selected').classList.remove('selected');
                
                
        var usuarioField = document.getElementById('usuario');
        var name = document.getElementById('nombre');
        var ap_p = document.getElementById('apellido_paterno');
        var ap_m = document.getElementById('apellido_materno');
        var emails = document.getElementById('email');
        var areas = document.getElementById('area');
        var perfiles = document.getElementById('perfil');
        usuarioField.removeAttribute('readonly'); // Elimina el atributo readonly
        name.removeAttribute('readonly'); // Elimina el atributo readonly
        ap_p.removeAttribute('readonly'); // Elimina el atributo readonly
        ap_m.removeAttribute('readonly');
        emails.removeAttribute('readonly'); //// Elimina el atributo readonly
        areas.removeAttribute('disabled'); //// Elimina el atributo readonly
        perfiles.removeAttribute('disabled'); //// Elimina el atributo readonly
         

        // Limpia los campos
        usuarioField.value = ''; // Limpia el valor del campo si es necesario
        name.value = ''; // Limpia el valor del campo si es necesario
        ap_p.value = ''; // Limpia el valor del campo si es necesario
        ap_m.value = ''; // Limpia el valor del campo si es necesario
        emails.value = ''; // Limpia el valor del campo si es necesario
        areas.value = ''; // Limpia el valor del campo si es necesario
        perfiles.value = ''; // Limpia e
                
                
            }
            // Cambiar color de la fila seleccionada
            fila.classList.add("selected");
            
            // obtener valor de la fila 
             var valor = fila.cells[9].textContent.trim();
            
             const btnguardar  =document.querySelector("#Guardar");
             const btnmodificar  =document.querySelector("#Modificar");
             const btnEstatus  =document.querySelector("#Estatus");
             const btnalta = document.querySelector("#ALTA");
            
      
            // Cambiar visibilidad de botones
            if (valor === "A"){
            btnguardar.style.display = "none";
            btnmodificar.style.display = "inline-block";
            btnEstatus.style.display = "inline-block";
            btnalta.style.display ="none";
            
            
            
            const nombre = fila.cells[0].textContent;
            const apellidoPaterno = fila.cells[1].textContent;
            const apellidoMaterno = fila.cells[2].textContent;
            const email = fila.cells[3].textContent;
            const area = fila.cells[4].textContent;
            const perfil = fila.cells[5].textContent;
            const usuario = fila.cells[8].textContent;

            // Asignar los valores a los inputs del formulario
            formulario.querySelector("#nombre").value = nombre;
            formulario.querySelector("#apellido_paterno").value = apellidoPaterno;
            formulario.querySelector("#apellido_materno").value = apellidoMaterno;
            formulario.querySelector("#email").value = email;
            formulario.querySelector("#area").value = area;
            formulario.querySelector("#perfil").value = perfil;
            formulario.querySelector("#usuario").value = usuario;

            // Asegurar que el campo de usuario no sea modificable
            formulario.querySelector("#usuario").setAttribute('readonly', true); 

            // Enfocar los campos de formulario en el orden deseado
            formulario.querySelector("#nombre").focus();
            formulario.querySelector("#apellido_paterno").focus();
            formulario.querySelector("#apellido_materno").focus();
            formulario.querySelector("#email").focus();
            formulario.querySelector("#area").focus();
            formulario.querySelector("#perfil").focus();
            formulario.querySelector("#usuario").focus();

        }else{
            btnguardar.style.display = "none";
            btnmodificar.style.display = "none";
            btnEstatus.style.display = "none";
            btnalta.style.display ="inline-block";
            
                
                 // Obtener los datos de la fila seleccionada
            const nombre = fila.cells[0].textContent;
            const apellidoPaterno = fila.cells[1].textContent;
            const apellidoMaterno = fila.cells[2].textContent;
            const email = fila.cells[3].textContent;
            const area = fila.cells[4].textContent;
            const perfil = fila.cells[5].textContent;
            const usuario = fila.cells[8].textContent;

            // Asignar los valores a los inputs del formulario
            formulario.querySelector("#nombre").value = nombre;
            formulario.querySelector("#apellido_paterno").value = apellidoPaterno;
            formulario.querySelector("#apellido_materno").value = apellidoMaterno;
            formulario.querySelector("#email").value = email;
            formulario.querySelector("#area").value = area;
            formulario.querySelector("#perfil").value = perfil;
            formulario.querySelector("#usuario").value = usuario;

            // Asegurar que el campo de usuario no sea modificable
            formulario.querySelector("#nombre").setAttribute('readonly', true);
            formulario.querySelector("#apellido_paterno").setAttribute('readonly', true);
            formulario.querySelector("#apellido_materno").setAttribute('readonly', true);
            formulario.querySelector("#email").setAttribute('readonly', true);
            formulario.querySelector("#area").setAttribute('disabled', true);
            formulario.querySelector("#perfil").setAttribute('disabled', true); 
            formulario.querySelector("#usuario").setAttribute('readonly', true);

            // Enfocar los campos de formulario en el orden deseado
            formulario.querySelector("#nombre").focus();
            formulario.querySelector("#apellido_paterno").focus();
            formulario.querySelector("#apellido_materno").focus();
            formulario.querySelector("#email").focus();
            formulario.querySelector("#area").focus();
            formulario.querySelector("#perfil").focus();
            formulario.querySelector("#usuario").focus();

        }
 
           
        }
    });

    // Limpiar el formulario y permitir la edición del usuario
    document.querySelector('#Limpiar').addEventListener('click', function () {
        // Este hace que todos los campos se restablezcan    
        document.getElementById('formulario').reset(); 

        // Muestra los botones Guardar, Modificar y Estatus
        document.getElementById('Guardar').style.display = 'inline-block';
        document.getElementById('Modificar').style.display = 'none';
        document.getElementById('Estatus').style.display = 'none';
        document.getElementById('ALTA').style.display = 'none';

        // Limpiar la selección previa
        if (document.querySelector('.selected')) {
            document.querySelector('.selected').classList.remove('selected');
            
        var usuarioField = document.getElementById('usuario');
        var name = document.getElementById('nombre');
        var ap_p = document.getElementById('apellido_paterno');
        var ap_m = document.getElementById('apellido_materno');
        var emails = document.getElementById('email');
        var areas = document.getElementById('area');
        var perfiles = document.getElementById('perfil');
        usuarioField.removeAttribute('readonly'); // Elimina el atributo readonly
        name.removeAttribute('readonly'); // Elimina el atributo readonly
        ap_p.removeAttribute('readonly'); // Elimina el atributo readonly
        ap_m.removeAttribute('readonly'); // Elimina el atributo readonly
        emails.removeAttribute('readonly');// Elimina el atributo readonly
        areas.removeAttribute('disabled');// Elimina el atributo readonly
        perfiles.removeAttribute('disabled');// Elimina el atributo readonly
         

        // Limpia el campo de usuario
        usuarioField.value = ''; // Limpia el valor del campo si es necesario
        name.value = ''; // Limpia el valor del campo si es necesario
        ap_p.value = ''; // Limpia el valor del campo si es necesario
        ap_m.value = ''; // Limpia el valor del campo si es necesario
        emails.value = ''; // Limpia el valor del campo si es necesario
        areas.value = ''; // Limpia el valor del campo si es necesario
        perfiles.value = ''; // Limpia e
            
        }

        // Habilitar el campo de usuario para permitir la entrada
        var usuarioField = document.getElementById('usuario');
        var name = document.getElementById('nombre');
        var ap_p = document.getElementById('apellido_paterno');
        var ap_m = document.getElementById('apellido_materno');
        var emails = document.getElementById('email');
        var areas = document.getElementById('area');
        var perfiles = document.getElementById('perfil');
        usuarioField.removeAttribute('readonly'); // Elimina el atributo readonly
        name.removeAttribute('readonly'); // Elimina el atributo readonly
        ap_p.removeAttribute('readonly'); // Elimina el atributo readonly
        ap_m.removeAttribute('readonly'); // Elimina el atributo readonly
        emails.removeAttribute('readonly'); // Elimina el atributo readonly
        areas.removeAttribute('disabled');// Elimina el atributo readonly
        perfiles.removeAttribute('disabled');

        // Limpia el campo de usuario
        usuarioField.value = ''; // Limpia el valor del campo si es necesario
        name.value = ''; // Limpia el valor del campo si es necesario
        ap_p.value = ''; // Limpia el valor del campo si es necesario
        ap_m.value = ''; // Limpia el valor del campo si es necesario
        emails.value = ''; // Limpia el valor del campo si es necesario
        areas.value = ''; // Limpia el valor del campo si es necesario
        perfiles.value = ''; // Limpia el valor del campo si es necesario
    });
});


    </script>
    <%@include file="../Pie.jsp"%>