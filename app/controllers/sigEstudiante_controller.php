<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class SigEstudianteController extends ApplicationController{

    public function before_filter(){
        if($this->is_ajax()){
            $this->set_response('view');
        }
    }

    public function index(){
    }

    public function observarProgeso($id = null){

    }

    public function comapracionEcaes($idEcaes = null){
        
    }

    public function listarEstudiantes(){
        $this->resultado = null;
        Load::lib("sistemaInformacion");
        $sig = new SistemaInformacion();
        $this->semestre = $this->post("semestre");
        if($this->semestre != 0){
            $this->resultado = $sig->listarEstudiantes($_SESSION["programa_id"], $this->semestre);
        }
       else{
           Flash::error("Semestre No espesificado");
       }
    }

    public function progresoEstudiante($cod = null){
        $this->resultado = null;
        $this->cod = $cod;

        if($cod != null){
            Load::lib("sistemaInformacion");
            $sig = new SistemaInformacion();
            $this->resultado = $sig->progresoEstudiante($cod);
        }

    }

    public function mostrarGraficaExamen($cod = null){
        $this->resultado = null;
        $i = 0;
        $j = 0;
        $k = 0;
        $this->categorias = array();
        $this->serie = array();

        if($cod != null){
            Load::lib("sistemaInformacion");
            $sig = new SistemaInformacion();
            $examenes = $sig->progresoEstudianteSQL($cod,"distinct(examen)");
            foreach ($examenes as $examen){
                $categorias[$i] = $examen["examen"];
                $j = 0;
                $filas_areas = $sig->progresoEstudianteSQL($cod, "*", "examen = ".$examen["examen"]);
                foreach ($filas_areas as $resultados){
                    $areas[$resultados["areatematica"]] = $resultados["areatematica"];
                    $serie[$examen["examen"]][$j] = /*$resultados["buenas"];**/(floatval($resultados["buenas"])/floatval($resultados["buenas"]+$resultados["malas"]))*100;
                    $j++;
                }
                $i++;
            }
            $this->areas = $areas;
            $this->resultado = $examen;
            $this->serie = $serie;
            $this->categoria = $categorias;
        }else{
            Flash::error("no se encontraron parametro ...");
        }
    }
    public function mostrarGraficaArea($cod = null){
        $this->resultado = null;
        $i = 0;
        $j = 0;
        $k = 0;
        $this->categorias = array();
        $this->serie = array();

        if($cod != null){
            Load::lib("sistemaInformacion");
            $sig = new SistemaInformacion();
            $examenes = $sig->progresoEstudianteSQL($cod,"distinct(areatematica)");
            foreach ($examenes as $examen){
                $categorias[$i] = $examen["areatematica"];
                $j = 0;
                $filas_areas = $sig->progresoEstudianteSQL($cod, "*", "areatematica = ".$examen["areatematica"]);
                foreach ($filas_areas as $resultados){
                    $areas[$resultados["examen"]] = $resultados["examen"];
                    $serie[$examen["areatematica"]][$j] = /*$resultados["buenas"];**/(floatval($resultados["buenas"])/floatval($resultados["buenas"]+$resultados["malas"]))*100;
                    $j++;
                }
                $i++;
            }
            $this->areas = $areas;
            $this->resultado = $examen;
            $this->serie = $serie;
            $this->categoria = $categorias;
        }else{
            Flash::error("no se encontraron parametro ...");
        }
    }

}
?>
