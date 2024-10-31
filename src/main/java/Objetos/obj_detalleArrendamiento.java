/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Objetos;

/**
 *
 * @author Leilani
 */
public class obj_detalleArrendamiento {
    private static final long serialversionIUD=1L;
    
    private int idDetalle;
    private String idMemorandum;
    private int idEncabezado;
    private String noMemorandum;
    private String consecutivo;
    private String concepto_desglose;
    private double importe;
    private String importeIndividual;

    
    
    
    public int getIdEncabezado() {
        return idEncabezado;
    }

    public void setIdEncabezado(int idEncabezado) {
        this.idEncabezado = idEncabezado;
    }

    public int getIdDetalle() {
        return idDetalle;
    }

    public void setIdDetalle(int idDetalle) {
        this.idDetalle = idDetalle;
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

    public String getConsecutivo() {
        return consecutivo;
    }

    public void setConsecutivo(String consecutivo) {
        this.consecutivo = consecutivo;
    }

    public String getConcepto_desglose() {
        return concepto_desglose;
    }
    
    public void setConcepto_desglose(String concepto_desglose) {
        this.concepto_desglose = concepto_desglose;
    }

    public double getImporte() {
        return importe;
    }

    public void setImporte(double importe) {
        this.importe = importe;
    }

    public String getImporteIndividual() {
        return importeIndividual;
    }

    public void setImporteIndividual(String importeIndividual) {
        this.importeIndividual = importeIndividual;
    }
    
    
    
}
