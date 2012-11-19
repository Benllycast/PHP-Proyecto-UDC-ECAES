<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of examen_controller
 *
 * @author Benlly
 */
class ExamenController extends ApplicationController
{
    //put your code here

    public function index($page = 1)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        $this->paginador = $this->Examen->Listar($page);
    }

    public function nueva()
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        $id = $this->Examen->nuevoExamen();
        Router::route_to('action: createExamen',"id: $id");
    }

    public function createExamen ($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $this->examen = $this->Examen->find($id);
            $this->programa = $this->Programa->find();
        }
        if($this->has_post('requiredexamen'))
        {
            $examen = array(
                    "id" => $this->post('requiredexamen.id'),
                    "nombre" => $this->post('requiredexamen.nombre'),
                    "descripcion"=> $this->post('requiredexamen.descripcion'),
                    "fecha_inicio"=>$this->post('requiredexamen.fecha_inicio'),
                    "fecha_fin"=>$this->post('requiredexamen.fecha_fin'),
                    "estado"=> ($this->has_post('requiredexamen.estado'))? 'true':'false',
                    "tiempo"=>10,
                    "programa_id"=>$this->post('requiredexamen.programa_id')
            );
            if(!$this->Examen->update($examen))
            {
                Flash::error('Falló Operación');
                $this->examen = $this->post('requiredexamen');
            } else
            {
                $this->redirect('examen/index/1');
            }
        }
    }

    public function deleteExamen($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $db = DbBase::raw_connect();
            $query = "select * from preguntaexamen where examen_id = $id";
            $result = $db->find("preguntaexamen","examen_id = ".$id);
            if($result)
            {
                Flash::warning("imposible eliminar examen, posee preguntas relacionadas a el");
                $this->route_to('examen', 2000);
            }
            else
            {
                if (!$this->Examen->delete($id))
                {
                    Flash::error('Falló Operación');
                }else
                {
                    Flash::success('Operacion exitosa');
                }
            }
        }
        $this->route_to('examen', 2000);
        //$this->seconds = 2000;
    }

    public function updateExamen($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $this->examen = $this->Examen->find($id);
            $this->programa = $this->Programa->find();
        }
        if($this->has_post('requiredexamen'))
        {
            $examen = array(
                    "id" => $this->post('requiredexamen.id'),
                    "nombre" => $this->post('requiredexamen.nombre'),
                    "descripcion"=> $this->post('requiredexamen.descripcion'),
                    "fecha_inicio"=>$this->post('requiredexamen.fecha_inicio'),
                    "fecha_fin"=>$this->post('requiredexamen.fecha_fin'),
                    "estado"=> ($this->has_post('requiredexamen.estado'))? 'true':'false',
                    "tiempo"=>10,
                    "programa_id"=>$this->post('requiredexamen.programa_id')
            );
            if(!$this->Examen->update($examen))
            {
                Flash::error('Falló Operación');
                $this->examen = $this->post('requiredexamen');
            } else
            {
                $this->redirect('examen/index/1');
            }
        }
    }

    public function readExamen($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null)
        {
            $this->examen = $this->Examen->find($id);
        }else
        {
            $this->redirect('examen/index');
        }
    }

    public function asociarPregunta($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null )
        {
            if($this->Examen->exists("id = $id"))
            {
                $this->examen = $this->Examen->find($id);
                $this->pregunta = $this->Pregunta->find("order: id");
                $this->asoc = $this->Pregunta->find_all_by_sql("SELECT * FROM pregunta WHERE pregunta.id IN (SELECT preguntaexamen.pregunta_id FROM preguntaexamen WHERE preguntaexamen.examen_id = $id) ORDER BY pregunta.id");
            }else
            {
                $this->redirect('examen/index', 2);
            }
        }else
        {
            $this->redirect('examen/index', 2);
        }
        if($this->has_post('box_pregunta','examen_id'))
        {
            Load::lib('preguntaexamen');
            $preguntaexamen = new Preguntaexamen();
            $pregunta = $this->post('box_pregunta');
            $examen_id = $this->post('examen_id');
            $this->resul = array();
            foreach($pregunta as $preguntas=>$valores )
            {
                $this->resul[$valores] = $preguntaexamen->linkPregunta($examen_id, $valores);
            }
            if(in_array(1, $this->resul))
            {
                Flash::success("Preguntas relacionadas con exito");
            }
            if(in_array(2, $this->resul))
            {
                Flash::warning("Error al asociar una pregunta en este examen");
            }
            if(in_array(3, $this->resul))
            {
                Flash::notice("Algunas preguntas ya se encuentran en este examen");
            }
        }
    }

    public function desasociarPregunta($id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($id != null )
        {
            if($this->Examen->exists("id = $id"))
            {
                $this->examen = $this->Examen->find($id);
                $this->pregunta = $this->Pregunta->find("order: id");
                $this->asoc = $this->Pregunta->find_all_by_sql("SELECT * FROM pregunta WHERE pregunta.id IN (SELECT preguntaexamen.pregunta_id FROM preguntaexamen WHERE preguntaexamen.examen_id = $id) ORDER BY pregunta.id");
            }else
            {
                $this->redirect('examen/index', 2);
            }
        }else
        {
            $this->redirect('examen/index', 2);
        }
        if($this->has_post('box_pregunta','examen_id'))
        {
            Load::lib('preguntaexamen');
            $preguntaexamen = new Preguntaexamen();
            $pregunta = $this->post('box_pregunta');
            $examen_id = $this->post('examen_id');
            $this->resul = array();
            foreach($pregunta as $preguntas=>$valores )
            {
                $this->resul[$valores] = $preguntaexamen->unlinkPregunta($examen_id, $valores);
            }
            if(in_array(1, $this->resul))
            {
                Flash::success("Preguntas la preguntas se eliminaron con exito");
            }
            if(in_array(2, $this->resul))
            {
                Flash::error("Error al asociar una pregunta en este examen");
            }
            if(in_array(3, $this->resul))
            {
                Flash::warning("Algunas preguntas no encontraron en el examen");
            }
        }
        $this->render("asociarPregunta");
    }
}
?>
