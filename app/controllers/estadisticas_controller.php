<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of estadisticas_controller
 *
 * @author Estudiante
 */
class EstadisticasController extends ApplicationController
{
    //put your code here
    public function index($page = 1)
    {

        if($_SESSION['tipo'] == "jefeprograma")
        {
            $this->render("jefeprograma");
            $this->paginador = $this->Examen->examenesRespuesta($page);
        }else if($_SESSION['tipo'] == "estudiante")
        {
            $this->render("estudiante");
            $this->paginador = $this->Examen->examenEstudiante($page);
        }else
        {
            $this->redirect("login/index");
        }

    }

    public function buenasMalasEstudiante($examen_id = null)
    {
        Load::lib("estadistica");
        $estadistica = new Estadisticas();
        $this->nombre = $estadistica->cantidadBuenasMalasEstudiante($_SESSION['codigo'],$examen_id);
        $this->examen_id = $examen_id;
        $this->area = $this->Areatematica->find();
    }

    public function bmExamenArea($examen_id = null)
    {
        if($examen_id != null)
        {
            if($this->has_post("areatematica"))
            {
                $areatematica = $this->post("areatematica");
                Load::lib("estadistica");
                $estadistica = new Estadisticas();
                $this->nombre = $estadistica->cantidadBuenasMalasAreatematicaExamen($examen_id,$areatematica);
            }
            $this->examen_id = $examen_id;
            $this->area = $this->Areatematica->find();
        }else
        {
            $this->redirect("esatdisticas/index");
        }
    }

    public function bmExamenAreaEst($examen_id = null)
    {
        if($examen_id != null)
        {
            if($this->has_post("areatematica"))
            {
                $areatematica = $this->post("areatematica");
                Load::lib("estadistica");
                $estadistica = new Estadisticas();
                $this->nombre = $estadistica->cantidadBuenasMalasAreatematicaExamenEstudiante($areatematica, $examen_id);
            }
            $this->examen_id = $examen_id;
            $this->area = $this->Areatematica->find();

        }else
        {
            $this->redirect("esatdisticas/index");
        }
    }

    public function buenasExamen($examen_id = null)
    {
        if($examen_id != null)
        {
            Load::lib("estadistica");
            $estadistica = new Estadisticas();
            $this->nombre = $estadistica->cantidadBuenasPreguntaExamen($examen_id);

        }else
        {
            $this->redirect("esatdisticas/index");
        }
    }

    public function malasExamen($examen_id = null)
    {
        if($examen_id != null)
        {
            Load::lib("estadistica");
            $estadistica = new Estadisticas();
            $this->nombre = $estadistica->cantidadMalasPreguntaExamen($examen_id);

        }else
        {
            $this->redirect("esatdisticas/index");
        }
    }
}
?>
