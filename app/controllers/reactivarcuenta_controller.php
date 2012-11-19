<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

/**
 * Description of reactivarcuenta_controller
 *
 * @author Administrador
 */
class ReactivarcuentaController extends ApplicationController
{

    public function index()
    {
        if($this->has_post("cod","pass"))
        {
            $cod = $this->post("cod");
            $pass = $this->post("pass");
            $db = DbBase::raw_connect();
            //$sql = "UPDATE usuario SET estado='TRUE' WHERE cod = $cod AND pass = '$pass' AND estado = 'FALSE'";
            $sql = "UPDATE usuario SET estado='TRUE' WHERE cod = $cod AND pass = '$pass' AND estado = 'FALSE'";
            $result = $this->Usuario->find("cod = ".$this->post("cod")." AND pass = '".$this->post("pass")."'");
            if(!$result)
            {
                Flash::error("verifique los datos");
            }else
            {
                $db->query($sql);
                Flash::success("Cuenta Reactivada");
                $this->route_to("controller: login","action: index");
            }
        }
    }
    //put your code here
}
?>
