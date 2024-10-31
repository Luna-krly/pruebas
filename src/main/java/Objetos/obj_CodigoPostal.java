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
public class obj_CodigoPostal {

    private static final long serialVersionUID = 1L;

    private String idCodigo;
    private String codigo;
    private String colonia;
    private String ciudad;
    private String delegacion;
    private String estado;
    private String estadoSAT;
    private String usuario;


    //IDCodigo
    public String getIdCodigo() {
        return idCodigo;
    }

    public void setIdCodigo(String idCodigo) {
        this.idCodigo = idCodigo;
    }

    //Codigo
    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    //Colonia
    public String getColonia() {
        return colonia;
    }

    public void setColonia(String colonia) {
        this.colonia = colonia;
    }

    //Colonia
    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    //Delegacion
    public String getDelegacion() {
        return delegacion;
    }

    public void setDelegacion(String delegacion) {
        this.delegacion = delegacion;
    }

    //Estado
    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    //Estado SAT
    public String getEstadoSAT() {
        return estadoSAT;
    }

    public void setEstadoSAT(String estadoSAT) {
        this.estadoSAT = estadoSAT;
    }

    //usuario
    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

}
