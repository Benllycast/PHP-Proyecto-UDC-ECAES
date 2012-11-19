<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of PreguntaExamen
 *
 * @author Benlly
 */
class Preguntaexamen {
    public $db = null;
    public $param = array();

    public function  __construct() {
        $this->db = DbBase::raw_connect();
    }

    public function linkPregunta($examen_id = null,$pregunta_id = null){
        $flag = 0;
        if($examen_id != null && $pregunta_id != null){            
            $result = $this->db->find('preguntaexamen',"examen_id = $examen_id AND pregunta_id = $pregunta_id");
            if(!$result){
                $sql = "INSERT INTO preguntaexamen(examen_id, pregunta_id) VALUES ($examen_id, $pregunta_id)";
                if($this->db->query($sql)){
                    $flag = 1;
                }else{
                    $flag = 2;
                }
            }else{
                $flag = 3;
            }
        }
        return $flag;
    }
    public function unlinkPregunta($examne_id = null, $pregunta_id = null){
        $flag = 0;
        if($examne_id != null && $pregunta_id != null){
            $result = $this->db->find("preguntaexamen","examen_id = $examne_id AND pregunta_id = $pregunta_id");
            if($result){
                $sql = "DELETE FROM preguntaexamen WHERE examen_id = $examne_id AND pregunta_id = $pregunta_id";
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

    public function buscarLink($examen_id = null , $pregunta_id = null){
        if($examen_id != null && $pregunta_id != null){
            if(!$this->db->find("preguntaexamen","examen_id = $examne_id AND pregunta_id = $pregunta_id")){
                return false;
            }else{
                return true;
            }
        }else{
            return 2;
        }
    }
}
?>
