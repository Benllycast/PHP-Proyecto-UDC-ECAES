<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of pregunta
 *
 * @author Benlly
 */
class Pregunta extends ActiveRecord{
    //put your code here

    public function initialize(){
        $this->belongs_to('tipo');
        $this->belongs_to('areatematica');
        $this->belongs_to('subarea');
    }

    public function listar($page = 1 ){
       //return $this->paginate("page: $page",'per_page: 10');
       return $this->paginate_by_sql('select * from pregunta order by pregunta.id',"page: $page",'per_page: 10');
    }

    public function nuevaPregunta(){
        $max = 0;
        $default = array(
            "texto" => "texto",
            "nivel"=>1,
            "clave"=> 1,
            "tema"=> 'tema',
            "tiempo"=> 1,
            "grupo_id" => null ,
            "tipo_id" => 1,
            "profesor_cod" => $_SESSION["codigo"],
            "imagen_id" => null,
            "subarea_id" => 1,
            "areatematica_id" => 1);
        if($this->save($default)){
            $max = $this->maximum('id');
        }else{
            Flash::error("NO SE PUDO GUARDAR");
        }
        if(is_numeric($max)){
            return $max;
        }else{
            return 0;
        }
    }
}
?>
