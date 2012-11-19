<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of opcionesrespuestas
 *
 * @author Estudiante
 */
class Opciones {
    //put your code here
    public $db = null;
    public $param = array();

    public function  __construct() {
        $this->db = DbBase::raw_connect();
    }

    public function buscarOpciones($pregunta_id = null){
        $opciones = null;
        if($pregunta_id != null){
            $opciones = $this->db->find("oprespuesta","pregunta_id = $pregunta_id","*","opcion");
        }
        return $opciones;
    }
}
?>
