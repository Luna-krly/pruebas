/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.Obj_Admin_usuario;
import Objetos.obj_Mensaje;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class dao_Administrar_usr extends DataAccessObject {
    

    private static final long serialVersionUID = 1L;

    public dao_Administrar_usr() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("Ingresa a dao_Administrar_urs");
    }
        public obj_Mensaje Administar_urs(String opcion, String usuario, String nombre, String ap_p, String ap_m, int id_area, String email, int id_perfil, String clave) {
        System.out.println("---entrando a dao con opcion" + opcion);
        try {
            String sql = "call menu_acc_usuarios(?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, usuario);
            stmt.setString(3, nombre);
            stmt.setString(4, ap_p);
            stmt.setString(5, ap_m);
            stmt.setInt(6, id_area);
            stmt.setString(7, email);
            stmt.setInt(8, id_perfil);
            stmt.setString(9, clave);

            stmt.registerOutParameter(10, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(11, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(12, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(10));
            msj.setDescripcion(stmt.getString(11));
            msj.setTipo(stmt.getBoolean(12));
            return msj;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje("Ocurrió un error al llamar procedimiento");
            msj.setDescripcion(ex.getMessage());
            msj.setTipo(false);
            return msj;
        }
    }

    public List<Obj_Admin_usuario> Listar() throws SQLException, DAOException {
        System.out.println("-----acceso_usuario.Mostrar lista()-----");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        Obj_Admin_usuario admUser = null;
        List<Obj_Admin_usuario> usuarioslista = new ArrayList<>();

        /*  String sql = "SELECT i.*, cc.usuario, cc.id_perfil, a.nombre , p.nombre  " +
             "FROM cat_inf_usuario i " +
             "JOIN cat_acc_usuario cc ON i.id_usuario = cc.id_usuario " +
             "JOIN cat_areas a ON i.id_area = a.id_area " +
             "JOIN cat_perfiles p ON cc.id_perfil = p.id_perfil " +
             "WHERE i.estatus = 'A'";*/
        //Vista de info_usuarios
        String sql = "SELECT * FROM facturacion.vw_informacion_usuarios;";

        try {
            //conexion
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("Administrar_usr - EJECUTA SENTENCIA");

            while (rs.next()) {

                admUser = new Obj_Admin_usuario();
                //admUser.setOpcion(rs.getString("opcion"));
                admUser.setUsuario(rs.getString("nombre_usuario"));
                admUser.setNombre(rs.getString("nombre"));
                admUser.setAp_p(rs.getString("apellido_paterno"));
                admUser.setAp_m(rs.getString("apellido_materno"));
                admUser.setId_area(rs.getString("id_area"));
                admUser.setNombre_area(rs.getString("area"));
                admUser.setEmail(rs.getString("correo"));
                admUser.setId_perfil(rs.getString("id_perfil"));
                //admUser.setClave(rs.getString("clave"));
                admUser.setNombre_perfil(rs.getString("perfil"));
                admUser.setEstatus(rs.getString("estatus")); //Añadir estatus del usuario
                usuarioslista.add(admUser);
            }

            return usuarioslista;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error al mandar la lista de usuarios");
            System.out.println("Excepcion: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());

            return null;
        }
    }

    public obj_Mensaje Administar_urs(String id_acc, String id_usu, String string, String usuario, String nombre, String ap_p, String ap_m, int id_area_int, int id_perfil_int, String clave) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
