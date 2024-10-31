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
public class obj_UMedida {
     private static final long serialversionIUD=1L;
    
    private int idUnidadMedida;
    private String claveUnidadMedida;
    private String descripcionUnidadMedida;
    private String usuario;


    public int getIdUnidadMedida() {
        return idUnidadMedida;
    }

    public void setIdUnidadMedida(int idUnidadMedida) {
        this.idUnidadMedida = idUnidadMedida;
    }

    public String getClaveUnidadMedida() {
        return claveUnidadMedida;
    }

    public void setClaveUnidadMedida(String claveUnidadMedida) {
        this.claveUnidadMedida = claveUnidadMedida;
    }

    public String getDescripcionUnidadMedida() {
        return descripcionUnidadMedida;
    }

    public void setDescripcionUnidadMedida(String descripcionUnidadMedida) {
        this.descripcionUnidadMedida = descripcionUnidadMedida;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

}
