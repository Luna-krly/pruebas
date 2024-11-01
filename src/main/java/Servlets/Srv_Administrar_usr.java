/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.dao_Administrar_usr;
import DAO.dao_Area;
import Objetos.Obj_Admin_usuario;
import Objetos.obj_Area;
import Objetos.obj_Mensaje;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author HP
 */
@WebServlet(name = "Srv_Administrar_usr", urlPatterns = {"/Srv_Administrar_usr"})
public class Srv_Administrar_usr extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        System.out.println("------Entrando al Srv Administrar_usr------------");
    
      HttpSession session = request.getSession();
      
        try{
        //conexion al dao de area
        dao_Area areaDao = new dao_Area();
        List<obj_Area> listaAreas = areaDao.Listar();
            System.out.println("Lista de areas:" + listaAreas);
        request.setAttribute("listaAreas", listaAreas);
         
        // conexion al dao de perfil 
        /* perfilDao perfilDao = new perfilDao();
         List<perfil> listaPerfil = perfilDao.listarperfil(); 
            System.out.println("Lista de perfiles:" + listaPerfil);
        request.setAttribute("listaPerfil", listaPerfil);*/


        String id_acc = request.getParameter("id_acceso");
        String id_usu = request.getParameter("id_usuario");
        String opcion = request.getParameter("opcion");
        String usuario = request.getParameter("usuario");
        String nombre = request.getParameter("nombre");
        String ap_p = request.getParameter("apaterno");
        String ap_m = request.getParameter("amaterno");
        String id_area = request.getParameter("id_area");
        String id_perfil = request.getParameter("id_perfil");
        String clave = request.getParameter("clave");

        
        //extraer el usuario del login:
        String usr_alta = (String) session.getAttribute("usuarioLogueado");


        String area;
            if ("1".equals(id_area)) {
                area= "Administración";
                System.out.println("Administración");
            } else if ("2".equals(id_area)) {
                area= "Sistemas";
                System.out.println("Sistemas");
            } else {
                area = "No válido";
                System.out.println("Tipo de persona no válido");
                // Manejar el error si es necesario
            }

        dao_Administrar_usr daoLista = new dao_Administrar_usr();
        List<Obj_Admin_usuario> admuser = null;  //mandamos a llamar la clase objeto

        // si no hay opcion entonces se enlistaran los usuarios
        if(opcion == null || opcion.equals(" ")){
            admuser = daoLista.Listar();
            session.setAttribute("mensaje", null);
            request.setAttribute("lista", admuser);
             System.out.println("Entra a opcion == null");
            request.getRequestDispatcher("AdminUsuarios.jsp").forward(request, response);
            return;
        }
        //crearemos el objeto de Obj_Admin_usuario con los valores del formulario
        Obj_Admin_usuario usuarios = new Obj_Admin_usuario();
        dao_Administrar_usr  procedimiento = new  dao_Administrar_usr ();
        obj_Mensaje respuesta = null;
        
        int id_area_int = 0;
        int id_perfil_int = 0;
        
        if(id_area!= null){
            id_area_int = Integer.parseInt(id_area);
        }
        if(id_perfil!= null){
            id_perfil_int = Integer.parseInt(id_perfil);
        }
       
        //dependiendo de la opcion seleccionada, realizara la accion correspondiente
        switch(opcion){
            case "guardar":
                
                //respuesta = procedimiento.accUsuario("guardar", expediente, nombre, ap_paterno, ap_materno, id_area_int , usr_alta, id_perfil_int, usuario, clave_acc);
                respuesta = procedimiento.Administar_urs(id_area_int, id_area_int, opcion, usuario, nombre, ap_p, ap_m, id_area_int, id_perfil_int, clave);
                break;
            case "modificar":
                //respuesta = procedimiento.accUsuario("modificar", expediente, nombre, ap_paterno, ap_materno,id_area_int, usr_alta,id_perfil_int, usuario, null);
                respuesta = procedimiento.Administar_urs(id_area_int, id_area_int, opcion, usuario, nombre, ap_p, ap_m, id_area_int, id_perfil_int, null);
                break;
            case "baja":
                System.out.println("entra a baja-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+");
                //respuesta = procedimiento.accUsuario("baja", expediente, nombre, ap_paterno, ap_materno, 0, usr_alta, 0, expediente, clave_acc);
                respuesta = procedimiento.Administar_urs(id_area_int, id_area_int, opcion, usuario, nombre, ap_p, ap_m, id_area_int, id_perfil_int, clave);
                System.out.println("titulo" + respuesta.getMensaje());
                System.out.println("descripcion"+ respuesta.getDescripcion());
                break;
            case "limpiar":
               //esta accion solo redirigira para limpiar el formulario
              session.setAttribute("mensaje", null);
              request.getRequestDispatcher("AdminUsuarios.jsp").forward(request, response);
              return;
              
              default:
              System.out.println("Opcion no valida");
              break;
        }
        
        //actulizamos la lista despues de realizar la accion
        admuser = daoLista.Listar();
        request.setAttribute("lista", admuser);
        
        if(respuesta.getTipo()){
            session.setAttribute("mensaje", respuesta);
            request.getRequestDispatcher("acceso_usuarios.jsp").forward(request, response);            
        }else{
            System.out.println("No se puede procesar la solicitud");
            System.out.println("Descripcion" + respuesta.getDescripcion());
             request.setAttribute("mensaje", respuesta);
             request.getRequestDispatcher("inicio.jsp").forward(request, response);
        }

        }catch(Exception ex){
          obj_Mensaje  respuesta = new obj_Mensaje ();
          respuesta.setMensaje("Error: no se pudo entrar" + ex);
          respuesta.setDescripcion(ex.getLocalizedMessage());
          respuesta.setTipo(false);
          request.setAttribute("mensaje", respuesta);
          request.getRequestDispatcher("inicio.jsp").forward(request, response);  
        }

      
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
