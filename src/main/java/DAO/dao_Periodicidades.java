/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_Periodicidades;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_Periodicidades extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_Periodicidades() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a Periodicidades DAO------------");
    }

     //---------------------------------------------------------MENU PERIODICIDADES
    public obj_Mensaje ctg_periodicidades(String opcion, obj_Periodicidades objPeriodo, String idRegistro) {
        System.out.println("--Menu-- Periodicidades");
        try {
            String sql = "call menu_periodicidades (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objPeriodo.getClavePeriodo());
            stmt.setString(3, objPeriodo.getDescripcionPeriodo());
            stmt.setString(4, objPeriodo.getUsuario());
            stmt.setString(5, idRegistro);


            stmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(6));
            msj.setDescripcion(stmt.getString(7));
            msj.setTipo(stmt.getBoolean(8));
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
    public List<obj_Periodicidades> Listar() throws SQLException, DAOException {
        System.out.println("--------------PeriodicidadesDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Periodicidades periodo = null;
        List<obj_Periodicidades> periodolista = new ArrayList<obj_Periodicidades>();

        String sql = "SELECT * FROM vw_periodicidades";
        System.out.println("PeriodicidadesDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("PeriodicidadesDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                periodo = new obj_Periodicidades();
                periodo.setIdPeriodo(rs.getInt("id"));
                periodo.setClavePeriodo(rs.getString("clave"));
                periodo.setDescripcionPeriodo(rs.getString("periodo"));
                periodolista.add(periodo);
            }
            return periodolista;

        } catch(Exception ex){
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        }finally {
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("Cierra consulta");
        }
    }
//--------------------------------------------------------------------------------------------------
}
