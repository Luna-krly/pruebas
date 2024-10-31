'use strict';

const listaImpuestosOriginal = JSON.parse(document.getElementById('impuestos').textContent);
const detallesListaOriginal = JSON.parse(document.getElementById('detalles').textContent);
const encabezadosListaOriginal = JSON.parse(document.getElementById('encabezados').textContent);
const impuestosLista = listaImpuestosOriginal ? [...listaImpuestosOriginal] : [];
const detallesLista = detallesListaOriginal ? [...detallesListaOriginal] : [];
const encabezadosLista = encabezadosListaOriginal ? [... encabezadosListaOriginal] : [];

const listaImpuestosMesesOriginal = JSON.parse(document.getElementById('impuestosMeses').textContent);
const detallesListaMesesOriginal = JSON.parse(document.getElementById('detallesMeses').textContent);
const encabezadosListaMesesOriginal = JSON.parse(document.getElementById('encabezadosMeses').textContent);
const impuestosListaMeses = listaImpuestosMesesOriginal ? [...listaImpuestosMesesOriginal] : [];
const detallesListaMeses = detallesListaMesesOriginal ? [...detallesListaMesesOriginal] : [];
const encabezadosListaMeses = encabezadosListaMesesOriginal ? [... encabezadosListaMesesOriginal] : [];
const yearPattern = /^\d{4}$/;



document.addEventListener('DOMContentLoaded', () => {
    if(encabezadosListaMeses.length > 0){
       const data  = document.querySelector("#ex3-tab-3");
       data.click();
    }
    
    
    
    
});

function filtrarFacturas() {
        document.getElementById('buscarFacurasAtomaticas').click();
};


function obtenerFcaturasMesesAnteriores(){
    document.getElementById('buscarFacurasAtomaticasMeses').click()
     
}

function obtenerClientesRef (){
        try {
            localStorage.removeItem("permisos");
            const date = new Date();
            const checkboxes = document.querySelectorAll('input[name="months[]"]:checked');
            let year = document.querySelector("#year").value;
            let userMonths = document.querySelector("#usuarioMeses").value;
            // Crear un array para almacenar los valores seleccionados
            const selectedMonths = Array.from(checkboxes).map(checkbox => checkbox.value);
            const montsString = selectedMonths.join();
            if(year.trim().length <= 0){
                customeError("Es obligatorio colocar un año");
                document.querySelector("#usuarioMeses").value = "";
            } else if(!yearPattern.test(year)){
                customeError("El año escrito es incorrecto");
                document.querySelector("#year").value = "";
                document.querySelector("#usuarioMeses").value = "";
            }else if(year > date.getFullYear()){
                customeError("El año escrito es mayor al año actual");
                document.querySelector("#year").value = "";
                document.querySelector("#usuarioMeses").value = "";
            }else if(selectedMonths.length <= 0 ){
                customeError("Es obligatorio seleccionar algun mes");
                document.querySelector("#usuarioMeses").value = ""
            }else{
                const body = {
                months: montsString,
                year: year,
                userMonths : userMonths, 
                action: '104'
                };
            
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "Srv_FacturacionAutomatica", true);
                xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
                xhr.onload = function() {
                    if (xhr.status == 200) {
                        var response = JSON.parse(xhr.responseText);
                    try {
                        limpiarSelects();
                        if(response.permisos.length >0){
                            colocarRfcEnSelect(response.permisos);
                            almacenarPermisos(response.permisos);
                        }
                    } catch (e) {

                    }
                } else {
                    limpiarSelects();
                }
                };
                xhr.send(JSON.stringify(body));;
            }
        } catch (e) {
            console.error(e);
        }

}


function colocarRfcEnSelect(permisos){
    const select = document.getElementById('selectRfc');
    const uniqueRFCs = new Set();
    
    console.log("Prueba para ver como mejora ",select);
    // Filtra los permisos únicos
    permisos.forEach(item => {
      if (!uniqueRFCs.has(item.rfc)) {
        uniqueRFCs.add(item.rfc);

        const option = document.createElement('option');
        option.value = item.rfc; // Establece el valor de la opción
        option.textContent = item.rfc; // Establece el texto visible de la opción
        select.appendChild(option); // Añade la opción al <select>
      }
    });
}

