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
public class obj_TFactor {
    private static final long serialversionIUD=1L;
    
    private int idTipoFactor;
    private String claveTipoFactor;
   private String descripcionTipoFactor;
    private String usuario;

    public int getIdTipoFactor() {
        return idTipoFactor;
    }

    public void setIdTipoFactor(int idTipoFactor) {
        this.idTipoFactor = idTipoFactor;
    }

    public String getClaveTipoFactor() {
        return claveTipoFactor;
    }

    public void setClaveTipoFactor(String claveTipoFactor) {
        this.claveTipoFactor = claveTipoFactor;
    }

    public String getDescripcionTipoFactor() {
        return descripcionTipoFactor;
    }

    public void setDescripcionTipoFactor(String descripcionTipoFactor) {
        this.descripcionTipoFactor = descripcionTipoFactor;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }


}
