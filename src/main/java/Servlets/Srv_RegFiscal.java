/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_RegFiscal;
import Excepciones.Validaciones;
import Objetos.obj_Mensaje;
import Objetos.obj_RegFiscal;
import Objetos.obj_Usuario;
import java.io.IOException;
import java.util.List;
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
@WebServlet("/Srv_RegFiscal")
public class Srv_RegFiscal extends HttpServlet implements Servlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //--------------------------INICIA----
        request.setCharacterEncoding("UTF-8");
        System.out.println("--------------------Ingresa a Srv_RegFiscal---------------------");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        obj_Mensaje mensaje = new obj_Mensaje();
        obj_RegFiscal rf = null;
        dao_RegFiscal call = null;
        obj_Usuario usuario = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        //Mostrar lista
        dao_RegFiscal dao3 = null;
        List<obj_RegFiscal> rflista = null;

        //TOMA LOS VALORES DEL FORMULARIO 
        String id = request.getParameter("idRegimenFiscal");
        String clave = request.getParameter("claveRegimenFiscal");
        String desc = request.getParameter("descripcionRegimenFiscal");
        String fisica = request.getParameter("esFisica");
        String moral = request.getParameter("esMoral");

//String fisica = request.getParameter("fis");
        // String moral= request.getParameter("mor");
        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_RegFiscal---------------------");
        System.out.println("Clave:" + clave);
        System.out.println("Descripcion:" + desc);
        System.out.println("Fisica: " + fisica);
        System.out.println("Moral: " + moral);

        //TOMA DATOS DEL USUARIO NOMBRE
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(15 * 60);
        usuario = (obj_Usuario) session.getAttribute("usuario");
        rsp = validar.verUsuario(usuario);

        if (rsp != true) {
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
        //-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (act == null) {
            //Ningún botón ha sido seleccionado
            System.out.println("Srv_RegFiscal- Ningun boton- Ingresa a TRY");
            try {
                System.out.println("Srv_RegFiscal- Lista servlet- Ingresa a TRY");
                dao3 = new dao_RegFiscal();
                rflista = dao3.Listar();
                request.setAttribute("rflista", rflista);
                System.out.println("Srv_RegFiscal- Lista servlet- Envia lista");

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
            request.getRequestDispatcher("CatalogosSat/RegimenFiscal.jsp").forward(request, response);
            return;

            //--------------------------------------------GUARDAR---------------------------------------------------------------  
        } else {
            try {
                if (fisica != null) {
                    fisica = "SI";
                } else {
                    fisica = "NO";
                }
                if (moral != null) {
                    moral = "SI";
                } else {
                    moral = "NO";
                }
                call = new dao_RegFiscal();
                rf = new obj_RegFiscal();

                rf.setClaveRegimen(clave);
                rf.setDescripcionRegimen(desc);
                rf.setFisica(fisica);
                rf.setMoral(moral);
                rf.setUsuario(usuario.getUsuario());//Nombre usuario

                mensaje = call.ctg_reg_fiscal(act, rf, id);
                session.setAttribute("mensaje", mensaje);

                dao3 = new dao_RegFiscal();
                rflista = dao3.Listar();
                session.setAttribute("rflista", rflista);

                response.sendRedirect("Srv_RegFiscal");
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
