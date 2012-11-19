<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of subarea
 *
 * @author Benlly
 */
class Subarea extends ActiveRecord{
    //put your code here
    public function initialize(){
        $this->belongs_to('areatematica');
    }

    public function listar($page = 1 ){
       //return $this->paginate("page: $page",'per_page: 10');
       return $this->paginate_by_sql('SELECT * FROM subarea ORDER BY subarea.id',"page: $page",'per_page: 10');
    }

    public function nuevaSubarea(){
        $max = 0;
        $default = array(
            "nombre" => "NOMBRE",
            "descripcion"=>"DESCRIPCION",
            "areatematica_id"=>1
            );
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
