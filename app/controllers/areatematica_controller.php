<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of areatematica_controller
 *
 * @author Benlly
 */
class AreatematicaController extends ApplicationController
{

    public $models = array('areatematica');

    public function index($page = 1)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        $this->paginador = $this->Areatematica->Listar($page);
    }
    public function nueva()
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        $id = $this->Areatematica->nuevaAreatematica();
        Router::route_to('action: createAreatematica',"id: $id");
    }

    public function createAreatematica($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        $this->id2 = null;
        if($id != null)
        {
            $this->areatematica = $this->Areatematica->find($id);
            $this->id2 = $id;
        }
        if($this->has_post('requiredareatematica'))
        {
            if(!$this->Areatematica->update($this->post('requiredareatematica')))
            {
                Flash::error('No se pudo crear el area tematica, Intentelo mas tarde');
                $this->areatematica = $this->post('requiredareatematica');
            } else
            {
                $this->redirect('areatematica/index/1');
            }
        }
    }


    public function deleteAreatematica($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $db = DbBase::raw_connect();
            $query = "select * from subarea where areatematica_id = $id";
            $result = $db->find("subarea","areatematica_id = ".$id);
            if($result)
            {
                Flash::warning("imposible eliminar area tematica, posee subareas que dependen de ella");
                $this->route_to('areatematica/index/1');
            }
            else
            {
                if (!$this->Areatematica->delete($id))
                {
                    Flash::error('Falló Operación');
                }else
                {
                    Flash::success('Operacion exitosa');
                    $this->route_to('areatematica/index/1');
                }
            }
        }

    }

    public function updateAreatematica($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $this->areatematica = $this->Areatematica->find($id);
        }
        if($this->has_post('requiredareatematica'))
        {
            if(!$this->Areatematica->update($this->post('requiredareatematica')))
            {
                Flash::error('Falló Operación');
                //$this->areatematica = $this->post('requiredareatematica');
            } else
            {
                $this->redirect('areatematica/index/1');
            }
        }
    }
}
?>
