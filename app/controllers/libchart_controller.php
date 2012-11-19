<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of libchart_controller
 *
 * @author Benlly
 */
class LibchartController extends ApplicationController
{
    public function index()
    {

    }

    public function grafica()
    {
        Load::lib("libchart");
        $chart = new VerticalBarChart(600,400);
        $dataSet = new XYDataSet();
        $dataSet->addPoint(new Point("Versión 0.5", 60));
        $dataSet->addPoint(new Point("Versión 0.4", 40));
        $dataSet->addPoint(new Point("Versión 0.3", 20));
        $chart->setDataSet($dataSet);
        $chart->getPlot()->setGraphPadding(new Padding(10, 20, 50, 50));
        $chart->setTitle("Crecimiento de Kumbia");
        //le damos la ruta y el nombre del archi
        $chart ->render("img/demo.png");
    }

    public function cantidad($examen_id)
    {
        Load::lib("estadistica");
        $estadistica = new Estadisticas();
        $this->nombre = $estadistica->cantidadMalasPreguntaExamen(52);
    }
}
?>
