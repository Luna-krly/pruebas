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
public class obj_TComprobante {
    private static final long serialversionUID=1L;
    
    private int idTipoComprobante;
    private String claveTipoComprobante;
    private String descripcionTipoComprobante;
    private String usuario;

    public int getIdTipoComprobante() {
        return idTipoComprobante;
    }

    public void setIdTipoComprobante(int idTipoComprobante) {
        this.idTipoComprobante = idTipoComprobante;
    }

    public String getClaveTipoComprobante() {
        return claveTipoComprobante;
    }

    public void setClaveTipoComprobante(String claveTipoComprobante) {
        this.claveTipoComprobante = claveTipoComprobante;
    }

    public String getDescripcionTipoComprobante() {
        return descripcionTipoComprobante;
    }

    public void setDescripcionTipoComprobante(String descripcionTipoComprobante) {
        this.descripcionTipoComprobante = descripcionTipoComprobante;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

}
