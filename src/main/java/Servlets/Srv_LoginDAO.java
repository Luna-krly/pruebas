/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_Usuario;
import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
@WebServlet("/Srv_LoginDAO")
public class Srv_LoginDAO extends HttpServlet implements Servlet {

    private static final long serialVersionUID = 1L;

    protected void doSomething(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Ingreso a servlet Login");
        obj_Mensaje respuesta = null;
        obj_Mensaje mensaje = null;
        //TOMA LOS VALORES DEL FORMULARIO 
        String usuario = request.getParameter("txtUsuario");
        String pwd = request.getParameter("txtPassword");
        String semilla = "$2a$10$Rzv65YUHj4T2XpDIYHvsQO"; // Puedes usar cualquier cadena fija aquí
        // Genera la contraseña cifrada con la semilla fija
        String contrasenaCifrada = BCrypt.hashpw(pwd, semilla);

        if(contrasenaCifrada.equals("$2a$10$Rzv65YUHj4T2XpDIYHvsQOYJmg5MCNMJf1HL/13xc.iYoAGOX2KkO")){
            //request.setAttribute("usuario", usuario);
            response.sendRedirect("Srv_CambioClave?usuario=" + usuario);
            return;
        }
        // Muestra la contraseña cifrada
        System.out.println("Contraseña cifrada: " + contrasenaCifrada);

        dao_Usuario call = null;
        obj_Usuario user = null;
        obj_Usuario user_bueno = null;

        try {
            call = new dao_Usuario();
            user = new obj_Usuario();
            user.setUsuario(usuario);
            user.setClave(contrasenaCifrada);
          //  respuesta = call.autenticacion(user);

            switch (respuesta.getMensaje()) {
                case "1":
                    call = new dao_Usuario();
                    user_bueno = new obj_Usuario();
                    user_bueno = call.traer_usuario(respuesta.getDescripcion());
                    if (user_bueno != null) { 
                        request.getSession().setAttribute("usuario", user_bueno);
                        request.getRequestDispatcher("Principal.jsp").forward(request, response);
                    } else {
                        mensaje = new obj_Mensaje();
                        mensaje.setMensaje("Favor de verificar con el adminsitrador ");
                        mensaje.setDescripcion("Usuario nulo");
                        mensaje.setTipo(false);
                        request.setAttribute("mensaje", mensaje);
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                    break;
                case "2":
                    mensaje = new obj_Mensaje();
                    mensaje.setMensaje("Error de usuario");
                    mensaje.setDescripcion("El usuario no existe.");
                    mensaje.setTipo(false);
                    request.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    break;
                case "3":
                    mensaje = new obj_Mensaje();
                    mensaje.setMensaje("Error de contraseña");
                    mensaje.setDescripcion("La contraseña no coincide con el usuario");
                    mensaje.setTipo(false);
                    request.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    break;
                case "4":
                    mensaje = new obj_Mensaje();
                    mensaje.setMensaje("Error de usuario");
                    mensaje.setDescripcion("El usuario esta dado de baja");
                    mensaje.setTipo(false);
                    request.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    break;
                case "5":
                    mensaje = new obj_Mensaje();
                    mensaje.setMensaje("Error de usuario");
                    mensaje.setDescripcion("Tiene que tener un cambio de contraseña");
                    mensaje.setTipo(false);
                    request.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    break;
                case "6":
                    mensaje = new obj_Mensaje();
                    mensaje.setMensaje("Error al llamar procedimiento");
                    mensaje.setDescripcion(respuesta.getDescripcion());
                    mensaje.setTipo(respuesta.getTipo());
                    request.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    break;
                default:
                    mensaje = new obj_Mensaje();
                    mensaje.setMensaje("Error desconocido");
                    mensaje.setDescripcion("Por favor verifique con el administrador");
                    mensaje.setTipo(false);
                    request.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    break;
            }
/*
            if (user != null) { //CREDENCIALES VALIDAS
                request.getSession().setAttribute("usuario", user);
                request.getRequestDispatcher("Principal.jsp").forward(request, response);

            } else { //CREDENCIALES NO VALIDAS
                mensaje = new obj_Mensaje();
                mensaje.setMensaje("Error al iniciar sesión");
                mensaje.setDescripcion("Credenciales no validas o usuario dado de baja.");
                mensaje.setTipo(false);
                request.setAttribute("mensaje", mensaje);
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }*/
        } catch (Exception ex) {
            ex.printStackTrace();

            mensaje = new obj_Mensaje();

            mensaje.setMensaje("Ocurrio un error al validar");
            mensaje.setDescripcion(ex.getMessage());
            mensaje.setTipo(false);

            request.setAttribute("mensaje", mensaje);
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        } finally {
            if (call != null) {
                call.closeConnection();
            }
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies
        doSomething(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies
        doSomething(request, response);
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
