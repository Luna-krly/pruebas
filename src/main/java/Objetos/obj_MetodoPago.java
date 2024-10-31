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
public class obj_MetodoPago {
     private static final long serialversionIUD=1L;
    
    private int idMetodoPago;
    private String claveMetodoPago;
    private String descripcionMetodoPago;
    private String usuario;


    public int getIdMetodoPago() {
        return idMetodoPago;
    }

    public void setIdMetodoPago(int idMetodoPago) {
        this.idMetodoPago = idMetodoPago;
    }

    public String getClaveMetodoPago() {
        return claveMetodoPago;
    }

    public void setClaveMetodoPago(String claveMetodoPago) {
        this.claveMetodoPago = claveMetodoPago;
    }

    public String getDescripcionMetodoPago() {
        return descripcionMetodoPago;
    }

    public void setDescripcionMetodoPago(String descripcionMetodoPago) {
        this.descripcionMetodoPago = descripcionMetodoPago;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

}
