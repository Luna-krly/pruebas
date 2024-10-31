/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.write('<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>');
document.write('<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>');
document.write('<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>');

document.addEventListener('DOMContentLoaded', function () {
    var valordeImporte = 0;
    function CalcularImporte() {
        valordeImporte = 0;
        var cantidad = parseFloat(document.getElementById("cantidad").value);
        var precio = parseFloat(document.getElementById("precioUnitario").value);
        var importe = (cantidad * precio).toFixed(2);
        valordeImporte = importe;
        document.getElementById("importeConcepto").value = importe;
        document.getElementById("importeConcepto").focus();
    }
    function calcularImporteImpuesto() {

        var importe = parseFloat(valordeImporte);
        var porcentaje = parseFloat(document.getElementById("porcentajeImpuesto").value);

        // Validar el importe
        if (!importe) {
            customeError("ERROR", 'ES NECESARIO TENER UN IMPORTE');
            return;
        } else if (isNaN(importe) || importe <= 0) {
            customeError("ERROR", 'EL IMPORTE DEBE SER UN NÚMERO POSITIVO MAYOR QUE CERO');
            return;
        }

        // Validar el porcentaje
        if (!porcentaje) {
            customeError("ERROR", 'ES NECESARIO TENER UN PORCENTAJE');
            return;
        } else if (isNaN(porcentaje) || porcentaje < 0 || porcentaje > 100) {
            customeError("ERROR", 'EL PORCENTAJE DEBE ESTAR ENTRE 0 Y 100');
            return;
        }

        var numero_porcentaje = porcentaje / 100;
        var formatoporcentaje = numero_porcentaje.toFixed(5);
        document.getElementById('porcentajeImpuesto').value = formatoporcentaje;
        document.getElementById('porcentajeImpuesto').focus();

        var impuesto = numero_porcentaje * importe;
        var formatoimpuesto = impuesto.toFixed(2);
        document.getElementById('importeImpuesto').value = formatoimpuesto;
        document.getElementById('importeImpuesto').focus();

    }
    //VALIDAR QUE EL FOLIO DE FACTURA ES EL CORRECTO
    function searchFactura() {
        const numeroFolio = document.getElementById("folio").value;
        if (numeroFolio == "") {
            customeError("ERROR", "INGRESE UN NÚMERO DE FOLIO");
            document.getElementById("folioEncontrado").value = "";
            return;
        }
        validateFactura();
        document.getElementById("folioEncontrado").value = numeroFolio;
        const body = {
            action: "104",
            numeroFolio: numeroFolio
        }

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "Srv_Facturas", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xhr.onload = function () {
            if (xhr.status == 200) {
                try {


                    var response = JSON.parse(xhr.responseText);
                    $('#modalFactuacion').modal('hide');

                    if (response.tipomensaje == "Error") {
                        response.messages.forEach(function (message) {
                            customeError("Error", message);
                        });
                    }
                    document.querySelector('#GuardarFactura').style.display = "none";
                    document.querySelector('#ModificarFactura').style.display = "block";
                    if (response?.encabezado?.idTipoComprobante) {
                        document.getElementById("idTipoComprobante").value = response.encabezado.idTipoComprobante;
                        get_tipoSerie();
                    }

                    if (response?.encabezado?.idCliente) {
                        document.getElementById("idCliente").value = response.encabezado.idCliente;
                        setInputByIdData(response.encabezado.idCliente, "ListClientesSat", "cliente");
                        document.getElementById("cliente").focus();
                        document.getElementById("cliente").blur();
                        get_idCliente();
                    }

                    if (response?.encabezado?.idPeriodicidad)
                        document.getElementById("periodicidad").value = response.encabezado.idPeriodicidad;
                    if (response?.encabezado?.mes)
                        document.getElementById("mes").value = response.encabezado.mes;
                    if (response?.encabezado?.conceptoFactura) {
                        document.getElementById("conceptoFactura").value = response.encabezado.conceptoFactura;
                        document.getElementById("conceptoFactura").focus();
                        document.getElementById("conceptoFactura").blur();
                    }

                    if (response?.encabezado?.fechaPago) {
                        document.getElementById("fechaPago").value = response.encabezado.fechaPago;
                        document.getElementById("fechaPago").focus();
                        document.getElementById("fechaPago").blur();
                    }

                    if (response?.encabezado?.idUsoCFDI) {
                        document.getElementById("idUsoCFDI").value = response.encabezado.idUsoCFDI;
                        setInputByIdData(response.encabezado.idUsoCFDI, "ListUsoCFDI", "usoCFDI");
                        document.getElementById("usoCFDI").focus();
                        document.getElementById("usoCFDI").blur();
                    }
                    if (response?.encabezado?.idMonedas)
                        document.getElementById("moneda").value = response.encabezado.idMonedas;

                    if (response?.encabezado?.serie) {
                        document.getElementById("serie").value = response.encabezado.serie;
                        document.getElementById("serie").focus();
                        document.getElementById("serie").blur();
                    }

                    if (response?.encabezado?.idTipoServicio) {
                        get_tipoServicio();
                        document.getElementById("tipoServicio").value = response.encabezado.idTipoServicio;
                    }

                    if (response?.encabezado?.idMetodoPago)
                        document.getElementById("metodoPago").value = response.encabezado.idMetodoPago;

                    if (response?.encabezado?.observaciones) {
                        document.getElementById("observaciones").value = response.encabezado.observaciones;
                        document.getElementById("observaciones").focus();
                        document.getElementById("observaciones").blur();
                    }

                    if (response?.encabezado?.idPermiso) {
                        document.getElementById("idPermiso").value = response.encabezado.idPermiso;
                        setInputByIdData(response.encabezado.idPermiso, "ListPermisos", "numeroPermiso");
                        document.getElementById("numeroPermiso").focus();
                        document.getElementById("numeroPermiso").blur();
                    }

                    if (response?.encabezado?.idFormaPago) {
                        document.getElementById("idFormaPago").value = response.encabezado.idFormaPago;
                        setInputByIdData(response.encabezado.idFormaPago, "ListFormaPago", "formaPago");
                        document.getElementById("formaPago").focus();
                        document.getElementById("formaPago").blur();
                    }

                    if (response?.encabezado?.idTipoRelacion && response?.encabezado?.idTipoRelacion !== "0") {
                        document.getElementById("tipoRelacion").click();
                        document.getElementById("idTipoRelacion").value = response.encabezado.idTipoRelacion;
                    }

                    if (response?.encabezado?.cuentaBanco) {
                        document.getElementById("cuentaBancaria").value = response.encabezado.cuentaBanco;
                    }

                    if (response?.encabezado?.totalletras) {
                        document.getElementById("totalLetras").value = response.encabezado.totalletras;

                        const divTotalLetras = document.getElementById('columnaTotalLetras');
                        const totalLetras = document.getElementById('totalLetras');
                        const spanNoTotalLetras = document.getElementById('spanNoTotalLetras');
                        const spanSiTotalLetras = document.getElementById('spanSiTotalLetras');
                        spanNoTotalLetras.hidden = true;
                        spanSiTotalLetras.hidden = false;

                        // Use setTimeout to ensure DOM update before focusing
                        setTimeout(() => {
                            totalLetras.focus();
                        }, 0);
                        divTotalLetras.style.display = 'block';
                    }

                    //let idTipoComprobante = document.getElementById("idTipoComprobante");
                    let table = document.getElementById("tablaProductosServicios").getElementsByTagName('tbody')[0];
                    let tipoComprobante = document.getElementById('idTipoComprobante');
                    let textTipoComprobante = idTipoComprobante.options[tipoComprobante.selectedIndex].text;


                    response.detalles.forEach((dato, index) => {
                        updateRowNumbers();
                        let newRow = table.insertRow(table.rows.length);

//                                  // Insertar celdas
                        let cell1 = newRow.insertCell(0);
                        let cell2 = newRow.insertCell(1);
                        let cel3 = newRow.insertCell(2);
                        let cell4 = newRow.insertCell(3);
                        let cell5 = newRow.insertCell(4);
                        let cell6 = newRow.insertCell(5);
                        let cell7 = newRow.insertCell(6);
                        let cell8 = newRow.insertCell(7);
                        let cell9 = newRow.insertCell(8);
                        let cell10 = newRow.insertCell(9);
                        let cell11 = newRow.insertCell(10);
//                                  // Asignar valores a las celdas
                        cell1.innerHTML = table.rows.length;
                        cell1.innerHTML += '<input type="hidden" name="renglon[]" value="' + table.rows.length + '">';

                        console.log("+++++++++++++++++++renglon" + dato.renglon);
                        cell2.innerHTML = setInputByIdData(dato.idProducoServicio, "ListProductoServicio", "productoServicio", true);
                        cell2.innerHTML += '<input type="hidden" name="idProductoServicio[]" value="' + (dato.idProducoServicio || "") + '">';

                        cel3.innerHTML = dato.cantidad;
                        cel3.innerHTML += '<input type="hidden" name="cantidad[]" value="' + (dato.cantidad || "") + '">';


                        cell4.innerHTML = setInputByIdData(dato.idUnidadMedida, "ListUnidadMedida", "unidadMedida", true);
                        cell4.innerHTML += '<input type="hidden" name="idUnidadMedida[]" value="' + (dato.idUnidadMedida || "") + '">';

                        cell5.innerHTML = dato.concepto;
                        cell5.innerHTML += '<input type="hidden" name="detalleConcepto[]" value="' + (dato.concepto || "") + '">';
//
                        cell6.innerHTML = dato.precioUnitario;
                        cell6.innerHTML += '<input type="hidden" name="precioUnitario[]" value="' + (dato.precioUnitario || "") + '">';

                        cell7.innerHTML = dato.importe;
                        cell7.innerHTML += '<input type="hidden" name="importeConcepto[]" value="' + (dato.importe || "") + '">';
                        valordeImporte = dato.importe;
                        // document.getElementById("importeConcepto").value = dato.importe;

                        cell8.innerHTML = dato.predial || "";
                        cell8.innerHTML += '<input type="hidden" name="cuentaPredial[]" value="' + (dato.predial || "") + '">';

                        cell9.innerHTML = dato.serie;
                        cell9.innerHTML += '<input type="hidden" name="serie[]" value="' + (dato.serie || "") + '">';

                        cell10.innerHTML = dato.fechaFactura;
                        cell10.innerHTML += '<input type="hidden" name="fechaFactura[]" value="' + (dato.fechaFactura || "") + '">';

                        // Seleccionamos los <th> por su posición en la fila (11, 12, 13, 14 son sus posiciones en el ejemplo dado)
                        const tabla = document.getElementById('tablaProductosServicios');

                        // Seleccionamos los <th> por su posición dentro de la tabla seleccionada
                        const thFacturaNC = tabla.querySelector('thead tr th:nth-child(11)');
                        const thSerieNC = tabla.querySelector('thead tr th:nth-child(12)');
                        const thFechaNC = tabla.querySelector('thead tr th:nth-child(13)');
                        const thFolioFiscalNC = tabla.querySelector('thead tr th:nth-child(14)');


                        console.log("tipo comprobaaaaaante+ " + textTipoComprobante);
                        if (textTipoComprobante !== "E - EGRESO") {
                            notaCreditoMenu(0);
                            // Agregamos la nueva clase
                            thFacturaNC.classList.add('d-none');
                            thSerieNC.classList.add('d-none');
                            thFechaNC.classList.add('d-none');
                            thFolioFiscalNC.classList.add('d-none');
                            cell11.innerHTML = '<button type="button" class="btn btn-sm" style="color:white; background-color: #A70303;" onclick="deleteRow(this)"><i class="fas fa-trash"></i></button>';
                        } else {
                            notaCreditoMenu(1);
                            // Agregamos la nueva clase
                            thFacturaNC.classList.remove('d-none');
                            thSerieNC.classList.remove('d-none');
                            thFechaNC.classList.remove('d-none');
                            thFolioFiscalNC.classList.remove('d-none');

                            let cell12 = newRow.insertCell(11);
                            let cell13 = newRow.insertCell(12);
                            let cell14 = newRow.insertCell(13);
                            let cell15 = newRow.insertCell(14);

                            cell11.innerHTML = dato.notaCreditoFactura || "";
                            cell11.innerHTML += '<input type="hidden" name="importeConcepto[]" value="' + (dato.notaCreditoFactura || "") + '">';

                            cell12.innerHTML = dato.notaCreditoSerie || "";
                            cell12.innerHTML += '<input type="hidden" name="cuentaPredial[]" value="' + (dato.notaCreditoSerie || "") + '">';

                            cell13.innerHTML = dato.notaCreditoFecha || "";
                            cell13.innerHTML += '<input type="hidden" name="serie[]" value="' + (dato.notaCreditoFecha || "") + '">';

                            cell14.innerHTML = dato.notaCreditoFolio || "";
                            cell14.innerHTML += '<input type="hidden" name="fechaFactura[]" value="' + (dato.notaCreditoFolio || "") + '">';

                            cell15.innerHTML = '<button type="button" class="btn btn-sm" style="color:white; background-color: #A70303;" onclick="deleteRow(this)"><i class="fas fa-trash"></i></button>';

                        }


                    });

                    let tableImportes = document.getElementById("tablaImpuestos").getElementsByTagName('tbody')[0];
                    let tipoImpuesto = document.getElementById('impuesto');
                    console.log("Ti´po impuesto " + tipoImpuesto.value)
                    let tipoFactor = document.getElementById('tipoFactor');


                    response.importes.forEach((dato, index) => {
                        updateRowNumbersImpuestos();

                        console.log("+++++++++++++++++++renglon impuestos" + dato.renglon);
                        console.log("+++++++++++++++++++tipo Impuesto impuestos" + dato.tipoImpuesto);
                        console.log("+++++++++++++++++++tipo factor impuestos" + dato.tipoFactor);
                        let newRow = tableImportes.insertRow(tableImportes.rows.length);
                        //  let tipoImpuesto = document.getElementById('impuesto');
                        let valorImpuesto = dato.tipoImpuesto; //
                        let textTipoImpuesto;
                        // let textTipoImpuesto = tipoImpuesto.options[dato.tipoImpuesto].text;
                        for (let i = 0; i < tipoImpuesto.options.length; i++) {
                            let option = tipoImpuesto.options[i];

                            // Compara el value de la opción con el valor que tienes
                            if (option.value === valorImpuesto) {
                                // Si coincide, accede al texto de la opción y a los atributos data-value y data-description
                                textTipoImpuesto = option.text;
                                console.log("Texto del impuesto:", textTipoImpuesto);
                                break; // Sal del bucle una vez que encuentres la coincidencia
                            }
                        }
                        console.log("textttttttttttt impuesto " + textTipoImpuesto);
                        let textTipoFactor = tipoFactor.options[dato.tipoFactor].text;
                        console.log("texxxxxttttttt factor " + textTipoFactor);
//                                  // Insertar celdas
                        let cell1 = newRow.insertCell(0);
                        let cell2 = newRow.insertCell(1);
                        let cel3 = newRow.insertCell(2);
                        let cell4 = newRow.insertCell(3);
                        let cell5 = newRow.insertCell(4);
                        let cell6 = newRow.insertCell(5);
                        let cell7 = newRow.insertCell(6);
                        let cell8 = newRow.insertCell(7);
                        let cell9 = newRow.insertCell(8);
                        // Asignar valores a las celdas
                        cell1.innerHTML = tableImportes.rows.length;
                        cell1.innerHTML += '<input type="hidden" name="renglon[]" value="' + tableImportes.rows.length + '">';

                        cell2.innerHTML = dato.impuesto;
                        cell2.innerHTML += '<input type="hidden" name="impuesto[]" value="' + (dato.impuesto || "") + '">';
//                          
                        cel3.innerHTML = textTipoImpuesto;
                        cel3.innerHTML += '<input type="hidden" name="idTipoImpuesto[]" value="' + (dato.tipoImpuesto || "") + '">';


                        cell4.innerHTML = textTipoFactor;
                        cell4.innerHTML += '<input type="hidden" name="idTipoFactor[]" value="' + (dato.tipoFactor || "") + '">';

                        cell5.innerHTML = dato.porcentaje;
                        cell5.innerHTML += '<input type="hidden" name="porcentajeImpuesto[]" value="' + (dato.porcentaje || "") + '">';
//
                        cell6.innerHTML = dato.importeImpuesto;
                        cell6.innerHTML += '<input type="hidden" name="importeImpuesto[]" value="' + (dato.importeImpuesto || "") + '">';

                        cell7.innerHTML = dato.importeBase;
                        cell7.innerHTML += '<input type="hidden" name="importeBase[]" value="' + (dato.importeBase || "") + '">';

                        cell8.innerHTML = dato.renglonProductoServicio || "";
                        cell8.innerHTML += '<input type="hidden" name="renglonProducto[]" value="' + (dato.renglonProductoServicio || "") + '">';

                        cell9.innerHTML = '<button type="button" class="btn btn-sm" style="color:white; background-color: #A70303;" onclick="deleteRow(this)"><i class="fas fa-trash"></i></button>';



                    });

                    calcularTotales();

                } catch (e) {
                    customeError("ERROR", "ERROR AL PROCESAR LA RESPUESTA JSON: " + e);
                    console.error("Error al procesar la respuesta JSON: ", e);
                }
            } else {
                customeError("ERROR", 'ERROR EN AL SOLICITUD AJAX.');
                console.error("Error en la solicitud AJAX.");
            }
        };
        xhr.send(JSON.stringify(body));



    }




    function sendData(action) {
        let body = {};


        let tablaImpuestos = document.getElementById("tablaImpuestos");
        let filasImpuestos = tablaImpuestos.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
        let datosImpuestos = [];
        for (let i = 0; i < filasImpuestos.length; i++) {
            let celdas = filasImpuestos[i].getElementsByTagName("td");
            let filaDatosImpuestos = {};
            for (let j = 0; j < celdas.length; j++) {
                let input = celdas[j].getElementsByTagName("input")[0];
                if (input) {
                    console.log(input.value + " ========= " + j);
                    if (j == 0)
                        filaDatosImpuestos["renglon"] = input.value;
                    if (j == 1)
                        filaDatosImpuestos["impuesto"] = input.value;
                    if (j == 2)
                        filaDatosImpuestos["idTipoImpuesto"] = input.value;
                    if (j == 3)
                        filaDatosImpuestos["idTipoFactor"] = input.value;
                    if (j == 4)
                        filaDatosImpuestos["porcentajeImpuesto"] = input.value;
                    if (j == 5)
                        filaDatosImpuestos["importeImpuesto"] = input.value;
                    if (j == 6)
                        filaDatosImpuestos["importeBase"] = input.value;
                    if (j == 7)
                        filaDatosImpuestos["renglonProducto"] = input.value;
                }
            }
            datosImpuestos.push(filaDatosImpuestos);
        }
//        
//        
//        // Validar que ninguno de los campos esté vacío
//        for (let i = 0; i < datosImpuestos.length; i++) {
//            let fila = datosImpuestos[i];
//            if (!fila.renglon || !fila.impuesto || !fila.idTipoImpuesto || !fila.idTipoFactor || !fila.porcentajeImpuesto || !fila.importeImpuesto || !fila.importeBase || !fila.renglonProducto) {
//                console.log("RENGLON: " + fila.renglon);
//                console.log("IMPUESTO " + fila.impuesto);
//                console.log("TIPO DE IMPUESTO : " + fila.idTipoImpuesto);
//                console.log("TIPO DE FACTOR " + fila.idTipoFactor);
//                console.log("PORCENTAJE IMPUESTO: " + fila.porcentajeImpuesto);
//                console.log("IMPORTE IMPUESTO: " + fila.importeImpuesto);
//                console.log("IMPORTE BASE: " + fila.importeBase);
//                console.log("RENGLON PRODUCTO: " + fila.renglonProducto);
//                // Mostrar mensaje de error si algún campo está vacío
//                customeError("ERROR", "POR FAVOR, INGRESA UN REGISTRO EN LA TABLA DE IMPUESTOS");
//                return; // Detener la función si hay un error
//            }
//        }





        let tablaProductosServicios = document.getElementById("tablaProductosServicios");
        let filasProductosServicios = tablaProductosServicios.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
        let datosProductosServicios = [];
        for (let i = 0; i < filasProductosServicios.length; i++) {
            let celdas = filasProductosServicios[i].getElementsByTagName("td");
            let filaDatosProdServ = {};
            for (let j = 0; j < celdas.length; j++) {
                let input = celdas[j].getElementsByTagName("input")[0];
                if (input) {
                    console.log(input.value + " ========= " + j);
                    if (j == 0)
                        filaDatosProdServ["renglon"] = input.value;
                    if (j == 1)
                        filaDatosProdServ["idProductoServicio"] = input.value;
                    if (j == 2)
                        filaDatosProdServ["cantidad"] = input.value;
                    if (j == 3)
                        filaDatosProdServ["idUnidadMedida"] = input.value;
                    if (j == 4)
                        filaDatosProdServ["detalleConcepto"] = input.value;
                    if (j == 5)
                        filaDatosProdServ["precioUnitario"] = input.value;
                    if (j == 6)
                        filaDatosProdServ["importeConcepto"] = input.value;
                    if (j == 7)
                        filaDatosProdServ["cuentaPredial"] = input.value;
                    if (j == 8)
                        filaDatosProdServ["serie"] = input.value;
                    if (j == 9)
                        filaDatosProdServ["fechaFactura"] = input.value;
                    if (j == 10)
                        filaDatosProdServ["nc_factura"] = input.value;
                    if (j == 11)
                        filaDatosProdServ["nc_serie"] = input.value;
                    if (j == 12)
                        filaDatosProdServ["nc_fecha"] = input.value;
                    if (j == 13)
                        filaDatosProdServ["nc_folioFiscal"] = input.value;
                }
            }
            datosProductosServicios.push(filaDatosProdServ);
        }
//
//        // Validar que ninguno de los campos esté vacío
//        for (let i = 0; i < datosProductosServicios.length; i++) {
//            let fila = datosProductosServicios[i];
//            if (!fila.renglon || !fila.idProductoServicio || !fila.cantidad || !fila.idUnidadMedida || !fila.detalleConcepto || !fila.precioUnitario || !fila.importeConcepto || !fila.fechaFactura) {
//                console.log("RENGLON: " + fila.renglon);
//                console.log("ID PROD SERV " + fila.idProductoServicio);
//                console.log("CANTIDAD: " + fila.cantidad);
//                console.log("ID U MEDIDA: " + fila.idUnidadMedida);
//                console.log("DETALLE CONCEPTO: " + fila.detalleConcepto);
//                console.log("PRECIO UNITARIO: " + fila.precioUnitario);
//                console.log("IMPORTE CONCEPTO: " + fila.importeConcepto);
//                console.log("FECHA CAPTURA: " + fila.fechaFactura);
//                // Mostrar mensaje de error si algún campo está vacío
//                customeError("ERROR", "POR FAVOR, INGRESA UN REGISTRO EN LA TABLA DE PRODUCTOS Y SERVICIOS");
//                return; // Detener la función si hay un error
//            }
//        }

        let idTipoComprobante = document.getElementById("idTipoComprobante");
        let tipoComprobante = idTipoComprobante.options[idTipoComprobante.selectedIndex].text;
        let idCliente = document.getElementById("idCliente");
        let periodicidad = document.getElementById("periodicidad");
        let mes = document.getElementById("mes");
        let conceptoFactura = document.getElementById("conceptoFactura");
        let fechaPago = document.getElementById("fechaPago");
        let observaciones = document.getElementById("observaciones");
        let idUsoCFDI = document.getElementById("idUsoCFDI");
        let fechaFactura = document.getElementById("fechaFactura");
        let cpEmisorFactura = document.getElementById("cpEmisorFactura");
        let serie = document.getElementById("serie");
        let moneda = document.getElementById("moneda");
        let tipoCambio = document.getElementById("tipoCambio");
        let idFormaPago = document.getElementById("idFormaPago");
        let cuentaBancaria = document.getElementById("cuentaBancaria");
        let metodoPago = document.getElementById("metodoPago");
        let idTipoRelacion = document.getElementById("idTipoRelacion");
        let tipoServicio = document.getElementById("tipoServicio");
        let condicionPago = document.getElementById("condicionPago");
        let idPermiso = document.getElementById("idPermiso");
        let Subtotal = document.getElementById("Subtotal");
        let IVA = document.getElementById("IVA");
        let Total = document.getElementById("Total");
        let totalLetras = document.getElementById("totalLetras");
        let folioEncontrado = document.getElementById("folioEncontrado");

        // Crear un objeto para mapear las variables a sus valores
        var campos = {
            idTipoComprobante: idTipoComprobante.value,
            idCliente: idCliente.value,
            mes: mes.value,
            conceptoFactura: conceptoFactura.value,
            fechaPago: fechaPago.value,
            observaciones: observaciones.value,
            idUsoCFDI: idUsoCFDI.value,
            fechaFactura: fechaFactura.value,
            cpEmisorFactura: cpEmisorFactura.value,
            serie: serie.value,
            moneda: moneda.value,
            tipoCambio: tipoCambio.value,
            idFormaPago: idFormaPago.value,
            metodoPago: metodoPago.value,
            idPermiso: idPermiso.value,
            Subtotal: Subtotal.value,
            IVA: IVA.value,
            Total: Total.value
        };

        // Crear un objeto para mapear los nombres de campo a mensajes personalizados
        var mensajesErrores = {
            idTipoComprobante: "POR FAVOR, COMPLETA EL CAMPO DE TIPO DE COMPROBANTE",
            idCliente: "POR FAVOR, COMPLETA EL CAMPO DE CLIENTE",
            mes: "POR FAVOR, COMPLETA EL CAMPO DE MES",
            conceptoFactura: "POR FAVOR,  COMPLETA EL CAMPO DE CONCEPTO DE FACTURA",
            fechaPago: "POR FAVOR, EL CAMPO DE FECHA DE PAGO",
            observaciones: "POR FAVOR, COMPLETA EL CAMPO DE OBSERVACIONES",
            idUsoCFDI: "POR FAVOR, COMPLETA EL CAMPO DE  USO DE CFDI",
            fechaFactura: "POR FAVOR, COMPLETA EL CAMPO DE FECHA DE FACTURA",
            cpEmisorFactura: "POR FAVOR, COMPLETA EL CAMPO DE CÓDIGO POSTAL DEL EMISOR",
            serie: "POR FAVOR, COMPLETA EL CAMPO DE SERIE",
            moneda: "POR FAVOR, COMPLETA EL CAMPO DE MONEDA",
            tipoCambio: "POR FAVOR, COMPLETA EL CAMPO DE TIPO DE CAMBIO",
            idFormaPago: "POR FAVOR, COMPLETA EL CAMPO DE FORMA DE PAGO",
            cuentaBancaria: "POR FAVOR, COMPLETA EL CAMPO DE CUENTA BANCARIA",
            metodoPago: "POR FAVOR, COMPLETA EL CAMPO DE MÉTODO DE PAGO",
            idPermiso: "POR FAVOR, COMPLETA EL CAMPO DE PERMISO",
            Subtotal: "POR FAVOR, COMPLETA EL CAMPO DE SUBTOTAL",
            IVA: "POR FAVOR, COMPLETA EL CAMPO DE IVA",
            Total: "POR FAVOR, COMPLETA EL CAMPO DE TOTAL"
        };

        // Iterar sobre el objeto para verificar si algún campo está vacío
        for (var campo in campos) {
            if (campos[campo] === "") {
                if (campo == "serie" && tipoComprobante == "T - TRASLADO") {

                } else {
                    customeError("ERROR", mensajesErrores[campo]);
                    return;
                }
                // Mostrar el mensaje de error personalizado para el campo vacío 
                // Detener la función después de mostrar el mensaje de error
            }
        }


        body.idTipoComprobante = idTipoComprobante.value;
        body.idCliente = idCliente.value.toUpperCase();
        body.periodicidad = periodicidad.value.toUpperCase();
        body.mes = mes.value.toUpperCase();
        body.conceptoFactura = conceptoFactura.value.toUpperCase();
        body.fechaPago = fechaPago.value.toUpperCase();
        body.observaciones = observaciones.value.toUpperCase();
        body.idUsoCFDI = idUsoCFDI.value.toUpperCase();
        body.fechaFactura = fechaFactura.value.toUpperCase();
        body.cpEmisorFactura = cpEmisorFactura.value.toUpperCase();
        body.serie = serie.value.toUpperCase();
        body.moneda = moneda.value.toUpperCase();
        body.tipoCambio = tipoCambio.value.toUpperCase();
        body.idFormaPago = idFormaPago.value.toUpperCase();
        body.cuentaBancaria = cuentaBancaria.value.toUpperCase();
        body.metodoPago = metodoPago.value.toUpperCase();
        body.idTipoRelacion = idTipoRelacion.value.toUpperCase();
        body.tipoServicio = tipoServicio.value.toUpperCase();
        body.condicionPago = condicionPago.value.toUpperCase();
        body.idPermiso = idPermiso.value.toUpperCase();
        body.Subtotal = Subtotal.value;
        body.IVA = IVA.value;
        body.Total = Total.value;
        body.totalLetras = totalLetras.value.toUpperCase();
        body.impuestos = datosImpuestos;
        body.productos = datosProductosServicios;
        body.folioEncontrado = folioEncontrado.value;
        body.action = action;

        //if (jsonArrendamiento?.idMemorandum)
        //    body.idMemorandum = jsonArrendamiento.idMemorandum;


        console.log(body);
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "Srv_Facturas", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xhr.onload = function () {
            if (xhr.status == 200) {
                try {

                    let mensajeExito = document.getElementById("MensajeExito");
                    let tituloExito = document.getElementById("TituloMensajeExito");
                    let descripcionExito = document.getElementById("DescripcionMensajeExito");
                    var response = JSON.parse(xhr.responseText);

                    if (response.tipomensaje == "Exito") {
                        response.messages.forEach(function (message) {
                            tituloExito.innerText = response.tipomensaje;
                            descripcionExito.innerText = message;
                            mensajeExito.style.display = "block";
                            // Ocultar el mensaje de alerta después de unos segundos
                            setTimeout(function () {
                                mensajeExito.style.display = 'none';
                            }, 3500);
                        });
                        window.location.href = "Srv_Facturas";

                    } else if (response.tipomensaje == "Error") {
                        response.messages.forEach(function (message) {
                            customeError("Error", message);
                        });
                    }

                } catch (e) {
                    customeError("ERROR", "ERROR AL PROCESAR LA RESPUESTA JSON: " + e);
                    console.error("Error al procesar la respuesta JSON: ", e);
                }
            } else {
                customeError("ERROR", 'ERROR EN AL SOLICITUD AJAX.');
                console.error("Error en la solicitud AJAX.");
            }
        };
        xhr.send(JSON.stringify(body));

        document.getElementById("Limpiar").click();
        limpiarTablas();
    }


    var retenido = 0;
    var traslado = 0;
    function insertImpuesto() {
        var importeBase = parseFloat(valordeImporte);
        var impuestoTrasladado = document.getElementById('impuestoTrasladado');
        var impuestoRetenido = document.getElementById('impuestoRetenido');

        if (!impuestoTrasladado.checked && !impuestoRetenido.checked) {
            customeError("ERROR", 'FAVOR DE SELECCIONAR UN TIPO DE IMPUESTO');
            return; // Detener la función después de mostrar el mensaje de error
        }
        var porcentajeImpuesto = document.getElementById('porcentajeImpuesto').value;
        var importeImpuesto = document.getElementById('importeImpuesto').value;
        // Crear un objeto para mapear las variables a sus nombres de campo
        var campos = {
            impuesto: document.getElementById('impuesto').value,
            tipoFactor: document.getElementById('tipoFactor').value,
            porcentajeImpuesto: porcentajeImpuesto,
            importeImpuesto: importeImpuesto
        };

        // Crear un objeto para mapear los nombres de campo a mensajes personalizados
        var mensajesErrores = {
            impuesto: "POR FAVOR, COMPLETA EL CAMPO DE IMPUESTO",
            tipoFactor: "POR FAVOR, COMPLETA EL CAMPO DE TIPO DE FACTOR",
            porcentajeImpuesto: "POR FAVOR, COMPLETA EL CAMPO DE PORCENTAJE DE IMPUESTO",
            importeImpuesto: "POR FAVOR, COMPLETA EL CAMPO DE IMPORTE DE IMPUESTO"
        };

        // Iterar sobre el objeto para verificar si algún campo está vacío
        for (var campo in campos) {
            if (campos[campo] === "") {
                // Mostrar el mensaje de error personalizado para el campo vacío
                customeError("ERROR", mensajesErrores[campo]);
                return; // Detener la función después de mostrar el mensaje de error
            }
        }
        // Extraer valores de impuesto y tipoFactor
        var impuestoSelect = document.getElementById('impuesto');
        var selectedImpuestoOption = impuestoSelect.options[impuestoSelect.selectedIndex];
        var idImpuesto = selectedImpuestoOption.value;
        var claveImpuesto = selectedImpuestoOption.getAttribute('data-clave').toUpperCase();
        var descripcionImpuesto = selectedImpuestoOption.getAttribute('data-descripcion').toUpperCase();
        var impuesto = claveImpuesto + ' - ' + descripcionImpuesto;

        var tipoFactorSelect = document.getElementById('tipoFactor');
        var selectedTipoFactorOption = tipoFactorSelect.options[tipoFactorSelect.selectedIndex];
        var idTipoFactor = selectedTipoFactorOption.value;
        var tipoFactor = selectedTipoFactorOption.getAttribute('data-clave').toUpperCase();


        var productoServicio = document.getElementById("tablaProductosServicios").getElementsByTagName('tbody')[0];
        if (productoServicio.rows.length == 0) {
            customeError("ERROR", "DEBE INGRESAR AL MENOS UN PRODUCTO O SERVICIO EN LA TABLA");
            return; // Detener la función después de mostrar el mensaje de error
        }

        var table = document.getElementById("tablaImpuestos").getElementsByTagName('tbody')[0];
        var newRow = table.insertRow(table.rows.length);

        var cell1 = newRow.insertCell(0);
        var cell2 = newRow.insertCell(1);
        var cell3 = newRow.insertCell(2);
        var cell4 = newRow.insertCell(3);

        var cell5 = newRow.insertCell(4);
        var cell6 = newRow.insertCell(5);
        var cell7 = newRow.insertCell(6);
        var cell8 = newRow.insertCell(7);
        var cell9 = newRow.insertCell(8);

        var tipoImpuesto = '';
        if (impuestoTrasladado.checked) {
            tipoImpuesto = 'TRASLADADO';
            traslado++;
            cell1.innerHTML = traslado;
            cell1.innerHTML += '<input type="hidden" name="renglon[]" value="' + traslado + '">';
        } else if (impuestoRetenido.checked) {
            tipoImpuesto = 'RETENIDO';
            retenido++;
            cell1.innerHTML = retenido;
            cell1.innerHTML += '<input type="hidden" name="renglon[]" value="' + retenido + '">';
        }

        cell2.innerHTML = tipoImpuesto;
        cell2.innerHTML += '<input type="hidden" name="impuesto[]" value="' + tipoImpuesto + '">';

        cell3.innerHTML = impuesto;
        cell3.innerHTML += '<input type="hidden" name="idTipoImpuesto[]" value="' + idImpuesto + '">';

        cell4.innerHTML = tipoFactor;
        cell4.innerHTML += '<input type="hidden" name="idTipoFactor[]" value="' + idTipoFactor + '">';

        cell5.innerHTML = porcentajeImpuesto;
        cell5.innerHTML += '<input type="hidden" name="porcentajeImpuesto[]" value="' + porcentajeImpuesto + '">';

        cell6.innerHTML = importeImpuesto;
        cell6.innerHTML += '<input type="hidden" name="importeImpuesto[]" value="' + importeImpuesto + '">';

        cell7.innerHTML = importeBase;
        cell7.innerHTML += '<input type="hidden" name="importeBase[]" value="' + importeBase + '">';

        cell8.innerHTML = productoServicio.rows.length;
        cell8.innerHTML += '<input type="hidden" name="renglonProducto[]" value="' + productoServicio.rows.length + '">';

        cell9.innerHTML = '<button type="button" class="btn btn-sm" style="color:white; background-color: #A70303;" onclick="deleteRowImpuestos(this)"><i class="fas fa-trash"></i></button>';


        // Clear input fields
        document.getElementById('impuesto').value = "";
        document.getElementById('impuesto').focus();
        document.getElementById('impuesto').blur();
        document.getElementById('tipoFactor').value = "";
        document.getElementById('tipoFactor').focus();
        document.getElementById('tipoFactor').blur();
        document.getElementById('porcentajeImpuesto').value = "";
        document.getElementById('porcentajeImpuesto').focus();
        document.getElementById('porcentajeImpuesto').blur();
        document.getElementById('importeImpuesto').value = "";
        document.getElementById('importeImpuesto').focus();
        document.getElementById('importeImpuesto').blur();

        document.getElementById('spanNoImpuestoTrasladado').hidden = false;
        document.getElementById('spanSiImpuestoTrasladado').hidden = true;
        document.getElementById('impuestoTrasladado').checked = false;

        document.getElementById('spanNoImpuestoRetenido').hidden = false;
        document.getElementById('spanSiImpuestoRetenido').hidden = true;
        document.getElementById('impuestoRetenido').checked = false;
        calcularTotales();
    }

    // Function to delete a row from the table
    function deleteRowImpuestos(btn) {
        var row = btn.parentNode.parentNode;
        row.parentNode.removeChild(row);
        updateRowNumbersImpuestos();
        calcularTotales();
    }

    function updateRowNumbersImpuestos() {
        console.log("UPDATE NUMBER ROW");
        var table = document.getElementById("tablaImpuestos").getElementsByTagName('tbody')[0];
        var rows = table.getElementsByTagName('tr');
        var retenidoRows = [];
        var trasladadoRows = [];
        retenido = 0;
        traslado = 0;
        // Separar las filas en dos categorías
        for (var i = 0; i < rows.length; i++) {
            var cellValue = rows[i].getElementsByTagName('td')[1].innerHTML.trim();
            if (cellValue.includes("RETENIDO")) {
                retenidoRows.push(rows[i]);
                retenido++;
            } else if (cellValue.includes("TRASLADADO")) {
                trasladadoRows.push(rows[i]);
                traslado++;
            }
        }
        // Actualizar los números de fila para "RETENIDO"
        for (var j = 0; j < retenidoRows.length; j++) {
            retenidoRows[j].getElementsByTagName('td')[0].innerHTML = j + 1;
        }

        // Actualizar los números de fila para "TRASLADADO"
        for (var k = 0; k < trasladadoRows.length; k++) {
            trasladadoRows[k].getElementsByTagName('td')[0].innerHTML = k + 1;
        }
    }


// Function to insert a row in the table
    function insertProducto() {
        var claveProductoServicio = document.getElementById('productoServicio').value.toUpperCase();
        var idProductoServicio = document.getElementById('idProductoServicio').value;
        let idTipoComprobante = document.getElementById("idTipoComprobante");
        let tipoComprobante = idTipoComprobante.options[idTipoComprobante.selectedIndex].text;
        var cantidad = document.getElementById('cantidad').value.toUpperCase();
        var unidadMedida = document.getElementById('unidadMedida').value.toUpperCase();
        var idUnidadMedida = document.getElementById('idUnidadMedida').value;
        var concepto = document.getElementById('detalleConcepto').value.toUpperCase();
        var precioUnitario = document.getElementById('precioUnitario').value.toUpperCase();
        var importeConcepto = document.getElementById('importeConcepto').value.toUpperCase();
        var cuentaPredial = document.getElementById('numeroCuentaPredial').value.toUpperCase();
        var serie = document.getElementById('serie').value.toUpperCase();
        var fechaFactura = document.getElementById('fechaFactura').value.toUpperCase();
        var nc_factura = document.getElementById('nc_factura').value.toUpperCase();
        var nc_serie = document.getElementById('nc_serie').value.toUpperCase();
        var nc_fecha = document.getElementById('nc_fecha').value.toUpperCase();
        var nc_folioFiscal = document.getElementById('nc_folioFiscal').value.toUpperCase();


        // Crear un objeto para mapear las variables a sus nombres de campo
        var campos = {
            claveProductoServicio: claveProductoServicio,
            cantidad: cantidad,
            unidadMedida: unidadMedida,
            concepto: concepto,
            precioUnitario: precioUnitario,
            importeConcepto: importeConcepto,
            serie: serie,
            fechaFactura: fechaFactura
        };
        // Crear un objeto para mapear los nombres de campo a mensajes personalizados
        var mensajesErrores = {
            claveProductoServicio: "POR FAVOR, COMPLETA EL CAMPO DE CLAVE DEL PRODUCTO O SERVICIO.",
            cantidad: "POR FAVOR, COMPLETA EL CAMPO DE CANTIDAD.",
            unidadMedida: "POR FAVOR, COMPLETA EL CAMPO DE UNIDAD DE MEDIDA.",
            concepto: "POR FAVOR, COMPLETA EL CAMPO DE CONCEPTO.",
            precioUnitario: "POR FAVOR, COMPLETA EL CAMPO DE PRECIO UNITARIO.",
            importeConcepto: "POR FAVOR, COMPLETA EL CAMPO DE IMPORTE DEL CONCEPTO.",
            serie: "POR FAVOR, COMPLETA EL CAMPO DE SERIE.",
            fechaFactura: "POR FAVOR, COMPLETA EL CAMPO DE FECHA DE FACTURA.",
            impuesto: "POR FAVOR, COMPLETA EL CAMPO DE IMPUESTO.",
            tipoFactor: "POR FAVOR, COMPLETA EL CAMPO DE TIPO DE FACTOR.",
            porcentajeImpuesto: "POR FAVOR, COMPLETA EL CAMPO DE PORCENTAJE DE IMPUESTO.",
            importeImpuesto: "POR FAVOR, COMPLETA EL CAMPO DE IMPORTE DE IMPUESTO."
        };
        // Iterar sobre el objeto para verificar si algún campo está vacío
        for (var campo in campos) {
            if (campos[campo] === "") {
                if (campo == "serie" && tipoComprobante == "T - TRASLADO") {

                } else {
                    customeError("ERROR", mensajesErrores[campo]);
                    return;
                }
            }
        }

        var table = document.getElementById("tablaProductosServicios").getElementsByTagName('tbody')[0];
        var newRow = table.insertRow(table.rows.length);
        var cell1 = newRow.insertCell(0);
        var cell2 = newRow.insertCell(1);
        var cell3 = newRow.insertCell(2);
        var cell4 = newRow.insertCell(3);
        var cell5 = newRow.insertCell(4);
        var cell6 = newRow.insertCell(5);
        var cell7 = newRow.insertCell(6);
        var cell8 = newRow.insertCell(7);
        var cell9 = newRow.insertCell(8);
        var cell10 = newRow.insertCell(9);
        var cell11 = newRow.insertCell(10);


        cell1.innerHTML = table.rows.length;
        cell1.innerHTML += '<input type="hidden" name="renglon[]" value="' + table.rows.length + '">';
        cell2.innerHTML = claveProductoServicio;
        cell2.innerHTML += '<input type="hidden" name="idProductoServicio[]" value="' + idProductoServicio + '">';
        cell3.innerHTML = cantidad;
        cell3.innerHTML += '<input type="hidden" name="cantidad[]" value="' + cantidad + '">';
        cell4.innerHTML = unidadMedida;
        cell4.innerHTML += '<input type="hidden" name="idUnidadMedida[]" value="' + idUnidadMedida + '">';
        cell5.innerHTML = concepto;
        cell5.innerHTML += '<input type="hidden" name="detalleConcepto[]" value="' + concepto + '">';
        cell6.innerHTML = precioUnitario;
        cell6.innerHTML += '<input type="hidden" name="precioUnitario[]" value="' + precioUnitario + '">';
        cell7.innerHTML = importeConcepto;
        cell7.innerHTML += '<input type="hidden" name="importeConcepto[]" value="' + importeConcepto + '">';
        cell8.innerHTML = cuentaPredial;
        cell8.innerHTML += '<input type="hidden" name="cuentaPredial[]" value="' + cuentaPredial + '">';
        cell9.innerHTML = serie;
        cell9.innerHTML += '<input type="hidden" name="serie[]" value="' + serie + '">';
        cell10.innerHTML = fechaFactura;
        cell10.innerHTML += '<input type="hidden" name="fechaFactura[]" value="' + fechaFactura + '">';


        if (tipoComprobante == "E - EGRESO") {
            //Condicion para mostrar o ocultar estos campos 
            const elementos = document.querySelectorAll('#tablaProductosServicios .d-none');

            // Recorre cada elemento y remueve la clase 'd-none'
            elementos.forEach((elemento) => {
                elemento.classList.remove('d-none');
            });

            var cell12 = newRow.insertCell(11);
            var cell13 = newRow.insertCell(12);
            var cell14 = newRow.insertCell(13);
            var cell15 = newRow.insertCell(14);

            cell11.innerHTML = nc_factura;
            cell11.innerHTML += '<input type="hidden" name="nc_factura[]" value="' + nc_factura + '">';
            cell12.innerHTML = nc_serie;
            cell12.innerHTML += '<input type="hidden" name="nc_serie[]" value="' + nc_serie + '">';
            cell13.innerHTML = nc_fecha;
            cell13.innerHTML += '<input type="hidden" name="nc_fecha[]" value="' + nc_fecha + '">';
            cell14.innerHTML = nc_folioFiscal;
            cell14.innerHTML += '<input type="hidden" name="nc_folioFiscal[]" value="' + nc_folioFiscal + '">';
            cell15.innerHTML = '<button type="button" class="btn btn-sm" style="color:white; background-color: #A70303;" onclick="deleteRow(this)"><i class="fas fa-trash"></i></button>';

        } else {
            cell11.innerHTML = '<button type="button" class="btn btn-sm" style="color:white; background-color: #A70303;" onclick="deleteRow(this)"><i class="fas fa-trash"></i></button>';
        }


        // Clear input fields
        document.getElementById('productoServicio').value = "";
        document.getElementById('idProductoServicio').value = "";
        document.getElementById('productoServicio').focus();
        document.getElementById('productoServicio').blur();
        document.getElementById('cantidad').value = "";
        document.getElementById('cantidad').focus();
        document.getElementById('cantidad').blur();
        document.getElementById('unidadMedida').value = "";
        document.getElementById('idUnidadMedida').value = "";
        document.getElementById('unidadMedida').focus();
        document.getElementById('unidadMedida').blur();
        document.getElementById('detalleConcepto').value = "";
        document.getElementById('detalleConcepto').focus();
        document.getElementById('detalleConcepto').blur();
        document.getElementById('precioUnitario').value = "";
        document.getElementById('precioUnitario').focus();
        document.getElementById('precioUnitario').blur();
        document.getElementById('importeConcepto').value = "";
        document.getElementById('importeConcepto').focus();
        document.getElementById('importeConcepto').blur();
        document.getElementById('numeroCuentaPredial').required = false;
        document.getElementById('numeroCuentaPredial').value = "";
        document.getElementById('numeroCuentaPredial').focus();
        document.getElementById('numeroCuentaPredial').blur();
        document.getElementById('numeroCuentaPredial').disabled = true;
        document.getElementById('spanNoCuentaPredial').hidden = false;
        document.getElementById('spanSiCuentaPredial').hidden = true;
        document.getElementById('cuentaPredial').checked = false;
        // insertImpuesto();
        calcularTotales();
    }
    // Function to delete a row from the table
    function deleteRow(btn) {
        var row = btn.parentNode.parentNode;
        row.parentNode.removeChild(row);
        updateRowNumbers();
        calcularTotales();
    }

    function deleteDataTable(nameTable) {
        const selector = "#" + nameTable + " tbody";
        const tablaImpuestos = document.querySelector(selector);
        while (tablaImpuestos.rows.length > 0) {
            tablaImpuestos.deleteRow(0);
        }
    }

    function updateRowNumbers() {
        var table = document.getElementById("tablaProductosServicios").getElementsByTagName('tbody')[0];
        var rows = table.getElementsByTagName('tr');
        for (var i = 0; i < rows.length; i++) {
            rows[i].getElementsByTagName('td')[0].innerHTML = i + 1;
        }
    }


    function limpiarTablas() {
        var tabla = document.getElementById("tablaProductosServicios");
        var cuerpoTabla = tabla.getElementsByTagName("tbody")[0];

        // Elimina todas las filas del cuerpo de la tabla
        while (cuerpoTabla.rows.length > 0) {
            cuerpoTabla.deleteRow(0);
        }
        var tabla2 = document.getElementById("tablaImpuestos");
        var cuerpoTabla2 = tabla2.getElementsByTagName("tbody")[0];

        // Elimina todas las filas del cuerpo de la tabla
        while (cuerpoTabla2.rows.length > 0) {
            cuerpoTabla2.deleteRow(0);
        }
    }
    function calcularTotales() {
        console.log("function.calcularTotales");
        //FilasImpuestos
        let filasImpuestos = document.querySelectorAll("#tablaImpuestos tbody tr");
        let filasProductos = document.querySelectorAll("#tablaProductosServicios tbody tr");

        let sumaImpuestos = 0;
        let sumaProductos = 0;

        filasImpuestos.forEach(fila => {
            let importe = parseFloat(fila.querySelector("td:nth-child(6) input").value);
            sumaImpuestos += importe;
            console.log("sumaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa IMP" + sumaImpuestos)
        });
        filasProductos.forEach(fila => {
            let importe = parseFloat(fila.querySelector("td:nth-child(7) input").value);
            sumaProductos += importe;
            console.log("sumaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa PRD " + sumaProductos)
        });
        // iva = sumaImporte * 0.16;  // Suponiendo un IVA del 16%
        //retenido = sumaImporte * 0.04;  // Suponiendo un retenido del 4%
        var total = (sumaProductos + sumaImpuestos).toFixed(2);

        document.getElementById("Subtotal").value = sumaProductos;
        document.getElementById("IVA").value = sumaImpuestos;
        document.getElementById("Total").value = total;

        document.getElementById("Total").blur();
        document.getElementById("Subtotal").blur();
        document.getElementById("IVA").blur();
        document.getElementById("totalLetras").blur();

        // let totalLetras = convertirNumero(total);
        // document.getElementById("totalLetras").value = totalLetras;

        document.getElementById("Total").focus();
        document.getElementById("totalLetras").focus();
        document.getElementById("Subtotal").focus();
        document.getElementById("IVA").focus();
    }

    window.sendData = sendData;
    window.searchFactura = searchFactura;
    window.insertImpuesto = insertImpuesto;
    window.deleteRowImpuestos = deleteRowImpuestos;
    window.updateRowNumbersImpuestos = updateRowNumbersImpuestos;
    window.insertProducto = insertProducto;
    window.deleteRow = deleteRow;
    window.deleteDataTable = deleteDataTable;
    window.updateRowNumbers = updateRowNumbers;
    window.limpiarTablas = limpiarTablas;
    window.CalcularImporte = CalcularImporte;
    window.calcularImporteImpuesto = calcularImporteImpuesto;
    window.calcularTotales = calcularTotales;
    // window.imprimirTabla = imprimirTabla;
});
