<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of respuestas_controller
 *
 * @author Estudiante
 */
class RespuestaController extends ApplicationController
{
    public function index()
    {

    }

    public function pregunta($examen_id = null)
    {

        if($this->has_post("preguntas") && is_array($this->post("preguntas")) && $examen_id != null)
        {
            Load::lib("respuesta");
            $respuesta = new Respuesta();
            $preguntas = $this->post("preguntas");
            $param = array();
            foreach($preguntas as $key => $value)
            {
                $param['examen_id']= $examen_id;
                $param['estudiante_cod']= $_SESSION['codigo'];
                $param['pregunta_id']= $key;
                $param['seleccion'] = $value;
                $respuesta->ingresarRespuesta($param);
            }

            $this->redirect("respuesta/examenTerminado/$examen_id");
        }
        if($examen_id == null)
        {
            $this->redirect("cuestionario/cuestionarioInscrito");
        }else
        {
            $this->pregunta = $this->Pregunta->find_all_by_sql("select *
                                                                from pregunta 
                                                                where pregunta.id in 
                                                                                   (select preguntaexamen.pregunta_id 
                                                                                    from preguntaexamen 
                                                                                    where preguntaexamen.examen_id = $examen_id) order by pregunta.id");
            if($this->pregunta != null)
            {
                Load::lib("opciones");
                $opcion = new Opciones();
                $this->opciones = array();
                foreach($this->pregunta as $preguntas)
                {
                    $this->opciones[$preguntas->id] = $opcion->buscarOpciones($preguntas->id);
                }
            }
            $this->examen_id = $examen_id;
        }
    }

    public function examenTerminado($examen_id = null)
    {
        $this->examen_id = $examen_id;
    }
}
?>
