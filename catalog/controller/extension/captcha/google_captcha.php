<?php
class ControllerExtensionCaptchaGoogleCaptcha extends Controller {
    public function index($error = array()) {
        $this->load->language('extension/captcha/google_captcha');

		$data['text_captcha'] = $this->language->get('text_captcha');

		$data['entry_captcha'] = $this->language->get('entry_captcha');

        if (isset($error['captcha'])) {
			$data['error_captcha'] = $error['captcha'];
		} else {
			$data['error_captcha'] = '';
		}

		$data['site_key'] = $this->config->get('google_captcha_key');

        $data['route'] = $this->request->get['route']; 

		return $this->load->view('extension/captcha/google_captcha', $data);
    }

    public function validate() {
		if (empty($this->session->data['gcapcha'])) {
			$this->load->language('extension/captcha/google_captcha');
			
			if( ini_get('allow_url_fopen') ) { 
				$recaptcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('google_captcha_secret')) . '&response=' . $this->request->post['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);
			}
			else{
				$ch = curl_init('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('google_captcha_secret')) . '&response=' . $this->request->post['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
				$recaptcha = curl_exec($ch); 
				curl_close($ch);
			}

			$recaptcha = json_decode($recaptcha, true);
	
			if ($recaptcha['success']) {
				$this->session->data['gcapcha']	= true;
			} else {
				return $this->language->get('error_captcha');
			}
		}
    }
}
