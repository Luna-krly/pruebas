/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Pagos;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_Pagos extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_Pagos() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("Ingresa a PagosDAO");
    }

    //--------------------------------------------GUARDAR-----------------------------------------------------
    public obj_Pagos create(obj_Pagos savePagos) throws SQLException, DAOException {
        System.out.println("--------------Pagos DAO. Create()--------------");
        PreparedStatement stmt = null;

        String sql = "INSERT INTO Pagos (idCliente,folPago,fchPago,banco,rfcBanco,ctacliente,notastc,idFPago,idmoneda,tcambio,noOperacion,total,\n"
                + "subtotal,ivaT,ivaR,idCFDI, idFactura,ffiscal,idMPago,nparcial,santerior,ipagado,sinsoluto,idIMPFactura ,base,ivaIT,ivaIR,pago,TotalISA,\n"
                + "TotalIT,TotalIR,TotalP,cveusr_alta,fch_alta,estatus ,idPago)\n"
                + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        System.out.println("Pagos DAO. create() - SQL - " + sql);

        try {

            stmt = prepareStatement(sql);

            stmt.setInt(1, savePagos.getIdCliente());
            stmt.setInt(2, savePagos.getFPago());
            stmt.setDate(3, (java.sql.Date) savePagos.getFchPago());
            stmt.setString(4, savePagos.getBanco());
            stmt.setString(5, savePagos.getRFCBanco());
            stmt.setString(6, savePagos.getCtaCliente());
            stmt.setString(7, savePagos.getNtaSTC());
            stmt.setInt(8, savePagos.getIdFPago());
            stmt.setInt(9, savePagos.getIdMoneda());
            stmt.setString(10, savePagos.getTCambio());
            stmt.setInt(11, savePagos.getNOperacion());
            stmt.setFloat(12, savePagos.getTotal());
            stmt.setFloat(13, savePagos.getSubtotal());
            stmt.setFloat(14, savePagos.getIVARt());
            stmt.setInt(15, savePagos.getIdUsoCFDI());
            stmt.setInt(16, savePagos.getIdFactura());
            stmt.setInt(17, savePagos.getFFiscal());
            stmt.setInt(18, savePagos.getIdMPago());
            stmt.setInt(19, savePagos.getNParcial());
            stmt.setFloat(20, savePagos.getSAnterior());
            stmt.setFloat(21, savePagos.getIPagado());
            stmt.setFloat(22, savePagos.getSInsoluto());
            stmt.setInt(23, savePagos.getImpFactura());
            stmt.setFloat(24, savePagos.getBase());
            stmt.setFloat(25, savePagos.getIvaIT());
            stmt.setFloat(26, savePagos.getIvaIR());
            // stmt.setFloat ( 27,savePagos.getIva

        //    stmt.setDate(1, (java.sql.Date) savePagos.getFchAlta());
         //   stmt.setString(1, savePagos.getCveusrAlta());
            stmt.setString(1, "A");

            stmt.executeUpdate();
            return savePagos;

        } finally {
            closeStatement(stmt);
        }
    }

}
