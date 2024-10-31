/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_Moneda;
import Excepciones.Validaciones;
import Objetos.obj_Mensaje;
import Objetos.obj_Monedas;
import Objetos.obj_Usuario;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
@WebServlet("/Srv_Monedas")
public class Srv_Monedas extends HttpServlet implements Servlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        System.out.println("Ingresa a Srv_Monedas");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs

        obj_Mensaje mensaje = new obj_Mensaje();
        obj_Monedas moneda = null;
        dao_Moneda call = null;
        obj_Usuario usuario = null;
        Validaciones validar = new Validaciones();
        boolean respuesta = false;
        //Mostrar lista
        dao_Moneda dao3 = null;
        List<obj_Monedas> monedalista = null;

        //TOMA LOS VALORES DEL FORMULARIO 
        String id = request.getParameter("idMoneda");
        String clave = request.getParameter("claveMoneda");
        String descripcion = request.getParameter("descripcionMoneda");

        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_Monedas---------------------");
        System.out.println("ID:" + id);
        System.out.println("Clave:" + clave);
        System.out.println("Descripcion:" + descripcion);

        //TOMA DATOS DEL USUARIO NOMBRE
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(15 * 60);
        usuario = (obj_Usuario) session.getAttribute("usuario");
        respuesta = validar.verUsuario(usuario);

        if (respuesta != true) {
            //MANDA LA INFORMACION AL OBJETO ERROR
            mensaje = new obj_Mensaje();

            mensaje.setMensaje("ERROR");
            mensaje.setDescripcion("FAVOR DE INICIAR SESIÓN");
            mensaje.setTipo(false);
            request.setAttribute("mensaje", mensaje);

            //Manda la pagina de eror si es que hay alguno 
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        //TOMA FECHA DE SESION ACTUAL
        Date date = new Date();
        long d = date.getTime(); //guardamos en un long el tiempo
        java.sql.Date fecha = new java.sql.Date(d);// parseamos al formato del sql  

//-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (act == null) {
            //nningun boton ha sido seleccionado
            System.out.println("-Lista servlet Ningun boton- Ingresa a TRY");
            try {
                System.out.println("-Lista servlet- Ingresa a TRY");
                dao3 = new dao_Moneda();
                monedalista = dao3.Listar();
                request.setAttribute("monedalista", monedalista);
                System.out.println("-Lista servlet- Envia lista");
            } catch (Exception ex) {
                ex.printStackTrace();
                mensaje.setMensaje("OCURRIO UN ERROR");
                mensaje.setDescripcion("NO SE PUEDEN ENVIAR LISTAS");
                mensaje.setTipo(false);
                
                System.out.println("Error en listas "+ex.getMessage());
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("CatalogosSat/Monedas.jsp").forward(request, response);
            return;
//-------------------------------------------GUARDAR---------------------------------------------------------------
        } else {
            //someone has altered the HTML and sent a different value!
            try {
                call = new dao_Moneda();
                moneda = new obj_Monedas();

                moneda.setClaveMoneda(clave);
                moneda.setDescripcionMoneda(descripcion);
                moneda.setUsuario(usuario.getUsuario());//TOMA AL USUARIO DE LA SESION

                mensaje = call.ctg_moneda(act, moneda, id);
                session.setAttribute("mensaje", mensaje);

                dao3 = new dao_Moneda();
                monedalista = dao3.Listar();
                session.setAttribute("monedalista", monedalista);

                response.sendRedirect("Srv_Monedas");
                return;

            } catch (Exception ex) {
                mensaje.setMensaje("OCURRIO UN ERROR.");
                mensaje.setDescripcion("FAVOR DE VERIFICAR CON ADMINISTRADOR");
                mensaje.setTipo(false);
                System.out.println("Error en el catch " + ex);
                
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
                return;
            } finally {
                if (call != null) {
                    call.closeConnection();
                }
                return;

            }
        }

    }

//Ultima Llave    
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
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies
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
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies
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
