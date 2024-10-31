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
public class obj_Factura {

    private static final long serialVersionUID = 1L;
    
    private Date FchCambio;
    private String CveusrAlta; 
    private String estatus;
    private String idFactura;
    private String folio;
    private String usuario;
    
    //AUTORIZACION
    private String usuarioAutorizo;
    private String fechaAutorizo;
    
    //ENCABEZADO
    private String idTipoComprobante;
    private String idCliente;
    private String idPeriodicidad;
    private String mes;
    private String conceptoFactura;
    private String fechaPago;
    private String observaciones;
    private String idUsoCFDI;
    private String fechaFactura;
    private String cpEmisorFactura;
    private String serie;
    private String idMoneda;
    private String tipoCambio;
    private String idFormaPago;
    private String cuentaBancaria;
    private String idMetodoPago;
    private String idTipoRelacion;
    private String idTipoServicio;
    private String condicionesPago;
    private String idPermiso;
    private String noPermiso;
    private Date fechaCambio;
    private String CveusrCambio;

    private String subtotal;
    private String IVA;
    private String total;
    private String totalLetras;
    private String claveCodigoPostal;

    //DETALLES
    private String renglonProducto;
    private String idProductoServicio;
    private String cantidad;
    private String idUnidadMedida;
    private String detalleConcepto;
    private String precioUnitario;
    private String importeConcepto;
    private String cuentaPredial;
    private String serieProducto;
    private String fechaFacturaProducto;
    private String FacturaNC;
    private String serieNC;
    private String fechaFacturaNC;
    private String folioFiscalNC;
    private String predial;
    

    //IMPUESTOS
    private String renglonImpuesto;
    private String impuesto;
    private String idTipoimpuesto;
    private String idTipoFactor;
    private String porcentajeImpuesto;
    private String importeImpuesto;
    private String importeBase;
    private String renglonProductoReferencia;
    private Float tasa;

    public String getUsuarioAutorizo() {
        return usuarioAutorizo;
    }

    public void setUsuarioAutorizo(String usuarioAutorizo) {
        this.usuarioAutorizo = usuarioAutorizo;
    }

    public String getFechaAutorizo() {
        return fechaAutorizo;
    }

    public void setFechaAutorizo(String fechaAutorizo) {
        this.fechaAutorizo = fechaAutorizo;
    }

    
    
    public String getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(String idFactura) {
        this.idFactura = idFactura;
    }

    public Float getTasa() {
        return tasa;
    }

    public void setTasa(Float tasa) {
        this.tasa = tasa;
    }

    public void setTasa(float tasa) {
        this.tasa = tasa;
    }
    
    public Date getFchCambio() {
        return FchCambio;
    }

    public void setFchCambio(Date FchCambio) {
        this.FchCambio = FchCambio;
    }

    public String getCveusrAlta() {
        return CveusrAlta;
    }

    public void setCveusrAlta(String CveusrAlta) {
        this.CveusrAlta = CveusrAlta;
    }
    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public String getPredial() {
        return predial;
    }

    public void setPredial(String predial) {
        this.predial = predial;
    }
    
    public Date getFechaCambio() {
        return fechaCambio;
    }

    public void setFechaCambio(Date fechaCambio) {
        this.fechaCambio = fechaCambio;
    }

    public String getCveusrCambio() {
        return CveusrCambio;
    }

    public void setCveusrCambio(String CveusrCambio) {
        this.CveusrCambio = CveusrCambio;
    }
    
    public String getNoPermiso() {
        return noPermiso;
    }

    public void setNoPermiso(String noPermiso) {
        this.noPermiso = noPermiso;
    }
    
    public String getClaveCodigoPostal() {
        return claveCodigoPostal;
    }

