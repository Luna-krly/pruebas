/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;


import DAO.dao_Banco;
import DAO.dao_CFDI;
import DAO.dao_CltSat;
import DAO.dao_FormaPago;
import DAO.dao_Impuestos;
import DAO.dao_MPago;
import DAO.dao_Moneda;
import DAO.dao_TComprobante;
import DAO.dao_TFactor;
import Excepciones.Validaciones;
import Objetos.Obj_Banco;
import Objetos.obj_CFDI;
import Objetos.obj_ClientesSAT;
import Objetos.obj_FormaPago;
import Objetos.obj_Impuestos;
import Objetos.obj_Mensaje;
import Objetos.obj_MetodoPago;
import Objetos.obj_Monedas;
import Objetos.obj_TComprobante;
import Objetos.obj_TFactor;
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
@WebServlet("/Srv_Pagos")
public class Srv_Pagos extends HttpServlet implements Servlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("--------------------Ingresa a Srv_Pagos---------------------");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        obj_Mensaje mensaje = new obj_Mensaje();

        obj_Usuario usuario = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        
        //Mostrar lista TIPO DE COMPROBANTE 
        dao_TComprobante daoTC = null;
        List<obj_TComprobante> tclista = null;
        
        //Mostrar lista CLIENTES SAT
        dao_CltSat daoCS = null;
        List<obj_ClientesSAT> cslista = null;

        //Mostrar lista FORMA PAGO
        dao_FormaPago daoFP = null;
        List<obj_FormaPago> fplista = null;

        //Mostrar lista MONEDAS
        dao_Moneda daoMN = null;
        List<obj_Monedas> mnlista = null;

        //Mostrar lista USO DE CFDI
        dao_CFDI daoUC = null;
        List<obj_CFDI> uclista = null;

        //Mostrar lista METODO DE PAGO
        dao_MPago daoMP = null;
        List<obj_MetodoPago> mplista = null;

        //Mostrar lista TIPO DE IMPUESTO
        dao_Impuestos daoIM = null;
        List<obj_Impuestos> implista = null;

        //Mostrar lista TIPO FACTOR
        dao_TFactor daoTF = null;
        List<obj_TFactor> tflista = null;

        //Mostrar lista Bancos
        dao_Banco daoBanco = null;
        List<Obj_Banco> bnlista = null;

        //INT VALORES CONVERTIR
        int folio = 0;
        int IDFPago = 0;
        int IDMoneda = 0;
        int NOperacion = 0;
        int IDUCfdi = 0;
        int IDFactura = 0;
        int IDMPago = 0;
        int NParcial = 0;
        //FLOAT VALORES CONVERTIR
        float totalD = 0;
        float subtotalD = 0;
        float ivaTD = 0;
        float ivaRD = 0;
        float saldoAnF = 0;
        float importePF = 0;
        float saldoAbF = 0;
        float totalSAT = 0;
        float totalITT = 0;
        float totalIRT = 0;
        float totalPT = 0;

        //TOMA LOS VALORES DEL FORMULARIO 
        String cliente = request.getParameter("ocultoRFC");
        //Pago
        String fol = request.getParameter("folio");
        String fpago = request.getParameter("FchP");
        String banco = request.getParameter("NBan");
        String rfcBanco = request.getParameter("Brfc");
        String cta = request.getParameter("CtaCl");
        String nota = request.getParameter("Nstc");
        String fmpago = request.getParameter("FP");
        String mon = request.getParameter("Mn");
        String tcam = request.getParameter("tCam");
        String nope = request.getParameter("Nop");
        String totD = request.getParameter("Total");
        String subD = request.getParameter("SbT");
        String ivatsD = request.getParameter("IvaT");
        String ivartD = request.getParameter("IvaR");
        String cfdi = request.getParameter("UFac");
        //Factura
        String fac = request.getParameter("ocultoFAC");
        String ffiscal = request.getParameter("FFisc");
        String mpago = request.getParameter("MP");
        String parcial = request.getParameter("NoPr");
        String saf = request.getParameter("SAntF");
        String ipf = request.getParameter("IPagF");
        String sabf = request.getParameter("SAbsF");
        //I
        String bci = request.getParameter("BCI");
        String iti = request.getParameter("IvaTI");
        String iri = request.getParameter("IvaRI");
        String pim = request.getParameter("PagoI");
        //T
        String tsat = request.getParameter("TSAT");
        String tivtt = request.getParameter("TITT");
        String tivrt = request.getParameter("TIRT");
        String tpgt = request.getParameter("TPT");

        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_PAGOS---------------------");
        System.out.println("Cliente:" + cliente);
        //P
        System.out.println("Folio:" + fol);
        System.out.println("Fecha Pago:" + fpago);
        System.out.println("Banco:" + banco);
        System.out.println("RFC Banco:" + rfcBanco);
        System.out.println("Cuenta Cliente:" + cta);
        System.out.println("Nota :" + nota);
        System.out.println("Forma Pago:" + fmpago);
        System.out.println("Moneda:" + mon);
        System.out.println("Tipo de Cambio:" + tcam);
        System.out.println("NO Operacion :" + nope);
        System.out.println("Total Deposito:" + totD);
        System.out.println("Subtotal Deposito:" + subD);
        System.out.println("Iva Trasladado Deposito:" + ivatsD);
        System.out.println("IVA Retenido Deposito:" + ivartD);
        System.out.println("Uso de Factura :" + cfdi);
        //F
        System.out.println("ID Factura :" + fac);
        System.out.println("Folio Fiscal :" + ffiscal);
        System.out.println("Metodo Pago :" + mpago);
        System.out.println("NO Parcial :" + parcial);
        System.out.println("Saldo Anterior F :" + saf);
        System.out.println("Importe PF :" + ipf);
        System.out.println("Saldo Absoluto F :" + sabf);
        //I
        System.out.println("Base calculo I :" + bci);
        System.out.println("iva tr I :" + iti);
        System.out.println("Iva rt I :" + iri);
        System.out.println("Pago I :" + pim);
        //T
        System.out.println("Total saldo ant T :" + tsat);
        System.out.println("total iva tr T:" + tivtt);
        System.out.println("total iva rt T :" + tivrt);
        System.out.println("total p t:" + tpgt);

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
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);

            return;
        }
        //TOMA FECHA DE SESION ACTUAL
        Date date = new Date();
        long d = date.getTime(); //guardamos en un long el tiempo
        java.sql.Date fecha = new java.sql.Date(d);// parseamos al formato del sql  

