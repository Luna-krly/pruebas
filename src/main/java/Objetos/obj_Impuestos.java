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
public class obj_Impuestos {

    private static final long serialVersionUID = 1L;

    private int idImpuesto;
    private String claveImpuesto;
    private String descripcionImpuesto;
    private String retencion;
    private String traslado;
    private String usuario;

    public int getIdImpuesto() {
        return idImpuesto;
    }

    public void setIdImpuesto(int idImpuesto) {
        this.idImpuesto = idImpuesto;
    }

    public String getClaveImpuesto() {
        return claveImpuesto;
    }

    public void setClaveImpuesto(String claveImpuesto) {
        this.claveImpuesto = claveImpuesto;
    }

    public String getDescripcionImpuesto() {
        return descripcionImpuesto;
    }

    public void setDescripcionImpuesto(String descripcionImpuesto) {
        this.descripcionImpuesto = descripcionImpuesto;
    }

    public String getRetencion() {
        return retencion;
    }

    public void setRetencion(String retencion) {
        this.retencion = retencion;
    }

    public String getTraslado() {
        return traslado;
    }

    public void setTraslado(String traslado) {
        this.traslado = traslado;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }
    
}
