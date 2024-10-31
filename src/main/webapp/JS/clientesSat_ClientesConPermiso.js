document.addEventListener('DOMContentLoaded', function () {

    // Define las listas que serán proporcionadas por el servidor
    const listaClientesSAT = JSON.parse(document.getElementById('listaClientesSatData').textContent);
    const listaReferencias = JSON.parse(document.getElementById('referenciaListaData').textContent);


    function insertClientesconPermiso() {
        const noRecordsMessage = document.getElementById('no-records-message');
        var idReferencia = 0;
        // Crea un mapa de clientes para acceder a ellos rápidamente por RFC
        const clientesMapa = new Map();
        listaClientesSAT.forEach(cliente => {
            clientesMapa.set(cliente.rfc, cliente);
        });

        // Obtén el cuerpo de la tabla
        const tbody = document.getElementById('datos-clientes-permisos');
        if (listaReferencias.length > 0) {

            // Llena la tabla con los datos combinados
            listaReferencias.forEach(referencia => {
                idReferencia++;
                const cliente = clientesMapa.get(referencia.rfcCliente);

                // Crea una nueva fila
                const fila = document.createElement('tr');


                const celdaRenglon = document.createElement('td');
                celdaRenglon.textContent = idReferencia;
                fila.appendChild(celdaRenglon);
                
                const celdaPermiso = document.createElement('td');
                celdaPermiso.textContent = referencia.permiso;
                fila.appendChild(celdaPermiso);
                
                const celdaConsecutivo = document.createElement('td');
                celdaConsecutivo.textContent = referencia.consecutivo;
                fila.appendChild(celdaConsecutivo);
                
                const celdaConcepto = document.createElement('td');
                celdaConcepto.textContent = referencia.concepto;
                fila.appendChild(celdaConcepto);
                
                const celdaReferenciaQR = document.createElement('td');
                celdaReferenciaQR.textContent = referencia.referenciaQR;
                fila.appendChild(celdaReferenciaQR);
                
                const celdaPATR = document.createElement('td');
                celdaPATR.textContent = referencia.patr;
                fila.appendChild(celdaPATR);
                
                const celdaIniciaVigencia = document.createElement('td');
                celdaIniciaVigencia.textContent = referencia.iniciaVigencia;
                fila.appendChild(celdaIniciaVigencia);
                
                const celdaTerminaVigencia = document.createElement('td');
                celdaTerminaVigencia.textContent = referencia.terminaVigencia;
                fila.appendChild(celdaTerminaVigencia);
                
                const celdaSeFactura = document.createElement('td');
                celdaSeFactura.textContent = referencia.seFactura;
                fila.appendChild(celdaSeFactura);
                
                const celdaUsuarioResponsable = document.createElement('td');
                celdaUsuarioResponsable.textContent = referencia.usuarioResponsable;
                fila.appendChild(celdaUsuarioResponsable);
                

                const celdaImporteConcepto = document.createElement('td');
                celdaImporteConcepto.textContent = referencia.importeConcepto.toFixed(2);
                fila.appendChild(celdaImporteConcepto);

                const celdaIVA = document.createElement('td');
                celdaIVA.textContent = referencia.importeIva.toFixed(2);
                fila.appendChild(celdaIVA);

                const celdaRenta = document.createElement('td');
                celdaRenta.textContent = referencia.importeRenta.toFixed(2);
                fila.appendChild(celdaRenta);
                
                const celdaNumeroCliente = document.createElement('td');
                celdaNumeroCliente.textContent = cliente ? cliente.numeroCliente : 'No disponible';
                fila.appendChild(celdaNumeroCliente);
                
                const celdaTipoPersona = document.createElement('td');
                celdaTipoPersona.textContent = cliente ? cliente.tipo : 'No disponible';
                fila.appendChild(celdaTipoPersona);
                
                const celdaRegimenFiscal = document.createElement('td');
                celdaRegimenFiscal.textContent = cliente ? cliente.regimenFiscal : 'No disponible';
                fila.appendChild(celdaRegimenFiscal);
                
                const celdaRFC = document.createElement('td');
                celdaRFC.textContent = referencia.rfcCliente;
                fila.appendChild(celdaRFC);

                const celdaNombreCliente = document.createElement('td');
                celdaNombreCliente.textContent = cliente ? cliente.nombreCliente : 'No disponible';
                fila.appendChild(celdaNombreCliente);

                const celdaCalle = document.createElement('td');
                celdaCalle.textContent = cliente ? cliente.calle : 'No disponible';
                fila.appendChild(celdaCalle);

                const celdaNumeroExterior = document.createElement('td');
                celdaNumeroExterior.textContent = cliente ? cliente.numeroExterior : 'No disponible';
                fila.appendChild(celdaNumeroExterior);

                const celdaNumeroInterior = document.createElement('td');
                celdaNumeroInterior.textContent = cliente ? cliente.numeroInterior : 'No disponible';
                fila.appendChild(celdaNumeroInterior);

                const celdaCodigoPostal = document.createElement('td');
                celdaCodigoPostal.textContent = cliente ? cliente.codigo : 'No disponible';
                fila.appendChild(celdaCodigoPostal);
                
                const celdaPais = document.createElement('td');
                celdaPais.textContent = cliente ? cliente.pais : 'No disponible';
                fila.appendChild(celdaPais);

                const celdaEmail = document.createElement('td');
                celdaEmail.textContent = cliente ? cliente.email : 'No disponible';
                fila.appendChild(celdaEmail);
                
                const celdaReferencia = document.createElement('td');
                celdaReferencia.textContent = cliente ? cliente.referencia : 'No disponible';
                fila.appendChild(celdaReferencia);
                
                const celdaCuentaBancaria = document.createElement('td');
                celdaCuentaBancaria.textContent = cliente ? cliente.cuentaBanco : 'No disponible';
                fila.appendChild(celdaCuentaBancaria);

                // Agrega la fila al cuerpo de la tabla
                tbody.appendChild(fila);
            });

            noRecordsMessage.style.display = 'none';
        } else {
            noRecordsMessage.style.display = 'block';
        }

    }


    function limpiarTabla(idTabla) {
    // Obtén el elemento <tbody> de la tabla usando el ID proporcionado
    const tbody = document.querySelector(`#${idTabla}`);
    console.log("Entra a limpiar tabla");
    
    // Asegúrate de que el <tbody> exista
    if (tbody) {
        // Elimina todos los elementos hijos del <tbody>, es decir, todas las filas de la tabla
        tbody.innerHTML = '';
    } else {
        console.error(`No se encontró el elemento con ID "${idTabla}"`);
    }
}

// Exporta una tabla HTML a excel
    function exportTableToExcel(tableID, filename) {
        if (!filename) filename = 'excel_data.xls';
        let dataType = 'application/vnd.ms-excel';
        let tableSelect = document.getElementById(tableID);
        let tableHTML = tableSelect.outerHTML;
        let tableText = '\uFEFF' + tableHTML;
        let tableData = new Uint8Array(new TextEncoder('utf-16le').encode(tableText));
        let blob = new Blob([tableData], {type: dataType});
        if (window.navigator && window.navigator.msSaveOrOpenBlob) {
            window.navigator.msSaveOrOpenBlob(blob, filename);
        } else {
            let a = document.createElement("a");
            document.body.appendChild(a);
            a.style = "display: none";
            let csvUrl = URL.createObjectURL(blob);
            a.href = csvUrl;
            a.download = filename;
            a.click();
            URL.revokeObjectURL(a.href);
            a.remove();
        }
    }



    // Exponer las funciones globalmente
    window.insertClientesconPermiso = insertClientesconPermiso;
    window.limpiarTabla = limpiarTabla;
    window.exportTableToExcel = exportTableToExcel;

});

