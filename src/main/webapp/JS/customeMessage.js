/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */
'use strict';

function customeError(mensaje, descripcion = "", tiempoVisible = 3000){
    // Obtener referencia al div de la alerta y sus elementos internos
    var alertDiv = document.getElementById('customAlert');
    var alertMessage = document.getElementById('alertMessage');
    var alertDescription = document.getElementById('alertDescription');

    // Asignar mensajes recibidos a los elementos de la alerta
    alertMessage.innerHTML = mensaje;
    alertDescription.innerHTML = descripcion;

    // Mostrar el div de la alerta
    alertDiv.style.display = 'block';

    // Ocultar el mensaje de alerta después de unos segundos
    setTimeout(function () {
        alertDiv.style.display = 'none';
    }, tiempoVisible);
}

 window.customeError= customeError;

