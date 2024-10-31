/*
 * To change this license header, choose License Headers in Project Proimpties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_CltSat;
import DAO.dao_Permiso;
import Excepciones.Validaciones;
import Objetos.obj_ClientesSAT;
import Objetos.obj_Mensaje;
import Objetos.obj_Permiso;
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
@WebServlet("/Srv_Permisos")
public class Srv_Permisos extends HttpServlet implements Servlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //--------------------------INICIA----

        System.out.println("--------------------Ingresa a Srv_Permisos---------------------");
        request.setCharacterEncoding("UTF-8");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        obj_Mensaje mensaje = new obj_Mensaje();

        obj_Permiso objpermiso = null;
        dao_Permiso call = null;
        obj_Usuario usuario = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        //Mostrar lista
        dao_Permiso dao3 = null;
        List<obj_Permiso> perlista = null;
        int cliente = 0;
        
        //MOSTRAR LISTA Clientes
        dao_CltSat daoCS = null;
        List<obj_ClientesSAT> cslista = null;

        //TOMA LOS VALORES DEL FORMULARIO 
        String id=request.getParameter("idNumeroPermiso");
        String permiso = request.getParameter("numeroPermiso");
        String rfc = request.getParameter("rfcCliente");
        String concepto = request.getParameter("conceptoPermiso");

        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_Permisos---------------------");
        System.out.println("Id:" + id);
        System.out.println("Permiso:" + permiso);
        System.out.println("RFC:" + rfc);
        System.out.println("Concepto:" + concepto);

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
        //TOMA FECHA DE SESION ACTUAL
        Date date = new Date();
        long d = date.getTime(); //guardamos en un long el tiempo
        java.sql.Date fecha = new java.sql.Date(d);// parseamos al formato del sql  

        //-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (act == null) {
            //Ningún botón ha sido seleccionado
            System.out.println("Srv_Permisos- Ningun boton- Ingresa a TRY");
            try {
                System.out.println("Srv_Permisos- Lista servlet- Ingresa a TRY");

                dao3 = new dao_Permiso();
                perlista = dao3.Listar();
                request.setAttribute("perlista", perlista);

                daoCS = new dao_CltSat();
                cslista = daoCS.Listar();
                request.setAttribute("cslista", cslista);


                System.out.println("Srv_Permisos- Lista servlet- Envia lista");

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
            RequestDispatcher rd = request.getRequestDispatcher("Catalogos/Permisos.jsp");
            rd.forward(request, response);
            return;

            //--------------------------------------------Procedimiento---------------------------------------------------------------  
        } else {
            try {
                cliente = Integer.parseInt(rfc);
                call = new dao_Permiso();
                objpermiso = new obj_Permiso();

                objpermiso.setConcepto(concepto);
                objpermiso.setIdCliente(cliente);
                objpermiso.setNumeroPermiso(permiso);
                objpermiso.setUsuario(usuario.getUsuario());//Nombre usuario

                mensaje = call.ctg_permisos(act, objpermiso, id);
                session.setAttribute("mensaje", mensaje);

                dao3 = new dao_Permiso();
                perlista = dao3.Listar();
                session.setAttribute("perlista", perlista);
                
                daoCS = new dao_CltSat();
                cslista = daoCS.Listar();
                session.setAttribute("cslista", cslista);


                response.sendRedirect("Srv_Permisos");
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

        //--------------    
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
        // Configurar los encabezados de respuesta para desactivar el caché del navegador
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
