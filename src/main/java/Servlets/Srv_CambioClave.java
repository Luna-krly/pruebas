/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.dao_Usuario;
import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.Servlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
@WebServlet("/Srv_CambioClave")
public class Srv_CambioClave extends HttpServlet implements Servlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        dao_Usuario call = null;
        obj_Usuario user = null;
        obj_Mensaje mensaje = null;
        String opcion = request.getParameter("action");
        String usuario = request.getParameter("txtUsuario");
        String clave = request.getParameter("txtPassword");
        String semilla = "$2a$10$Rzv65YUHj4T2XpDIYHvsQO";
        String clave_cifrada = "";

        try {
            if (opcion == null) {
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("Cambio_Primera_Vez.jsp").forward(request, response);
                return;
            } else if (opcion.equals("reset_clave")) {
                call=new dao_Usuario();
                mensaje=new obj_Mensaje();
                clave_cifrada = BCrypt.hashpw(clave, semilla);
                mensaje=call.cambiar_clave_reset(usuario, clave_cifrada);               
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            } else {
                mensaje = new obj_Mensaje();
                mensaje.setMensaje("Ocurrio un error al validar");
                mensaje.setDescripcion("Favor de consultar con administrador");
                mensaje.setTipo(false);
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }
        } catch (Exception ex) {
            ex.printStackTrace();

            mensaje = new obj_Mensaje();
            mensaje.setMensaje("Ocurrio un error al validar");
            mensaje.setDescripcion(ex.getMessage());
            mensaje.setTipo(false);

            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("index.jsp").forward(request, response);
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
