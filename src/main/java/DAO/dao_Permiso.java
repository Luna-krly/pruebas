/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_Permiso;
import Objetos.obj_referenciaPermiso;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_Permiso extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_Permiso() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a Permisos DAO------------");
    }

    //---------------------------------------------------------MENU PERMISOS
    public obj_Mensaje ctg_permisos(String opcion, obj_Permiso objPermiso, String idRegistro) {
        System.out.println("--Menu-- Permisos");
        try {
            String sql = "call menu_permisos (?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objPermiso.getNumeroPermiso());
            stmt.setInt(3, objPermiso.getIdCliente());
            stmt.setString(4, objPermiso.getConcepto());
            stmt.setString(5, objPermiso.getUsuario());

            stmt.setString(6, idRegistro);

            stmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(9, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(7));
            msj.setDescripcion(stmt.getString(8));
            msj.setTipo(stmt.getBoolean(9));
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

//Para imprimir se utiliza Mostrar en estatus A
//--------------------------------------------MOSTRAR LISTA--------------------------------------------------------
    public List<obj_Permiso> Listar() throws SQLException, DAOException {
        System.out.println("--------------PermisoDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Permiso permiso = null;
        List<obj_Permiso> perlista = new ArrayList<obj_Permiso>();

        String sql = "SELECT * FROM vw_permisos";
        System.out.println("PermisoDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                permiso = new obj_Permiso();
                permiso.setIdPermiso(rs.getInt("id"));
                permiso.setRfcCliente(rs.getString("cliente"));
                permiso.setRfc(rs.getString("rfc"));
                permiso.setNumeroPermiso(rs.getString("numero"));
                permiso.setConsecutivo(rs.getInt("consecutivo"));
                permiso.setConcepto(rs.getString("concepto"));
                perlista.add(permiso);
            }
            return perlista;

        } catch (Exception ex) {
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        } finally {
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("Cierra consulta");
        }
    }

    

//--------------------------------------------------------------------------------------------------    
}
