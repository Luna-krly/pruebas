/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_RegFiscal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_RegFiscal extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_RegFiscal() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a Regimen Fiscal DAO------------");
    }

  ///*****Modificar al procedimiento los parámetros
  //---------------------------------------------------------MENU REGIMEN FISCAL
    public obj_Mensaje ctg_reg_fiscal(String opcion, obj_RegFiscal objRegimenFiscal, String idRegistro) {
        System.out.println("--Menu-- Regimen Fiscal");
        try {
            String sql = "call menu_reg_fiscal (?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objRegimenFiscal.getClaveRegimen());
            stmt.setString(3, objRegimenFiscal.getDescripcionRegimen());
            stmt.setString(4, objRegimenFiscal.getUsuario());
            stmt.setString(5, idRegistro);
            stmt.setString(6, objRegimenFiscal.getFisica());
            stmt.setString(7, objRegimenFiscal.getMoral());


            stmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(9, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(10, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(8));
            msj.setDescripcion(stmt.getString(9));
            msj.setTipo(stmt.getBoolean(10));
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
    public List<obj_RegFiscal> Listar() throws SQLException, DAOException {
        System.out.println("--------------RegFiscalDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_RegFiscal rf = null;
        List<obj_RegFiscal> rflista = new ArrayList<obj_RegFiscal>();

        String sql = "SELECT * FROM vw_reg_fiscal";
        System.out.println("RegFiscalDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("RegFiscalDAOO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                rf = new obj_RegFiscal();
                rf.setIdRegimen(rs.getInt("id"));
                rf.setClaveRegimen(rs.getString("clave"));
                rf.setDescripcionRegimen(rs.getString("descripcion"));
                rf.setFisica(rs.getString("fisica"));
                rf.setMoral(rs.getString("moral"));
                rflista.add(rf);
            }
            return rflista;

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
