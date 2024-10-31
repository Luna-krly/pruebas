/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Area;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_Area extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_Area() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a Area DAO------------");
    }

    //--------------------------------------------MOSTRAR LISTA--------------------------------------------------------
    public List<obj_Area> Listar() throws SQLException, DAOException {
        System.out.println("--------------AreaDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Area area = null;
        List<obj_Area> arealista = new ArrayList<obj_Area>();

        String sql = "SELECT * FROM cat_areas WHERE estatus=1 ORDER BY id_area ASC";

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                area = new obj_Area();
                area.setIdArea(rs.getInt("id_area"));
                area.setNombre_area(rs.getString("nombre"));
                area.setEstatus(rs.getString("estatus"));
                arealista.add(area);
            }
            return arealista;

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
//-------------------------------------------------------   
}
