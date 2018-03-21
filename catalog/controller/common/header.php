<?php
	class ControllerCommonHeader extends Controller {
		public function index() {
			// Analytics
			$this->load->model('extension/extension');
			
			$data['analytics'] = array();
			
			$analytics = $this->model_extension_extension->getExtensions('analytics');
			
			foreach ($analytics as $analytic) {
				if ($this->config->get($analytic['code'] . '_status')) {
					$data['analytics'][] = $this->load->controller('extension/analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));
				}
			}
			
			$server = $this->config->get('config_url');
			
			if ($this->request->server['HTTPS']) {
				$server = $this->config->get('config_ssl');
			}
			
			if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
				$this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
			}
			
			$data['title'] = $this->document->getTitle();
			
			$data['base'] = $server;
			$data['description'] = $this->document->getDescription();
			$data['keywords'] = $this->document->getKeywords();
			$data['links'] = $this->document->getLinks();
			$data['styles'] = $this->document->getStyles();
			$data['scripts'] = $this->document->getScripts(); //debug($data['scripts']);
			$data['lang'] = $this->language->get('code');
			$data['direction'] = $this->language->get('direction');
			
			$data['name'] = $this->config->get('config_name');
			
			$data['logo'] = '';
			if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
				$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
			}
			
			$this->load->language('common/header');
			
			//XML
			$data['quicksignup'] = $this->load->controller('common/quicksignup');
			$data['signin_or_register'] = $this->language->get('signin_or_register');
			
			$data['text_home'] = $this->language->get('text_home');
			
			// Wishlist
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
			
			if ($this->customer->isLogged()) {
				$this->load->model('account/wishlist');
				
				$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
			}
			
			$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
			$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', true), $this->customer->getFirstName(), $this->url->link('account/logout', '', true));
			
			$data['text_account'] = $this->language->get('text_account');
			$data['text_register'] = $this->language->get('text_register');
			$data['text_login'] = $this->language->get('text_login');
			$data['text_order'] = $this->language->get('text_order');
			$data['text_transaction'] = $this->language->get('text_transaction');
			$data['text_download'] = $this->language->get('text_download');
			$data['text_logout'] = $this->language->get('text_logout');
			$data['text_checkout'] = $this->language->get('text_checkout');
			$data['text_category'] = $this->language->get('text_category');
			$data['text_all'] = $this->language->get('text_all');
			
			$data['home'] = $this->url->link('common/home');
			$data['wishlist'] = $this->url->link('account/wishlist', '', true);
			$data['logged'] = $this->customer->isLogged();
			$data['account'] = $this->url->link('account/account', '', true);
			$data['register'] = $this->url->link('account/register', '', true);
			$data['login'] = $this->url->link('account/login', '', true);
			$data['order'] = $this->url->link('account/order', '', true);
			$data['transaction'] = $this->url->link('account/transaction', '', true);
			$data['download'] = $this->url->link('account/download', '', true);
			$data['logout'] = $this->url->link('account/logout', '', true);
			$data['shopping_cart'] = $this->url->link('checkout/cart');
			$data['checkout'] = $this->url->link('checkout/checkout', '', true);
			$data['contact'] = $this->url->link('information/contact');
			$data['telephone'] = $this->config->get('config_telephone');
			
			$data['language'] = $this->load->controller('common/language');
			$data['currency'] = $this->load->controller('common/currency');
			$data['search'] = $this->load->controller('common/search');
			$data['cart'] = $this->load->controller('common/cart');
			
			// For page specific css
			
			$data['class'] = 'common-home';
			if (isset($this->request->get['route'])) {
				$class = '';
				
				if (isset($this->request->get['product_id'])) {
					$class = ' pid-' . $this->request->get['product_id'];
				}
				elseif (isset($this->request->get['path'])) {
					$class = ' cid-' . $this->request->get['path'];
				}
				elseif (isset($this->request->get['manufacturer_id'])) {
					$class = ' mid-' . $this->request->get['manufacturer_id'];
				}
				elseif (isset($this->request->get['information_id'])) {
					$class = ' iid-' . $this->request->get['information_id'];
				}
				elseif (isset($this->request->get['ncat'])) {
					$class = ' ncat-' . $this->request->get['ncat'];
				}
				elseif (isset($this->request->get['news_id'])) {
					$class = ' nid-' . $this->request->get['news_id'];
				}
				
				$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
			}
			
			// Social Media Sharing

			$general_image = false;
			if ($this->config->get('config_image')) {
				$general_image = $this->config->get('config_image');
			}
			
			$data["content_type"] = "website";
			
			$data["store_name"] = $this->config->get("config_name");
			
			$sharing_image	= "";
			
			$data["fb_img"] = "";
			$data["tw_img"] = "";
			$data["gp_img"] = "";
			
			$data['current_page'] = $server;
			
			if (isset($this->request->get['route'])) {
			
				if (isset($this->request->get['product_id'])) {
				
					$data["content_type"] = "article";
					
					$this->load->model("catalog/product");
					
					$product_info = $this->model_catalog_product->getProduct((int)$this->request->get['product_id']);
					
					if($product_info){
						$sharing_image = $product_info["image"];
						
						$data['current_page'] = $this->url->link("catalog/product", "product_id=" . $product_info["product_id"], true);
					}
				}
				
			}
			
			$fb_width = 600;
			$fb_height = 315;

			$tw_width = 512;
			$tw_height = 299;

			$gp_width = 612;
			$gp_height = 299;

			if($sharing_image){ 
				$this->load->model("tool/image");
				
				$data["fb_img"] = $this->model_tool_image->resize($sharing_image, $fb_width, $fb_height, 'w');
				$data["tw_img"] = $this->model_tool_image->resize($sharing_image, $tw_width, $tw_height, 'w');
				$data["gp_img"] = $this->model_tool_image->resize($sharing_image, $gp_width, $gp_height, 'w');
			}
			elseif($general_image){
				$data["fb_img"] = $this->model_tool_image->resize($general_image, $fb_width, $fb_height, 'w');
				$data["tw_img"] = $this->model_tool_image->resize($general_image, $tw_width, $tw_height, 'w');
				$data["gp_img"] = $this->model_tool_image->resize($general_image, $gp_width, $gp_height, 'w');
			}
			elseif($this->config->get('config_logo')){
				$sharing_image = $this->config->get('config_logo');

				$data["fb_img"] = $this->model_tool_image->resize($sharing_image, $fb_width, $fb_height, 'w');
				$data["tw_img"] = $this->model_tool_image->resize($sharing_image, $tw_width, $tw_height, 'w');
				$data["gp_img"] = $this->model_tool_image->resize($sharing_image, $gp_width, $gp_height, 'w');
			}
			
			$this->load->model('catalog/menu');

            $menus = $this->model_catalog_menu->getMenu(1);

			$data['menu'] = array();

            if($menus){
				$this->load->model('catalog/category');
				$this->load->model('catalog/information');
				$this->load->model('catalog/ncategory');

				$menu = json_decode($menus['list'], true);
				if($menu){ 
					$i = 0;

					foreach($menu as $each){
						$slug = generateSlug($each['route']);

						if($each['route'] == $each['query']){
							$active = ( count(explode($slug, $data['class'])) == 2 )?'active':'';
							
							if($each['indent']){
								$data['menu'][$i] = array(
									'name'	=> $this->language->get($slug),
									'href'	=> $this->url->link($each['route']),
									'indent'	=>	$each['indent'],
									'active'=> $active
								);
							}
							else{
								$data['menu'][$i] = array(
									'name'	=> $this->language->get($slug),
									'href'	=> $this->url->link($each['route']),
									'indent'	=>	$each['indent'],
									'active'=> $active,
									'child'	=>	array()
								);
							}
						}
						else{
							$active = '';
							$page_id = explode('=', $each['query']);
							$page_id = end($page_id);
							$info = array();

							if($each['route'] == "product/category"){
								$info = $this->model_catalog_category->getCategory($page_id);
								$active = ( count(explode('cid-'.$page_id, $data['class'])) == 2 )?'active':'';
							}
							elseif($each['route'] == "information/information"){ 
								$info = $this->model_catalog_information->getInformation($page_id);
								$info['name'] = $info['title'];
								$active = ( count(explode('iid-'.$page_id, $data['class'])) == 2 )?'active':'';
							}
							elseif($each['route'] == "news/ncategory"){	
								$info = $this->model_catalog_ncategory->getncategory($page_id);
								$active = ( count(explode('ncat-'.$page_id, $data['class'])) == 2 )?'active':'';
							}

							if($info){
								$data['menu'][$i] = array(
									'name'	=> $info['name'],
									'href'	=> $this->url->link($each['route'], $each['query']),
									'active'=> $active
								);
							}
							
						}

						$i++;
					} // End Foreach
				}
			}

			return $this->load->view('common/header', $data);
		}
	}