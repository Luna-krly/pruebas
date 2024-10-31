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
public class obj_TRelacion {
    private static final long serialversionIUD=1L;
    
    private int idTipoRelacion;
    private String claveTipoRelacion;
    private String descripcionTipoRelacion;
    private String usuario;
    
    
    public int getIdTipoRelacion() {
        return idTipoRelacion;
    }

    public void setIdTipoRelacion(int idTipoRelacion) {
        this.idTipoRelacion = idTipoRelacion;
    }

    public String getClaveTipoRelacion() {
        return claveTipoRelacion;
    }

    public void setClaveTipoRelacion(String claveTipoRelacion) {
        this.claveTipoRelacion = claveTipoRelacion;
    }

    public String getDescripcionTipoRelacion() {
        return descripcionTipoRelacion;
    }

    public void setDescripcionTipoRelacion(String descripcionTipoRelacion) {
        this.descripcionTipoRelacion = descripcionTipoRelacion;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }
   

}
