<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of areatematica
 *
 * @author Benlly
 */
class Areatematica extends ActiveRecord{
    //put your code here
    public function listar($page = 1 ){
       //return $this->paginate("page: $page",'per_page: 10');
       return $this->paginate_by_sql('SELECT * FROM areatematica ORDER BY areatematica.id',"page: $page",'per_page: 10');
    }

    public function nuevaAreatematica(){
        $max = 0;
        $default = array(
            "nombre" => "NOMBRE",
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
