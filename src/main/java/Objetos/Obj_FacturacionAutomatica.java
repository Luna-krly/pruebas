/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Objetos;

import java.util.Date;
import Funciones.Convertir;
import java.math.RoundingMode;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ivan Velazquez
 */
public class Obj_FacturacionAutomatica {
    private int folio;
    private String serie;
    private String tipoComprobante;
    private String RFC;
    private String cliente;
    private String lugarEmision;
    private String usoFactura;
    private String  fechaFactura;
    private String horaFactura;
    private String Moneda;
    private String tipoCambio; 
    private String formaPago;
    private String cuentaBanco; 
    private String metodoPago; 
    private String condicionesPago; 
    private String noPermiso; 
    private double subTotal;
    private double IVA;
    private double totalFactura;
    private String totalLetra; 
    private String usuarioResponsable; 
    private String fechaGeneracion;
    private String estatus; 
    private String conceptoFactura;
    private String fechaPago;
    private double saldoFactura;
    private String mesFactura;
    private String sinDomicilio;
    private String tipoServicio;
    private int idCliente;
    private List<Obj_ConceptoFactura> conceptos;
    private List<Obj_ImpuestoConcepto> impuestos;

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public void setConceptos(List<Obj_ConceptoFactura> conceptos) {
        this.conceptos = conceptos;
    }

    public void setImpuestos(List<Obj_ImpuestoConcepto> impuestos) {
        this.impuestos = impuestos;
    }
    

    public int getFolio() {
        return folio;
    }

    public void setFolio(int Folio) {
        this.folio = Folio;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String Serie) {
        this.serie = Serie;
    }

    public String getTipoComprobante() {
        return tipoComprobante;
    }

    public void setTipoComprobante(String tipoComprobante) {
        this.tipoComprobante = tipoComprobante;
    }

    public String getRFC() {
        return RFC;
    }

    public void setRFC(String RFC) {
        this.RFC = RFC;
    }

    public String getCliente() {
        return cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }

    public String getLugarEmision() {
        return lugarEmision;
    }

    public void setLugarEmision(String lugarEmision) {
        this.lugarEmision = lugarEmision;
    }

    public String getUsoFactura() {
        return usoFactura;
    }

    public void setUsoFactura(String usoFactura) {
        this.usoFactura = usoFactura;
    }

    public String getFechaFactura() {
        return fechaFactura;
    }

    public void setFechaFactura(String fechaFactura) {
        this.fechaFactura = fechaFactura;
    }

    public String getHoraFactura() {
        return horaFactura;
    }

    public void setHoraFactura(String horaFactura) {
        this.horaFactura = horaFactura;
    }

    public String getMoneda() {
        return Moneda;
    }

    public void setMoneda(String Moneda) {
        this.Moneda = Moneda;
    }

    public String getTipoCambio() {
        return tipoCambio;
    }

    public void setTipoCambio(String tipoCambio) {
        this.tipoCambio = tipoCambio;
    }

    public String getFormaPago() {
        return formaPago;
    }

    public void setFormaPago(String formaPago) {
        this.formaPago = formaPago;
    }

    public String getCuentaBanco() {
        return cuentaBanco;
    }

    public void setCuentaBanco(String cuentaBanco) {
        this.cuentaBanco = cuentaBanco;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getCondicionesPago() {
        return condicionesPago;
    }

    public void setCondicionesPago(String condicionesPago) {
        this.condicionesPago = condicionesPago;
    }

    public String getNoPermiso() {
        return noPermiso;
    }

    public void setNoPermiso(String noPermiso) {
        this.noPermiso = noPermiso;
    }

    public double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }

    public double getIVA() {
        return IVA;
    }

    public void setIVA(double IVA) {
        this.IVA = IVA;
    }

    public double getTotalFactura() {
        return totalFactura;
    }

    public void setTotalFactura(double totalFactura) {
        this.totalFactura = totalFactura;
    }

    public String getTotalLetra() {
        return totalLetra;
    }

    public void setTotalLetra(double total) {
        BigDecimal bd = new BigDecimal(String.valueOf(total));
        BigDecimal iPart = new BigDecimal(bd.toBigInteger());
        BigDecimal fPartToInt = bd.subtract(bd.setScale(0, RoundingMode.FLOOR)).movePointRight(bd.scale());
        int enteros= iPart.intValue();
        int decimales=fPartToInt.intValue();
        Convertir convertir = new Convertir();
        this.totalLetra = convertir.getStringOfNumber(enteros, decimales);
    }

    public String getUsuarioResponsable() {
        return usuarioResponsable;
    }

    public void setUsuarioResponsable(String usuarioResponsable) {
        this.usuarioResponsable = usuarioResponsable;
    }

    public String getFechaGeneracion() {
        return fechaGeneracion;
    }

    public void setFechaGeneracion(String fechaGeneracion) {
        this.fechaGeneracion = fechaGeneracion;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public String getConceptoFactura() {
        return conceptoFactura;
    }

    public void setConceptoFactura(String conceptoFactura) {
        this.conceptoFactura = conceptoFactura;
    }

    public String getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(String fechaPago) {
        this.fechaPago = fechaPago;
    }

    public double getSaldoFactura() {
        return saldoFactura;
    }

    public void setSaldoFactura(double saldoFactura) {
        this.saldoFactura = saldoFactura;
    }

    public String getMesFactura() {
        return mesFactura;
    }

    public void setMesFactura(String mesFactura) {
        this.mesFactura = mesFactura;
    }

    public String getTipoServicio() {
        return tipoServicio;
    }

    public void setTipoServicio(String tipoServicio) {
        this.tipoServicio = tipoServicio;
    }
}
