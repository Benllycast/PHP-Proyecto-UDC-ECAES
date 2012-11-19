<?php

class JefeProgramaController extends ApplicationController
{

    public function index()
    {

    }

    public function registrarJefePrograma()
    {
        

        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        $this->aux = false;
        if($this->has_post('usuario'))
        {
            $usuario = $this->post('usuario');
            $result = $this->Usuario->find("cod = ".$this->post("usuario.cod"));
            if($result)
            {
                Flash::error('Hubo un problema al registrarse!!!');
                Flash::notice("posiblemente su codigo ya existe o ha sido desactivado. reactive su cuenta");
                $this->aux = true;
                $this->usuario = $this->post('usuario');
            }else
            {
                $cod = $this->post("requeredcod");
                $nombre = $this->post("requirednombre");
                $p_apellido = $this->post("requiredp_apellido");
                $s_apellido = $this->post("requireds_apellido");
                $user_name = $this->post("requireduser_name");
                $pass = $this->post("requiredpass");
                $email = $this->post("requiredemail");
                $programa = $this->post("requeredprograma_id");
                $this->Usuario->sql("INSERT INTO usuario(
                    cod, nombre, p_apellido, s_apellido, user_name, pass, email,fecha_ing, programa_id)
                    VALUES (" .$cod.",'"
                        .$nombre."','"
                        .$p_apellido."','"
                        .$s_apellido."','"
                        .$user_name."','"
                        .$pass."','"
                        .$email."','"
                        .date("Y-m-d")."',"
                        .$programa.")");
                $db = DbBase::raw_connect();
                $query = "insert into jefeprograma(cod) values (".$usuario['cod'].")";
                $db->query($query);
                Flash::success('Director de programa Registrado');
            }
        }
        $this->programa = $this->Programa->find();
    }

    public function borrarJefePrograma()
    {

        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if(isset($_SESSION["codigo"]))
        {
            $sql = "update usuario set estado = 'false' where cod = ".$_SESSION["codigo"];
            $this->Usuario->sql($sql);
            Flash::success('Operacion exitosa');
            $this->route_to("controller: login","action: logout");
        }
        //$this->redirect('estudiante/index/');
    }
    public function actualizarJefePrograma()
    {

        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="jefeprograma")
        {
            $this->redirect("login/index");
        }
        if($this->has_post("usuario"))
        {
            $user = $this->post("usuario");
            $nombre = $this->post("requirednombre");
            $p_apellido = $this->post("requiredp_apellido");
            $s_apellido = $this->post("requireds_apellido");
            $user_name = $this->post("requireduser_name");
            $pass = $this->post("requiredpass");
            $email = $this->post("requiredemail");
            $sql = "UPDATE usuario
                    SET nombre='".$nombre."', p_apellido='".$p_apellido."', s_apellido='".$s_apellido."', user_name='".$user_name."',
                    pass='".$pass."', email='".$email."', programa_id=".$user["programa_id"]."
                    WHERE cod=".$_SESSION["codigo"];
            if(!$this->Usuario->sql($sql))
            {
                Flash::error("operacion fallida!!!!");
            }
            else
                Flash::success("Estudiante actualizado con exito");

        }

        if(isset($_SESSION["codigo"]))
        {
            $this->cod = $_SESSION["codigo"];
            $sql = "select * from usuario where cod = ".$this->cod;
            $this->usuario = $this->Usuario->find_by_sql($sql);
            $this->programa = $this->Programa->find();
        }

    }
}
?>
