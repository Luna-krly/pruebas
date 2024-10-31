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
public class obj_RegFiscal {
    private static final long serialVersionUID=1L;
    
    private int idRegimen;
    private String claveRegimen;
    private String descripcionRegimen;
    private String fisica;
    private String moral;
    private String usuario;

    public int getIdRegimen() {
        return idRegimen;
    }

    public void setIdRegimen(int idRegimen) {
        this.idRegimen = idRegimen;
    }

    public String getClaveRegimen() {
        return claveRegimen;
    }

    public void setClaveRegimen(String claveRegimen) {
        this.claveRegimen = claveRegimen;
    }

    public String getDescripcionRegimen() {
        return descripcionRegimen;
    }

    public void setDescripcionRegimen(String descripcionRegimen) {
        this.descripcionRegimen = descripcionRegimen;
    }

    public String getFisica() {
        return fisica;
    }

    public void setFisica(String fisica) {
        this.fisica = fisica;
    }

    public String getMoral() {
        return moral;
    }

    public void setMoral(String moral) {
        this.moral = moral;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }
    
}