function filtrarPermisosPorRfc(rfcSeleccionado) {
            const select = document.getElementById('selectPermiso');
            
            const permisos = JSON.parse(localStorage.getItem('permisos')) || [];
            
            const uniquePermisos = new Set();

            // Filtra los permisos únicos
            permisos.forEach(item => {
              if (!uniquePermisos.has(item.permiso) && item.rfc == rfcSeleccionado) {
                uniquePermisos.add(item.permiso);

                const option = document.createElement('option');
                option.value = item.permiso; // Establece el valor de la opción
                option.textContent = item.permiso; // Establece el texto visible de la opción
                select.appendChild(option); // Añade la opción al <select>
              }
            });
}

function manejarCambioRfc() {
            const rfcSeleccionado = document.getElementById('selectRfc').value;
            if (rfcSeleccionado) {
                const selectPermiso = document.getElementById("selectPermiso");
                const optionToKeepPermiso = document.getElementById('encabezadoSelectPermiso');
                Array.from(selectPermiso.options).forEach(function(option) {
                   if (option !== optionToKeepPermiso) {
                       selectPermiso.removeChild(option);
                   }
                });
                selectPermiso.selectedIndex = 0;
                filtrarPermisosPorRfc(rfcSeleccionado);
            }
}

function almacenarPermisos(permisos) {
            localStorage.setItem('permisos', JSON.stringify(permisos));
}

function limpiarSelects(){
  
    const selectRfc = document.getElementById('selectRfc');
    const optionToKeepRfc = document.getElementById('encabezadoSelectRfc');
    // Itera sobre una copia de las opciones del <select> (para evitar problemas al modificar el DOM mientras lo iteras)
    Array.from(selectRfc.options).forEach(function(option) {
        // Elimina la opción si no es la que quieres mantener
        
        if (option !== optionToKeepRfc) {
            selectRfc.removeChild(option);
        }
    });
    
    selectRfc.selectedIndex = 0;
    
    const selectPermiso = document.getElementById("selectPermiso");
    const optionToKeepPermiso = document.getElementById('encabezadoSelectPermiso');
    
     Array.from(selectPermiso.options).forEach(function(option) {
        // Elimina la opción si no es la que quieres mantener
        if (option !== optionToKeepPermiso) {
            selectPermiso.removeChild(option);
        }
    });
    
    selectPermiso.selectedIndex = 0;
}

function limpiarUsuario(){
    const selecUsuarios = document.getElementById("usuarioMeses");
    selecUsuarios.value = "";
}

function guardarFacturas() {
    
        const body = {
            listaEncabezado:encabezadosLista,
            listaDetalle:detallesLista,
            ListaImpuestos: impuestosLista, 
            action: '101'
        };
    
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "Srv_FacturacionAutomatica", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
         xhr.onload = function() {
            if (xhr.status == 200) {
            try {
               
                let mensajeExito=document.getElementById("MensajeExito");
                let tituloExito=document.getElementById("TituloMensajeExito");
                let descripcionExito= document.getElementById("DescripcionMensajeExito");
                
                var response = JSON.parse(xhr.responseText);
                console.log("RESPONSE " , response);
                if(response.tipomensaje=="Exito"){
                    response.messages.forEach(function(message) {
                        tituloExito.innerText =response.tipomensaje;
                        descripcionExito.innerText =message;
                        mensajeExito.style.display="block";
                        
                        // Ocultar el mensaje de alerta después de unos segundos
                setTimeout(function () {
                    mensajeExito.style.display = 'none';
                }, 3500);
                    });
                document.getElementById('Limpiar').click();
                }else if (response.tipomensaje=="Error"){
                    response.messages.forEach(function(message) {
                        customeError("Error", message);
                    });
                    document.getElementById('Limpiar').click();
                }
                
            } catch (e) {
                customeError("Error", "Error al procesar la solicitud");
                console.error("Error al procesar la respuesta JSON: ", e);
            }
        } else {
            customeError("Error",'Error al procesar la solicitud.');
            console.error("Error en la solicitud AJAX.");
        }
        };
        xhr.send(JSON.stringify(body));
 };
 
 function guardarFacturasMesesAnteriores() {
    
        const body = {
            listaEncabezado:encabezadosListaMeses,
            listaDetalle:detallesListaMeses,
            ListaImpuestos: impuestosListaMeses, 
            action: '101'
        };
    
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "Srv_FacturacionAutomatica", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
         xhr.onload = function() {
            if (xhr.status == 200) {
            try {
               
                let mensajeExito=document.getElementById("MensajeExito");
                let tituloExito=document.getElementById("TituloMensajeExito");
                let descripcionExito= document.getElementById("DescripcionMensajeExito");
                
                var response = JSON.parse(xhr.responseText);
                console.log("RESPONSE " , response);
                if(response.tipomensaje=="Exito"){
                    response.messages.forEach(function(message) {
                        tituloExito.innerText =response.tipomensaje;
                        descripcionExito.innerText =message;
                        mensajeExito.style.display="block";
                        
                        // Ocultar el mensaje de alerta después de unos segundos
                setTimeout(function () {
                    mensajeExito.style.display = 'none';
                }, 3500);
                    });
                document.getElementById('LimpiarMeses').click();
                }else if (response.tipomensaje=="Error"){
                    response.messages.forEach(function(message) {
                        customeError("Error", message);
                    });
                    document.getElementById('Limpiar').click();
                }
                
            } catch (e) {
                customeError("Error", "Error al procesar la solicitud");
                console.error("Error al procesar la respuesta JSON: ", e);
            }
        } else {
            customeError("Error",'Error al procesar la solicitud.');
            console.error("Error en la solicitud AJAX.");
        }
        };
        xhr.send(JSON.stringify(body));
 };

