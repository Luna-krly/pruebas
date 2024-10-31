/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_CltSat;
import DAO.dao_CodPostal;
import DAO.dao_Pais;
import DAO.dao_Permiso;
import DAO.dao_RegFiscal;
import DAO.dao_ReferenciaPermiso;
import DAO.dao_Usuario;
import Excepciones.Validaciones;
import Objetos.obj_ClientesSAT;
import Objetos.obj_CodigoPostal;
import Objetos.obj_Mensaje;
import Objetos.obj_Paises;
import Objetos.obj_Permiso;
import Objetos.obj_RegFiscal;
import Objetos.obj_Usuario;
import Objetos.obj_referenciaPermiso;
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
@WebServlet("/Srv_CSat")
public class Srv_CSat extends HttpServlet implements Servlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("--------------------Ingresa a Srv_CSat---------------------");
        request.setCharacterEncoding("UTF-8");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs

        obj_Mensaje mensaje = new obj_Mensaje();

        obj_Usuario usuario = null;
        obj_ClientesSAT cliente = null;
        dao_CltSat call = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        //Mostrar lista CODIGOS POSTALES
        dao_CodPostal daoCP = null;
        List<obj_CodigoPostal> cpostlista = null;

        //MOSTRAR LISTA Clientes
        dao_CltSat daoCS = null;
        List<obj_ClientesSAT> cslista = null;

        //MOSTRAR LISTA Regimen Fiscal
        dao_RegFiscal daoRF = null;
        List<obj_RegFiscal> rflista = null;

        //MOSTRAR LISTA País
        dao_Pais daoP = null;
        List<obj_Paises> paislista = null;

        //MOSTRAR LISTA Permiso
        dao_Permiso daoPr = null;
        List<obj_Permiso> permisolista = null;

        //MOSTRAR LISTA Referencia de Permisos y Clientes
        dao_ReferenciaPermiso daoRp = null;
        List<obj_referenciaPermiso> referencialista = null;
        
        //Lista de usuarios
        dao_Usuario daoUsuario = null;
        List<obj_Usuario>  usuariosLista = null; 


        //TOMA LOS VALORES DEL FORMULARIO
        String id = request.getParameter("idCliente");
        String numeroCliente = request.getParameter("numeroCliente");
        String tipo = request.getParameter("tipoPersona");
        String idRegimen = request.getParameter("regimenFiscal");
        String rfc = request.getParameter("rfcCliente");
        String nombreCliente = request.getParameter("nombreCliente");
        String calle = request.getParameter("calle");
        String numeroExterior = request.getParameter("numeroExterior");
        String numeroInterior = request.getParameter("numeroInterior");//opcional
        String codigoPostal = request.getParameter("codigoPostal");
        String pais = request.getParameter("pais");
        String email = request.getParameter("email");//opcional
        String condicionPago = request.getParameter("condicionPago");//opcional
        String cuentaBancaria = request.getParameter("cuentaBancaria");//opcional
        String referenciBancaria = request.getParameter("referenciaBancaria");

        int idreg = 0;
        int idcp = 0;
        int idpais = 0;
        int idcliente = 0;

        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_CSat---------------------");
        System.out.println("clave:" + act);
        System.out.println("ID:" + numeroCliente);
        System.out.println("Tipo:" + tipo);
        System.out.println("Regimen:" + idRegimen);
        System.out.println("RFC:" + rfc);
        System.out.println("Nombre:" + nombreCliente);
        System.out.println("Calle:" + calle);
        System.out.println("N.ext:" + numeroExterior);
        System.out.println("N.int:" + numeroInterior);
        System.out.println("CP:" + codigoPostal);
        System.out.println("Pais:" + pais);
        System.out.println("Email:" + email);
        System.out.println("Referencia:" + condicionPago);
        System.out.println("Cuenta:" + cuentaBancaria);
        System.out.println("referenciBancaria: " + referenciBancaria);

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
            //nningun boton ha sido seleccionado
            System.out.println("Srv_CSat- Ningun botonha sido seleccionado");
            try {
                daoCP = new dao_CodPostal();
                cpostlista = daoCP.Listar();
                request.setAttribute("cpostlista", cpostlista);

                daoCS = new dao_CltSat();
                cslista = daoCS.Listar();
                request.setAttribute("cslista", cslista);

                daoRF = new dao_RegFiscal();
                rflista = daoRF.Listar();
                request.setAttribute("rflista", rflista);

                daoP = new dao_Pais();
                paislista = daoP.Listar();
                request.setAttribute("paislista", paislista);

                daoPr = new dao_Permiso();
                permisolista = daoPr.Listar();
                request.setAttribute("permisolista", permisolista);

                daoRp = new dao_ReferenciaPermiso();
                referencialista = daoRp.Listar();
                request.setAttribute("referencialista", referencialista);
                
                daoUsuario = new dao_Usuario();
                usuariosLista = daoUsuario.Listar();
                request.setAttribute("usuarios", usuariosLista);
        
            } catch (Exception ex) {
                ex.printStackTrace();
                mensaje.setMensaje("OCURRIO UN ERROR");
                mensaje.setDescripcion("NO SE PUEDEN ENVIAR LISTAS");
                mensaje.setTipo(false);

                System.out.println("Error en listas " + ex.getMessage());
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("CatalogosSat/ClientesSAT.jsp").forward(request, response);
            return;
            //-------------------------------------------GUARDAR---------------------------------------------------------------
        } else {

            try {
                idreg = Integer.parseInt(idRegimen);
                idcp = Integer.parseInt(codigoPostal);
                idpais = Integer.parseInt(pais);
                idcliente = Integer.parseInt(numeroCliente);
                call = new dao_CltSat();
                cliente = new obj_ClientesSAT();
                cliente.setNumeroCliente(idcliente);
                cliente.setTipo(tipo);
                cliente.setIdRegimen(idreg);
                cliente.setRfc(rfc);
                cliente.setNombreCliente(nombreCliente);
                cliente.setCalle(calle);
                cliente.setNumeroExterior(numeroExterior);
                cliente.setNumeroInterior(numeroInterior);
                cliente.setIdCodigo(idcp);
                cliente.setIdPais(idpais);
                cliente.setEmail(email);
                cliente.setCodigoQr(referenciBancaria);
                cliente.setReferencia(condicionPago);
                cliente.setCuentaBanco(cuentaBancaria);
                cliente.setUsuario(usuario.getUsuario());//Nombre usuario

                mensaje = call.ctg_clientesSAT(act, cliente, id);
                System.out.println("Mensaje " + mensaje);
                session.setAttribute("mensaje", mensaje);

                response.sendRedirect("Srv_CSat");
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
