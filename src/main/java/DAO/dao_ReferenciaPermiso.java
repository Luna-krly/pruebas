/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_referenciaPermiso;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Leilani
 */
public class dao_ReferenciaPermiso extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_ReferenciaPermiso() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("-------------Ingresa a referencia permiso DAO------------");
    }
    // Formato de decimales
    private static final DecimalFormat decimalFormat = new DecimalFormat("#.00");

    //---------------------------------------------------------MENU UNIDAD DE MEDIDA
    public obj_Mensaje guardar_referencias(String usuario, String rfcCliente,String JSON) {
        System.out.println("--Menu-- referencia permiso JSON");
        try {
            String sql = "call menu_referencias_permisos (?,?,?,?,?,?)";
            stmt = prepareCall(sql);
            
            stmt.setString(1, usuario);
            stmt.setString(2, JSON);
            stmt.setString(3, rfcCliente);

            stmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(6, java.sql.Types.VARCHAR);
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
    
    
    
    //---------------------------------------------------------MENU UNIDAD DE MEDIDA
    public obj_Mensaje ctg_ref_permiso(String opcion, obj_referenciaPermiso objReferencia, String idRegistro) {
        System.out.println("--Menu-- referencia permiso");
        try {
            String sql = "call menu_ref_cliente_permiso (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objReferencia.getRfcCliente());
            stmt.setString(3, objReferencia.getNombreCliente());
            stmt.setString(4, objReferencia.getPermiso());
            stmt.setString(5, objReferencia.getConsecutivo());
            stmt.setString(6, objReferencia.getConcepto());
            stmt.setString(7, objReferencia.getReferenciaQR());
            stmt.setString(8, objReferencia.getPatr());

            stmt.setString(9, objReferencia.getIniciaVigencia());
            stmt.setString(10, objReferencia.getTerminaVigencia());
            stmt.setString(11, objReferencia.getUsuarioResponsable());
            stmt.setString(12, objReferencia.getSeFactura());
            stmt.setDouble(13, objReferencia.getImporteConcepto());
            stmt.setDouble(14, objReferencia.getImporteIva());
            stmt.setDouble(15, objReferencia.getImporteRenta());
            stmt.setString(16, objReferencia.getUsuario());
            stmt.setString(17, idRegistro);

            stmt.registerOutParameter(18, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(19, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(20, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(18));
            msj.setDescripcion(stmt.getString(19));
            msj.setTipo(stmt.getBoolean(20));
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

    //--------------------------------------------MOSTRAR LISTA--------------------------------------------------------
    public List<obj_referenciaPermiso> Listar() throws SQLException, DAOException {
        System.out.println("--------------ReferenciaPermiso.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_referenciaPermiso referencia = null;
        List<obj_referenciaPermiso> referencialista = new ArrayList<obj_referenciaPermiso>();

        String sql = "SELECT * FROM vw_referencias_permisos";
        System.out.println("ReferenciaPermiso.Mostar todo() - SQL - " + sql);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("ReferenciaPermiso.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                referencia = new obj_referenciaPermiso();
                referencia.setIdReferencia(rs.getString("idReferencia"));
                referencia.setRfcCliente(rs.getString("rfc"));
                referencia.setNombreCliente(rs.getString("nombre"));
                referencia.setPermiso(rs.getString("permiso"));
                referencia.setConsecutivo(rs.getString("consecutivo"));
                referencia.setConcepto(rs.getString("concepto"));
                referencia.setReferenciaQR(rs.getString("referenciaqr"));
                referencia.setPatr(rs.getString("patr"));
                referencia.setIniciaVigencia(rs.getString("inicia"));
                referencia.setTerminaVigencia(rs.getString("termina"));
                referencia.setUsuarioResponsable(rs.getString("responsable"));
                referencia.setSeFactura(rs.getString("factura"));

                // Obtener el importe de la base de datos
                double impConcepto = rs.getDouble("imp_concepto");
                // Establecer el importe en el objeto
                referencia.setImporteConcepto(impConcepto);

                double impIva = rs.getDouble("iva");
                referencia.setImporteIva(impIva);

                double impRenta = rs.getDouble("renta");
                referencia.setImporteRenta(impRenta);

                referencia.setEstatus(rs.getString("estatus"));
                referencialista.add(referencia);
            }

            return referencialista;

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
    
    public List<obj_referenciaPermiso> obtenerPermisos(String responsibleUser, String year, String[] months) throws SQLException, DAOException {
        System.out.println("--------------ReferenciaPermiso obtenerPermisos()--------------");
        
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_referenciaPermiso referencia = null;
        List<obj_referenciaPermiso> referencialista = new ArrayList<obj_referenciaPermiso>();
        
        // Construir la consulta SQL con parámetros dinámicos para IN
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM clientes_refer WHERE sefactura = ? AND usr_responsable = ?");
//        for (int i = 0; i < months.length; i++) {
//            sqlBuilder.append("?");
//            if (i < months.length - 1) {
//                sqlBuilder.append(",");
//            }
//        }
//        sqlBuilder.append(")");

        String sql = sqlBuilder.toString();
        System.out.println("ReferenciaPermiso.obtenerPermisos() - SQL - " + sql);
        try {
            stmt = prepareCall(sql);
            stmt.setString(1, "S");
            stmt.setString(2, responsibleUser);
            rs = stmt.executeQuery();
            while (rs.next()) {
                System.out.println("Entreee y quiero ver el permiso: " + rs.getString("permiso"));
                referencia = new obj_referenciaPermiso();
                referencia.setIdReferencia(rs.getString("id_refer"));
                referencia.setRfcCliente(rs.getString("rfc"));
                referencia.setPermiso(rs.getString("permiso"));
                referencia.setUsuario(rs.getString("usr_responsable"));
                
                referencialista.add(referencia);
            }

            return referencialista;

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
    
}
