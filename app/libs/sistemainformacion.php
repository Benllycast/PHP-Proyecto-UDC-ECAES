<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of sistemasinformacion
 *
 * @author Benlly
 */
class SistemaInformacion
{
    private $db;

    public function  __construct()
    {
        $this->db = DbBase::raw_connect();
    }

    public function listarEstudiantes($programa_id, $semestre)
    {
        $result = $this->db->in_query("select u.cod as \"cod\", u.nombre as \"nombre\", p.nombre as \"programa\", e.semestre as \"semestre\"
                                    from usuario as u inner join programa as p on u.programa_id = p.id and p.id = $programa_id, estudiante e
                                    where u.cod = e.cod and e.semestre = $semestre");

        return $result;
    }

    public function dianamictable($programa_id = null)
    {

        $result = null;

        if($programa_id == null)
            return null;

        $result = $this->db->in_query ("select *
                                        from dinamictable($programa_id) as
                                        (
                                            examen integer,
                                            cant_buenas bigint,
                                            cant_malas bigint,
                                            total_respuestas bigint,
                                            porcentaje_buenas double precision,
                                            porcentaje_malas double precision,
                                            indice_bm double precision,
                                            indice_mb double precision,
                                            areatematica integer)");

        return  $result;
    }

    public function dianamictableSQL($programa_id = null, $select = "*",$condicion= null)
    {

        $result = null;
        $where = "";

        if($programa_id == null)
            return null;

        if($condicion != null)
            $where = "where ".$condicion;

        $result = $this->db->in_query ("select $select
                                        from dinamictable($programa_id) as
                                        (
                                            examen integer,
                                            cant_buenas bigint,
                                            cant_malas bigint,
                                            total_respuestas bigint,
                                            porcentaje_buenas double precision,
                                            porcentaje_malas double precision,
                                            indice_bm double precision,
                                            indice_mb double precision,
                                            areatematica integer) $where");

        return  $result;
    }

    public function cosultproexamen($programa_id = null, $examen_id = null)
    {
        $resul = null;

        if($programa_id == null || $examen_id == null)
            return null;

        $resul = $this->db->in_query("select *
                                    from consultaproexam($programa_id,$examen_id) as
                                    (
                                        examen integer,
                                        cant_buenas bigint,
                                        cant_malas bigint,
                                        total_respuestas bigint,
                                        porcentaje_buenas double precision,
                                        porcentaje_malas double precision,
                                        indice_bm double precision,
                                        indice_mb double precision,
                                        areatematica integer)");
        return $resul;

    }

    public function consultproarea($programa_id = null, $areatematica_id = null)
    {
        $result = null;

        if($programa_id == null || $areatematica_id == null)
        {
            return  null;
        }

        $result = $this->db->in_query("select *
                                        from consultaproarea($programa_id,$areatematica_id)as
                                        (
                                            examen integer, cant_buenas bigint,
                                            cant_malas bigint,
                                            total_respuestas bigint,
                                            porcentaje_buenas double precision,
                                            porcentaje_malas double precision,
                                            indice_bm double precision,
                                            indice_mb double precision,
                                            areatematica integer)");
        return $result;
    }

    public function consultproexamenarea($programa_id = null, $examen_id = null, $areatematica_id = null)
    {
        $result = null;

        if($programa_id == null || $examen_id == null || $areatematica_id == null)
            return null;

        $result = $this->db->in_query("select *
                                        from consultaproexamarea(2,6,1)as
                                        (
                                            examen integer,
                                            cant_buenas bigint,
                                            cant_malas bigint,
                                            total_respuestas bigint,
                                            porcentaje_buenas double precision,
                                            porcentaje_malas double precision,
                                            indice_bm double precision,
                                            indice_mb double precision,
                                            areatematica integer)");
        return  $result;
    }

    public function progresoEstudiante($estudiante_id =  null)
    {
        $resultado = null;

        if($estudiante_id == null)
            return null;

        $query = "select
                    * 
                  from 
                    dinamictablecod(10) as 
                    (
                        examen integer, 
                        buenas bigint, 
                        malas bigint,
                        areatematica integer, 
                        total bigint, 
                        porcentaje_buenas double precision, 
                        porcentaje_malas double precision, 
                        indice_bm double precision, 
                        indice_mb double precision
                     )";

        $resultado = $this->db->in_query($query);

        return $resultado;
    }

    public function progresoEstudianteSQL($estudiante_id = null, $select = "*", $condicion = null)
    {
        $resultado = null;
        $where = "";

        if($estudiante_id == null)
            return null;

        if($condicion != null)
            $where = "where ".$condicion;

        $query = "select
                $select
                  from
                    dinamictablecod(10) as
                    (
                        examen integer,
                        buenas bigint,
                        malas bigint,
                        areatematica integer,
                        total bigint,
                        porcentaje_buenas double precision,
                        porcentaje_malas double precision,
                        indice_bm double precision,
                        indice_mb double precision
                     ) $where";

        $resultado = $this->db->in_query($query);

        return $resultado;
    }

}
?>
