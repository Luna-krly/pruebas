/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_TComprobante;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_TComprobante extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_TComprobante() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a Tipo de Comprobante DAO------------");
    }

  //---------------------------------------------------------MENU TIPO COMPROBANTE
    public obj_Mensaje ctg_tipo_comprob(String opcion, obj_TComprobante objBanco, String idRegistro) {
        System.out.println("--Menu-- Tipo de Comprobante");
        try {
            String sql = "call menu_tipo_comprob (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objBanco.getClaveTipoComprobante());
            stmt.setString(3, objBanco.getDescripcionTipoComprobante());
            stmt.setString(4, objBanco.getUsuario());
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
    public List<obj_TComprobante> Listar() throws SQLException, DAOException {
        System.out.println("--------------TComprobanteDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_TComprobante tcompr = null;
        List<obj_TComprobante> tclista = new ArrayList<obj_TComprobante>();

        String sql = "SELECT * FROM vw_tipo_comprob";
        System.out.println("TComprobanteDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("TComprobanteDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                tcompr = new obj_TComprobante();
                tcompr.setIdTipoComprobante(rs.getInt("id"));
                tcompr.setClaveTipoComprobante(rs.getString("clave"));
                tcompr.setDescripcionTipoComprobante(rs.getString("descripcion"));
                //  tcompr.setSerie(rs.getString("serie"));
                tclista.add(tcompr);
            }
            return tclista;

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
