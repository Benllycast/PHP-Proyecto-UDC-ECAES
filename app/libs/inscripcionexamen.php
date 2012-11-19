<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of inscripcionesexamen
 *
 * @author Estudiante
 */
class Inscripcionexamen {
    //put your code here
    public $db = null;
    public $param = array();

    public function  __construct() {
        $this->db = DbBase::raw_connect();
    }

    public function inscribir($examen_id = null, $estudiante_cod = null){
        $flag = 0;
        if($examen_id != null && $estudiante_cod != null){
            $result = $this->db->find("inscripcionexamen","examen_id = $examen_id AND estudiante_cod = $estudiante_cod");
            if(!$result){
                $sql = "INSERT INTO inscripcionexamen(examen_id, estudiante_cod, fecha) VALUES ($examen_id, $estudiante_cod,'".date("Y-m-d")."')";
                if($this->db->query($sql)){
                    $flag = 1;
                }else{
                    $flag = 2;
                }
            }else{
                $flag = 3;
            }
        }else{
            $flag = 0;
        }
        return $flag;
    }

    public function desinscribir($examen_id, $estudiante_cod){
        $flag = 0;
        if($examen_id != null && $estudiante_cod != null){
            $result = $this->db->find("inscripcionexamen","examen_id = $examen_id AND estudiante_cod = $estudiante_cod");
            if($result){
                $sql = "DELETE FROM inscripcionexamen WHERE examen_id = $examen_id AND estudiante_cod = $estudiante_cod";
                if($this->db->query($sql)){
                    $flag = 1;
                }else{
                    $flag = 2;
                }
            }else{
                $flag = 3;
            }
        }else{
            $flag = 0;
        }
        return $flag;
    }

    public function buscarInscripcion($examen_id, $estudiante_cod){
        $flag = 0;
        if($examen_id != null && $pregunta_id != null){
            $result = $this->db->find("preguntaexamen","examen_id = $examen_id AND estudiante_cod = $estudiante_cod");
            if($result){
                $flag = 1;
            }else{
                $flag = 2;
            }
        }
        return $flag;
    }
}
?>
