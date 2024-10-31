document.addEventListener('DOMContentLoaded', function () {

    // Obtiene la fecha de hoy en el formato YYYY-MM-DD
//      let today = new Date().toISOString().split('T')[0];
    // Asigna la fecha de hoy al atributo max del input
//     document.getElementById('iniciaVigencia').value = today;
//     document.getElementById('iniciaVigencia').setAttribute('min', today);
//     validateDates();

    // Define las listas que serán proporcionadas por el servidor
    const listaPermisoOriginal = JSON.parse(document.getElementById('listaPermisoData').textContent);
    const referenciaListaOriginal = JSON.parse(document.getElementById('referenciaListaData').textContent);
    let referenciaLista = [...referenciaListaOriginal];
    let listaPermisoReferencia = [...listaPermisoOriginal];

    function clearTablePermisosArrendamiento() {
        const noRecordsMessage = document.getElementById('no-records-message');
        noRecordsMessage.style.display = 'block';
        const tbody = document.getElementById('datos-permisos');
        while (tbody.firstChild) {
            tbody.removeChild(tbody.firstChild);
        }
        referenciaLista = [...referenciaListaOriginal];
    }

    function isertDataTablePermisosArrendamiento(rfcCliente) {
        const tbody = document.getElementById('datos-permisos');
        const filteredReferenciaLista = referenciaLista.filter(permisoArrendamiento => permisoArrendamiento.rfcCliente === rfcCliente);
        const noRecordsMessage = document.getElementById('no-records-message');
        var idArrendamiento = 0;

        if (filteredReferenciaLista.length > 0) {
            filteredReferenciaLista.forEach(permisoArrendamiento => {
                idArrendamiento++;

                // Función para crear una celda con texto y un campo oculto
                const crearCeldaDeTabla = (filaPadre, contenidoTexto, nombreCampoOculto, valorCampoOculto, clases) => {
                    const celda = document.createElement('td');
                    celda.innerHTML = `${contenidoTexto}<input type="hidden" name="${nombreCampoOculto}" value="${valorCampoOculto}">`;
                    celda.className = clases;
                    filaPadre.appendChild(celda);
                };

// Crear la fila
                const fila = document.createElement('tr');

// Añadir celdas a la fila
                crearCeldaDeTabla(fila, idArrendamiento, 'renglon[]', idArrendamiento, 'text-center id-permiso');
                crearCeldaDeTabla(fila, permisoArrendamiento.rfcCliente, 'rfcArrendatario[]', permisoArrendamiento.rfcCliente, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.nombreCliente, 'nombreArrendatario[]', permisoArrendamiento.nombreCliente, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.permiso, 'permiso[]', permisoArrendamiento.permiso, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.consecutivo, 'numero[]', permisoArrendamiento.consecutivo, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.concepto, 'descripcion[]', permisoArrendamiento.concepto, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.referenciaQR, 'referenciaqr[]', permisoArrendamiento.referenciaQR, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.patr, 'numeroPATR[]', permisoArrendamiento.patr, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.iniciaVigencia, 'iniciaVigencia[]', permisoArrendamiento.iniciaVigencia, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.terminaVigencia, 'finVigencia[]', permisoArrendamiento.terminaVigencia, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.usuarioResponsable, 'usuarioResponsable[]', permisoArrendamiento.usuarioResponsable, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.seFactura, 'sefactura[]', permisoArrendamiento.seFactura, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.importeConcepto, 'importeConcepto[]', permisoArrendamiento.importeConcepto, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.importeIva, 'importeIva[]', permisoArrendamiento.importeIva, 'texto-largo');
                crearCeldaDeTabla(fila, permisoArrendamiento.importeRenta, 'importeRenta[]', permisoArrendamiento.importeRenta, 'texto-largo');

// Crear y añadir el botón
                const celdaBoton = document.createElement('td');
                const boton = document.createElement('button');
                boton.type = 'button';
                boton.className = 'btn btn-sm';
                boton.style.color = 'white';
                boton.style.backgroundColor = '#A70303';
                boton.onclick = function () {
                    deleteRow(this);
                };
                const icono = document.createElement('i');
                icono.className = 'fas fa-trash';
                boton.appendChild(icono);
                celdaBoton.appendChild(boton);
                fila.appendChild(celdaBoton);


                tbody.appendChild(fila);
            });
            noRecordsMessage.style.display = 'none';
        } else {
            noRecordsMessage.style.display = 'block';
        }
    }

    function resetSelects() {
        const emptyOption = document.createElement("option");
        emptyOption.value = '';
        emptyOption.disabled = true;
        emptyOption.selected = true;
        emptyOption.style.display = 'none';

        const selects = ['select-permiso', 'select-numero', 'select-descripcion'];
        selects.forEach(id => {
            const select = document.getElementById(id);
            select.appendChild(emptyOption);
        });
    }

    function filterData() {
        console.log("La función filterData() se está ejecutando.");
        resetSelects();
        actualizarPermisos();
    }

    function actualizarPermisos() {
        console.log("La función actualizarPermisos() se está ejecutando.");
        let rfcCliente = document.getElementById("rfcArrendatario").value;
        rfcCliente = rfcCliente.toUpperCase();
        const permisosSelect = document.getElementById("select-permiso");
        permisosSelect.innerHTML = ''; // Limpia todas las opciones del select

        const emptyOption = document.createElement("option");
        emptyOption.value = '';
        emptyOption.disabled = true;
        emptyOption.selected = true;
        emptyOption.style.display = 'none';
        permisosSelect.appendChild(emptyOption);

        const permisosUnicos = [...new Set(listaPermisoReferencia
                    .filter(permiso => permiso.rfc === rfcCliente)
                    .map(permiso => permiso.numeroPermiso)
                    .filter(value => value))]; // Filtrar ciudades únicas no nulas
        permisosUnicos.forEach(value => {
            const option = document.createElement("option");
            option.value = value;
            option.text = value;
            permisosSelect.appendChild(option);
        });
    }

    function actualizarConsecutivos() {
        console.log("La función actualizarPermisos() se está ejecutando.");
        let rfcCliente = document.getElementById("rfcArrendatario").value;
        rfcCliente = rfcCliente.toUpperCase();

        const numeroPermiso = document.getElementById("select-permiso").value;

        const consecutivosSelect = document.getElementById("select-numero");
        consecutivosSelect.innerHTML = ''; // Limpia todas las opciones del select
        const conceptoSelect = document.getElementById("select-descripcion");
        conceptoSelect.innerHTML = ''; // Limpia todas las opciones del select

        const emptyOption = document.createElement("option");
        emptyOption.value = '';
        emptyOption.disabled = true;
        emptyOption.selected = true;
        emptyOption.style.display = 'none';
        consecutivosSelect.appendChild(emptyOption);

        const consecutivosUnicos = [...new Set(listaPermisoReferencia
                    .filter(permiso => permiso.rfc === rfcCliente && permiso.numeroPermiso === numeroPermiso)
                    .map(permiso => permiso.consecutivo)
                    .filter(value => value))];
        consecutivosUnicos.forEach(value => {
            const option = document.createElement("option");
            option.value = value;
            option.text = value;
            consecutivosSelect.appendChild(option);
        });
    }

    function actualizarDescripcion() {
        console.log("La función actualizarDescripcion() se está ejecutando.");
        let rfcCliente = document.getElementById("rfcArrendatario").value;
        rfcCliente = rfcCliente.toUpperCase();
        console.log(rfcCliente);
        const numeroPermiso = document.getElementById("select-permiso").value;
        console.log(numeroPermiso);
        const consecutivo = document.getElementById("select-numero").value;
        console.log(consecutivo);

        const conceptoSelect = document.getElementById("select-descripcion");
        conceptoSelect.innerHTML = ''; // Limpia todas las opciones del select

        const emptyOption = document.createElement("option");
        emptyOption.value = '';
        emptyOption.disabled = true;
        emptyOption.selected = true;
        emptyOption.style.display = 'none';
        conceptoSelect.appendChild(emptyOption);

        const descripcionUnico = [...new Set(listaPermisoReferencia
                    .filter(permiso => permiso.rfc == rfcCliente && permiso.numeroPermiso == numeroPermiso && permiso.consecutivo == consecutivo)
                    .map(permiso => permiso.concepto)
                    .filter(value => value))]; // Si son tres también compara tipo de dato

        descripcionUnico.forEach(value => {
            console.log("Lista que coincide " + value);
            const option = document.createElement("option");
            option.value = value;
            option.text = value;
            option.selected = true;
            conceptoSelect.appendChild(option);
        });
    }

    let tabla = document.getElementById('datos-permisos');
    let formularioPermiso = document.getElementById('formularioPermiso');

    tabla.addEventListener('click', function (event) {
        if (event.target.tagName === 'TD') {
            var fila = event.target.parentNode;

            if (tabla.querySelector('.selected')) {
                tabla.querySelector('.selected').classList.remove('selected');
            }
            fila.classList.add("selected");

//            let idPermiso = fila.querySelector('.id-permiso').innerText;
            let rfc = fila.querySelector('.texto-largo:nth-child(2)').innerText;
            let nombre = fila.querySelector('.texto-largo:nth-child(3)').innerText;
            let permiso = fila.querySelector('.texto-largo:nth-child(4)').innerText;
            let noConcepto = fila.querySelector('.texto-largo:nth-child(5)').innerText;
            let descripcionConcepto = fila.querySelector('.texto-largo:nth-child(6)').innerText;
            let referenciaBancaria = fila.querySelector('.texto-largo:nth-child(7)').innerText;
            let noPATRS = fila.querySelector('.texto-largo:nth-child(8)').innerText;
            let iniciaVigencia = fila.querySelector('.texto-largo:nth-child(9)').innerText;
            let finVigencia = fila.querySelector('.texto-largo:nth-child(10)').innerText;
            let usuario = fila.querySelector('.texto-largo:nth-child(11)').innerText;
            let seFactura = fila.querySelector('.texto-largo:nth-child(12)').innerText;
            let importeConcepto = fila.querySelector('.texto-largo:nth-child(13)').innerText;
            let importeIva = fila.querySelector('.texto-largo:nth-child(14)').innerText;
            let importeRenta = fila.querySelector('.texto-largo:nth-child(15)').innerText;
            // Obtener el botón de eliminación
            let botonEliminar = fila.querySelector('td:last-child button');
            if (botonEliminar) {
                console.log("-----------------------------------------Se encontró el botón eliminar");
                // Simula un clic en el botón
                botonEliminar.click(); // Esto activará el evento `click` en el botón, llamando a la función `deleteRow`
            } else {
                console.log("------------------********No se encontró el botón");
            }


//            formularioPermiso.querySelector("#idPermisoReferenciaBancaria").value = idPermiso;
            formularioPermiso.querySelector("#rfcArrendatario").value = rfc;
            formularioPermiso.querySelector("#nombreArrendatario").value = nombre;
            formularioPermiso.querySelector("#select-permiso").value = permiso;
            actualizarConsecutivos();
            formularioPermiso.querySelector("#select-numero").value = noConcepto;
            actualizarDescripcion();
            formularioPermiso.querySelector("#select-descripcion").value = descripcionConcepto;
            formularioPermiso.querySelector("#referenciaqr").value = referenciaBancaria;
            formularioPermiso.querySelector("#numeroPART").value = noPATRS;
            formularioPermiso.querySelector("#iniciaVigencia").value = iniciaVigencia;
            formularioPermiso.querySelector("#iniciaVigencia").setAttribute('min', iniciaVigencia);
            validateDates();
            formularioPermiso.querySelector("#finVigencia").value = finVigencia;
            formularioPermiso.querySelector("#usuarioResponsable").value = usuario;
            formularioPermiso.querySelector("#sefactura").value = seFactura;
            formularioPermiso.querySelector("#importeConcepto").value = importeConcepto;
            formularioPermiso.querySelector("#importeIva").value = importeIva;
            formularioPermiso.querySelector("#importeRenta").value = importeRenta;



            formularioPermiso.querySelector("#idPermisoReferenciaBancaria").focus();
            formularioPermiso.querySelector("#rfcArrendatario").focus();
            formularioPermiso.querySelector("#nombreArrendatario").focus();
            formularioPermiso.querySelector("#select-permiso").focus();
            formularioPermiso.querySelector("#select-numero").focus();
            formularioPermiso.querySelector("#select-descripcion").focus();
            formularioPermiso.querySelector("#referenciaqr").focus();
            formularioPermiso.querySelector("#numeroPART").focus();
            formularioPermiso.querySelector("#iniciaVigencia").focus();
            formularioPermiso.querySelector("#finVigencia").focus();
            formularioPermiso.querySelector("#usuarioResponsable").focus();
            formularioPermiso.querySelector("#sefactura").focus();
            formularioPermiso.querySelector("#importeConcepto").focus();
            formularioPermiso.querySelector("#importeIva").focus();
            formularioPermiso.querySelector("#importeRenta").focus();



        }
    });

    document.querySelector('#limpiarPermisos').addEventListener('click', function (event) {
        event.preventDefault();
        if (document.querySelector('#datos-permisos .selected')) {
            document.querySelector('#datos-permisos .selected').classList.remove('selected');
        }
        // Resetear los inputs de fecha y simular la interacción del usuario
        let inputIniciaVigencia = formularioPermiso.querySelector("#iniciaVigencia");
        let inputFinVigencia = formularioPermiso.querySelector("#finVigencia");

//        formularioPermiso.querySelector("#idPermisoReferenciaBancaria").value = "";
        formularioPermiso.querySelector("#referenciaqr").value = "";
        formularioPermiso.querySelector("#numeroPART").value = "";
        formularioPermiso.querySelector("#sefactura").value = "";
        formularioPermiso.querySelector("#importeConcepto").value = "";
        formularioPermiso.querySelector("#importeIva").value = "";
        formularioPermiso.querySelector("#importeRenta").value = "";

        inputIniciaVigencia.value = ''; // Resetear el valor del input
        inputFinVigencia.value = ''; // Resetear el valor del input

        inputIniciaVigencia.focus();
        inputIniciaVigencia.blur();
        inputFinVigencia.focus();
        inputFinVigencia.blur();
        filterData();
        actualizarConsecutivos();
        actualizarDescripcion();

    });

    function calcularImportes() {
        const importeConcepto = parseFloat(document.getElementById('importeConcepto').value);
        if (!isNaN(importeConcepto)) {
            const importeRenta = (importeConcepto / 1.16).toFixed(2);
            const importeIVA = (importeRenta * 0.16).toFixed(6);

            document.getElementById('importeIva').value = importeIVA;
            document.getElementById('importeRenta').value = importeRenta;
            document.getElementById('importeIva').focus();
            document.getElementById('importeIva').blur();
            document.getElementById('importeRenta').focus();
            document.getElementById('importeRenta').blur();
        }
    }

    function validateDates() {
        let fechaInicio = document.getElementById('iniciaVigencia').value;
        let beforeDay = new Date(fechaInicio);
        beforeDay.setDate(beforeDay.getDate() + 1);
        let formatbeforeDay = beforeDay.toISOString().split('T')[0];
        let fechaFinInput = document.getElementById('finVigencia');
        fechaFinInput.setAttribute('min', formatbeforeDay);
    }

    function validarFechas() {
        let fechaInicio = document.getElementById("iniciaVigencia");
        let fechaFin = document.getElementById("finVigencia");

        if (fechaInicio.value > fechaFin.value) {
            customeError("ERROR", "LA FECHA DE INICIO NO PUEDE SER POSTERIOR A LA FECHA DE TÉRMINO.");
            //fechaInicio.value = "";
            fechaFin.value = "";
        }
    }
    function get_validarUsuario() {
        var input = document.getElementById('usuarioResponsable').value.toUpperCase();
        var lista = document.getElementById('ListUsuarios').getElementsByTagName('option');
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
            customeError("ERROR", 'USUARIO NO VÁLIDO');
            document.getElementById("usuarioResponsable").value = '';
        }
    }

    function insertRow() {
        const noRecordsMessage = document.getElementById('no-records-message');
        noRecordsMessage.style.display = 'none';
        var rfcArrendatario = document.getElementById('rfcArrendatario').value.toUpperCase();
        var nombreArrendatario = document.getElementById('nombreArrendatario').value.toUpperCase();
        var permiso = document.getElementById('select-permiso').value.toUpperCase();
        var numero = document.getElementById('select-numero').value.toUpperCase();
        var descripcion = document.getElementById('select-descripcion').value.toUpperCase();
        var referenciaqr = document.getElementById('referenciaqr').value.toUpperCase();
        var numeroPATR = document.getElementById('numeroPART').value.toUpperCase();
        var iniciaVigencia = document.getElementById('iniciaVigencia').value.toUpperCase();
        var finVigencia = document.getElementById('finVigencia').value.toUpperCase();
        var usuarioResponsable = document.getElementById('usuarioResponsable').value.toUpperCase();
        var sefactura = document.getElementById('sefactura').value.toUpperCase();
        var importeConcepto = document.getElementById('importeConcepto').value.toUpperCase();
        var importeIva = document.getElementById('importeIva').value.toUpperCase();
        var importeRenta = document.getElementById('importeRenta').value.toUpperCase();


        var campos = {
            rfcArrendatario: rfcArrendatario,
            nombreArrendatario: nombreArrendatario,
            permiso: permiso,
            numero: numero,
            descripcion: descripcion,
            iniciaVigencia: iniciaVigencia,
            finVigencia: finVigencia,
            usuarioResponsable: usuarioResponsable,
            sefactura: sefactura,
            importeConcepto: importeConcepto,
            importeIva: importeIva,
            importeRenta: importeRenta
        };

        // Crear un objeto para mapear los nombres de campo a mensajes personalizados
        var mensajesErrores = {
            rfcArrendatario: "POR FAVOR, COMPLETA EL CAMPO DE RFC DE CLIENTE.",
            nombreArrendatario: "POR FAVOR, COMPLETA EL CAMPO DE NOMBRE DE CLIENTE.",
            permiso: "POR FAVOR, COMPLETA EL CAMPO DE PERMISO.",
            numero: "POR FAVOR, COMPLETA EL CAMPO DE NÚMERO DE PERMISO.",
            descripcion: "POR FAVOR, COMPLETA EL CAMPO DE DESCRIPCIÓN DE PERMISO.",
            iniciaVigencia: "POR FAVOR, COMPLETA EL CAMPO DE INICIO DE VIGENCIA.",
            finVigencia: "POR FAVOR, COMPLETA EL CAMPO DE FIN DE VIGENCIA.",
            usuarioResponsable: "POR FAVOR, COMPLETA EL CAMPO DE USUARIO RESPONSABLE.",
            sefactura: "POR FAVOR, SELECCIONA SI SE FACTURA O NO.",
            importeConcepto: "POR FAVOR, COMPLETA EL CAMPO DE IMPORTE DE CONCEPTO.",
            importeIva: "POR FAVOR, COMPLETA EL CAMPO DE IMPORTE DE IVA.",
            importeRenta: "POR FAVOR, COMPLETA EL CAMPO DE IMPORTE DE RENTA."
        };

        // Iterar sobre el objeto para verificar si algún campo está vacío
        for (var campo in campos) {
            if (campos[campo] === "") {
                // Mostrar el mensaje de error personalizado para el campo vacío
                customeError("ERROR", mensajesErrores[campo]);
                return; // Detener la función después de mostrar el mensaje de error
            }
        }

        var table = document.getElementById("permisosReferencias").getElementsByTagName('tbody')[0];
        var newRow = table.insertRow(table.rows.length);
        var cell1 = newRow.insertCell(0);
        var cell2 = newRow.insertCell(1);
        var cell16 = newRow.insertCell(2);
        var cell3 = newRow.insertCell(3);
        var cell4 = newRow.insertCell(4);
        var cell5 = newRow.insertCell(5);
        var cell6 = newRow.insertCell(6);
        var cell7 = newRow.insertCell(7);
        var cell8 = newRow.insertCell(8);
        var cell9 = newRow.insertCell(9);
        var cell10 = newRow.insertCell(10);
        var cell11 = newRow.insertCell(11);
        var cell12 = newRow.insertCell(12);
        var cell13 = newRow.insertCell(13);
        var cell14 = newRow.insertCell(14);
        var cell15 = newRow.insertCell(15);

        cell1.innerHTML = table.rows.length;
        cell1.className = 'text-center texto-largo';
        cell1.innerHTML += '<input type="hidden" name="renglon[]" value="' + table.rows.length + '">';
        cell2.innerHTML = rfcArrendatario;
        cell2.className = 'texto-largo';
        cell2.innerHTML += '<input type="hidden" name="rfcArrendatario[]" value="' + rfcArrendatario + '">';
        cell16.innerHTML = nombreArrendatario;
        cell16.className = 'texto-largo';
        cell16.innerHTML += '<input type="hidden" name="nombreArrendatario[]" value="' + nombreArrendatario + '">';
        cell3.innerHTML = permiso;
        cell3.className = 'texto-largo';
        cell3.innerHTML += '<input type="hidden" name="permiso[]" value="' + permiso + '">';
        cell4.innerHTML = numero;
        cell4.className = 'texto-largo';
        cell4.innerHTML += '<input type="hidden" name="numero[]" value="' + numero + '">';
        cell5.innerHTML = descripcion;
        cell5.className = 'texto-largo';
        cell5.innerHTML += '<input type="hidden" name="descripcion[]" value="' + descripcion + '">';
        cell6.innerHTML = referenciaqr;
        cell6.className = 'texto-largo';
        cell6.innerHTML += '<input type="hidden" name="referenciaqr[]" value="' + referenciaqr + '">';
        cell7.innerHTML = numeroPATR;
        cell7.className = 'texto-largo';
        cell7.innerHTML += '<input type="hidden" name="numeroPATR[]" value="' + numeroPATR + '">';
        cell8.innerHTML = iniciaVigencia;
        cell8.className = 'texto-largo';
        cell8.innerHTML += '<input type="hidden" name="iniciaVigencia[]" value="' + iniciaVigencia + '">';
        cell9.innerHTML = finVigencia;
        cell9.className = 'texto-largo';
        cell9.innerHTML += '<input type="hidden" name="finVigencia[]" value="' + finVigencia + '">';
        cell10.innerHTML = usuarioResponsable;
        cell10.className = 'texto-largo';
        cell10.innerHTML += '<input type="hidden" name="usuarioResponsable[]" value="' + usuarioResponsable + '">';
        cell11.innerHTML = sefactura;
        cell11.className = 'texto-largo';
        cell11.innerHTML += '<input type="hidden" name="sefactura[]" value="' + sefactura + '">';
        cell12.innerHTML = importeConcepto;
        cell12.className = 'texto-largo';
        cell12.innerHTML += '<input type="hidden" name="importeConcepto[]" value="' + importeConcepto + '">';
        cell13.innerHTML = importeIva;
        cell13.className = 'texto-largo';
        cell13.innerHTML += '<input type="hidden" name="importeIva[]" value="' + importeIva + '">';
        cell14.innerHTML = importeRenta;
        cell14.className = 'texto-largo';
        cell14.innerHTML += '<input type="hidden" name="importeRenta[]" value="' + importeRenta + '">';
        cell15.innerHTML = '<button type="button" class="btn btn-sm" style="color:white; background-color: #A70303;" onclick="deleteRow(this)"><i class="fas fa-trash"></i></button>';

        document.getElementById('select-permiso').value = "";
        document.getElementById('select-permiso').focus();
        document.getElementById('select-permiso').blur();
        document.getElementById('select-numero').value = "";
        document.getElementById('select-numero').focus();
        document.getElementById('select-numero').blur();
        document.getElementById('select-descripcion').value = "";
        document.getElementById('select-descripcion').focus();
        document.getElementById('select-descripcion').blur();
        document.getElementById('referenciaqr').value = "";
        document.getElementById('referenciaqr').focus();
        document.getElementById('referenciaqr').blur();
        document.getElementById('numeroPART').value = "";
        document.getElementById('numeroPART').focus();
        document.getElementById('numeroPART').blur();
        document.getElementById('iniciaVigencia').value = "";
        document.getElementById('iniciaVigencia').focus();
        document.getElementById('iniciaVigencia').blur();
        document.getElementById('finVigencia').value = "";
        document.getElementById('finVigencia').focus();
        document.getElementById('finVigencia').blur();
        document.getElementById('usuarioResponsable').value = "";
        document.getElementById('usuarioResponsable').focus();
        document.getElementById('usuarioResponsable').blur();
        document.getElementById('sefactura').value = "";
        document.getElementById('sefactura').focus();
        document.getElementById('sefactura').blur();
        document.getElementById('importeConcepto').value = "";
        document.getElementById('importeConcepto').focus();
        document.getElementById('importeConcepto').blur();
        document.getElementById('importeIva').value = "";
        document.getElementById('importeIva').focus();
        document.getElementById('importeIva').blur();
        document.getElementById('importeRenta').value = "";
        document.getElementById('importeRenta').focus();
        document.getElementById('importeRenta').blur();
    }

    // Function to delete a row from the table
    function deleteRow(btn) {
        var row = btn.parentNode.parentNode;
        row.parentNode.removeChild(row);
        updateRowNumbers();
    }
    function updateRowNumbers() {
        const noRecordsMessage = document.getElementById('no-records-message');
        var table = document.getElementById("permisosReferencias").getElementsByTagName('tbody')[0];
        var rows = table.getElementsByTagName('tr');
        for (var i = 0; i < rows.length; i++) {
            rows[i].getElementsByTagName('td')[0].innerHTML = i + 1;
        }
        if(rows.length==0){
            noRecordsMessage.style.display = 'block';
        }else{
            noRecordsMessage.style.display = 'none';
        }
    }

    function sendData(action) {
        let body = {};
        let rfcArrendatario = document.getElementById("rfcArrendatario").value;
        let tablaReferencias = document.getElementById("permisosReferencias");
        let filasReferencias = tablaReferencias.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
        let datosReferencias = [];
        for (let i = 0; i < filasReferencias.length; i++) {
            let celdas = filasReferencias[i].getElementsByTagName("td");
            let filaDatosReferencias = {};
            for (let j = 0; j < celdas.length; j++) {
                let input = celdas[j].getElementsByTagName("input")[0];
                if (input) {
                    if ((j + 1) == 1)
                        filaDatosReferencias["renglon"] = input.value;
                    if ((j + 1) == 2)
                        filaDatosReferencias["rfcArrendatario"] = input.value;
                    if ((j + 1) == 3)
                        filaDatosReferencias["nombreArrendatario"] = input.value;
                    if ((j + 1) == 4)
                        filaDatosReferencias["permiso"] = input.value;
                    if ((j + 1) == 5)
                        filaDatosReferencias["numero"] = input.value;
                    if ((j + 1) == 6)
                        filaDatosReferencias["descripcion"] = input.value;
                    if ((j + 1) == 7)
                        filaDatosReferencias["referenciaqr"] = input.value;
                    if ((j + 1) == 8)
                        filaDatosReferencias["numeroPATR"] = input.value;
                    if ((j + 1) == 9)
                        filaDatosReferencias["iniciaVigencia"] = input.value;
                    if ((j + 1) == 10)
                        filaDatosReferencias["finVigencia"] = input.value;
                    if ((j + 1) == 11)
                        filaDatosReferencias["usuarioResponsable"] = input.value;
                    if ((j + 1) == 12)
                        filaDatosReferencias["sefactura"] = input.value;
                    if ((j + 1) == 13)
                        filaDatosReferencias["importeConcepto"] = input.value;
                    if ((j + 1) == 14)
                        filaDatosReferencias["importeIva"] = input.value;
                    if ((j + 1) == 15)
                        filaDatosReferencias["importeRenta"] = input.value;
                }
            }
            datosReferencias.push(filaDatosReferencias);
        }
        body.datosReferencias = datosReferencias;
        body.rfcCliente = rfcArrendatario;
        body.action = action;

        console.log(body);
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "Srv_ReferenciaPermiso", true);
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
                        window.location.href = "Srv_CSat";
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
        document.getElementById("limpiarPermisos").click();
    }

    // Exponer las funciones globalmente
    window.calcularImportes = calcularImportes;
    window.isertDataTablePermisosArrendamiento = isertDataTablePermisosArrendamiento;
    window.clearTablePermisosArrendamiento = clearTablePermisosArrendamiento;
    window.filterData = filterData;
    window.actualizarPermisos = actualizarPermisos;
    window.actualizarConsecutivos = actualizarConsecutivos;
    window.actualizarDescripcion = actualizarDescripcion;
    window.validateDates = validateDates;
    window.validarFechas = validarFechas;
    window.get_validarUsuario = get_validarUsuario;
    window.insertRow = insertRow;
    window.deleteRow = deleteRow;
    window.updateRowNumbers = updateRowNumbers;
    window.sendData = sendData;
});

