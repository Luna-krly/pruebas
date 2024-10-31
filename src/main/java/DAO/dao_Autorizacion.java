/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Autorizacion;
import Objetos.obj_Mensaje;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author USER
 */
public class dao_Autorizacion extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_Autorizacion() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a Autorizaciones DAO------------");
    }

    //--------------------------------------------MOSTRAR LISTA--------------------------------------------------------
    public List<obj_Autorizacion> Listar() throws SQLException, DAOException {
        System.out.println("AutorizarDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Autorizacion autorizar = null;
        List<obj_Autorizacion> autorizarlista = new ArrayList<obj_Autorizacion>();

        String sql = "SELECT * FROM vw_autorizaciones";
        System.out.println("AutorizarDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("AutorizarDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                autorizar = new obj_Autorizacion();
                autorizar.setId(rs.getString("id"));
                autorizar.setSerie(rs.getString("serie"));
                autorizar.setFolio(rs.getString("folio"));
                autorizar.setFecha(rs.getString("fecha_factura"));
                autorizar.setEstatus(rs.getString("estatus"));
                // autorizar.setImporte(rs.getString("importe"));

                DecimalFormat df = new DecimalFormat("#,##0.00");
                String importeStr = rs.getString("importe");
                BigDecimal importe = new BigDecimal(importeStr); // Convierte el String a BigDecimal

                // Formatea el importe
                String importeFormateado = df.format(importe);

                // Establece el importe formateado en el objeto autorizar
                autorizar.setImporte(importeFormateado);

                autorizar.setUsuarioGenero(rs.getString("usuario_genero"));
                autorizarlista.add(autorizar);
            }
            return autorizarlista;

        } catch (Exception ex) {
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        } finally {
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("AutorizarDAO.Mostar -Cierra consulta");
        }
    }
//---------------------------------------------------------     
    //--------------------------------------------------------AUTORIZAR FACTURA
    public obj_Mensaje autorizacion(String folio, String serie, String usuario) {
        System.out.println("--Menu-- AUTORIZAR factura");
        try {
            String sql = "call menu_facturas_autorizacion (?,?,?,?,?,?)";
            stmt = prepareCall(sql);
            
            stmt.setString(1, folio);
            stmt.setString(2, serie);
            stmt.setString(3, usuario);

            stmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(6, java.sql.Types.BOOLEAN);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(4));
            msj.setDescripcion(stmt.getString(5));
            msj.setTipo(stmt.getBoolean(6));
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
    

}
