/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_Usuario extends DataAccessObject{
    private static final long serialVersionUID = 1L;
    
    public dao_Usuario() throws ClassNotFoundException, SQLException{
        super();
    }
    
    //---------------------------------------------------------AUTENTICACION
    public obj_Mensaje autenticacion( String usuario, String clave) {
        System.out.println("--Menu-- Autenticacion Usuario");
        try {
            String sql = "call menu_login (?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, usuario);
            stmt.setString(2, clave);
            stmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            stmt.execute();

            System.out.println("ID USUARIO: "+ stmt.getString(4));
            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(3));
            msj.setDescripcion(stmt.getString(4));
            msj.setTipo(stmt.getBoolean(5));
            return msj;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje("Error al ejecutrar procedimiento");
            msj.setDescripcion(ex.getMessage());
            msj.setTipo(false);
            return msj;
        }
    }
    
    
        //---------------------------------------------------------OBJETO USUARIO
    public obj_Usuario traer_usuario(String id) {
        System.out.println("--Menu-- Objeto Usuario");
        try {
            String sql = "call menu_obj_usuario (?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, id);

            stmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(9, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(10, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(11, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(12, java.sql.Types.INTEGER);


            stmt.execute();

            obj_Usuario usuario = new obj_Usuario();
            usuario.setId(stmt.getString(2));
            usuario.setNombre(stmt.getString(3));
            usuario.setApellido_paterno(stmt.getString(4));
            usuario.setApellido_materno(stmt.getString(5));
            usuario.setEstatus(stmt.getString(6));
            usuario.setArea(stmt.getString(7));
            usuario.setId_perfil(stmt.getString(8));
            usuario.setPerfil(stmt.getString(9));
            usuario.setUsuario(stmt.getString(10));
            usuario.setFecha_ultimo_cambio(stmt.getString(11));
            usuario.setDias_cambio(stmt.getInt(12));
            return usuario;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        }
    }
    
    //---------------------------------------------------------VERIFICAR EL USUARIO CLV
    public obj_Mensaje verificar_usuario( String usuario, int area) {
        System.out.println("--Menu-- Verificación de Usuario");
        try {
            String sql = "call verificar_usuario (?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, usuario);
            stmt.setInt(2, area);
            stmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            stmt.execute();
            
            System.out.println("ID MENSAJE: "+ stmt.getString(3) );
            System.out.println("ID USUARIO: "+ stmt.getString(4));
            
            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(3));
            msj.setDescripcion(stmt.getString(4));
            msj.setTipo(stmt.getBoolean(5));
            return msj;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje("6");
            msj.setDescripcion(ex.getMessage());
            msj.setTipo(false);
            return msj;
        }
    }
    
    
        //---------------------------------------------------------CAMBIAR CLAVE
    public obj_Mensaje cambiar_clave (int id_usuario, String nueva_clave) {
        System.out.println("--Menu-- Cambiar clave");
        try {
            String sql = "call cambiar_contrasena (?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setInt(1, id_usuario);
            stmt.setString(2, nueva_clave);
            stmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(3));
            msj.setDescripcion(stmt.getString(4));
            msj.setTipo(stmt.getBoolean(5));
            return msj;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje("Ocurrio un error");
            msj.setDescripcion(ex.getMessage());
            msj.setTipo(false);
            return msj;
        }
    }
    
    
    
            //---------------------------------------------------------ACTUALIZAR CLAVE
    public obj_Mensaje actualizar_clave (int id_usuario, String actual_clave, String nueva_clave) {
        System.out.println("--Menu-- Actualizar clave");
        try {
            String sql = "call cambio_contrasena_dentro (?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setInt(1, id_usuario);
            stmt.setString(2, actual_clave);
            stmt.setString(3, nueva_clave);
            stmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(4));
            msj.setDescripcion(stmt.getString(5));
            msj.setTipo(stmt.getBoolean(6));
            return msj;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje("Ocurrio un error");
            msj.setDescripcion(ex.getMessage());
            msj.setTipo(false);
            return msj;
        }
    }
    
    public List<obj_Usuario> Listar() throws SQLException, DAOException{
        System.out.println("------------ Usuario Mostrar lista() -------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Usuario usuario = null;
        List<obj_Usuario> usuariosLista = new ArrayList<obj_Usuario>();
        
        String qs = "SELECT id, nombre, apellido_paterno, id_area, area FROM vw_informacion_usuarios";
        try {
            stmt = prepareStatement(qs);
            rs=stmt.executeQuery();
             System.out.println("Usuario.Mostar - EJECUTA SENTENCIA");
            while(rs.next()){   
            usuario= new obj_Usuario();
            usuario.setId(rs.getString("id"));
            usuario.setNombre(rs.getNString("nombre"));
            usuario.setApellido_paterno(rs.getString("apellido_paterno")); 
            usuario.setArea(rs.getString("area"));
            usuariosLista.add(usuario);
            }
            
            return usuariosLista;
        } catch (Exception e) {
             System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + e);
            System.out.println("Mensaje: " + e.getMessage());
            return null;
        }finally {
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("Cierra consulta");
        }
    
    }
    
    
         //---------------------------------------------------------VERIFICAR SI ES AUTORIZADO DE CAMBIAR CLAVE
    public obj_Mensaje verificar_reset(String usuario) {
        System.out.println("--Menu-- Actualizar clave");
        try {
            String sql = "call validacion_usr_reset (?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, usuario);
            stmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(4, java.sql.Types.BOOLEAN);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(2));
            msj.setDescripcion(stmt.getString(3));
            msj.setTipo(stmt.getBoolean(4));
            return msj;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje("Ocurrio un error");
            msj.setDescripcion(ex.getMessage());
            msj.setTipo(false);
            return msj;
        }
    }
    
         //---------------------------------------------------------CAMBIAR CONTRASEÑA RESET
    public obj_Mensaje cambiar_clave_reset(String usuario, String clave ) {
        System.out.println("--Menu-- Actualizar clave");
        try {
            String sql = "call cambiar_contrasena_reset (?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, usuario);
            stmt.setString(2, clave);
            stmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(5, java.sql.Types.BOOLEAN);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(3));
            msj.setDescripcion(stmt.getString(4));
            msj.setTipo(stmt.getBoolean(5));
            return msj;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje("Ocurrio un error");
            msj.setDescripcion(ex.getMessage());
            msj.setTipo(false);
            return msj;
        }
    }
    
    
    
    
    
    
    //-----------------------
    

}
