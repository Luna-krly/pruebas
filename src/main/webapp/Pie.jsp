<%-- 
    Document   : Pie
    Created on : 16 feb 2024, 11:10:47
    Author     : Ing. Evelyn Leilani Avendaño 
    Author     : Lezly Oliván
--%>
<!-- Background image -->
</header>

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
    import { Input, Ripple, initMDB } from "mdb-ui-kit";
    initMDB({Input, Ripple});
                    history.forward();
            </script>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
crossorigin="anonymous"></script>
<!-- MDB -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.1.0/mdb.min.js"></script>
<script type="text/javascript"
src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.1.0/mdb.umd.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
</head>
</body>
</html>
