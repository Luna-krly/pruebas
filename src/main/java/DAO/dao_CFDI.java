/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_CFDI;
import Objetos.obj_Mensaje;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_CFDI extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_CFDI() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a USO CFDI DAO------------");
    }

    ///*****Modificar al procedimiento los parámetros
    //---------------------------------------------------------MENU uso de cfdi
    public obj_Mensaje ctg_cfdi(String opcion, obj_CFDI objCFDI, String idRegistro) {
        System.out.println("--Menu-- Uso de CFDI");
        try {
            String sql = "call menu_uso_cfdi (?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objCFDI.getClaveUsoCFDI());
            stmt.setString(3, objCFDI.getDescripcionUsoCFDI());
            stmt.setString(4, objCFDI.getUsuario());
            stmt.setString(5, idRegistro);
            stmt.setString(6, objCFDI.getFisica());
            stmt.setString(7, objCFDI.getMoral());
            
            

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
    public List<obj_CFDI> Listar() throws SQLException, DAOException {
        System.out.println("--------------UsoCFDIDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_CFDI uc = null;
        List<obj_CFDI> uclista = new ArrayList<obj_CFDI>();

        String sql = "SELECT * FROM vw_uso_cfdi";
        System.out.println("UsoCFDIDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("UsoCFDIDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                uc = new obj_CFDI();
                uc.setIdUsoCFDI(rs.getInt("id"));
                uc.setClaveUsoCFDI(rs.getString("clave"));
                uc.setDescripcionUsoCFDI(rs.getString("descripcion"));
                uc.setFisica(rs.getString("fisica"));
                uc.setMoral(rs.getString("moral"));
                uclista.add(uc);
            }

            return uclista;

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
