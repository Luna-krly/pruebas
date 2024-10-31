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
public class obj_MArrendamiento {

    private static final long serialVersionUID = 1L;

    private String idMemorandum;
    private String noMemorandum;
    private String idConcepto;
    private String nombreConcepto;
    private String fecha;
    private String remitente;
    private String destinatario;
    
    private String depositoBancario;
    private String cuentaBancaria;
    
    private String conceptoGeneral;

    private double total;
    private double retenido;
    private double iva;
    private double subtotal;
    private String totalLetras;
    private String nombreVo;
    private String puestoVo;
    private String nombreAtt;
    private String puestoAtt;
    private String estatus;
    private String usuario;
    private String motivos;
    private String fechaCapturado;

    public String getFechaCapturado() {
        return fechaCapturado;
    }

    public void setFechaCapturado(String fechaCapturado) {
        this.fechaCapturado = fechaCapturado;
    }
    
    

    public String getIdMemorandum() {
        return idMemorandum;
    }

    public void setIdMemorandum(String idMemorandum) {
        this.idMemorandum = idMemorandum;
    }

    public String getNoMemorandum() {
        return noMemorandum;
    }

    public void setNoMemorandum(String noMemorandum) {
        this.noMemorandum = noMemorandum;
    }

    public String getIdConcepto() {
        return idConcepto;
    }

    public void setIdConcepto(String idConcepto) {
        this.idConcepto = idConcepto;
    }

    public String getNombreConcepto() {
        return nombreConcepto;
    }

    public void setNombreConcepto(String nombreConcepto) {
        this.nombreConcepto = nombreConcepto;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getRemitente() {
        return remitente;
    }

    public void setRemitente(String remitente) {
        this.remitente = remitente;
    }

    public String getDestinatario() {
        return destinatario;
    }

    public void setDestinatario(String destinatario) {
        this.destinatario = destinatario;
    }

    public String getDepositoBancario() {
        return depositoBancario;
    }

    public void setDepositoBancario(String depositoBancario) {
        this.depositoBancario = depositoBancario;
    }

    public String getCuentaBancaria() {
        return cuentaBancaria;
    }

    public void setCuentaBancaria(String cuentaBancaria) {
        this.cuentaBancaria = cuentaBancaria;
    }

    public String getConceptoGeneral() {
        return conceptoGeneral;
    }

    public void setConceptoGeneral(String conceptoGeneral) {
        this.conceptoGeneral = conceptoGeneral;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public double getRetenido() {
        return retenido;
    }

    public void setRetenido(double retenido) {
        this.retenido = retenido;
    }

    public double getIva() {
        return iva;
    }

    public void setIva(double iva) {
        this.iva = iva;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public String getTotalLetras() {
        return totalLetras;
    }

    public void setTotalLetras(String totalLetras) {
        this.totalLetras = totalLetras;
    }

    public String getNombreVo() {
        return nombreVo;
    }

    public void setNombreVo(String nombreVo) {
        this.nombreVo = nombreVo;
    }

    public String getPuestoVo() {
        return puestoVo;
    }

    public void setPuestoVo(String puestoVo) {
        this.puestoVo = puestoVo;
    }

    public String getNombreAtt() {
        return nombreAtt;
    }

    public void setNombreAtt(String nombreAtt) {
        this.nombreAtt = nombreAtt;
    }

    public String getPuestoAtt() {
        return puestoAtt;
    }

    public void setPuestoAtt(String puestoAtt) {
        this.puestoAtt = puestoAtt;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getMotivos() {
        return motivos;
    }

    public void setMotivos(String motivos) {
        this.motivos = motivos;
    }

    
    
  

}
