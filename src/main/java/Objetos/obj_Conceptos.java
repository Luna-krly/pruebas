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
public class obj_Conceptos {

    private static final long serialVersionUID = 1L;

    private String idConcepto;
    private String nombre;
    private String tipoIngreso;
    private String remitente;
    private String destinatario;
    private String concepto;
    private String nombreVo;
    private String nombreAtt;
    private String puestoVo;
    private String puestoAtt;

    private String usuario;


    //IDConcepto
    public String getIdConcepto() {
        return idConcepto;
    }

    public void setIdConcepto(String idConcepto) {
        this.idConcepto = idConcepto;
    }

    //nombre
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTipoIngreso() {
        return tipoIngreso;
    }

    public void setTipoIngreso(String tipoIngreso) {
        this.tipoIngreso = tipoIngreso;
    }


    //Remitente
    public String getRemitente() {
        return remitente;
    }

    public void setRemitente(String remitente) {
        this.remitente = remitente;
    }

    //Destinatario
    public String getDestinatario() {
        return destinatario;
    }

    public void setDestinatario(String destinatario) {
        this.destinatario = destinatario;
    }

    //concepto
    public String getConcepto() {
        return concepto;
    }

    public void setConcepto(String concepto) {
        this.concepto = concepto;
    }
    //nombre vo

    public String getNombreVo() {
        return nombreVo;
    }

    public void setNombreVo(String nombreVo) {
        this.nombreVo = nombreVo;
    }
    
    //nombre att
    public String getNombreAtt() { 
        return nombreAtt;
    }

    public void setNombreAtt(String nombreAtt) {    
        this.nombreAtt = nombreAtt;
    }

    //puesto vo
    public String getPuestoVo() {
        return puestoVo;
    }

    public void setPuestoVo(String puestoVo) {
        this.puestoVo = puestoVo;
    }
    //puesto att
    public String getPuestoAtt() {
        return puestoAtt;
    }

    public void setPuestoAtt(String puestoAtt) {
        this.puestoAtt = puestoAtt;
    }

    //CveusrAlta
    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    
}
