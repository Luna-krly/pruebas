/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.write('<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>');
document.write('<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>');
document.write('<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>');

document.addEventListener('DOMContentLoaded', function () {
    //VALIDAR QUE EL FOLIO DE FACTURA ES EL CORRECTO
    function validateFactura() {
        var input = document.getElementById('folio').value.toUpperCase();
        var lista = document.getElementById('ListFacturaBuscar').getElementsByTagName('option');
        var found = false;

        // Iterar sobre los elementos de la lista
        for (var i = 0; i < lista.length; i++) {
            if (input === lista[i].value) {
                found = true;
                break;
            }
        }

        // Si no se encontró el RFC en la lista, limpiar el input
        if (!found) {
            customeError("ERROR", 'FOLIO NO VÁLIDO');
            document.getElementById('folio').value = '';
            document.getElementById("folioEncontrado").value = "";
        }
    }

    //AÑADIR ESTILOS A IMPORTANT
    // Función para agregar estilo con !important
    function addImportantStyle(nombreInput) {
        var sheet = document.createElement('style');
        sheet.id = 'importantStyle-' + nombreInput;
        sheet.innerHTML = '#' + nombreInput + ' { background-color: gainsboro !important; }';
        document.head.appendChild(sheet);
    }

    // Función para eliminar estilo con !important y agregar uno nuevo
    function removeImportantStyle(nombreInput) {
        // Eliminar el estilo anterior
        var sheet = document.getElementById('importantStyle-' + nombreInput);
        if (sheet) {
            sheet.parentNode.removeChild(sheet);
        }

        // Agregar un nuevo estilo con !important para sobrescribir el anterior
        var newSheet = document.createElement('style');
        newSheet.id = 'overrideStyle-' + nombreInput;
        newSheet.innerHTML = '#' + nombreInput + ' { background-color: white !important; }';
        document.head.appendChild(newSheet);
        document.getElementById(nombreInput).style.backgroundColor = 'White';
    }

    //VALIDACIONES PARA TIPO DE SERIE
    function get_tipoSerie() {
        var serie = document.getElementById('serie');
        var tipoServicio = document.getElementById('tipoServicio');
        var opciones = serie.options;
        let tipoComprobante = document.getElementById('idTipoComprobante');
        let textTipoComprobante = idTipoComprobante.options[tipoComprobante.selectedIndex].text;

        if (textTipoComprobante !== "E - EGRESO") {
            notaCreditoMenu(2);
            // Seleccionamos los <th> por su posición en la fila (11, 12, 13, 14 son sus posiciones en el ejemplo dado)
            const tabla = document.getElementById('tablaProductosServicios');

            // Seleccionamos los <th> por su posición dentro de la tabla seleccionada
            const thFacturaNC = tabla.querySelector('thead tr th:nth-child(11)');
            const thSerieNC = tabla.querySelector('thead tr th:nth-child(12)');
            const thFechaNC = tabla.querySelector('thead tr th:nth-child(13)');
            const thFolioFiscalNC = tabla.querySelector('thead tr th:nth-child(14)');
            // Agregamos la nueva clase
            thFacturaNC.classList.add('d-none');
            thSerieNC.classList.add('d-none');
            thFechaNC.classList.add('d-none');
            thFolioFiscalNC.classList.add('d-none');

        }

        deleteDataTable("tablaProductosServicios");
        deleteDataTable("tablaImpuestos");

        serie.disabled = false;
        serie.required = true;
        serie.value = '';
        serie.blur();
        for (let i = 0; i < opciones.length; i++) {
            opciones[i].style.display = 'block';
        }

        for (let i = 0; i < opciones.length; i++) {
            //1 Ingreso 
            if (tipoComprobante.value == '1') {
                if (opciones[i].value == 'NC') {
                    opciones[i].style.display = 'none';
                }
                removeImportantStyle('serie');
                //2 Egreso
            } else if (tipoComprobante.value == '2') {
                if (opciones[i].value == 'A' || opciones[i].value == 'B') {
                    opciones[i].style.display = 'none';
                }
                removeImportantStyle('serie');
                tipoServicio.disabled = true;
                tipoServicio.required = false;
                tipoServicio.value = '';
                tipoServicio.blur();
                addImportantStyle('tipoServicio');
            } else {
                opciones[i].style.display = 'none';
                serie.disabled = true;
                serie.required = false;
                serie.value = '';
                serie.blur();
                addImportantStyle('serie');
                tipoServicio.disabled = true;
                tipoServicio.required = false;
                tipoServicio.value = '';
                tipoServicio.blur();
                addImportantStyle('tipoServicio');

            }
        }
    }

    function setInputByIdData(idData, listId, inputId, toReturn = false) {
        // Obtener todas las opciones del datalist
        var options = document.getElementById(listId).options;
        // Recorrer las opciones del datalist para buscar el idCliente
        for (var i = 0; i < options.length; i++) {
            // Comparar el data-value con el idCliente
            if (options[i].getAttribute('data-value') === idData) {
                // Si coincide, establecer el valor del input con el value de la opción
                if (toReturn) {
                    return options[i].value;
                } else {
                    document.getElementById(inputId).value = options[i].value;
                }

                break; // Salir del bucle una vez encontrado
            }
    }
    }

// Establecer la fecha actual
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); // Enero es 0
    var yyyy = today.getFullYear();

    // Formatear la fecha como yyyy-MM-dd para que sea compatible con el input type="date"
    var formattedDate = yyyy + '-' + mm + '-' + dd;
    document.getElementById('fechaPago').setAttribute('max', formattedDate);
    document.getElementById('fechaFactura').value = formattedDate;

    function get_idUsoCfdi() {
        var input = document.getElementById('usoCFDI').value.toUpperCase();
        var lista = document.getElementById('ListUsoCFDI').getElementsByTagName('option');
        var found = false;
        // Iterar sobre los elementos de la lista
        for (var i = 0; i < lista.length; i++) {
            if (input === lista[i].value) {
                found = true;
                // Obtener el valor del atributo 'data-value'
                var dataValue = lista[i].getAttribute("data-value");
                document.getElementById('idUsoCFDI').value = dataValue;
                break;
            }
        }
        // Si no se encontró el RFC en la lista, limpiar el input
        if (!found) {
            document.getElementById('usoCFDI').value = '';
            document.getElementById('idUsoCFDI').value = '';
            document.getElementById("usoCFDI").focus();
            document.getElementById("idUsoCFDI").focus();
            document.getElementById("usoCFDI").blur();
            document.getElementById("idUsoCFDI").blur();
            customeError("ERROR", 'USO DE CFDI NO VÁLIDO');
        }
    }


    function get_tipoServicio() {
        var serieSelect = document.getElementById('serie');
        var tipoServicioInput = document.getElementById('tipoServicio');
        // Verifica si la opción seleccionada es "A"
        if (serieSelect.value === 'A') {
            console.log("Selecciona A");
            tipoServicioInput.disabled = false;// Habilita el campo
            tipoServicioInput.required = true;
            tipoServicioInput.value = '';
            tipoServicioInput.blur();
            removeImportantStyle('tipoServicio');
            notaCreditoMenu(2);
        } else if (serieSelect.value === 'NC') {
            notaCreditoMenu(1);
            tipoServicioInput.value = ''; // Limpia el valor si es necesario
            tipoServicioInput.disabled = true; // Deshabilita el campo
            tipoServicioInput.blur();
            addImportantStyle('tipoServicio');
        } else {
            tipoServicioInput.value = ''; // Limpia el valor si es necesario
            tipoServicioInput.disabled = true; // Deshabilita el campo
            tipoServicioInput.blur();
            notaCreditoMenu(2);
            addImportantStyle('tipoServicio');
        }

    }

    function get_idFormaPago() {
        var input = document.getElementById('formaPago').value.toUpperCase();
        var lista = document.getElementById('ListFormaPago').getElementsByTagName('option');
        var found = false;
        // Iterar sobre los elementos de la lista
        for (var i = 0; i < lista.length; i++) {
            if (input === lista[i].value) {
                found = true;
                // Obtener el valor del atributo 'data-value'
                var dataValue = lista[i].getAttribute("data-value");
                document.getElementById('idFormaPago').value = dataValue;
                break;
            }
        }
        // Si no se encontró el RFC en la lista, limpiar el input
        if (!found) {
            document.getElementById('formaPago').value = '';
            document.getElementById('idFormaPago').value = '';
            document.getElementById("formaPago").focus();
            document.getElementById("idFormaPago").focus();
            document.getElementById("formaPago").blur();
            document.getElementById("idFormaPago").blur();
            customeError("ERROR", 'FORMA DE PAGO NO VÁLIDA');
        }
    }

    function validarCuentaBancaria() {
        var input = document.getElementById('cuentaBancaria');
        var errorMessage = document.getElementById('error-message');
        var value = input.value;

        // Clear previous error message
        errorMessage.textContent = '';

        // Check if value is '0' or a 4-digit number

        if (value == '0000') {
            errorMessage.textContent = 'EL VALOR DEBE SER UN NÚMERO DE 4 DÍGITOS O 0.';
            input.setCustomValidity('Invalid input');
            input.value = '';
        } else if (value === '0' || /^[0-9]{4}$/.test(value)) {
            // Valid input
            input.setCustomValidity(''); // Clear any previous custom validity
        } else {
            // Invalid input
            errorMessage.textContent = 'EL VALOR DEBE SER UN NÚMERO DE 4 DÍGITOS O 0.';
            input.setCustomValidity('Invalid input');
            input.value = '';
        }
    }

    document.getElementById('tipoRelacion').addEventListener('change', function () {
        const tipoRelacion = document.getElementById('idTipoRelacion');
        const spanNoRetenido = document.getElementById('spanNoTipoRelacion');
        const spanSiRetenido = document.getElementById('spanSiTipoRelacion');
        if (this.checked) {
            spanNoRetenido.hidden = true;
            spanSiRetenido.hidden = false;
            tipoRelacion.required = true;
            tipoRelacion.disabled = false;
            removeImportantStyle('idTipoRelacion');
        } else {
            spanNoRetenido.hidden = false;
            spanSiRetenido.hidden = true;
            tipoRelacion.required = false;
            tipoRelacion.value = "";
            tipoRelacion.disabled = true;
            addImportantStyle('idTipoRelacion');
        }
    });

    function redirigir(event) {
        if (event.keyCode === 13) { // Si se presiona la tecla Enter
            event.preventDefault();
            // Obtener el elemento de la pestaña y el contenido a mostrar
            var tabToActivate = document.getElementById('ex3-tab-2');
            var contentToShow = document.getElementById('ex3-tabs-2');

            if (tabToActivate && contentToShow) {
                // Ocultar todos los contenidos
                const contentItems = document.querySelectorAll('.tab-pane');
                contentItems.forEach((contentItem) => {
                    contentItem.classList.remove('show', 'active');
                });

                // Desactivar todas las pestañas
                const menuItems = document.querySelectorAll('.nav-link');
                menuItems.forEach((item) => {
                    item.classList.remove('active');
                });

                // Mostrar el contenido correspondiente y activar la pestaña
                contentToShow.classList.add('show', 'active');
                tabToActivate.classList.add('active');
            }
        }
    }

    function get_idProductoServicio() {
        var input = document.getElementById('productoServicio').value.toUpperCase();
        var lista = document.getElementById('ListProductoServicio').getElementsByTagName('option');
        var found = false;
        // Iterar sobre los elementos de la lista
        for (var i = 0; i < lista.length; i++) {
            if (input === lista[i].value) {
                found = true;
                // Obtener el valor del atributo 'data-value'
                var dataValue = lista[i].getAttribute("data-value");
                document.getElementById('idProductoServicio').value = dataValue;
                break;
            }
        }
        // Si no se encontró el RFC en la lista, limpiar el input
        if (!found) {
            document.getElementById('productoServicio').value = '';
            document.getElementById('idProductoServicio').value = '';
            document.getElementById("productoServicio").focus();
            document.getElementById("idProductoServicio").focus();
            document.getElementById("productoServicio").blur();
            document.getElementById("idProductoServicio").blur();
            customeError("ERROR", 'PRODUCTO O SERVICIO NO VÁLIDO');
        }
    }

    function validarCantidad() {
        var input = document.getElementById('cantidad');
        var errorMessage = document.getElementById('error-cantidad');
        var value = input.value;
        var numValue = parseFloat(value);
        // Limpiar mensaje de error
        errorMessage.textContent = '';
        input.setCustomValidity(''); // Limpiar cualquier validez personalizada previa
        // Validación de número decimal
        if (isNaN(numValue) || numValue < 1) {
            errorMessage.textContent = 'LA CANTIDAD DEBE SER UN NÚMERO MAYOR O IGUAL A 1.';
            input.setCustomValidity('La cantidad debe ser un número mayor o igual a 1.');
            input.value = ''; // Opcional: Limpiar el campo si no es válido
        } else if (!/^\d+(\.\d{1,2})?$/.test(value)) {
            errorMessage.textContent = 'LA CANTIDAD DEBE TENER HASTA DOS DECIMALES.';
            input.setCustomValidity('La cantidad debe tener hasta dos decimales.');
            input.value = ''; // Opcional: Limpiar el campo si no es válido
            input.blur();
        } else {
            input.setCustomValidity(''); // Valid input
        }
    }

    function get_idUnidadMedida() {
        var input = document.getElementById('unidadMedida').value.toUpperCase();
        var lista = document.getElementById('ListUnidadMedida').getElementsByTagName('option');
        var found = false;
        // Iterar sobre los elementos de la lista
        for (var i = 0; i < lista.length; i++) {
            if (input === lista[i].value) {
                found = true;
                // Obtener el valor del atributo 'data-value'
                var dataValue = lista[i].getAttribute("data-value");
                document.getElementById('idUnidadMedida').value = dataValue;
                break;
            }
        }
        // Si no se encontró el RFC en la lista, limpiar el input
        if (!found) {
            document.getElementById('unidadMedida').value = '';
            document.getElementById('idUnidadMedida').value = '';
            document.getElementById("unidadMedida").focus();
            document.getElementById("idUnidadMedida").focus();
            document.getElementById("unidadMedida").blur();
            document.getElementById("idUnidadMedida").blur();
            customeError("ERROR", 'UNIDAD DE MEDIDA NO VÁLIDA');
        }
    }

    function notaCreditoMenu(option) {
        var menu = document.getElementById('nc_menu');
        if (option == 1) {
            menu.style.display = 'block';
        } else {
            menu.style.display = 'none';
        }
    }

    document.getElementById('cuentaPredial').addEventListener('change', function () {
        const cuentaPredial = document.getElementById('numeroCuentaPredial');
        const spanNoPredial = document.getElementById('spanNoCuentaPredial');
        const spanSiPredial = document.getElementById('spanSiCuentaPredial');
        if (this.checked) {
            spanNoPredial.hidden = true;
            spanSiPredial.hidden = false;
            cuentaPredial.required = true;
            cuentaPredial.value = '022-060-10-000-1';
            cuentaPredial.disabled = false;
            cuentaPredial.readOnly = true;
            cuentaPredial.focus();
            removeImportantStyle('numeroCuentaPredial');
        } else {
            spanNoPredial.hidden = false;
            spanSiPredial.hidden = true;
            cuentaPredial.required = false;
            cuentaPredial.value = "";
            cuentaPredial.focus();
            cuentaPredial.blur();
            cuentaPredial.disabled = true;
            addImportantStyle('numeroCuentaPredial');
        }
    });

    document.getElementById('impuestoTrasladado').addEventListener('change', function () {
        const spanNoImpuestoTrasladado = document.getElementById('spanNoImpuestoTrasladado');
        const spanSiImpuestoTrasladado = document.getElementById('spanSiImpuestoTrasladado');


        const impuestoRetenido = document.getElementById('impuestoRetenido');
        const spanNoImpuestoRetenido = document.getElementById('spanNoImpuestoRetenido');
        const spanSiImpuestoRetenido = document.getElementById('spanSiImpuestoRetenido');

        if (this.checked) {
            spanNoImpuestoTrasladado.hidden = true;
            spanSiImpuestoTrasladado.hidden = false;

            spanNoImpuestoRetenido.hidden = false;
            spanSiImpuestoRetenido.hidden = true;
            impuestoRetenido.checked = false;
        } else {
            spanNoImpuestoTrasladado.hidden = false;
            spanSiImpuestoTrasladado.hidden = true;
        }
    });

    document.getElementById('impuestoRetenido').addEventListener('change', function () {
        const spanNoImpuestoRetenido = document.getElementById('spanNoImpuestoRetenido');
        const spanSiImpuestoRetenido = document.getElementById('spanSiImpuestoRetenido');

        const impuestoTrasladado = document.getElementById('impuestoTrasladado');
        const spanNoImpuestoTrasladado = document.getElementById('spanNoImpuestoTrasladado');
        const spanSiImpuestoTrasladado = document.getElementById('spanSiImpuestoTrasladado');

        if (this.checked) {
            spanNoImpuestoRetenido.hidden = true;
            spanSiImpuestoRetenido.hidden = false;
            spanNoImpuestoTrasladado.hidden = false;
            spanSiImpuestoTrasladado.hidden = true;
            impuestoTrasladado.checked = false;

        } else {
            spanNoImpuestoRetenido.hidden = false;
            spanSiImpuestoRetenido.hidden = true;
        }
    });


    document.getElementById('conLetras').addEventListener('change', function () {
        const divTotalLetras = document.getElementById('columnaTotalLetras');
        const totalLetras = document.getElementById('totalLetras');
        const spanNoTotalLetras = document.getElementById('spanNoTotalLetras');
        const spanSiTotalLetras = document.getElementById('spanSiTotalLetras');
        if (this.checked) {
            spanNoTotalLetras.hidden = true;
            spanSiTotalLetras.hidden = false;
            // totalLetras.required = true;
            // totalLetras.disabled = false;
            calcularTotales();
            // Use setTimeout to ensure DOM update before focusing
            setTimeout(() => {
                totalLetras.focus();
            }, 0);
            divTotalLetras.style.display = 'block';
        } else {
            spanNoTotalLetras.hidden = false;
            spanSiTotalLetras.hidden = true;
            totalLetras.value = "";
            //totalLetras.required = false;
            // totalLetras.disabled = true;
            document.getElementById("totalLetras").blur();
            divTotalLetras.style.display = 'none';
        }
    });



    function convertirNumero(num) {
        // Función para convertir la parte entera a palabras
        function convertirParteEntera(num) {
            const unidades = ["", "UN", "DOS", "TRES", "CUATRO", "CINCO", "SEIS", "SIETE", "OCHO", "NUEVE"];
            const decenas = ["", "DIEZ", "VEINTE", "TREINTA", "CUARENTA", "CINCUENTA", "SESENTA", "SETENTA", "OCHENTA", "NOVENTA"];
            const centenas = ["", "CIENTO", "DOSCIENTOS", "TRESCIENTOS", "CUATROCIENTOS", "QUINIENTOS", "SEISCIENTOS", "SETECIENTOS", "OCHOCIENTOS", "NOVECIENTOS"];

            if (num === 0)
                return "CERO";
            if (num === 10)
                return "DIEZ";
            if (num === 100)
                return "CIEN";
            if (num === 1000)
                return "MIL";
            if (num === 1000000)
                return "UN MILLÓN";
            if (num === 1000000000)
                return "UN BILLÓN";

            let palabras = "";

            if (num < 10)
                return unidades[num];
            if (num < 20)
                return ["ONCE", "DOCE", "TRECE", "CATORCE", "QUINCE"][num - 11] || "DIECI" + unidades[num - 10];
            if (num < 30)
                return num === 20 ? "VEINTE" : "VEINTI" + unidades[num - 20];
            if (num < 100)
                return decenas[Math.floor(num / 10)] + (num % 10 ? " Y " + unidades[num % 10] : "");
            if (num < 1000)
                return centenas[Math.floor(num / 100)] + (num % 100 ? " " + convertirParteEntera(num % 100) : "");

            if (num < 1000000) {
                let miles = Math.floor(num / 1000);
                let resto = num % 1000;
                palabras = (miles === 1 ? "MIL" : convertirParteEntera(miles) + " MIL");
                if (resto > 0)
                    palabras += " " + convertirParteEntera(resto);
                return palabras;
            }

            if (num < 1000000000) {
                let millones = Math.floor(num / 1000000);
                let resto = num % 1000000;
                palabras = (millones === 1 ? "UN MILLÓN" : convertirParteEntera(millones) + " MILLONES");
                if (resto > 0)
                    palabras += " " + convertirParteEntera(resto);
                return palabras;
            }

            let billones = Math.floor(num / 1000000000);
            let resto = num % 1000000000;
            palabras = (billones === 1 ? "UN BILLÓN" : convertirParteEntera(billones) + " BILLONES");
            if (resto > 0)
                palabras += " " + convertirParteEntera(resto);
            return palabras;
        }

        // Función para convertir la parte decimal a palabras
        function convertirParteDecimal(num) {
            return " " + num + "/100";
        }

        // Separar la parte entera y decimal del número
        let partes = String(num).split('.');
        let parteEntera = partes[0];
        let parteDecimal = partes[1];

        // Convertir la parte entera a palabras
        let resultado = convertirParteEntera(parseInt(parteEntera));

        // Si hay parte decimal, convertirla a palabras
        if (parteDecimal) {
            resultado += " PESOS " + convertirParteDecimal(parteDecimal);
        } else {
            resultado += " PESOS";
        }

        // Agregar la parte de la moneda mexicana
        resultado += " M.N.";

        return resultado.toUpperCase();
    }


    document.getElementById('Limpiar').addEventListener('click', function (event) {
        document.querySelector('#GuardarFactura').style.display = "block";
        document.querySelector('#ModificarFactura').style.display = "none";

        const ids = [
            "idTipoComprobante", "cliente", "idCliente", "periodicidad", "mes",
            "conceptoFactura", "fechaPago", "observaciones", "idUsoCFDI", "usoCFDI",
            "serie", "moneda", "idFormaPago", "formaPago", "cuentaBancaria",
            "metodoPago", "idTipoRelacion", "tipoServicio", "condicionPago",
            "idPermiso", "Subtotal", "IVA", "Total", "totalLetras",
            "folioEncontrado", "productoServicio", "idProductoServicio",
            "cantidad", "unidadMedida", "idUnidadMedida", "detalleConcepto",
            "precioUnitario", "importeConcepto", "numeroCuentaPredial",
            "nc_factura", "nc_serie", "nc_fecha", "nc_folioFiscal",
            'folio', 'folioEncontrado', 'usoCFDI', 'idUsoCFDI',
            'formaPago', 'idFormaPago', 'productoServicio',
            'idProductoServicio', 'unidadMedida', 'idUnidadMedida',
            'calle', 'numeroExterior', 'numeroInterior', 'delegacion',
            'estado', 'pais', 'codigoPostal', 'email',
            'tipoPersona', 'regimenFiscal', 'condicionPago',
            'cuentaBancaria', 'numeroPermiso', 'detalleConcepto'
        ];

        ids.forEach(id => {
            const element = document.getElementById(id);
            if (element) {
                element.focus();
                element.value = ""; // Limpia el valor
                element.blur(); // Da foco al elemento
                element.blur();
            }
        });

        // Manejo de periodicidad
        const periodicidad = document.getElementById("periodicidad");
        if (periodicidad) {
            periodicidad.required = false;
            periodicidad.disabled = true;
            periodicidad.focus();
            periodicidad.blur();
            addImportantStyle('periodicidad');
        }

        var dataList = document.getElementById('ListPermisos');
        if (dataList) {
            dataList.innerHTML = '';
        }

        var inputPermiso = document.getElementById('numeroPermiso');
        if (inputPermiso) {
            inputPermiso.value = '';
            inputPermiso.disabled = true;
            inputPermiso.focus();
            inputPermiso.blur();
        }

        var textarea = document.getElementById('detalleConcepto');
        if (textarea) {
            textarea.value = "";
            textarea.blur();
        }

        const tipoRelacion = document.getElementById('idTipoRelacion');
        const spanNoRetenido = document.getElementById('spanNoTipoRelacion');
        const spanSiRetenido = document.getElementById('spanSiTipoRelacion');
        if (this.checked) {
            spanNoRetenido.hidden = true;
            spanSiRetenido.hidden = false;
            tipoRelacion.required = true;
            tipoRelacion.disabled = false;
            removeImportantStyle('idTipoRelacion');
        } else {
            spanNoRetenido.hidden = false;
            spanSiRetenido.hidden = true;
            tipoRelacion.required = false;
            tipoRelacion.value = "";
            tipoRelacion.disabled = true;
            addImportantStyle('idTipoRelacion');
        }

        limpiarTablas();


        const divTotalLetras = document.getElementById('columnaTotalLetras');
        const totalLetras = document.getElementById('totalLetras');
        const spanNoTotalLetras = document.getElementById('spanNoTotalLetras');
        const spanSiTotalLetras = document.getElementById('spanSiTotalLetras');
        spanNoTotalLetras.hidden = false;
        spanSiTotalLetras.hidden = true;
        totalLetras.value = "";
        document.getElementById("totalLetras").blur();
        divTotalLetras.style.display = 'none';
    });


    window.validateFactura = validateFactura;
    window.addImportantStyle = addImportantStyle;
    window.removeImportantStyle = removeImportantStyle;
    window.get_tipoSerie = get_tipoSerie;
    window.setInputByIdData = setInputByIdData;
    window.get_idUsoCfdi = get_idUsoCfdi;
    window.get_tipoServicio = get_tipoServicio;
    window.get_idFormaPago = get_idFormaPago;
    window.validarCuentaBancaria = validarCuentaBancaria;
    window.redirigir = redirigir;
    window.get_idProductoServicio = get_idProductoServicio;
    window.validarCantidad = validarCantidad;
    window.get_idUnidadMedida = get_idUnidadMedida;
    window.notaCreditoMenu = notaCreditoMenu;
    window.convertirNumero = convertirNumero;

    // window.imprimirTabla = imprimirTabla;
});
