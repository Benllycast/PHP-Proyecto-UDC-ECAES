<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of examen
 *
 * @author Benlly
 */
class Examen extends ActiveRecord{

    public function initialize(){
        $this->belongs_to('programa');
    }

    public function listar($page = 1 ){
       //return $this->paginate("page: $page",'per_page: 10');
       return $this->paginate_by_sql('SELECT * FROM examen ORDER BY examen.id',"page: $page",'per_page: 10');
    }
    public function listarEstudiante($page = 1 ){
       //return $this->paginate("page: $page",'per_page: 10');
       return $this->paginate_by_sql("SELECT * FROM examen WHERE examen.estado = 'TRUE'","page: $page",'per_page: 10');
    }

    public function examenesRespuesta($page = 1){
         return $this->paginate_by_sql("SELECT * FROM examen WHERE examen.id in (select distinct respuesta.examen_id from respuesta )","page: $page", "per_page: 10");
    }

    public function examenEstudiante($page = 1){
         return $this->paginate_by_sql("SELECT * FROM examen WHERE examen.id in (select distinct respuesta.examen_id from respuesta where respuesta.estudiante_cod = ".$_SESSION['codigo']." )");
    }

    public function nuevoExamen(){
        $max = 0;
        $default = array(
            "nombre" => "NOMBRE",
            "descripcion"=>"DESCRIPCION",
            "fecha_inicio"=>date("Y-m-d"),
            "fecha_fin"=>date("Y-m-d"),
            "estado"=>'true',
            "tiempo"=>10,
            "programa_id"=>1
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
        $this->exists();
    }
}
?>
