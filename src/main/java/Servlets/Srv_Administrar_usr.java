/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.dao_Administrar_usr;
import DAO.dao_Area;
import DAO.dao_Perfil;
import Objetos.Obj_Admin_usuario;
import Objetos.obj_Area;
import Objetos.obj_Mensaje;
import Objetos.obj_Perfil;
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

          try {
            //conexion al dao de area
            dao_Area areaDao = new dao_Area();
            List<obj_Area> listaAreas = areaDao.Listar();
            System.out.println("Lista de areas:" + listaAreas);
            request.setAttribute("listaAreas", listaAreas);

            // conexion al dao de perfil 
            dao_Perfil perfilDao = new dao_Perfil();
            List<obj_Perfil> listaPerfil = perfilDao.listarperfil();
            System.out.println("Lista de perfiles:" + listaPerfil);
            request.setAttribute("listaPerfil", listaPerfil);

            String opcion = request.getParameter("action");
            System.out.println("opcion resivida: " + opcion);
            String usuario = request.getParameter("usuario");
            System.out.println("usuario" + usuario);
            String nombre = request.getParameter("nombre");
            System.out.println("nombre" + nombre);
            String ap_p = request.getParameter("apaterno");
            System.out.println("apellido paterno" + ap_p);
            String ap_m = request.getParameter("amaterno");
            System.out.println("apellido materno" + ap_m);
            String email = request.getParameter("correo");
            System.out.println("correo" + email);
            String id_area = request.getParameter("id_area");
            System.out.println("id_area" + id_area);
            String id_perfil = request.getParameter("id_perfil");
            System.out.println("id_perfil" + id_perfil);
            String clave = request.getParameter("clave");

            //extraer el usuario del login:
            //String usr_alta = (String) session.getAttribute("usuarioLogueado");
            dao_Administrar_usr daoLista = new dao_Administrar_usr();
            List<Obj_Admin_usuario> admuser = null;  //mandamos a llamar la clase objeto

            // si no hay opcion entonces se enlistaran los usuarios
            if (opcion == null || opcion.equals(" ")) {
                admuser = daoLista.Listar();
                session.setAttribute("mensaje", null);
                request.setAttribute("lista", admuser);
                System.out.println("Entra a opcion == null");
                request.getRequestDispatcher("Admin/AdminUsuarios.jsp").forward(request, response);
                return;
            }
            //crearemos el objeto de Obj_Admin_usuario con los valores del formulario
            Obj_Admin_usuario usuarios = new Obj_Admin_usuario();
            dao_Administrar_usr procedimiento = new dao_Administrar_usr();
            obj_Mensaje respuesta = null;

            int id_area_int = 0;
            int id_perfil_int = 0;

            if (id_area != null) {
                id_area_int = Integer.parseInt(id_area);
            }
            if (id_perfil != null) {
                id_perfil_int = Integer.parseInt(id_perfil);
            }

            //dependiendo de la opcion seleccionada, realizara la accion correspondiente
            switch (opcion) {
                case "101":
                    respuesta = procedimiento.Administar_urs("101", usuario, nombre, ap_p, ap_m, id_area_int, email, id_perfil_int, clave);
                    break;
                case "102":
                    respuesta = procedimiento.Administar_urs("102", usuario, nombre, ap_p, ap_m, id_area_int, email, id_perfil_int, null);
                    break;
                case "103":
                    respuesta = procedimiento.Administar_urs("103", usuario, nombre, ap_p, ap_m, 0, email, 0, clave);
                    break;
                case "104":
                 respuesta = procedimiento.Administar_urs("104", usuario, nombre, ap_p, ap_m, 0, email, 0, clave);
                    break;

                default:
                    System.out.println("Opcion no valida");
                    respuesta = new obj_Mensaje();
                    respuesta.setMensaje("Error");
                    respuesta.setDescripcion("Opción no válida");
                    respuesta.setTipo(false);
                    session.setAttribute("mensaje", null);
                    break;
            }

            //actulizamos la lista despues de realizar la accion
            admuser = daoLista.Listar();
            request.setAttribute("lista", admuser);

            // Dependiendo de si necesitas el mensaje en la sesión o solo en el request
            if (respuesta != null && respuesta.getTipo() != null) {
                //asegurar que titulo y descripcion no manden un null
                if (respuesta.getMensaje() == null) {
                    respuesta.setMensaje(""); //asignamos un valor vacio si es null
                }
                if (respuesta.getDescripcion() == null) {
                    respuesta.setDescripcion(""); //aseginacion de valor vacio en caso de ser null
                }
                if (respuesta.getTipo()) {
                    session.setAttribute("mensaje", respuesta); // Usar session para persistir el mensaje
                    request.getRequestDispatcher("Admin/AdminUsuarios.jsp").forward(request, response);
                } else {
                    System.out.println("No se puede procesar la solicitud");
                    System.out.println("Descripcion: " + respuesta.getDescripcion());
                    session.setAttribute("mensaje", respuesta); // Configura en session si quieres que persista tras la redirección
                    request.getRequestDispatcher("Admin/AdminUsuarios.jsp").forward(request, response);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            obj_Mensaje respuesta = new obj_Mensaje();
            respuesta.setMensaje("Error: no se pudo entrar" + ex);
            respuesta.setDescripcion(ex.getLocalizedMessage());
            respuesta.setTipo(false);
            session.setAttribute("mensaje", respuesta);
            request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);//Dirige a pagina de errores generales
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
