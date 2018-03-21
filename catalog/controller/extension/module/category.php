<?php
class ControllerExtensionModuleCategory extends Controller {
	public function index() {
		$this->load->language('extension/module/category');

		$data['heading_title'] = $this->language->get('heading_title');

		$parts = array();

		if ( isset($this->request->get['path']) ) {
			$parts = explode('_', (string)$this->request->get['path']);
		}

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			
			/* Child */
			$children_data = array();

			$children = $this->model_catalog_category->getCategories($category['category_id']);

			foreach($children as $child) {
				
				/* Grand Child */
				$grand_children_data = array();
			
				$grand_children = $this->model_catalog_category->getCategories($child['category_id']);
	
				foreach($grand_children as $grand_child) {
					$grand_filter_data = array('filter_category_id' => $grand_child['category_id'], 'filter_sub_category' => true);
	
					$grand_children_data[] = array(
						'active'	=> in_array($grand_child["category_id"], $parts)?'active':'',
						'category_id' => $grand_child['category_id'],
						'name' => $grand_child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($grand_filter_data) . ')' : ''),
						'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $grand_child["category_id"])
					);
				}
				/* End Grand Child */


				$filter_data = array('filter_category_id' => $child['category_id'], 'filter_sub_category' => true);

				$children_data[] = array(
					'active'	=> in_array($child["category_id"], $parts)?'active':'',
					'category_id' => $child['category_id'],
					'name' => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']),
					'child'=> $grand_children_data
				);
			}
			/* End Child */

			$filter_data = array(
				'filter_category_id'  => $category['category_id'],
				'filter_sub_category' => true
			);

			$data['categories'][] = array(
				'active'	=> in_array($category["category_id"], $parts)?'active':'',
				'category_id' => $category['category_id'],
				'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
				'children'    => $children_data,
				'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
			);
		}

		return $this->load->view('extension/module/category', $data);
	}

}