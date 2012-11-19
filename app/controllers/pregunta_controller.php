<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of pregunta_controller
 *
 * @author Benlly
 */
class PreguntaController extends ApplicationController
{

    Public $models = array('pregunta','tipo','areatematica','imagen','subarea');

    public function index($page = 1)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="profesor")
        {
            $this->redirect("login/index");
        }
        $this->paginador = $this->Pregunta->Listar($page);
    }

    public function page($page = 1)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="profesor")
        {
            $this->redirect("login/index");
        }
        $this->paginador = $this->Pregunta->Listar($page);
    }

    public function nueva()
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="profesor")
        {
            $this->redirect("login/index");
        }
        $id = $this->Pregunta->nuevaPregunta();
        Router::route_to("action: createPregunta","id: $id");
    }

    public function createPregunta($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="profesor")
        {
            $this->redirect("login/index");
        }
        $id = $this->Pregunta->nuevaPregunta();
        $flag = false;
        if($id != null)
        {
            $this->requiredpregunta = $this->Pregunta->find($id);
            $this->tipo = $this->Tipo->find();
            $this->areatematica = $this->Areatematica->find();
            $this->subarea = $this->Subarea->find();
            $this->id= $id;
        }
        if($this->has_post('requiredpregunta'))
        {
            if(!$this->Pregunta->update($this->post('requiredpregunta')))
            {
                Flash::error('Falló Operación');
                $this->pregunta = $this->post('requiredpregunta');
            } else
            {
                $pregunta = $this->post('requiredpregunta.id');
                $oprespuesta = $this->post('requiredoprespuesta');
                $opcion = array();
                $db = DbBase::raw_connect();
                foreach ($oprespuesta as $key=>$value)
                {
                    $opcion['pregunta_id']=$pregunta;
                    $opcion['opcion']=$key;
                    $opcion['texto']=$value;
                    $opcion['imagen_id']='';
                    if( !$db->query("INSERT INTO oprespuesta(pregunta_id, opcion, texto, imagen_id)
    VALUES (".$opcion['pregunta_id'].",".$opcion['opcion']." ,'".$opcion['texto']."',".(($opcion['imagen_id']=='')? "null":$opcion['imagen_id']).")"))
                    {
                        Flash::error("No se registro la OP $key");
                    }
                }
                $db->close();
                $this->redirect('pregunta/index/1');
            }
        }
    }

    public function deletePregunta($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="profesor")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $db = DbBase::raw_connect();
            $query = "select * from preguntaexamen where pregunta_id = $id";
            $result = $db->find("preguntaexamen","pregunta_id = ".$id);
            if($result)
            {
                Flash::warning("imposible eliminar pregunta, Esta asociada a un examen");
                $this->route_to('pregunta/index/1');
            }
            else
            {
                if (!$this->Pregunta->delete($id))
                {
                    Flash::error('Falló Operación');
                }else
                {
                    Flash::success('Operacion exitosa');
                }
            }
        }
        $this->route_to('pregunta/index/1');
    }

    public function selectPregunta()
    {

    }

    public function updatePregunta($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="profesor")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $this->pregunta = $this->Pregunta->find($id);
            $this->tipo = $this->Tipo->find();
            $this->areatematica = $this->Areatematica->find();
            $this->subarea = $this->Subarea->find();
            $db = DbBase::raw_connect();
            $this->oprespuesta = $db->find("oprespuesta","pregunta_id = $id");
            $db->close();
        }
        if($this->has_post('requiredpregunta'))
        {
            if(!$this->Pregunta->update($this->post('requiredpregunta')))
            {
                Flash::error('Falló Operación');
                $this->pregunta = $this->post('requiredpregunta');
            } else
            {
                $pregunta = $this->post('requiredpregunta.id');
                $oprespuesta = $this->post('oprespuesta');
                $opcion = array();
                $db = DbBase::raw_connect();
                foreach ($oprespuesta as $key=>$value)
                {
                    $opcion['pregunta_id']=$pregunta;
                    $opcion['opcion']=$key;
                    $opcion['texto']=$value;
                    $opcion['imagen_id']='';
                    if( !$db->query("UPDATE oprespuesta SET texto='".$opcion['texto']."', imagen_id=".(($opcion['imagen_id']=='')? "null":$opcion['imagen_id'])." WHERE pregunta_id = ".$opcion['pregunta_id']." AND opcion =".$opcion['opcion'].";"))
                    {
                        Flash::error("No se registro la OP $key");
                    }
                }
                $db->close();
                $this->redirect('pregunta/index/1');
                //Router::route_to('action: index');
            }
        }
    }
}
?>
