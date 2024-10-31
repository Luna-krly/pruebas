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
public class obj_ProdServ {
    private static final long serialversionIUD=1L;
    
    private int idProdServ;
    private String claveProdServ;
    private String descripcionProdServ;
    private String idObjImpuesto;
    private String objetoImpuesto;

    private String usuario;


    public int getIdProdServ() {
        return idProdServ;
    }

    public void setIdProdServ(int idProdServ) {
        this.idProdServ = idProdServ;
    }

    public String getClaveProdServ() {
        return claveProdServ;
    }

    public void setClaveProdServ(String claveProdServ) {
        this.claveProdServ = claveProdServ;
    }

    public String getDescripcionProdServ() {
        return descripcionProdServ;
    }

    public void setDescripcionProdServ(String descripcionProdServ) {
        this.descripcionProdServ = descripcionProdServ;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getIdObjImpuesto() {
        return idObjImpuesto;
    }

    public void setIdObjImpuesto(String idObjImpuesto) {
        this.idObjImpuesto = idObjImpuesto;
    }

    public String getObjetoImpuesto() {
        return objetoImpuesto;
    }

    public void setObjetoImpuesto(String objetoImpuesto) {
        this.objetoImpuesto = objetoImpuesto;
    }


}