//-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (act == null) {
            //nningun boton ha sido seleccionado
            System.out.println("Srv_Pago- Ningun boton- Ingresa a TRY");
            try {
                System.out.println("Srv_Pago-Lista servlet- Ingresa a TRY");
                
                daoTC = new dao_TComprobante();//---------------TIPO DE COMPROBANTE
                tclista = daoTC.Listar();
                request.setAttribute("tclista", tclista);
                
                daoFP = new dao_FormaPago();//----------------------FORMA DE PAGO
                fplista = daoFP.Listar();
                request.setAttribute("fplista", fplista);

                daoMN = new dao_Moneda();//----------------------MONEDA
                mnlista = daoMN.Listar();
                request.setAttribute("monlista", mnlista);

                daoUC = new dao_CFDI();//----------------------USO CFDI
                uclista = daoUC.Listar();
                request.setAttribute("cfdilista", uclista);

                daoMP = new dao_MPago();//----------------------MÉTODO DE PAGO
                mplista = daoMP.Listar();
                request.setAttribute("mplista", mplista);

                daoIM = new dao_Impuestos();//----------------------IMPUESTOS
                implista = daoIM.Listar();
                request.setAttribute("implista", implista);

                daoTF = new dao_TFactor();//--------------------TipoFactor
                tflista = daoTF.Listar();
                request.setAttribute("tflista", tflista);

                daoCS = new dao_CltSat();//----------------------CLIENTES SAT
                cslista = daoCS.Listar();
                request.setAttribute("cslista", cslista);

               
                daoBanco = new dao_Banco();//----------------------Bancos
                bnlista = daoBanco.Listar();
                request.setAttribute("bnlista", bnlista);

                System.out.println("Srv_Pago-Lista servlet- Envia lista");

            } catch (Exception ex) {
                ex.printStackTrace();

                mensaje.setMensaje("Ocurrio un error al buscar listas de pagos.");
                mensaje.setDescripcion(ex.getMessage());
                mensaje.setTipo(false);
                request.setAttribute("mensaje", mensaje);
            }
            request.getRequestDispatcher("Documentos/Pagos.jsp").forward(request, response);
            return;
//-------------------------------------------GUARDAR---------------------------------------------------------------
        } else if (act.equals("Guardar")) {
            //Guardar button was pressed en VALUE

//-------------------------------------------CAMBIAR-------------------------------------------------------------
        } else if (act.equals("Cambiar")) {
            //Cambiar button was pressed
//------------------------------------------BAJA LÓGICA----------------------------------------------------------
        } else if (act.equals("Baja")) {
            //Baja button was pressed
//-------------------------------------------IMPRIMIR------------------------------------------------------------
        } else if (act.equals("Imprimir")) {
            //Imprimir button was pressed
//---------------------------------TOMA UN VALOR DIFERENTE DE BOTONES---------------------------------------------
        } else {
            //someone has altered the HTML and sent a different value!
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
