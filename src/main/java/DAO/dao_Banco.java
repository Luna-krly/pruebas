/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Excepciones.DAOException;
import Objetos.Obj_Banco;
import Objetos.obj_Mensaje;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**

 *aaaaxcx

 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_Banco extends DataAccessObject{
 private static final long serialVersionUID = 1L;
   
    public dao_Banco() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("-------------Ingresa a Banco DAO------------");
    }
    
   //---------------------------------------------------------MENU BANCOS
    public obj_Mensaje ctg_banco(String opcion, Obj_Banco objBanco, String idRegistro) {
        System.out.println("--Menu-- Bancos");
        try {
            String sql = "call menu_bancos (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objBanco.getRfc());
            stmt.setString(3, objBanco.getNombre());
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
    

//--------------------------------------------MOSTRAR LISTA--------------------------------------------------------
    public List<Obj_Banco> Listar() throws SQLException, DAOException{
      System.out.println("--------------BancoDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	Obj_Banco banco= null;
        List<Obj_Banco> bancolista = new ArrayList<Obj_Banco>();
        
        String sql="SELECT * FROM vw_bancos";
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            while(rs.next()){   
            banco= new Obj_Banco();
            banco.setIdBanco(rs.getInt("id"));
            banco.setRfc(rs.getString("rfc"));
            banco.setNombre(rs.getString("nombre"));
            bancolista.add(banco);
            }
            return bancolista;
            
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
//-------------------------------------------------------   
}
