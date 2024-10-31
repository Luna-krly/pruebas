/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Objetos;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class obj_Usuario {

    private static final long serialVersionUID = 1L;

    private String id;
    private String nombre;
    private String usuario;
    private String apellido_paterno;
    private String apellido_materno;
    private String clave;//PASSWORD
    private String id_perfil;
    private String perfil;
    private String area;
    private String fecha_ultimo_cambio;
    private String estatus;
    private int dias_cambio;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getApellido_paterno() {
        return apellido_paterno;
    }

    public void setApellido_paterno(String apellido_paterno) {
        this.apellido_paterno = apellido_paterno;
    }

    public String getApellido_materno() {
        return apellido_materno;
    }

    public void setApellido_materno(String apellido_materno) {
        this.apellido_materno = apellido_materno;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getId_perfil() {
        return id_perfil;
    }

    public void setId_perfil(String id_perfil) {
        this.id_perfil = id_perfil;
    }

    public String getPerfil() {
        return perfil;
    }

    public void setPerfil(String perfil) {
        this.perfil = perfil;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getFecha_ultimo_cambio() {
        return fecha_ultimo_cambio;
    }

    public void setFecha_ultimo_cambio(String fecha_ultimo_cambio) {
        this.fecha_ultimo_cambio = fecha_ultimo_cambio;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public int getDias_cambio() {
        return dias_cambio;
    }

    public void setDias_cambio(int dias_cambio) {
        this.dias_cambio = dias_cambio;
    }




}
