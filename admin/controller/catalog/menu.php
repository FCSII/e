<?php
    class ControllerCatalogMenu extends Controller{
        private $error = array();
        
        public function index(){

            $this->load->language('catalog/menu');

            $this->load->model('catalog/menu');

            $this->document->setTitle($this->language->get('heading_title'));

            $this->getList();
        }

        protected function getList(){

            $token = $this->session->data['token'];

            $data['button_add'] = $this->language->get('button_add');

            $data['button_edit'] = $this->language->get('button_edit');

            $data['button_delete'] = $this->language->get('button_delete');

            $data['heading_title'] = $this->language->get('heading_title');

            $data['text_list'] = $this->language->get('text_list');

            $data['col_title'] = $this->language->get('col_title');
            $data['col_id'] = $this->language->get('col_id');
            $data['col_action'] = $this->language->get('col_action');
            $data['col_status'] = $this->language->get('col_status');

            $data['breadcrumbs'] = array();

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_home'),
                'href' => $this->url->link('common/dashboard', 'token=' . $token, true)
            );
                
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('catalog/menu', 'token='.$this->session->data['token'])
            );

            $data['add'] = $this->url->link('catalog/menu/add', 'token=' . $token);

            $data = $this->load->controller('common/common', $data);

            $data['warning'] = "";
            
            if( isset($this->session->data['warning']) ){
                $data['warning'] = $this->session->data['warning'];
                unset($this->session->data['warning']);
            } 

            $data['success'] = "";
            
            if( isset($this->session->data['success']) ){
                $data['success'] = $this->session->data['success'];
                unset($this->session->data['success']);
            } 

            $menus = $this->model_catalog_menu->getMenus();

            $data['menus'] = array();

            foreach($menus as $menu){
                $data['menus'][] = array(
                    'menu_id'   =>  $menu['menu_id'],
                    'title'     =>  $menu['title'],
                    'status'    =>  $menu['status'],
                    'edit'      =>  $this->url->link('catalog/menu/edit', 'token='.$token.'&menu_id='.$menu['menu_id']),
                    'delete'    =>  $this->url->link('catalog/menu/remove', 'token='.$token.'&menu_id='.$menu['menu_id']),
                );
            }

            $this->response->setOutput($this->load->view('catalog/menu_list', $data));
        }  

        public function remove(){

            if( isset($this->request->get['menu_id']) && $this->validated()){
                $this->load->model("catalog/menu");

                $menu_id = (int)$this->request->get['menu_id'];

                $this->model_catalog_menu->removeMenu($menu_id);

                $this->session->data['success'] = "You have successfully modify the menu list";
            }

            if( isset($this->error['warning']) ){
                $this->session->data['warning'] = $this->error['warning'];
            }

            $this->response->redirect($this->url->link('catalog/menu', 'token='.$this->session->data['token']));
        }

        public function add(){
            $this->load->language('catalog/menu');

            $this->load->model('catalog/menu');

            if( $this->request->server['REQUEST_METHOD'] == "POST" && $this->validateForm() ){
                $this->model_catalog_menu->addMenu($this->request->post);

                $this->session->data['success'] = "You have successfully added a new menu";

                $this->response->redirect($this->url->link('catalog/menu', 'token='.$this->session->data['token']));
            }

            $this->document->setTitle($this->language->get('heading_title'));

            $this->getForm();
        }

        public function edit(){
            $this->load->language('catalog/menu');

            $this->load->model('catalog/menu');

            if( $this->request->server['REQUEST_METHOD'] == "POST" && $this->validateForm() ){
                $this->model_catalog_menu->editMenu($this->request->get['menu_id'], $this->request->post);

                $this->session->data['success'] = "You have successfully modify a menu";

                $this->response->redirect($this->url->link('catalog/menu', 'token='.$this->session->data['token']));
            }

            $this->document->setTitle($this->language->get('heading_title'));

            $this->getForm();
        }

        protected function getForm(){

            $token = $this->session->data['token'];

            $data['button_save'] = $this->language->get('button_save');

            $data['button_cancel'] = $this->language->get('button_cancel');

            $data['heading_title'] = $this->language->get('heading_title');

            $data['text_form'] = $this->language->get('text_form');

            $data['text_list'] = $this->language->get('text_list');

            $data['field_title'] = $this->language->get('field_title');

            $data['field_status'] = $this->language->get('field_status');

            $data['text_enabled'] = $this->language->get('text_enabled');
            
            $data['text_disabled'] = $this->language->get('text_disabled');

            $data['breadcrumbs'] = array();

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_home'),
                'href' => $this->url->link('common/dashboard', 'token=' . $token, true)
            );
                
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('catalog/menu', 'token=' . $token, true)
            );

            $data['action'] = $this->url->link('catalog/menu/add', 'token=' . $token);
            $data['cancel'] = $this->url->link('catalog/menu', 'token=' . $token );

            $menu = array();

            if( isset($this->request->get['menu_id']) ){
                $menu_id = $this->request->get['menu_id'];

                $data['action'] = $this->url->link('catalog/menu/edit', 'token=' . $token . "&menu_id=" . $menu_id);

                $menu = $this->model_catalog_menu->getMenu($menu_id);
            }

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_form'),
                'href' =>  $data['action']
            );

            $data['warning'] = "";

            if( isset($this->session->data['warning']) ){
                $data['warning'] = $this->session->data['warning'];
                unset($this->session->data['warning']);
            } 

            $data['error_title'] = "";

            if( isset($this->error['title']) ){
                $data['error_title'] = $this->error['title'];
            }

            if(isset($this->request->post['title'])){
                $data['title'] = $this->request->post['title'];
            }
            elseif(isset($menu['title'])){
                $data['title'] = $menu['title'];
            }
            else{
                $data['title'] = "";
            }

            if(isset($this->request->post['status'])){
                $data['status'] = $this->request->post['status'];
            }
            elseif(isset($menu['status'])){
                $data['status'] = $menu['status'];
            }
            else{
                $data['status'] = "";
            }

            if(isset($this->request->post['menus'])){
                $data['menus'] = $this->request->post['menus'];
            }
            elseif(isset($menu['menus'])){
                $data['menus'] = $menu['menus'];
            }
            else{
                $data['menus'] = array();
            }

            $filters = array(
                'sort'  => 'name',
                'order'  => 'ASC',
                'start' => 0,
                'limit' => -1
            );

            $data["menu_options"] = array(
                'Static'    =>  array(
                    'common/home' =>   array(
                        'name'  =>  'Home',
                        'route' =>  'common/home',
                        'query' =>  'common/home',
                        'indent' =>  0
                    ),
                    'information/contact'   =>  array(
                        'name'  => 'Contact Us',
                        'route' => 'information/contact',
                        'query' => 'information/contact',
                        'indent' => 0
                    )
                )
            );

            $this->load->model('catalog/category');
            $categories = $this->model_catalog_category->getCategories($filters);

            foreach($categories as $category){
                $data["menu_options"]['Categories']['path=' . $category['category_id']] = array(
                    'name'  =>  $category['name'],
                    'route' =>  'product/category',
                    'query' =>  'path=' . $category['category_id'],
					'indent' => 0
                );
            }

            $filters['sort'] = 'title';

            $this->load->model('catalog/information');
            $informations = $this->model_catalog_information->getInformations($filters);
           
            foreach($informations as $information){
                $data["menu_options"]['Information']['information_id=' . $information['information_id']] = array(
                    'name'  =>  $information['title'],
                    'route' =>  'information/information',
                    'query' =>  'information_id=' . $information['information_id'],
					'indent' => 0
                );
            }

            $this->load->model('catalog/ncategory');
            $ncategories = $this->model_catalog_ncategory->getncategories();

            foreach($ncategories as $ncategory){
                $data["menu_options"]['News / Blog']['ncat=' . $ncategory['ncategory_id']] = array(
                    'name'  =>  $ncategory['name'],
                    'route' =>  'news/ncategory',
                    'query' =>  'ncat=' . $ncategory['ncategory_id'],
					'indent' => 0
                );
            }

            if($data['menus']){
				$class=array(
					'first',
					'second',
					'third',
					'forth',
					'fifth',
					'sixth',
				);
			
                foreach($data['menus'] as $index => $menu){ 
                    if($menu['route'] == 'product/category' && isset($data["menu_options"]['Categories'][$menu['query']])){
                        $data['menus'][$index]['title'] = $data["menu_options"]['Categories'][$menu['query']]['name'];
                    }
                    elseif($menu['route'] == 'information/information' && isset($data["menu_options"]['Information'][$menu['query']]) ){
                        $data['menus'][$index]['title'] = $data["menu_options"]['Information'][$menu['query']]['name'];
                    }
                    elseif($menu['route'] == 'news/ncategory' && isset($data["menu_options"]['News / Blog'][$menu['query']])){
                        $data['menus'][$index]['title'] = $data["menu_options"]['News / Blog'][$menu['query']]['name'];
                    }
                    elseif( isset($data["menu_options"]['Static'][$menu['route']]) ){
                        $data['menus'][$index]['title'] = $data["menu_options"]['Static'][$menu['route']]['name'];
                    }
					
					if( !isset($menu["indent"]) ){
						$data['menus'][$index]['indent'] = 0;
					}
					
					$data['menus'][$index]['class'] = $class[$data['menus'][$index]['indent']];
					
                }
            }
			
			

            $data = $this->load->controller('common/common', $data);

            $this->response->setOutput($this->load->view('catalog/menu_form', $data));
        }

        protected function validated(){
            if(!$this->user->hasPermission('access', 'catalog/menu')){
                $this->error['warning'] = "You don't have sufficient permission to modify this page";
            }

            return !$this->error;
        }

        public function validateForm(){
            $this->validated();

            if(utf8_strlen($this->request->post['title']) < 2 || utf8_strlen($this->request->post['title']) > 32){
                $this->error['title'] = "Title must be wihin 2 to 32 characters";
            }

            return !$this->error;
        }
    }