document.addEventListener('DOMContentLoaded', function () {
    
    const tabla = document.getElementById('tablaEncabezado');
    

    tabla.addEventListener('click', handleTableClick);
    document.getElementById('Limpiar').addEventListener('click', limpiarTablasMesActual);

    function handleTableClick(event) {
        if (event.target.tagName === 'TD') {
            const fila = event.target.parentNode;

            const selected = tabla.querySelector('.selected');
            if (selected) selected.classList.remove('selected');
            fila.classList.add('selected');

            const [noRenglon, folio, serie, tipoComprobante, RFC, cliente, LugarEmision, usoFcatura, fechaFactura, horaFactura,
                moneda, tipoCambio, formaPago, cuentaBanco, metodoPago, condicionesPago, permiso, subTotal, iva,
                totalFactura, totalLetras, usuarioResponsable, fechaGeneracion, estatus, conceptoFacturacion, fechaPago,
                saldoFactura, mesFactura,tipoServicio] = Array.from(fila.querySelectorAll('.texto-largo'))
                .map(td => td.innerText);

            const impuestos = impuestosLista.filter(impuesto => impuesto.RFC === RFC && impuesto.permiso === permiso);
            const detalles = detallesLista.filter(detalle => detalle.RFC === RFC && detalle.permiso === permiso);

            limpiarTbody('datosConsultaEncabezado');
            limpiarTbody('datosConsultaImpuestos');
            limpiarTbody('datosConsultaDetalle');

            agregarFila('datosConsultaEncabezado', [noRenglon, folio, serie, tipoComprobante, RFC, cliente, LugarEmision, usoFcatura, fechaFactura, horaFactura,
                moneda, tipoCambio, formaPago, cuentaBanco, metodoPago, condicionesPago, permiso, subTotal, iva,
                totalFactura, totalLetras, usuarioResponsable, fechaGeneracion, estatus, conceptoFacturacion, fechaPago,
                saldoFactura, mesFactura, tipoServicio]);

            impuestos.forEach((impuesto, index) => {
                agregarFila('datosConsultaImpuestos', [
                    index + 1, impuesto.folio, impuesto.serie, impuesto.fechaFactura, impuesto.renglon,
                    impuesto.tipoImpuesto, impuesto.tipoFactor, impuesto.tasaImpuesto, impuesto.importeImpuesto,
                    impuesto.impTrasRet, impuesto.renglonConcepto, impuesto.impuestoBase
                ]);
            });

            detalles.forEach((detalle, index) => {
                agregarFila('datosConsultaDetalle', [
                    index + 1, detalle.folio, detalle.serie, detalle.fechaFactura, detalle.renglon,
                    detalle.productoServicio, detalle.cantidad, detalle.unidadMedida, detalle.descripcionUnidadMedida,
                    detalle.precioUnitario, detalle.importeConcepto, detalle.cuentaPredial, detalle.concepto
                ]);
            });

            document.querySelector("#ex3-tab-2").click();
        }
    }

    function agregarFila(tbodyId, data) {
        const tbody = document.getElementById(tbodyId);
        const row = document.createElement('tr');
        row.innerHTML = data.map(d => `<td>${d}</td>`).join('');
        tbody.appendChild(row);
    }

    function limpiarTablasMesActual() {
        limpiarTbody('datosEncabezado');
        limpiarTbody('datosConcetos');
        limpiarTbody('datosImpuestos');
        limpiarTablasConsulta();
    }

    function limpiarTablasConsulta() {
        limpiarTbody('datosConsultaEncabezado');
        limpiarTbody('datosConsultaDetalle');
        limpiarTbody('datosConsultaImpuestos');
    }
    
    
});

