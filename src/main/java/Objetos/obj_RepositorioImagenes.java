/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Objetos;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class obj_RepositorioImagenes {

    // Ruta base para las imágenes
    private static final String BASE_PATH = "/pruebas/Diseño/imagen/";

    // Imágenes específicas
    private static final String ERROR_404 = BASE_PATH + "Error404.png";
    private static final String FONDO = BASE_PATH + "fondo.png";
    private static final String LOGO_SIN_NOMBRE = BASE_PATH + "Logo-Metro-SN.png";
    private static final String LOGO_CON_NOMBRE = BASE_PATH + "Logo_Metro.png";
    private static final String INICIO = BASE_PATH + "Inicio.png";
    private static final String LOGO = BASE_PATH + "logo.png";
    private static final String PERFIL = BASE_PATH + "avatar.webp";
    private static final String LOGO_MOVILIDAD = BASE_PATH + "LogoAhora.png";
    private static final String ErroresGenerales = BASE_PATH + "ErroresGenerales.png";
    private static final String CambioClave = BASE_PATH + "CambioClave.png";
    private static final String CambioClavePredeterminada = BASE_PATH + "claveCambioNvo.png";


    // Métodos para obtener rutas específicas de imágenes
    public static String getError404() {
        return ERROR_404;
    }

    public static String getFondo() {
        return FONDO;
    }

    public static String getLogoSinNombre() {
        return LOGO_SIN_NOMBRE;
    }

    public static String getLogoConNombre() {
        return LOGO_CON_NOMBRE;
    }

    public static String getInicio() {
        return INICIO;
    }

    public static String getLogo() {
        return LOGO;
    }

    public static String getPerfil() {
        return PERFIL;
    }

    public static String getLogoMovilidad() {
        return LOGO_MOVILIDAD;
    }
    
    public static String getErroresGenerales() {
        return ErroresGenerales;
    }
    
    public static String getCambioClave() {
        return CambioClave;
    }
    
    public static String getCambioClavePredeterminada() {
        return CambioClavePredeterminada;
    }
    
    
}