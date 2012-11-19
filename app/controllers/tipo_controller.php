<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of tipo_controller
 *
 * @author Benlly
 */
class TipoController extends ApplicationController
{

    public $models = array('tipo');

    public function index($page = 1)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        $this->paginador = $this->Tipo->Listar($page);
    }
    public function nueva()
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        $id = $this->Tipo->nuevaTipo();
        Router::route_to('action: createTipo',"id: $id");
    }

    public function createTipo($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $this->tipo = $this->Tipo->find($id);
        }
        if($this->has_post('requiredtipo'))
        {
            if(!$this->Tipo->update($this->post('requiredtipo')))
            {
                Flash::error('Falló Operación');
                $this->tipo = $this->post('requiredtipo');
            } else
            {
                $this->redirect('tipo/index/1');
            }
        }
    }

    public function deleteTipo($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $db = DbBase::raw_connect();
            $query = "select * from pregunta where tipo_id = $id";
            $result = $db->find("pregunta","tipo_id= ".$id);
            if($result)
            {
                Flash::warning("imposible eliminar tipo, posee preguntas relacionadas");
                $this->route_to('tipo/index/1');
            }
            else
            {
                if (!$this->Tipo->delete($id))
                {
                    Flash::error('Falló Operación');
                    $this->route_to('tipo/index/1');
                }else
                {
                    Flash::success('Operacion exitosa');
                    $this->route_to('tipo/index/1');
                }
            }
        }

    }

    public function updateTipo($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $this->tipo = $this->Tipo->find($id);
        }
        if($this->has_post('requiredtipo'))
        {
            if(!$this->Tipo->update($this->post('requiredtipo')))
            {
                Flash::error('Falló Operación');
                $this->tipo = $this->post('requiredtipo');
            } else
            {
                $this->redirect('tipo/index/1');
            }
        }
    }
}
?>
