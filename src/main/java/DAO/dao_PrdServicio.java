/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_ProdServ;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_PrdServicio extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_PrdServicio() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a Productos y Servicios DAO------------");
    }

    
   //---------------------------------------------------------MENU PRODUCTOS Y SERVICIOSS
    public obj_Mensaje ctg_prod_serv(String opcion, obj_ProdServ objProdServ, String idRegistro) {
        System.out.println("--Menu-- Productos y Servicios");
        try {
            String sql = "call menu_prod_serv (?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objProdServ.getClaveProdServ());
            stmt.setString(3, objProdServ.getDescripcionProdServ());
            stmt.setString(4, objProdServ.getIdObjImpuesto());
            stmt.setString(5, objProdServ.getUsuario());
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
    public List<obj_ProdServ> Listar() throws SQLException, DAOException {
        System.out.println("--------------obj_ProdServDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_ProdServ prodserv = null;
        List<obj_ProdServ> pslista = new ArrayList<obj_ProdServ>();

        String sql = "SELECT * FROM vw_prod_serv";
        System.out.println("obj_ProdServDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("obj_ProdServDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                prodserv = new obj_ProdServ();
                prodserv.setIdProdServ(rs.getInt("id"));
                prodserv.setClaveProdServ(rs.getString("clave"));
                prodserv.setDescripcionProdServ(rs.getString("descripcion"));
                prodserv.setIdObjImpuesto(rs.getString("id_objeto_impuesto"));
                prodserv.setObjetoImpuesto(rs.getString("objeto_impuesto"));
                pslista.add(prodserv);
            }
            return pslista;

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
}
