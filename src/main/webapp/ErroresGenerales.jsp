<%-- 
    Document   : ErroresGenerales
    Created on : 5 jun 2024, 13:47:10
    Author     : Ing. Evelyn Leilani Avendaño 
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
                    OCURRIÓ UN ERROR INESPERADO 
                </h1>
                <p style="color: #5E0707;">Ocurrió un error, favor de verificar con el administrador</p>
            </div>
        </div>
        <a class="d-flex justify-content-center align-items-center" href="Principal.jsp" data-mdb-ripple-color="primary">
            <img id="inicio" class="img-fluid" width="550" src="<%=erroresGenerales%>"
                 alt="Imagen Error General">
        </a>
    </div>
    <%@include file="Mensaje.jsp"%>
</main>
<!-- Background image -->

<%@include file="Pie.jsp"%>
