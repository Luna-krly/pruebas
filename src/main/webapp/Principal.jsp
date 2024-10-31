<%-- 
    Document   : Principal
    Created on : 16 feb 2024, 11:15:16
    Author     : Ing. Evelyn Leilani Avendaño 
    Author     : Lezly Oliván
--%>

<%@include file="Encabezado.jsp"%>
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
    }
</style>
 <style>
        #mensaje {
            display: none; /* El div estará oculto inicialmente */
            color: red; /* Cambia el color del texto según tus preferencias */
        }
    </style>
<!-- Cuerpo -->
<main class="col ps-md-2 pt-2 mx-3">
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <div class="page-header pt-3 stc">
        <h3>BIENVENID@, ${usuario.getNombre()} ${usuario.getApellido_paterno()}</h3>
    </div>
    <div id="datetime" class="stc" style="font-size: 75%;">
    </div>
    <hr>
    <div class="row">
        <div class="col-12 text-sm-center">
            <div class="col-12 text-sm-center">
                
                <div id="mensaje" class="h4"></div>

                <c:set var="diasRestantes" value="${usuario.getDias_cambio()}" />
                <c:if test="${diasRestantes < 5}">
                    <script>
                        // Mostrar el div con el mensaje
                        var mensaje = "FALTAN ${diasRestantes} DÍAS PARA QUE EXPIRE LA CONTRASEÑA, FAVOR DE CAMBIARLA";
                        document.getElementById("mensaje").innerHTML = mensaje;
                        document.getElementById("mensaje").style.display = "block"; // Mostrar el div
                    </script>
                    <hr>
                </c:if>

                
                <h1 class="stc display-6 text-center d-none d-sm-block">
                    SISTEMA DE FACTURACIÓN
                </h1>
                <h1 class="stc display-6 text-center d-none d-sm-block" style="font-size: 1.3em;">
                    SUBGERENCIA DE INGRESOS
                </h1>
                <h1 class="stc display-6 text-center d-block d-sm-none" style="font-size: 1.2em;">
                    FACTURACIÓN
                </h1>
            </div>
        </div>
        <a class="d-flex justify-content-center align-items-center" href="#" data-mdb-ripple-color="primary">
            <img id="inicio" class="img-fluid" width="550" src="<%=inicio%>"
                 alt="Imagen Bienvenida">
        </a>
    </div>
</div>

<%@include file="Mensaje.jsp"%>


</main>
<!-- Background image -->

<%@include file="Pie.jsp"%>