function limpiarTablasMesesAnteriores (){
        console.log("limpiarTablasMesesAnteriores")
        limpiarTbody('datosEncabezadoMeses');
        limpiarTbody('datosConcetosMeses');
        limpiarTbody('datosImpuestosMeses');
    }

function limpiarTbody(tbodyId) {
        const tbody = document.getElementById(tbodyId);
        const filas = tbody.getElementsByTagName('tr');
        // Comenzar desde el final para evitar problemas de reindexación al eliminar
        for (let i = filas.length - 1; i >= 0; i--) {
            const fila = filas[i];
            const esEncabezado = fila.querySelector('th') !== null;
            if (!esEncabezado) {
                tbody.removeChild(fila);
            }
        }
    }
    
function verificarFecha(){
        limpiarUsuario();
        // Obtener el mes actual (0-11) y convertir a formato de 2 dígitos (01-12)
        let year = document.querySelector("#year").value;
        const now = new Date();
        const currentMonth = String(now.getMonth() + 1).padStart(2, '0');
        
        if(year.trim().length <= 0){
                customeError("Es obligatorio colocar un año");
                document.querySelector("#usuarioMeses").value = "";
            } else if(!yearPattern.test(year)){
                customeError("El año escrito es incorrecto");
                document.querySelector("#year").value = "";
                document.querySelector("#usuarioMeses").value = "";
            }else if(year > now.getFullYear()){
                customeError("El año escrito es mayor al año actual");
                document.querySelector("#year").value = "";
                document.querySelector("#usuarioMeses").value = "";
            }else 
        
        
        if(year == now.getFullYear()){
                // Obtener todas las casillas de verificación
            const checkboxes = document.querySelectorAll('input[type="checkbox"][name="months[]"]');

            // Iterar sobre cada checkbox y deshabilitar los que tengan valor menor al mes actual
            checkboxes.forEach(checkbox => {
                if (checkbox.value >= currentMonth) {
                    checkbox.disabled = true;
                    checkbox.parentElement.classList.add('disabled'); // Opcional: aplicar estilo a etiquetas deshabilitadas
                }
            });
        }else{
            const checkboxes = document.querySelectorAll('input[type="checkbox"][name="months[]"]');
            // Iterar sobre cada checkbox y deshabilitar los que tengan valor menor al mes actual
            checkboxes.forEach(checkbox => {
                    checkbox.disabled = false;
                    checkbox.parentElement.classList.remove('disabled'); // Opcional: aplicar estilo a etiquetas deshabilitadas
            });
        }
}

//function exportTableToExcel(tableID, filename) {
//                    // Tipo de exportación
//                    if (!filename)
//                        filename = 'excel_data.xls';
//                    let dataType = 'application/vnd.ms-excel';
//
//                    // Origen de los datos
//                    let tableSelect = document.getElementById(tableID);
//                    let tableHTML = tableSelect.outerHTML;
//
//                    // Convierte la tabla HTML a una cadena de texto codificada en UTF-16LE
//                    let tableText = '\uFEFF' + tableHTML; // El prefijo \uFEFF indica la codificación UTF-16LE
//                    let tableData = new Uint8Array(new TextEncoder('utf-16le').encode(tableText));
//
//                    // Crea el archivo descargable
//                    let blob = new Blob([tableData], {type: dataType});
//
//                    // Crea un enlace de descarga en el navegador
//                    if (window.navigator && window.navigator.msSaveOrOpenBlob) {
//                        // Descargar para IExplorer
//                        window.navigator.msSaveOrOpenBlob(blob, filename);
//                    } else {
//                        // Descargar para Chrome, Firefox, etc.
//                        let a = document.createElement("a");
//                        document.body.appendChild(a);
//                        a.style = "display: none";
//                        let csvUrl = URL.createObjectURL(blob);
//                        a.href = csvUrl;
//                        a.download = filename;
//                        a.click();
//                        URL.revokeObjectURL(a.href)
//                        a.remove();
//                    }
//                }

 function exportTableToExcel(tableID, filename) {
            // Obtener la tabla HTML
            let table = document.getElementById(tableID);
            // Convertir la tabla HTML a un libro de trabajo de Excel
            let wb = XLSX.utils.table_to_book(table, {sheet: "Sheet1"});
            // Generar y descargar el archivo XLSX
            XLSX.writeFile(wb, filename);
        }