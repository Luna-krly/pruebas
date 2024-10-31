// Agrega los enlaces a las bibliotecas en tu archivo JSP o HTML
document.write('<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>');
document.write('<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>');
document.write('<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>');

document.addEventListener('DOMContentLoaded', function () {
    /*function imprimirTabla() {
        var table = document.getElementById('tablaCatalogoClientes');

        var doc = new jsPDF({
            orientation: 'landscape'
        });

        var data = [];
        var headers = [];
        var numCols = table.rows[0].cells.length;

        for (var j = 0; j < numCols; j++) {
            headers.push(table.rows[0].cells[j].textContent.trim());
        }

        var visibleRows = [];
        var tbody = table.getElementsByTagName('tbody')[0];
        for (var i = 0; i < tbody.rows.length; i++) {
            if (window.getComputedStyle(tbody.rows[i]).display !== 'none') {
                var row = [];
                for (var j = 0; j < numCols; j++) {
                    row.push(tbody.rows[i].cells[j].textContent.trim());
                }
                visibleRows.push(row);
            }
        }

        doc.autoTable({
            head: [headers],
            body: visibleRows,
            startY: 10,
            styles: { fontSize: 8 },
            headStyles: { fillColor: [22, 160, 133] }
        });

        doc.save('Catalogo_de_Clientes.pdf');
    }*/

    // Cambiar botones en input de busqueda para impresiones
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

    // Toma datos de tabla para moverlos arriba y cambiar los botones 
    var tabla = document.getElementById('datos');
    var formulario = document.getElementById('formulario');
    var formularioPermiso = document.getElementById('formularioPermiso');
    
    tabla.addEventListener('click', function (event) {
        if (event.target.tagName === 'TD') {
            var fila = event.target.parentNode;
            console.log("CLICK A TABLA");
            if (tabla.querySelector('.selected')) {
                tabla.querySelector('.selected').classList.remove('selected');
                clearTablePermisosArrendamiento();
            }
            fila.classList.add("selected");
            document.querySelector("#rfcBancoError").innerText = "";

            document.querySelector('#Guardar').style.display = "none";
            document.querySelector('#Modificar').style.display = "block";
            document.querySelector('#Baja').style.display = "block";

            let idCliente = fila.querySelector('.id-cliente').innerText;
            let numeroCliente = fila.querySelector('.texto-largo:nth-child(2)').innerText;
            let tipoPersona = fila.querySelector('.texto-largo:nth-child(3)').innerText;
            console.log("Tipo de persona en seleccioon "+ tipoPersona);
            getListaRegimen(tipoPersona);
            let idRegimenFiscal = fila.querySelector('.texto-largo:nth-child(4)').innerText;
            let rfcCliente = fila.querySelector('.texto-largo:nth-child(6)').innerText;
            let nombreCliente = fila.querySelector('.texto-largo:nth-child(7)').innerText;
            let calle = fila.querySelector('.texto-largo:nth-child(8)').innerText;
            let noExterior = fila.querySelector('.texto-largo:nth-child(9)').innerText;
            let noInterior = fila.querySelector('.texto-largo:nth-child(10)').innerText;
            let codigoPostal = fila.querySelector('.texto-largo:nth-child(11)').innerText;
            let idPais = fila.querySelector('.texto-largo:nth-child(13)').innerText;
            let email = fila.querySelector('.texto-largo:nth-child(15)').innerText;
            let condicionPago = fila.querySelector('.texto-largo:nth-child(16)').innerText;
            let cuentaBancaria = fila.querySelector('.texto-largo:nth-child(17)').innerText;
            let referenciaQr = fila.querySelector('.texto-largo:nth-child(18)').innerText;
           
            isertDataTablePermisosArrendamiento(rfcCliente);

          //  formulario.querySelector("#idRegimenFiscal").value = idRegimenFiscal;
            formulario.querySelector("#idPais").value = idPais;
            formulario.querySelector("#codigoPostal").value = codigoPostal;
            formulario.querySelector("#idCliente").value = idCliente;
            formulario.querySelector("#numeroCliente").value = numeroCliente;
            formulario.querySelector("#tipoPersona").value = tipoPersona;
            formulario.querySelector("#regimenFiscal").value = idRegimenFiscal;
            formulario.querySelector("#rfcCliente").value = rfcCliente;
            formulario.querySelector("#rfcCliente").readOnly = true;
            formularioPermiso.querySelector("#rfcArrendatario").value = rfcCliente;
            filterData();
            actualizarConsecutivos();
            actualizarDescripcion();

            formulario.querySelector("#nombreCliente").value = nombreCliente;
            formularioPermiso.querySelector("#nombreArrendatario").value = nombreCliente;
            formulario.querySelector("#calle").value = calle;
            formulario.querySelector("#numeroExterior").value = noExterior;
            formulario.querySelector("#numeroInterior").value = noInterior;
            let valueColonia = document.querySelector('#ListaCP option[data-value="' + codigoPostal + '"]').value;
            document.getElementById("colonia").value = valueColonia;
            let valueDelegacion = document.querySelector('#ListaDelegacion option[data-value="' + codigoPostal + '"]').value;
            document.getElementById("delegacion").value = valueDelegacion;
            let valueEstado = document.querySelector('#ListaEstado option[data-value="' + codigoPostal + '"]').value;
            document.getElementById("estado").value = valueEstado;
            formulario.querySelector("#pais").value = idPais;

            formulario.querySelector("#email").value = email;
            formulario.querySelector("#condicionPago").value = condicionPago;
            formulario.querySelector("#cuentaBancaria").value = cuentaBancaria;
            formulario.querySelector("#referenciaBancaria").value = referenciaQr;

            formulario.querySelector("#estado").focus();
            formulario.querySelector("#delegacion").focus();
            formulario.querySelector("#numeroCliente").focus();
            formulario.querySelector("#tipoPersona").focus();
            formulario.querySelector("#regimenFiscal").focus();
            formulario.querySelector("#rfcCliente").focus();
            formularioPermiso.querySelector("#rfcArrendatario").focus();
            formulario.querySelector("#nombreCliente").focus();
            formularioPermiso.querySelector("#nombreArrendatario").focus();
            formulario.querySelector("#calle").focus();
            formulario.querySelector("#numeroExterior").focus();
            formulario.querySelector("#numeroInterior").focus();
            formulario.querySelector("#colonia").focus();

            formulario.querySelector("#pais").focus();
            formulario.querySelector("#email").focus();
            formulario.querySelector("#condicionPago").focus();
            formulario.querySelector("#cuentaBancaria").focus();
            formulario.querySelector("#referenciaBancaria").focus();
        }
    });

    function get_codigosPostales() {
        var inputRFC = document.getElementById('listaClientes').value.toUpperCase();
        var listaRFCs = document.getElementById('clientes').getElementsByTagName('option');
        var found = false;

        for (var i = 0; i < listaRFCs.length; i++) {
            if (inputRFC === listaRFCs[i].value) {
                found = true;
                var dataValue = listaRFCs[i].getAttribute("data-value");
                document.getElementById('rfcCliente').value = dataValue;
                break;
            }
        }

        if (!found) {
            customeError('ERROR','RFC NO VÁLIDO');
            document.getElementById('listaClientes').value = '';
            document.getElementById('rfcCliente').value = '';
        }
    }

    function get_cp() {
        let Inputcolonia = document.getElementById("colonia").value;
        let listCodigoPostal = document.getElementById('ListaCP').getElementsByTagName('option');
        let found = false;

        for (let i = 0; i < listCodigoPostal.length; i++) {
            if (Inputcolonia === listCodigoPostal[i].value) {
                found = true;
                let deleg = document.getElementById("delegacion");
                let est = document.getElementById("estado");
                let dataValue = listCodigoPostal[i].getAttribute("data-value");
                document.getElementById('codigoPostal').value = dataValue;

                let CPdelegacion = document.querySelector('#ListaDelegacion option[data-value="' + dataValue + '"]').value;
                deleg.value = CPdelegacion;
                deleg.setAttribute("data-value", dataValue);

                let CPest = document.querySelector('#ListaEstado option[data-value="' + dataValue + '"]').value;
                est.value = CPest;
                est.setAttribute("data-value", dataValue);

                break;
            }
        }

        if (!found) {
            customeError('ERROR','CÓDIGO POSTAL NO VÁLIDO.');
            document.getElementById('ListaCP').value = '';
            document.getElementById('colonia').value = '';
            document.getElementById('codigoPostal').value = '';
            document.querySelector("#estado").value = '';
            document.querySelector("#delegacion").value = '';
        }

        document.querySelector("#estado").focus();
        document.querySelector("#delegacion").focus();
    }

    document.querySelector('#Baja').style.display = "none";

    document.querySelector('#Limpiar').addEventListener('click', function () {
        document.querySelector("#rfcCliente").readOnly = false;
        clearTablePermisosArrendamiento();
        document.querySelector("#rfcBancoError").innerText = "";
        document.querySelector('#Guardar').style.display = "block";
        document.querySelector('#Modificar').style.display = "none";
        document.querySelector('#Baja').style.display = "none";
        if (document.querySelector('.selected')) {
            document.querySelector('.selected').classList.remove('selected');
        }
       
            document.querySelector("#idPermisoReferenciaBancaria").value ="";
            document.querySelector("#rfcArrendatario").value ="";
            document.querySelector("#nombreArrendatario").value ="";
            document.querySelector("#referenciaqr").value ="";
            document.querySelector("#numeroPART").value = "";
            document.querySelector("#iniciaVigencia").value ="";
            document.querySelector("#finVigencia").value ="";
            document.querySelector("#sefactura").value ="";
            document.querySelector("#importeConcepto").value ="";
            document.querySelector("#importeIva").value ="";
            document.querySelector("#importeRenta").value ="";
            document.getElementById("select-permiso").innerHTML = "";
            document.getElementById("select-numero").innerHTML = "";
            document.getElementById("select-descripcion").innerHTML = "";

        
        
    });

    document.getElementById('formulario').addEventListener('submit', function (event) {
        var inputs = document.getElementsByTagName('input');
        var areas = document.getElementsByTagName('textarea');
        for (var i = 0; i < areas.length; i++) {
            areas[i].value = areas[i].value.toUpperCase();
        }
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].type === 'text') {
                inputs[i].value = inputs[i].value.toUpperCase();
            }
        }
    });

    $("#busqueda").on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#datos tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });

    function validarRFC() {
        const rfcInput = document.getElementById('rfcCliente');
        const rfcError = document.getElementById('rfcBancoError');
        const rfc = rfcInput.value.toUpperCase();
        const regexNumber = /\d$/;
        let año, mes, homoclave, dia;
        
        let letras = rfc.substr(0, 4);
        if(regexNumber.test(letras)){
            letras = rfc.substr(0, 3);
            año = rfc.substr(3, 2);
            mes = rfc.substr(5, 2);
            dia = rfc.substr(7, 2);
            homoclave = rfc.substr(9, 3);   
        }else{
            año = rfc.substr(4, 2);
            mes = rfc.substr(6, 2);
            dia = rfc.substr(8, 2);
            homoclave = rfc.substr(10, 3);
        }
        
        console.log(letras)
        const letrasPattern = /^[A-ZÑ&]{3,4}$/;
        if (!letrasPattern.test(letras)) {
            rfcError.innerText = 'Las primeras 3 o 4 letras deben ser letras mayúsculas.';
            rfcError.style.display = 'block';
            return;
        }

        const añoPattern = /^\d{2}$/;
        if (!añoPattern.test(año)) {
            rfcError.innerText = 'El año debe ser 2 dígitos (00-99).';
            rfcError.style.display = 'block';
            return;
        }

        const mesPattern = /^(0[1-9]|1[0-2])$/;
        if (!mesPattern.test(mes)) {
            rfcError.innerText = 'El mes debe ser entre 01 y 12.';
            rfcError.style.display = 'block';
            return;
        }

        const diaPattern = /^(0[1-9]|[12]\d|3[01])$/;
        if (!diaPattern.test(dia)) {
            rfcError.innerText = 'El día debe ser válido para el mes seleccionado.';
            rfcError.style.display = 'block';
            return;
        }

        const homoclavePattern = /^[A-Z0-9]{3}$/;
        if (!homoclavePattern.test(homoclave)) {
            rfcError.innerText = 'La homoclave debe ser 3 caracteres (letras o números).';
            rfcError.style.display = 'block';
            return;
        }

        rfcError.style.display = 'none';
    }

    document.addEventListener("DOMContentLoaded", function () {
        setTimeout(function () {
            var alerta = document.querySelector("#myAlert");
            if (alerta) {
                alerta.style.display = "none";
            }
        }, 3500);
    });
    
    function validarCuentaBancaria() {
        var input = document.getElementById('cuentaBancaria');
        var value = input.value;
        // Check if value is '0' or a 4-digit number
        if (value === '0' || /^[0-9]{10}$/.test(value)) {
            // Valid input
            input.setCustomValidity(''); // Clear any previous custom validity
        } else {
            // Invalid input
            customeError("ERROR","LA CUENTA BANCARIA TIENE QUE SER DE DIEZ DIGITOS O CERO");
            input.setCustomValidity('Invalid input');
        }
    }

    window.onload = function () {
        document.getElementById("formulario").reset();
    };
     window.get_cp= get_cp;
     window.validarRFC = validarRFC;
     window.validarCuentaBancaria = validarCuentaBancaria;
    // window.imprimirTabla = imprimirTabla;
});
