<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of subarea_controller
 *
 * @author Benlly
 */
class SubareaController extends ApplicationController
{
    public $models = array('subarea','areatematica');

    public function index($page = 1)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        $this->paginador = $this->Subarea->Listar($page);
    }
    public function nueva()
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        $id = $this->Subarea->nuevaSubarea();
        Router::route_to('action: createSubarea',"id: $id");
    }

    public function createSubarea($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $this->subarea = $this->Subarea->find($id);
            $this->areatematica = $this->Areatematica->find();
        }
        if($this->has_post('requiredsubarea'))
        {
            if(!$this->Subarea->update($this->post('requiredsubarea')))
            {
                Flash::error('Falló Operación');
                $this->subarea = $this->post('requiredsubarea');
            } else
            {
                $this->redirect('subarea/index/1');
            }
        }
    }

    public function deleteSubarea($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $db = DbBase::raw_connect();
            $query = "select * from pregunta where subarea_id = $id";
            $result = $db->find("pregunta","subarea_id = ".$id);
            if($result)
            {
                Flash::warning("imposible eliminar subarea, posee preguntas");
                $this->route_to('subarea/index/1');
            }
            else
            {
                if (!$this->Subarea->delete($id))
                {
                    Flash::error('Falló Operación');
                }else
                {
                    Flash::success('Operacion exitosa');
                    $this->redirect('subarea/index/1');
                }
            }
        }

    }

    public function updateSubarea($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $this->subarea = $this->Subarea->find($id);
            $this->areatematica = $this->Areatematica->find();
        }
        if($this->has_post('subarea'))
        {
            if(!$this->Subarea->update($this->post('subarea')))
            {
                Flash::error('Falló Operación');
                $this->subarea = $this->post('subarea');
            } else
            {
                $this->redirect('subarea/index/1');
            }
        }
    }

}
?>
