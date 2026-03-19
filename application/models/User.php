<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User extends CI_Model {

    protected $table = 'users';

    public function __construct()
    {
        parent::__construct();
        $this->load->database();
    }

    /**
     * Find a user by email address.
     *
     * @param  string $email
     * @return object|null
     */
    public function get_by_email($email)
    {
        return $this->db
                    ->where('email', $email)
                    ->get($this->table)
                    ->row();
    }

    /**
     * Find a user by primary key.
     *
     * @param  int $id
     * @return object|null
     */
    public function get_by_id($id)
    {
        return $this->db
                    ->where('id', $id)
                    ->get($this->table)
                    ->row();
    }
}
