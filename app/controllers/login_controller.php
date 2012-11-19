<?php
class loginController extends ApplicationController
{
    //put your code here
    public function index()
    {


        if(isset ($_SESSION["tipo"]))
        {
            $this->redirect($_SESSION["tipo"]."/index");
        }

        Load::lib('filter');
        $login = ($this->has_post("codigo"))? Filter::get($this->post("codigo"), 'trim'):"" ;/*Tomamos el login del post*/
        $password = ($this->has_post("password"))? Filter::get($this->post("password"), "trim"):"" ; /*Tomamos el pass del post*/
        if($login != "" && $password != "")
        {
            $sql = "SELECT * FROM usuario WHERE usuario.cod = $login and usuario.pass = '".$password."' and usuario.estado = 'true';";
            $this->usuario = $this->Usuario->find_by_sql($sql);
            /*Si el usuario y la clave son correctos ingresa el usuario*/
            if($this->usuario)
            {
                session_start();
                $_SESSION["userName"] = $this->usuario->nombre;
                $_SESSION["codigo"] = $this->usuario->cod;
                $_SESSION["programa_id"] = $this->usuario->programa_id;
                /*Session::set("userName",$this->usuario->nombre);
                    Session::set("codigo",$this->usuario->cod);*/
                $con = DbBase::raw_connect();
                $sql = "select * from estudiante where cod = ".$_SESSION["codigo"];
                $tipo = $con->find("estudiante","cod = ".$_SESSION["codigo"]);
                if($tipo)
                {
                    $_SESSION["tipo"] = "estudiante";
                    //Session::set("tipo", "estudiante");
                }else
                {
                    $sql = "select * from profesor where cod =".$_SESSION["codigo"];
                    $tipo = $con->find("profesor","cod = ".$_SESSION["codigo"]);
                    if($tipo)
                        $_SESSION["tipo"] = "profesor";
                    //Session::set("tipo", "profesor");
                    else
                    {
                        $sql = "select * from jefeprograma where cod = ".$_SESSION["codigo"];
                        $tipo = $con->find("jefeprograma","cod = ".$_SESSION["codigo"]);
                        if($tipo)
                            $_SESSION["tipo"] = "jefeprograma";
                        //Session::set("tipo", "jefeprograma");
                    }
                }
                $_SESSION["nombre"] = $this->usuario->nombre;
                $url = $_SESSION["tipo"];
                $this->redirect($url."/index");



                //$this->redirect("menus/index");
            }else
            {
                Flash::error("Usuario/Password invalido");
            }
            /*Si el usuario o clave estuvieron mal, vuelvo al formulario de ingreso.*/
        }
    }

    public function logout()
    {
        //session_start();
        session_unset();
        session_destroy();
        $this->render(null);
        Flash::notice("sesion cerrada con exito");
        $this->route_to("action: index");
    }
}
?>
