<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

class SigProgramaController extends ApplicationController
{


    public function before_filter()
    {
        if($this->is_ajax())
        {
            $this->set_response('view');
        }
    }

    public function index()
    {
        Load::lib("sistemaInformacion");
        $sig = new SistemaInformacion();
        $this->resultado = $sig->dianamictable($_SESSION["programa_id"]);
        if($this->resultado == null)
        {
            Flash::error("Nose encuentran resultados");
        }
    }

    public function estadisticasResultadosExamen()
    {
        $this->resultado = null;
        $this->resultado2 = null;

        Load::lib("sistemaInformacion");
        $sig = new SistemaInformacion();

        $this->resultado2 = $sig->dianamictableSQL($_SESSION["programa_id"], 'distinct(examen)');

        if($this->has_post("examen_id"))
        {
            $this->examen_id = $this->post("examen_id");
            $this->resultado = $sig->cosultproexamen($_SESSION["programa_id"], $this->examen_id);
        }

    }

    public function mostrarGrafica($examen_id = null)
    {
        $this->serie = array();
        $this->serie2 = array();
        $this->categoria = array();

        Load::lib("sistemaInformacion");
        $sig = new SistemaInformacion();

        $this->resultado = $sig->cosultproexamen($_SESSION["programa_id"], $examen_id);
        $i = 0;
        foreach ($this->resultado as $fila)
        {
            $this->serie[$i] = $fila["cant_buenas"];
            $this->serie2[$i] = $fila["cant_malas"];
            $this->categoria[$i] = $fila["areatematica"];
            $i++;
        }
    }
    public function mostrarGraficaPorcentaje($examen_id = null)
    {
        $this->serie = array();
        $this->serie2 = array();
        $this->categoria = array();

        Load::lib("sistemaInformacion");
        $sig = new SistemaInformacion();

        $this->resultado = $sig->cosultproexamen($_SESSION["programa_id"], $examen_id);
        $i = 0;
        foreach ($this->resultado as $fila)
        {
            $this->serie[$i] = $fila["porcentaje_buenas"]*100;
            $this->serie2[$i] = $fila["porcentaje_malas"]*100;
            $this->categoria[$i] = $fila["areatematica"];
            $i++;
        }
    }


    public function progresoPrograma()
    {

        Load::lib("sistemaInformacion");
        $sig = new SistemaInformacion();
        $this->resultado = $sig->dianamictableSQL($_SESSION["programa_id"], "distinct(areatematica)");
       
    }

    public function comparacionExamenes()
    {

        $this->serie = array();
        $this->serie2 = array();
        $this->categoria = array();
        $this->resultado = null;

        Load::lib("sistemaInformacion");
        $sig = new SistemaInformacion();


        if ($this->has_post("areatematica") && $this->post("areatematica")!= -1)
        {
            $this->areatematica_id = $this->post("areatematica");
            $this->resultado = $sig->consultproarea($_SESSION["programa_id"], $this->areatematica_id);
            $i = 0;
            foreach ($this->resultado as $filas)
            {
                $this->serie[$i] = $filas["indice_bm"];
                $this->serie2[$i] = $filas["indice_mb"];
                $this->categoria[$i] = $filas["examen"];
                $i++;
            }

        }else{
            Flash::error("no se encuentran resultados");
        }

    }
}

?>