    public void setClaveCodigoPostal(String claveCodigoPostal) {
        this.claveCodigoPostal = claveCodigoPostal;
    }
    
    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }
    
    public String getIdTipoComprobante() {
        return idTipoComprobante;
    }

    public void setIdTipoComprobante(String idTipoComprobante) {
        this.idTipoComprobante = idTipoComprobante;
    }

    public String getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(String idCliente) {
        this.idCliente = idCliente;
    }

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
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

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getIdUsoCFDI() {
        return idUsoCFDI;
    }

    public void setIdUsoCFDI(String idUsoCFDI) {
        this.idUsoCFDI = idUsoCFDI;
    }

    public String getFechaFactura() {
        return fechaFactura;
    }

    public void setFechaFactura(String fechaFactura) {
        this.fechaFactura = fechaFactura;
    }

    public String getCpEmisorFactura() {
        return cpEmisorFactura;
    }

    public void setCpEmisorFactura(String cpEmisorFactura) {
        this.cpEmisorFactura = cpEmisorFactura;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public String getTipoCambio() {
        return tipoCambio;
    }

    public void setTipoCambio(String tipoCambio) {
        this.tipoCambio = tipoCambio;
    }

    public String getIdFormaPago() {
        return idFormaPago;
    }

    public void setIdFormaPago(String idFormaPago) {
        this.idFormaPago = idFormaPago;
    }

    public String getCuentaBancaria() {
        return cuentaBancaria;
    }

    public void setCuentaBancaria(String cuentaBancaria) {
        this.cuentaBancaria = cuentaBancaria;
    }

    public String getIdTipoRelacion() {
        return idTipoRelacion;
    }

    public void setIdTipoRelacion(String idTipoRelacion) {
        this.idTipoRelacion = idTipoRelacion;
    }

    public String getCondicionesPago() {
        return condicionesPago;
    }

    public void setCondicionesPago(String condicionesPago) {
        this.condicionesPago = condicionesPago;
    }

    public String getIdPermiso() {
        return idPermiso;
    }

    public void setIdPermiso(String idPermiso) {
        this.idPermiso = idPermiso;
    }

    public String getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(String subtotal) {
        this.subtotal = subtotal;
    }

    public String getIVA() {
        return IVA;
    }

    public void setIVA(String IVA) {
        this.IVA = IVA;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getTotalLetras() {
        return totalLetras;
    }

    public void setTotalLetras(String totalLetras) {
        this.totalLetras = totalLetras;
    }

    public String getRenglonProducto() {
        return renglonProducto;
    }

    public void setRenglonProducto(String renglonProducto) {
        this.renglonProducto = renglonProducto;
    }

    public String getIdProductoServicio() {
        return idProductoServicio;
    }

    public void setIdProductoServicio(String idProductoServicio) {
        this.idProductoServicio = idProductoServicio;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    public String getIdUnidadMedida() {
        return idUnidadMedida;
    }

    public void setIdUnidadMedida(String idUnidadMedida) {
        this.idUnidadMedida = idUnidadMedida;
    }

    public String getDetalleConcepto() {
        return detalleConcepto;
    }

    public void setDetalleConcepto(String detalleConcepto) {
        this.detalleConcepto = detalleConcepto;
    }

    public String getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(String precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public String getFacturaNC() {
        return FacturaNC;
    }

    public void setFacturaNC(String FacturaNC) {
        this.FacturaNC = FacturaNC;
    }

    public String getFolioFiscalNC() {
        return folioFiscalNC;
    }

    public void setFolioFiscalNC(String folioFiscalNC) {
        this.folioFiscalNC = folioFiscalNC;
    }



    public String getSerieNC() {
        return serieNC;
    }

    public void setSerieNC(String serieNC) {
        this.serieNC = serieNC;
    }

    public String getFechaFacturaNC() {
        return fechaFacturaNC;
    }

    public void setFechaFacturaNC(String fechaFacturaNC) {
        this.fechaFacturaNC = fechaFacturaNC;
    }

    
    public String getImporteConcepto() {
        return importeConcepto;
    }

    public void setImporteConcepto(String importeConcepto) {
        this.importeConcepto = importeConcepto;
    }

    public String getCuentaPredial() {
        return cuentaPredial;
    }

    public void setCuentaPredial(String cuentaPredial) {
        this.cuentaPredial = cuentaPredial;
    }

    public String getSerieProducto() {
        return serieProducto;
    }

    public void setSerieProducto(String serieProducto) {
        this.serieProducto = serieProducto;
    }

    public String getFechaFacturaProducto() {
        return fechaFacturaProducto;
    }

    public void setFechaFacturaProducto(String fechaFacturaProducto) {
        this.fechaFacturaProducto = fechaFacturaProducto;
    }

    public String getRenglonImpuesto() {
        return renglonImpuesto;
    }

    public void setRenglonImpuesto(String renglonImpuesto) {
        this.renglonImpuesto = renglonImpuesto;
    }

    public String getImpuesto() {
        return impuesto;
    }

    public void setImpuesto(String impuesto) {
        this.impuesto = impuesto;
    }

    public String getIdTipoimpuesto() {
        return idTipoimpuesto;
    }

    public void setIdTipoimpuesto(String idTipoimpuesto) {
        this.idTipoimpuesto = idTipoimpuesto;
    }

    public String getIdTipoFactor() {
        return idTipoFactor;
    }

    public void setIdTipoFactor(String idTipoFactor) {
        this.idTipoFactor = idTipoFactor;
    }

    public String getPorcentajeImpuesto() {
        return porcentajeImpuesto;
    }

    public void setPorcentajeImpuesto(String porcentajeImpuesto) {
        this.porcentajeImpuesto = porcentajeImpuesto;
    }

    public String getImporteImpuesto() {
        return importeImpuesto;
    }

    public void setImporteImpuesto(String importeImpuesto) {
        this.importeImpuesto = importeImpuesto;
    }

    public String getImporteBase() {
        return importeBase;
    }

    public void setImporteBase(String importeBase) {
        this.importeBase = importeBase;
    }

    public String getRenglonProductoReferencia() {
        return renglonProductoReferencia;
    }

    public void setRenglonProductoReferencia(String renglonProductoReferencia) {
        this.renglonProductoReferencia = renglonProductoReferencia;
    }

    public String getIdPeriodicidad() {
        return idPeriodicidad;
    }

    public void setIdPeriodicidad(String idPeriodicidad) {
        this.idPeriodicidad = idPeriodicidad;
    }

    public String getIdMoneda() {
        return idMoneda;
    }

    public void setIdMoneda(String idMoneda) {
        this.idMoneda = idMoneda;
    }

    public String getIdMetodoPago() {
        return idMetodoPago;
    }

    public void setIdMetodoPago(String idMetodoPago) {
        this.idMetodoPago = idMetodoPago;
    }

    public String getIdTipoServicio() {
        return idTipoServicio;
    }

    public void setIdTipoServicio(String idTipoServicio) {
        this.idTipoServicio = idTipoServicio;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    
}
