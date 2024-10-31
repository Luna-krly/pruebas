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
public class obj_Pagos {
     private static final long serialVersionUID = 1L;
    
    //Pago

    private int idPago;
    private int idCliente;
    
    private int folPago;//FOLIO PAGO
    private Date fchPago;
    private String banco;
    private String rfcBanco;
    private String ctacliente;
    private String notastc;
    private int idFPago;
    private int idmoneda;
    private String tcambio;//tipo de cambio
    private int noOperacion;
    private float total;
    private float subtotal;
    private float ivaT;
    private float ivaR;
    private int idCFDI;
    
    //Factura
    private int idFactura;
    private int ffiscal;//folio fiscal
    private int idMPago;
    private int nparcial;//no parcial
    private float santerior;//saldo anterior
    private float ipagado;//importe pagado
    private float sinsoluto;//saldo insoluto
    //Impuesto
    private int idIMPFactura;
    private float base;
    private float ivaIT;
    private float ivaIR;
    private float pago;
    private float TotalSA;
    private float TotalIT;
    private float TotalIR;
    private float TotalP;
    

    //--------------
    private String usuario;

    private String estatus;

    
    //-------------------------------------PAGO
    //ID PAGO
    public int getIdPago(){
        return idPago;
    }
    public void setIdPago(int idPago){
        this.idPago=idPago;
    }
    
    //ID CLIENTE
    public int getIdCliente(){
        return idCliente;
    }
    public void setIdCliente(int idCliente){
        this.idCliente=idCliente;
    }
    
    //FOLIO DE PAGO
    public int getFPago(){
        return folPago;
    }
    public void setFPago(int folPago){
        this.folPago=folPago;
    }

    // FECHA PAGO
    public Date getFchPago(){
        return fchPago;
    }
    public void setFchPago(Date fchPago){
        this.fchPago=fchPago;
    }
    
    //NOMBRE DEL BANCO
    public String getBanco(){
        return banco;
    }
    public void setBanco(String banco){
        this.banco=banco;
    }
    //RFC DEL BANCO
    public String getRFCBanco(){
        return rfcBanco;
    }
    public void setRFCBanco(String rfcBanco){
        this.rfcBanco=rfcBanco;
    }
    
    //CUENTA CLIENTE
    public String getCtaCliente(){
        return ctacliente;
    }
    public void setCtaCliente(String ctacliente){
        this.ctacliente=ctacliente;
    }
    
    //NOTA STC
    public String getNtaSTC(){
        return notastc;
    }
    public void setNtaSTC(String notastc){
        this.notastc=notastc;
    }
    
    //ID FORMA DE PAGO
    public int getIdFPago(){
        return idFPago;
    }
    public void setIdFPago(int idFPago){
        this.idFPago=idFPago;
    }
    
    //ID MONEDA
    public int getIdMoneda(){
        return idmoneda;
    }
    public void setIdMoneda(int idmoneda){
        this.idmoneda=idmoneda;
    }
    //TIPO DE CAMBIO
    public String getTCambio(){
        return tcambio;
    }
    public void setTCambio(String tcambio){
        this.tcambio=tcambio;
    }
    //NO OPERACION
    public int getNOperacion(){
        return noOperacion;
    }
    public void setNOperacion(int noOperacion){
        this.noOperacion=noOperacion;
    }
    //TOTAL
    public float getTotal(){
        return total;
    }
    public void setTotal(float total){
        this.total=total;
    }
    //SUBTOTAL
    public float getSubtotal(){
        return subtotal;
    }
    public void setSubotal(float subtotal){
        this.subtotal=subtotal;
    }
    //IVA TRASLADADO
    public float getIVATr(){
        return ivaT;
    }
    public void setIVATr(float ivaT){
        this.ivaT=ivaT;
    }
    
    //IVA RETENIDO
    public float getIVARt(){
        return ivaR;
    }
    public void setIVARt(float ivaR){
        this.ivaR=ivaR;
    }

    //USO DE CFDI
    public int getIdUsoCFDI(){
        return idCFDI;
    }
    public void setIdUsoCFDI(int idCFDI){
        this.idCFDI=idCFDI;
    }
    //------------------------------------------------FACTURA
    //ID FACTURA
    public int getIdFactura(){
        return idFactura;
    }
    public void setIdFactura(int idFactura){
        this.idFactura=idFactura;
    }
    //FOLIO FISCAL
    public int getFFiscal(){
        return ffiscal;
    }
    public void setFFiscal(int ffiscal){
        this.ffiscal=ffiscal;
    }
    //ID METODO DE PAGO
    public int getIdMPago(){
        return idMPago;
    }
    public void setIdMPago(int idMPago){
        this.idMPago=idMPago;
    }
    //NÚMERO PARCIAL
    public int getNParcial(){
        return nparcial;
    }
    public void setNParcial(int nparcial){
        this.nparcial=nparcial;
    }
    //SALDO ANTERIOR
    public float getSAnterior(){
        return santerior;
    }
    public void setSAnterior(float santerior){
        this.santerior=santerior;
    }
    //IMPORTE PAGADO
    public float getIPagado(){
        return ipagado;
    }
    public void setIPagado(float ipagado){
        this.ipagado=ipagado;
    }
    //saldo insoluto
    public float getSInsoluto(){
        return sinsoluto;
    }
    public void setSInsoluto(float sinsoluto){
        this.sinsoluto=sinsoluto;
    }
    
    
    //---------------------------------------------------Impuesto
    //ID IMPUESTO DE FACTURA
    public int getImpFactura(){
        return idIMPFactura;
    }
    public void setImpFactura(int idIMPFactura){
        this.idIMPFactura=idIMPFactura;
    }
    //BASE DE CALCULO
    public float getBase(){
        return base;
    }
    public void setBase(float base){
        this.base=base;
    }
    //IVA IMPUESTO TRASLADADO
    public float getIvaIT(){
        return ivaIT;
    }
    public void setIvaIT(float ivaIT){
        this.ivaIT=ivaIT;
    }
    //IVA IMPUESTO RETENIDO
    public float getIvaIR(){
        return ivaIR;
    }
    public void setIvaIR(float ivaIR){
        this.ivaIR=ivaIR;
    }
    //PAGO
    public float getPago(){
        return pago;
    }
    public void setPago(float pago){
        this.pago=pago;
    }
    //IVA IMPUESTO RETENIDO
    public float getTSAnterior(){
        return TotalSA;
    }
    public void setTSAnterior(float TotalSA){
        this.TotalSA=TotalSA;
    }
    //TOTAL IVA TRASLADADO
    public float getTITrasladado(){
        return TotalIT;
    }
    public void setTITrasladado(float TotalIT){
        this.TotalIT=TotalIT;
    }
    //TOTAL IVA RETENIDO
    public float getTIRetenido(){
        return TotalIR;
    }
    public void setTIRetenido(float TotalIR){
        this.TotalIR=TotalIR;
    }
    //TOTAL Pago
    public float getTotalP(){
        return TotalP;
    }
    public void setTotalP(float TotalP){
        this.TotalP=TotalP;
    }


    //--------------------------------------------------------
    //Usuario
    public String getUsuario() {    
        return usuario;
    }
    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    //Estatus
    public String getEstatus() {
        return estatus;
    }
    
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    } 
}
