/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Objetos.obj_Mensaje;
import java.sql.SQLException;

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
         public obj_Mensaje Administar_urs(int id_acc, int id_usu,String opcion,String usuario, String nombre, String ap_p, String ap_m,int id_area, int id_perfil, String clave) {
        System.out.println("---entrando a dao con opcion" +opcion);
        try {
            String sql = "call menu_acc_usuarios(?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);
            
            stmt.setInt(1, id_acc);
            stmt.setInt(2, id_usu);
            stmt.setString(3, opcion);
            stmt.setString(4, usuario );
            stmt.setString(5, nombre);
            stmt.setString(6, ap_p );
            stmt.setString(7, ap_m);
            stmt.setInt(8, id_area);
            stmt.setInt(9, id_perfil);
            stmt.setString(10, clave);
            

            stmt.registerOutParameter(11, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(12, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(13, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(11));
            msj.setDescripcion(stmt.getString(12));
            msj.setTipo(stmt.getBoolean(13));
            return msj;
        
        }catch (Exception ex){
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
}
