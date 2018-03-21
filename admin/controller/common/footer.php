<?php
	class ControllerCommonFooter extends Controller {
		public function index() {
			$this->load->language('common/footer');
			
			// Enhanced CKEditor
			if (!file_exists(DIR_CATALOG.'../vqmod/xml/enhanced_file_manager.xml') || file_exists(DIR_CATALOG.'../vqmod/xml/enhanced_file_manager.xml_')) {
				$data['fm_installed'] = 0;
			}
			
			if (file_exists(DIR_CATALOG.'../vqmod/xml/enhanced_file_manager.xml') && $this->config->get('fm_installed') == 1) {
				$data['fm_installed'] = 1;
			}
			
			if ($this->config->get('ea_cke_enable_ckeditor') == 1) {
				$data['ckeditor_enabled'] = 1;
				} else {
				$data['ckeditor_enabled'] = 0;
			}
			
			if ($this->config->get('ea_cke_ckeditor_skin')) {
				$data['ckeditor_skin'] = $this->config->get('ea_cke_ckeditor_skin');
				} else {
				$data['ckeditor_skin'] = 'moono-lisa';
			}
			
			if ($this->config->get('ea_cke_codemirror_skin')) {
				$data['codemirror_skin'] = $this->config->get('ea_cke_codemirror_skin');
				} else {
				$data['codemirror_skin'] = 'eclipse';
			}
			// Enhanced CKEditor
			
			$data['pim_status'] = $this->config->get('pim_status');
			$data['text_footer'] = sprintf($this->language->get('text_footer'), $this->config->get('config_name'));
			$data['lang'] = 'en';
			$data['width'] = $this->config->get('pim_width');
			$data['height'] = $this->config->get('pim_height');
			
			if ($this->user->isLogged() && isset($this->request->get['token']) && ($this->request->get['token'] == $this->session->data['token'])) {
				$data['text_version'] = sprintf($this->language->get('text_version'), VERSION);
				} else {
				$data['text_version'] = '';
			}
			
			$data['ajax_save'] = false;
			if($this->user->isLogged()){
				$data['ajax_save'] = true;
			}
			
			if(!$this->user->isLogged()){
				$data['ckeditor_enabled'] = false;
				$data['ajax_save'] = false;
				$data['pim_status'] = false;
			}
			
			return $this->load->view('common/footer', $data);
		}
	}
