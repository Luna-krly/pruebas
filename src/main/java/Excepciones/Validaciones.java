/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Excepciones;

import Objetos.obj_Usuario;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class Validaciones {
      private static final long serialVersionUID = 1L;

    public boolean verUsuario(obj_Usuario usr) {
        if (usr == null) {
            return false;
        } else {
            return true;
        }
    }

    public boolean campos(String campo) {
        if (campo == null || campo.trim().equals("")) {
            return false;
        } else {
            return true;
        }
    }
}
