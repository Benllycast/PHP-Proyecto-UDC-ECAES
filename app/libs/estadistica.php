<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of estadistica
 *
 * @author Estudiante
 */
class Estadisticas {
    private $db;

    public function  __construct() {        
        $this->db = DbBase::raw_connect();
    }
    //muestras la cantidad de BUENAS por estudiante
    public function cantidadBuenasMalasEstudiante($estudiante_cod = null, $examen_id = null){
        $nombre = $examen_id.$_SESSION["codigo"].".png";
        Load::lib("libchart");
        if($estudiante_cod != null && $examen_id != null){
            $chart = new PieChart(500, 250);
            $buenas = $this->db->query("select cantidad_acertada_est_exam($estudiante_cod,$examen_id) as buenas");
            $buenas = $this->db->fetch_array();
            $malas = $this->db->query("select cantidad_acertada_est_exam2($estudiante_cod,$examen_id) as malas");
            $malas = $this->db->fetch_array();
            $vector = array("buenas"=>$buenas["buenas"],"malas"=>$malas["malas"]);
            $dataSet = new XYDataSet();
            $dataSet->addPoint(new Point("Buenas", $vector["buenas"]));
            $dataSet->addPoint(new Point("Malas", $vector["malas"]));
            $chart->setDataSet($dataSet);
            $chart->setTitle("Resultados Examen $examen_id de ".$_SESSION['codigo']);
            $chart->render("img/".$nombre);
        }
        return $nombre;
    }

    public function cantidadBuenasMalasAreatematicaExamen($examen_id = null, $areatematica_id = null){
        $nombre = "buenasAreatematicaExamen".$_SESSION["codigo"].".png";
        Load::model("areatematica");
        $areatematica = new Areatematica();
        $nombrearea = $areatematica->find("columns: nombre","conditions: id = $areatematica_id");
        if($examen_id != null && $areatematica_id != null){
            Load::lib("libchart");
            $chart = new VerticalBarChart(500, 250);
            $buenas = $this->db->query("select cantidad_area_exam($areatematica_id,$examen_id) as buenas");
            $buenas = $this->db->fetch_array();
            $malas = $this->db->query("select cantidad_area_exam2($areatematica_id,$examen_id) as malas");
            $malas = $this->db->fetch_array();
            $vector = array("buenas"=>$buenas["buenas"],"malas"=>$malas["malas"]);
            $dataSet = new XYDataSet();
            $dataSet->addPoint(new Point("Buenas", $vector["buenas"]));
            $dataSet->addPoint(new Point("Malas", $vector["malas"]));
            $chart->setDataSet($dataSet);
            $chart->setTitle("Resultados Examen $examen_id en el area $nombrearea->nombre");
            $chart->render("img/".$nombre);
        }
        return $nombre;
    }

    public function cantidadBuenasMalasAreatematicaExamenEstudiante($areatematica_id = null,$examen_id = null){
        $nombre = "buenasAreatematicaExamenEstudiante".$_SESSION["codigo"].".png";
        Load::model("areatematica");
        $areatematica = new Areatematica();
        $nombrearea = $areatematica->find("conditions: id = $areatematica_id");
        if($examen_id != null && $areatematica_id != null){
            Load::lib("libchart");
            $chart = new VerticalBarChart(500, 250);
            $buenas = $this->db->query("select cantidad_exam_area_cod($areatematica_id,$examen_id,".$_SESSION["codigo"].") as buenas");
            $buenas = $this->db->fetch_array();
            $malas = $this->db->query("select cantidad_exam_area_cod2($areatematica_id,$examen_id,".$_SESSION["codigo"].") as malas");
            $malas = $this->db->fetch_array();
            $vector = array("buenas"=>$buenas["buenas"],"malas"=>$malas["malas"]);
            $dataSet = new XYDataSet();
            $dataSet->addPoint(new Point("Buenas", $vector["buenas"]));
            $dataSet->addPoint(new Point("Malas", $vector["malas"]));
            $chart->setDataSet($dataSet);
            $chart->setTitle("Examen: $examen_id  Area: $nombrearea->nombre Estudiante: ".$_SESSION["codigo"]);
            $chart->render("img/".$nombre);
        }
        return $nombre;
    }    

    public function cantidadBuenasPreguntaExamen($examen_id){
        $nombre = "buenasPreguntaExamen".$examen_id.".png";
         if($examen_id != null){
            Load::lib("libchart");
            $dataSet = new XYDataSet();
            $sql = "SELECT pregunta.id , count(*) AS correctas FROM examen, pregunta, respuesta
            WHERE respuesta.pregunta_id = pregunta.id
            AND respuesta.acertada = true
            AND examen.id = respuesta.examen_id
            AND respuesta.examen_id = $examen_id
            GROUP BY pregunta.id ORDER BY pregunta.id";

            $buenas = $this->db->in_query($sql);
            //$buenas = $this->db->fetch_array();
            $i = 10;
            foreach($buenas as $values){
                $dataSet->addPoint(new Point($values['id'], $values['correctas']));
                $i+=10;
            }

            $chart = new HorizontalBarChart(500, 170+$i);
            $chart->setDataSet($dataSet);
            $chart->setTitle("Cantida de acertadas del Examen : $examen_id");
            $chart->render("img/$nombre");

         }
         return $nombre;
    }

    public function cantidadMalasPreguntaExamen($examen_id){
        $nombre = "buenasPreguntaExamen".$examen_id.".png";
         if($examen_id != null){
             Load::lib("libchart");
            

            $dataSet = new XYDataSet();
            $sql = "SELECT pregunta.id , count(*) AS correctas FROM examen, pregunta, respuesta
            WHERE respuesta.pregunta_id = pregunta.id
            AND respuesta.acertada = false
            AND examen.id = respuesta.examen_id
            AND respuesta.examen_id = $examen_id
            GROUP BY pregunta.id ORDER BY pregunta.id";

            $buenas = $this->db->in_query($sql);
            //$buenas = $this->db->fetch_array();
            $i = 10;
            foreach($buenas as $values){
                $dataSet->addPoint(new Point("ID ".$values['id'], $values['correctas']));
                $i+=10;
            }

            $chart = new HorizontalBarChart(500, 170+$i);
            $chart->setDataSet($dataSet);
            $chart->setTitle("Cantida de erradas del Examen : $examen_id");
            $chart->render("img/$nombre");

         }
         return $nombre;
    }
}
?>
