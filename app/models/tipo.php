<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of tipo
 *
 * @author Benlly
 */
class Tipo extends ActiveRecord {
    public function listar($page = 1 ){
       //return $this->paginate("page: $page",'per_page: 10');
       return $this->paginate_by_sql('SELECT * FROM tipo ORDER BY tipo.id',"page: $page",'per_page: 10');
    }

    public function nuevatipo(){
        $max = 0;
        $default = array(
            "nombre" => "NOMBRE",
            "numero"=>1,
            "descripcion"=>"DESCRIPCION",
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
