/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_TFactor;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_TFactor extends DataAccessObject{

    private static final long serialVersionUID = 1L;

    public dao_TFactor() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a Tipo de factor DAO------------");
    }

    
    ////*****Verificar funcionalidad de catálogo solo es un registro
//---------------------------------------------------------MENU TIPO FACTOR
    public obj_Mensaje ctg_tipo_factor(String opcion, obj_TFactor objTipoFactor, String idRegistro) {
        System.out.println("--Menu-- Tipo de Factor");
        try {
            String sql = "call menu_tipo_factor (?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objTipoFactor.getClaveTipoFactor());
            stmt.setString(3, objTipoFactor.getUsuario());
            stmt.setString(4, idRegistro);


            stmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(5));
            msj.setDescripcion(stmt.getString(6));
            msj.setTipo(stmt.getBoolean(7));
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
    public List<obj_TFactor> Listar() throws SQLException, DAOException {
        System.out.println("--------------TFactorDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_TFactor tf = null;
        List<obj_TFactor> tflista = new ArrayList<obj_TFactor>();

        String sql = "SELECT * FROM vw_tipo_factor";
        System.out.println("TFactorDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("TFactorDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                tf = new obj_TFactor();
                tf.setIdTipoFactor(rs.getInt("id"));
                tf.setClaveTipoFactor(rs.getString("clave"));
                tflista.add(tf);
            }
            
            return tflista;

        }catch(Exception ex){
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
}
