<?php

class Usuario extends ActiveRecord {
    public $display_errors = true;

    public function initialize(){
        $this->validates_uniqueness_of('user_name', 'message: Intente con otro nombre de usuario');
    }
}
?>
