<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of cuestionario_controller
 *
 * @author Estudiante
 */
class CuestionarioController extends ApplicationController
{
    //put your code here

    public function index()
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="estudiante")
        {
            $this->redirect("login/index");
        }
    }
    
    public function cuestionarioEstudiante($page = 1)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="estudiante")
        {
            $this->redirect("login/index");
        }
        $this->paginador = $this->Examen->listar($page);
    }

    public function cuestionarioInscrito()
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="estudiante")
        {
            $this->redirect("login/index");
        }
        $estudiante_cod = $_SESSION["codigo"];
        if($estudiante_cod != null)
        {
            $this->estudiante_cod = $estudiante_cod;
            $this->examen = $this->Examen->find_all_by_sql("select * from examen where examen.id in (select inscripcionexamen.examen_id from inscripcionexamen where estudiante_cod = $estudiante_cod) order by id");
        }else
        {
            $this->redirect("cuestionario");
        }
    }

    public function inscripciones($realizar = null,$examen_id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="estudiante")
        {
            $this->redirect("login/index");
        }
        $estudiante_cod = $_SESSION["codigo"];
        if($realizar != null && $examen_id != null && $estudiante_cod != null)
        {
            if($realizar == "inscribir")
            {
                //$examen_id = $this->post('examen_id');
                //$estudiante_id = $this->post('estudiante_id');
                Load::lib('inscripcionexamen');
                $inscripcion = new Inscripcionexamen();
                switch ($inscripcion->inscribir($examen_id, $estudiante_cod))
                {
                    case 1:
                        Flash::success("Se ha inscrito Correctamente");
                        break;
                    case 2:
                        Flash::error("No se inscrito en este examen");
                        break;
                    case 3:
                        Flash::warning("ya esta inscrito");
                        break;
                    default:
                        Flash::error("Erro al momento de inscribir");
                }
                $direccion = "cuestionarioEstudiante";
            }elseif($realizar == "desinscribir")
            {
                //$examen_id = $this->post('examen_id');
                //$pregunta_id = $this->post('pregunta_id');
                Load::lib('inscripcionexamen');
                $inscripcion = new Inscripcionexamen();
                switch ($inscripcion->desinscribir($examen_id, $estudiante_cod))
                {
                    case 1:
                        Flash::success("se ha eiminado su inscripcion");
                        break;
                    case 2:
                        Flash::error("No se ha borrado la inscripcion");
                        break;
                    case 3:
                        Flash::warning("no se encuentra Inscrito en el examen");
                        break;
                    default:
                        Flash::error("Erro al momento de borrar su inscripcion");
                }
                $direccion = "cuestionarioInscrito";
            }else
            {
                Flash::error("verifique la accion");
            }
        }
        //$this->render(null);
        if($direccion == "cuestionarioEstudiante")
        {
            $this->route_to("action: $direccion","id: 1");
        }
        elseif($direccion == "cuestionarioInscrito")
        {
            $this->route_to("action: $direccion","id: ".$_SESSION["codigo"]);
        }

    }

    public function realizarExamen($examen_id = null)
    {
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="estudiante")
        {
            $this->redirect("login/index");
        }

        if($examen_id != null)
        {
            $this->examen = $this->Examen->find($examen_id);
            $this->cantidad = $this->Pregunta->count_by_sql("select count(*)
                                                             from pregunta
                                                             where id in
                                                                (select pregunta_id
                                                                 from preguntaexamen
                                                                 where examen_id = $examen_id)");
            $this->areatematica = $this->Areatematica->find_all_by_sql("select distinct areatematica.nombre
                                                                        from areatematica
                                                                        where id in (select pregunta.areatematica_id
                                                                                    from pregunta
                                                                                    where pregunta.id in (select preguntaexamen.pregunta_id
                                                                                                          from preguntaexamen
                                                                                                          where preguntaexamen.examen_id = $examen_id) )");

        }else
        {
            $this->redirect("cuestioanrioInscrito");
        }
    }
}
?>
