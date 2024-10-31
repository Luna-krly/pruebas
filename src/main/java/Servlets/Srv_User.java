/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.dao_Usuario;
import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
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
@WebServlet("/Srv_User")
public class Srv_User extends HttpServlet implements Servlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        dao_Usuario call = null;
        obj_Usuario usuario = null;
        int id = 0;
        String semilla = "$2a$10$Rzv65YUHj4T2XpDIYHvsQO";
        String nombre_usuario = request.getParameter("txtUsuario");
        String usuario_identificado = request.getParameter("txtUsuarioCambio");
        String clave_usuario = request.getParameter("txtPassword");
        String clave_anterior = request.getParameter("txtAnterior");
        String area_usuario = request.getParameter("txtArea");
        String boton = request.getParameter("boton");

        String clave_cifrada = "";
        String clave_cifrada_anterior = "";
        obj_Mensaje mensaje = new obj_Mensaje();
        try {
            if (!clave_usuario.equals("")) {
                clave_cifrada = BCrypt.hashpw(clave_usuario, semilla);
                if (clave_cifrada.equals("$2a$10$Rzv65YUHj4T2XpDIYHvsQOYJmg5MCNMJf1HL/13xc.iYoAGOX2KkO")) {
                    //request.setAttribute("usuario", usuario);
                    mensaje = new obj_Mensaje();
                    call = new dao_Usuario();
                    mensaje = call.verificar_reset(nombre_usuario);
                    if (mensaje.getTipo()) {
                        response.sendRedirect("Srv_CambioClave?txtUsuario=" + nombre_usuario);
                        return;
                    } else {
                        request.setAttribute("mensaje", mensaje);
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                }
            }

            switch (boton) {
                case "inicio_sesion":
                    clave_cifrada = BCrypt.hashpw(clave_usuario, semilla);
                    call = new dao_Usuario();
                    System.out.println("Clave cifrada: " + clave_cifrada);
                    mensaje = call.autenticacion(nombre_usuario, clave_cifrada);
                    if (mensaje.getMensaje().equals("1")) {
                        usuario = call.traer_usuario(mensaje.getDescripcion());
                        if (usuario != null) {
                            request.getSession().setAttribute("usuario", usuario);
                            request.getRequestDispatcher("Principal.jsp").forward(request, response);
                        } else {
                            mensaje.setMensaje("FAVOR DE VERIFICAR CON EL ADMINISTRADOR");
                            mensaje.setDescripcion("USUARIO NULO");
                            mensaje.setTipo(false);
                            request.setAttribute("mensaje", mensaje);
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        }
                    } else if (mensaje.getMensaje().equals("2")) {
                        usuario = call.traer_usuario(mensaje.getDescripcion());
                        if (usuario != null) {
                            request.setAttribute("info_usuario", usuario.getId());
                            request.getRequestDispatcher("Cambio_Clave.jsp").forward(request, response);
                        } else {
                            mensaje.setMensaje("FAVOR DE VERIFICAR CON EL ADMINISTRADOR");
                            mensaje.setDescripcion("USUARIO NULO");
                            mensaje.setTipo(false);
                            request.setAttribute("mensaje", mensaje);
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("mensaje", mensaje);
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                    break;

                case "verifica_datos":
                    int area = Integer.parseInt(area_usuario);
                    mensaje = call.verificar_usuario(nombre_usuario, area);
                    if (mensaje.getMensaje().equals("S")) {
                        String id_usuario = mensaje.getDescripcion();
                        request.setAttribute("info_usuario", id_usuario);
                        request.getRequestDispatcher("Cambio_Clave.jsp").forward(request, response);
                    } else {
                        request.setAttribute("mensaje", mensaje);
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                    break;

                case "cambio_clave":
                    clave_cifrada = BCrypt.hashpw(clave_usuario, semilla);
                    id = Integer.parseInt(usuario_identificado);
                    mensaje = call.cambiar_clave(id, clave_cifrada);
                    request.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    break;

                case "actualizar_clave":
                    clave_cifrada = BCrypt.hashpw(clave_usuario, semilla);
                    id = Integer.parseInt(usuario_identificado);
                    clave_cifrada_anterior = BCrypt.hashpw(clave_anterior, semilla);
                    mensaje = call.actualizar_clave(id, clave_cifrada_anterior, clave_cifrada);
                    request.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("Principal.jsp").forward(request, response);
                    break;

                default:
                    mensaje.setMensaje("OCURRIÓ UN ERROR INESPERADO");
                    mensaje.setDescripcion("FAVOR DE ESCOGER UNA OPCIÓN VÁLIDA");
                    mensaje.setTipo(false);
                    request.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    break;
            }
        } catch (Exception ex) {
            mensaje.setMensaje("OCURRIÓ UN ERROR INESPERADO");
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
