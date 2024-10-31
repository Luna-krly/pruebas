/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_Paises;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_Pais extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_Pais() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a Paises DAO------------");
    }

   //---------------------------------------------------------MENU paises
    public obj_Mensaje ctg_pais(String opcion, obj_Paises objPais, String idRegistro) {
        System.out.println("--Menu-- Paises");
        try {
            String sql = "call menu_pais (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objPais.getClavePais());
            stmt.setString(3, objPais.getDescripcionPais());
            stmt.setString(4, objPais.getUsuario());
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
    public List<obj_Paises> Listar() throws SQLException, DAOException {
        System.out.println("--------------PaisDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Paises pais = null;
        List<obj_Paises> paislista = new ArrayList<obj_Paises>();

        String sql = "SELECT * FROM vw_pais";
        System.out.println("PaisDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("PaisDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                pais = new obj_Paises();
                pais.setIdPais(rs.getInt("id"));
                pais.setClavePais(rs.getString("clave"));
                pais.setDescripcionPais(rs.getString("descripcion"));
                paislista.add(pais);
            }
            
            return paislista;

        }catch(Exception ex){
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        } finally {
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("PaisDAO.Mostar -Cierra consulta");
        }
    }
//--------------------------------------------------------------------------------------------------
}
