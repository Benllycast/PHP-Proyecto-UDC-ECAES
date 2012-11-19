<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of repuesta
 *
 * @author Benlly
 */
class Respuesta {
    public $db = null;
    public $param = array();

    public function  __construct() {
        $this->db = DbBase::raw_connect();
    }

    public function ingresarRespuesta($param = null){
        if($param == null || !is_array($param)){
            return;
        }else{
            $result = $this->db->find("respuesta","examen_id = ".$param['examen_id']." AND estudiante_cod = ".$param['estudiante_cod']." AND pregunta_id = ".$param['pregunta_id']);
            if(!$result){
                $sql = "INSERT INTO respuesta(examen_id, estudiante_cod, pregunta_id, seleccion) VALUES (".$param['examen_id'].", ".$param['estudiante_cod'].", ".$param['pregunta_id'].", ".$param['seleccion'].")";
            }else{
                $sql = "UPDATE respuesta SET seleccion=".$param['seleccion']." WHERE examen_id = ".$param['examen_id']." AND estudiante_cod = ".$param['estudiante_cod']." AND pregunta_id = ".$param['pregunta_id'];
            }
            $this->db->query($sql);
        }
    }
}
?>
