/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Objetos;

import java.util.Date;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class obj_FormaPago {

    private static final long serialversionIUD = 1L;

    private int idFormaPago;
    private String claveFormaPago;
    private String descripcionFormaPago;
    private String usuario;


    //ID Forma de pago
    public int getIdFormaPago() {
        return idFormaPago;
    }

    public void setIdFormaPago(int idFormaPago) {
        this.idFormaPago = idFormaPago;
    }

    //cveFPago

    public String getClaveFormaPago() {
        return claveFormaPago;
    }

    public void setClaveFormaPago(String claveFormaPago) {
        this.claveFormaPago = claveFormaPago;
    }

    public String getDescripcionFormaPago() {
        return descripcionFormaPago;
    }

    public void setDescripcionFormaPago(String descripcionFormaPago) {
        this.descripcionFormaPago = descripcionFormaPago;
    }

   //USUARIO
    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

}
