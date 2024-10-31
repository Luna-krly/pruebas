/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_Conceptos;
import DAO.dao_TIngresos;
import Excepciones.Validaciones;
import Objetos.obj_Conceptos;
import Objetos.obj_Mensaje;
import Objetos.obj_TIngreso;
import Objetos.obj_Usuario;
import java.io.IOException;
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
@WebServlet("/Srv_Concepto")
public class Srv_Concepto extends HttpServlet implements Servlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("--------------------Ingresa a Srv_Conceptos---------------------");
         request.setCharacterEncoding("UTF-8");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        obj_Mensaje mensaje = new obj_Mensaje();
        obj_Conceptos concepto = null;
        dao_Conceptos call = null;
        obj_Usuario usuario = null;
        Validaciones validar = new Validaciones();
        boolean respuesta = false;

        //Mostrar lista
        dao_Conceptos dao3 = null;
        List<obj_Conceptos> conceptolista = null;

        //Mostrar lista TIPO INGRESOS
        dao_TIngresos dao4 = null;
        List<obj_TIngreso> ingresosclista = null;

        //TOMA LOS VALORES DEL FORMULARIO 
        String id_concepto = request.getParameter("idConcepto");
        String nombre_concepto = request.getParameter("nombreConcepto");
        String tipo_ingreso = request.getParameter("tipoIngreso");
        String remitente = request.getParameter("remitente");
        String destinatario = request.getParameter("destinatario");
        String descripcion_concepto = request.getParameter("descripcionConcepto");
        String nombre_vo = request.getParameter("nombreVo");
        String nombre_att = request.getParameter("nombreAtentamente");
        String puesto_vo = request.getParameter("puestoVo");
        String puesto_att = request.getParameter("puestoAtentamente");

        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_Conceptos---------------------");
        System.out.println("Id: " + id_concepto);
        System.out.println("N.Concepto:" + nombre_concepto);
        System.out.println("Ingreso:" + tipo_ingreso);
        System.out.println("Remitente:" + remitente);
        System.out.println("Destinatario:" + destinatario);
        System.out.println("Concepto:" + descripcion_concepto);
        System.out.println("Persona VO:" + nombre_vo);
        System.out.println("Persona ATT:" + nombre_att);
        System.out.println("Puesto VO:" + puesto_vo);
        System.out.println("Puesto ATT:" + puesto_att);

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

        //-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (act == null) {
            //Ningún botón ha sido seleccionado
            System.out.println("Srv_Conceptos- Ningun boton- Ingresa a TRY");
            try {
                System.out.println("Srv_Conceptos-Lista servlet- Ingresa a TRY");
                dao3 = new dao_Conceptos();
                conceptolista = dao3.Listar();
                request.setAttribute("conceptolista", conceptolista);

                //Mostrar lista
                dao4 = new dao_TIngresos();
                ingresosclista = dao4.Listar();
                request.setAttribute("ingresosclista", ingresosclista);

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
            RequestDispatcher rd = request.getRequestDispatcher("Catalogos/Conceptos.jsp");
            rd.forward(request, response);
            return;

            //--------------------------------------------GUARDAR---------------------------------------------------------------  
        } else {
            try {
                call = new dao_Conceptos();
                concepto = new obj_Conceptos();
                concepto.setNombre(nombre_concepto);
                concepto.setTipoIngreso(tipo_ingreso);
                concepto.setRemitente(remitente);
                concepto.setDestinatario(destinatario);
                concepto.setConcepto(descripcion_concepto);
                concepto.setNombreVo(nombre_vo);
                concepto.setNombreAtt(nombre_att);
                concepto.setPuestoVo(puesto_vo);
                concepto.setPuestoAtt(puesto_att);
                concepto.setUsuario(usuario.getUsuario());//Nombre usuario

                mensaje = call.ctg_conceptos(act, concepto, id_concepto);
                session.setAttribute("mensaje", mensaje);

                dao3 = new dao_Conceptos();
                conceptolista = dao3.Listar();
                session.setAttribute("conceptolista", conceptolista);

                //Mostrar lista
                dao4 = new dao_TIngresos();
                ingresosclista = dao4.Listar();
                session.setAttribute("ingresosclista", ingresosclista);

                response.sendRedirect("Srv_Concepto");
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

//------------
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
