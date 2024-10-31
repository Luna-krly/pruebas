/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Objetos;

/**
 *
 * @author PC
 */
public class Obj_ConceptoFactura {
    private int folio;
    private String serie;
    private String fechaFactura;
    private String renglon;
    private String productoServicio;
    private String cantidad;
    private String unidadMedida;
    private String descripcionUnidadMedida;
    private String precioUnitario;
    private String importeConcepto;
    private double descuento;
    private String cuentaPredial;
    private String concepto;
    private String permiso;

    public String getPermiso() {
        return permiso;
    }

    public void setPermiso(String permiso) {
        this.permiso = permiso;
    }
    
    public String getRFC() {
        return RFC;
    }

    public void setRFC(String RFC) {
        this.RFC = RFC;
    }
    private String RFC;

    public String getConcepto() {
        return concepto;
    }

    public void setConcepto(String concepto) {
        this.concepto = concepto;
    }
    
    public int getFolio() {
        return folio;
    }

    public void setFolio(int folio) {
        this.folio = folio;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public String getFechaFactura() {
        return fechaFactura;
    }

    public void setFechaFactura(String fechaFactura) {
        this.fechaFactura = fechaFactura;
    }

    public String getRenglon() {
        return renglon;
    }

    public void setRenglon(String renglon) {
        this.renglon = renglon;
    }

    public String getProductoServicio() {
        return productoServicio;
    }

    public void setProductoServicio(String productoServicio) {
        this.productoServicio = productoServicio;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    public String getUnidadMedida() {
        return unidadMedida;
    }

    public void setUnidadMedida(String unidadMedida) {
        this.unidadMedida = unidadMedida;
    }

    public String getDescripcionUnidadMedida() {
        return descripcionUnidadMedida;
    }

    public void setDescripcionUnidadMedida(String descripcionUnidadMedida) {
        this.descripcionUnidadMedida = descripcionUnidadMedida;
    }

    public String getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(String precioUnitario) {
        this.precioUnitario = precioUnitario;
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
}
