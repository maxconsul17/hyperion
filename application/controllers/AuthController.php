<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class AuthController extends CI_Controller {

    public function __construct()
    {
        parent::__construct();
        $this->load->model('User', 'User_model');
        $this->load->library(['session', 'form_validation']);
        $this->load->helper(['url', 'form']);
    }

    // ---------------------------------------------------------------
    // GET /auth/login  →  show login form
    // POST /auth/login →  process login
    // ---------------------------------------------------------------
    public function login()
    {
        // Already logged in? Redirect to dashboard
        if ($this->session->userdata('logged_in')) {
            redirect('dashboard');
        }

        if ($this->input->method() === 'post') {
            $this->_process_login();
        } else {
            $this->load->view('auth/index');
        }
    }

    // ---------------------------------------------------------------
    // POST /auth/login  →  validate & authenticate
    // ---------------------------------------------------------------
    private function _process_login()
    {
        $this->form_validation->set_rules('email',    'Email',    'required|valid_email|trim');
        $this->form_validation->set_rules('password', 'Password', 'required|min_length[6]');

        if ($this->form_validation->run() === FALSE) {
            // Validation failed – redisplay form with inline errors
            $this->load->view('auth/login');
            return;
        }

        $email    = $this->input->post('email',    TRUE);
        $password = $this->input->post('password', TRUE);

        $user = $this->User_model->get_by_email($email);

        if ($user && password_verify($password, $user->password)) {
            // Set session
            $session_data = [
                'user_id'   => $user->id,
                'user_name' => $user->name,
                'user_email'=> $user->email,
                'logged_in' => TRUE,
            ];
            $this->session->set_userdata($session_data);
            redirect('dashboard');
        } else {
            $this->session->set_flashdata('error', 'Invalid email or password. Please try again.');
            redirect('auth/login');
        }
    }

    // ---------------------------------------------------------------
    // GET /auth/logout
    // ---------------------------------------------------------------
    public function logout()
    {
        $this->session->sess_destroy();
        redirect('auth/login');
    }
}
