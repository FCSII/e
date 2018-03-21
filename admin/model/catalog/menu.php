<?php
    class ModelCatalogMenu extends Model{ 

        private $menus  =  DB_PREFIX . 'menus';
        private $menus_list  =  DB_PREFIX . 'menus_list';
        
        public function getMenus(){
            $query  =  $this->db->query("SELECT * FROM $this->menus");
            return $query->rows;
        }

        public function getMenu($menu_id = 0){
            $menu_id = (int)$menu_id;
            $menu = array();

            $query = $this->db->query("SELECT * FROM $this->menus WHERE menu_id=$menu_id");
            
            if($query->num_rows == 1){ 
                
                $menu = array(
                    'menu_id'   =>  $menu_id,
                    'title'     =>  $query->row['title'],
                    'status'    =>  $query->row['status'],
                    'menus'     =>  json_decode($query->row['list'], true)
                );
            }

            return $menu;
        }

        public function removeMenu($menu_id = 0){
            if($menu_id){
                $this->clearList($menu_id);
                $this->db->query("DELETE FROM $this->menus WHERE menu_id='".(int)$menu_id."'");
            }
        }

        public function addMenu($data = array()){

            if( isset($data['menus']) ){
                $data['menus'] = $this->reconstruct($data['menus']);
            }
            else{
                $data['menus'] = array();
            }

            $this->db->query("INSERT INTO $this->menus SET title = '" . $this->db->escape( $data['title'] ) . "', status = '" .(int)$data['status'] . "', list='".$this->db->escape(json_encode($data['menus']))."'");

        }

        public function editMenu($menu_id= 0, $data = array()){

            $menu_id = (int)$menu_id;

            if( isset($data['menus']) ){
                $data['menus'] = $this->reconstruct($data['menus']);
            }
            else{
                $data['menus'] = array();
            }

            $this->db->query("UPDATE $this->menus SET title = '" . $this->db->escape( $data['title'] ) . "', status = '" .(int)$data['status'] . "', list='".$this->db->escape(json_encode($data['menus']))."' WHERE menu_id='".(int)$menu_id."'");
        }

        private function reconstruct($menus){
            $construct = array();
            foreach($menus as $var => $gmenu){
                foreach($gmenu as $index => $menu){
                    $construct[$index][$var] = $menu;
                }
            }
            return $construct;
        }
        
        private function clearList($menu_id = 0){
            $menu_id = (int)$menu_id;
            $this->db->query("DELETE FROM $this->menus_list WHERE menu_id='".(int)$menu_id."'");
        }
    }