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
public class obj_TServicio {
    private int idTServicio;
    private String clave;
    private String descripcion;
    private String usuario;

    public int getIdTServicio() {
        return idTServicio;
    }

    public void setIdTServicio(int idTServicio) {
        this.idTServicio = idTServicio;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    //Usuario
    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }


}