<?php

class EstudianteController extends ApplicationController
{
    //put your code here


    public function index()
    {
        //session_start();
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="estudiante")
        {
            $this->redirect("login/index");
        }
    }
    public function registrarEstudiante()
    {
        $this->aux = false;
        if($this->has_post("requiredusuario"))
        {
            $usuario = $this->post('requiredusuario');
            $result = $this->Usuario->find("cod = ".$this->post("requiredusuario.cod"));
            if($result)
            {
                Flash::error('Hubo un problema al registrarse!!!');
                Flash::notice("posiblemente su codigo ya existe o ha sido desactivado. reactive su cuenta");
                $this->aux = true;
                $this->usuario = $this->post('requiredusuario');
            }else
            {
                $this->Usuario->sql("INSERT INTO usuario(
                    cod, nombre, p_apellido, s_apellido, user_name, pass, email,fecha_ing, programa_id)
                    VALUES (" .$usuario['cod'].",'"
                        .$usuario['nombre']."','"
                        .$usuario['p_apellido']."','"
                        .$usuario['s_apellido']."','"
                        .$usuario['user_name']."','"
                        .$usuario['pass']."','"
                        .$usuario['email']."','"
                        .date("Y-m-d")."',"
                        .$usuario['programa_id'].")");
                $db = DbBase::raw_connect();
                $query = "insert into estudiante(cod,semestre) values (".$usuario['cod'].",".$usuario['sem'].")";
                $db->query($query);
                Flash::success('Usuario Registrado!!!');
                $this->route_to("login/index");
            }
        }
        $this->programa = $this->Programa->find();
    }

    public function borrarEstudiante()
    {

        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="estudiante")
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
    public function actualizarEstudiante()
    {
        $this->entro = false;
        if(!isset($_SESSION["tipo"]) || $_SESSION["tipo"]!="estudiante")
        {
            $this->redirect("login/index");
        }

        if($this->has_post("requiredusuario"))
        {
            Load::lib('filter');

            $nombre = ($this->has_post("requirednombre"))? Filter::get($this->post("requirednombre"), 'trim'):"" ;
            $p_apellido = ($this->has_post("requiredp_apellido"))? Filter::get($this->post("requiredp_apellido"), 'trim'):"" ;
            $s_apellido = ($this->has_post("requireds_apellido"))? Filter::get($this->post("requireds_apellido"), 'trim'):"" ;
            $user_name = ($this->has_post("requireduser_name"))? Filter::get($this->post("requireduser_name"), 'trim'):"" ;
            $pass = ($this->has_post("requiredpass"))? Filter::get($this->post("requiredpass"), 'trim'):"" ;
            $email = ($this->has_post("requiredemail"))? Filter::get($this->post("requiredemail"), 'trim'):"" ;
            /*if($nombre == "" || $p_apellido == "" || $s_apellido == ""
          || $user_name == "" || $pass == "" || $email == ""){
          Flash::warning("Todos los campos deben estar llenos");
          }*/
            // else{
            $user = $this->post("requiredusuario");
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

            //}
        }
        if(isset ($_SESSION["codigo"]))
        {
            $this->cod =$_SESSION["codigo"];
            $sql = "select * from usuario where cod = ".$this->cod;
            $this->usuario = $this->Usuario->find_by_sql($sql);
            $this->programa = $this->Programa->find();
            $entro = true;
        }



    }
}
?>
