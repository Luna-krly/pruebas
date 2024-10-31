<%-- 
    Document   : 404.jsp
    Created on : 6 may 2024, 16:01:21
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
<!-- Cuerpo -->
<main class="col ps-md-2 pt-2 mx-3">
    <a href="#" data-bs-target="#sidebar" data-bs-toggle="collapse" class="text-decoration-none menuitem nav-link">
        <i class="bi bi-list"></i>
    </a>
    <br>
    <br>
    <br>
    <br>
    <div class="row">
        <div class="col-12 text-sm-center">
            <div class="col-12 text-sm-center">
                <h1 class="stc display-6 text-center d-none d-sm-block">
                    ERROR 404 - PÁGINA NO DISPONIBLE
                </h1>

            </div>
        </div>
        <a class="d-flex justify-content-center align-items-center" href="Principal.jsp" data-mdb-ripple-color="primary">
            <img id="inicio" class="img-fluid" width="550" src="https://i.ibb.co/Lx1Z7W8/Error404.png"
                 alt="Imagen 404">
        </a>
    </div>
    <%@include file="Mensaje.jsp"%>
</main>
<!-- Background image -->

<%@include file="Pie.jsp"%>
