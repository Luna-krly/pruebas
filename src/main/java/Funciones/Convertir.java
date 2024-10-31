/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Funciones;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class Convertir {
     private Integer counter = 0;
    private String value = "";
    private String nombreDeMoneda;

    public Convertir() {
        nombreDeMoneda = "PESOS";
    }

    public void setNombreMoneda(String nombre) {
        nombreDeMoneda = nombre;
    }

    public String getStringOfNumber(int enteros) {
        int _counter = enteros;
        if (_counter == 1) {
            return "UN BILLON ";
        } else {
            return doThings(_counter) + " BILLONES ";
        }
    }

    public String getStringOfNumber(float num) {
        int _counter = (int) num;
        float resto = num - _counter;
        int fraccion = Math.round(resto * 100);
        return doThings(_counter) + " " + nombreDeMoneda + " " + fraccion + "/100 M.N.";
    }

    public String getStringOfNumber(int enteros, int decimales) {
        int _counter = enteros;
        int fraccion = decimales;
        return doThings(_counter) + " " + nombreDeMoneda + " " + fraccion + "/100 M.N.";
    }

    private String doThings(Integer _counter) {
        switch (_counter) {
            case 0:
                return "CERO";
            case 1:
                return "UN";
            case 2:
                return "DOS";
            case 3:
                return "TRES";
            case 4:
                return "CUATRO";
            case 5:
                return "CINCO";
            case 6:
                return "SEIS";
            case 7:
                return "SIETE";
            case 8:
                return "OCHO";
            case 9:
                return "NUEVE";
            case 10:
                return "DIEZ";

            case 11:
                return "ONCE";
            case 12:
                return "DOCE";
            case 13:
                return "TRECE";
            case 14:
                return "CATORCE";
            case 15:
                return "QUINCE";
            case 20:
                return "VEINTE";
            case 30:
                return "TREINTA";
            case 40:
                return "CUARENTA";
            case 50:
                return "CINCUENTA";
            case 60:
                return "SESENTA";
            case 70:
                return "SETENTA";
            case 80:
                return "OCHENTA";
            case 90:
                return "NOVENTA";

            case 100:
                return "CIEN";
            case 200:
                return "DOSCIENTOS";
            case 300:
                return "TRESCIENTOS";
            case 400:
                return "CUATROCIENTOS";
            case 500:
                return "QUINIENTOS";
            case 600:
                return "SEISCIENTOS";
            case 700:
                return "SETECIENTOS";
            case 800:
                return "OCHOCIENTOS";
            case 900:
                return "NOVECIENTOS";

            case 1000:
                return "MIL";

            case 1000000:
                return "UN MILLON";

            case 1000000000:
                return "UN BILLON";
        }

        if (_counter < 20) {
            return "DIECI" + doThings(_counter - 10);
        }
        if (_counter < 30) {
            return "VEINTI" + doThings(_counter - 20);
        }
        if (_counter < 100) {
            return doThings((int) (_counter / 10) * 10) + " Y " + doThings(_counter % 10);
        }
        if (_counter < 200) {
            return "CIENTO " + doThings(_counter - 100);
        }
        if (_counter < 1000) {
            return doThings((int) (_counter / 100) * 100) + " " + doThings(_counter % 100);
        }
        if (_counter < 2000) {
            return "MIL " + doThings(_counter % 1000);
        }
        if (_counter < 1000000) {
            String var = "";
            var = doThings((int) (_counter / 1000)) + " MIL";
            if (_counter % 1000 != 0) {
                var += " " + doThings(_counter % 1000);
            }
            return var;
        }
        if (_counter < 1000000000) {
            String var = "";
            var = doThings((int) (_counter / 1000000)) + " MILLONES";
            if (_counter % 1000000 != 0) {
                var += " " + doThings(_counter % 1000000);
            }
            return var;
        }
        return "";
    }
    
    public static String obtenerNombreMes(String codigoMes) {
        // Arreglo de nombres de meses en el orden correspondiente
        String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", 
                          "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
        
        // Convertir el código del mes a un número (asumiendo que el código está en formato "01", "02", etc.)
        int indice = Integer.parseInt(codigoMes) - 1; // Restar 1 para ajustar al índice 0-based
        
        // Verificar si el índice está dentro del rango válido
        if (indice >= 0 && indice < meses.length) {
            return meses[indice];
        } else {
            return "Código de mes inválido"; // Manejar códigos fuera de rango
        }
    }
}
