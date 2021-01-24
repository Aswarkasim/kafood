<?php

use Restserver\Libraries\REST_Controller;

defined('BASEPATH') or exit('No direct script access allowed');
require APPPATH . '/libraries/REST_Controller.php';

class User extends REST_Controller
{

  public function index_get()
  {
    $id_user = $this->get('id_user');
    $user = null;
    if ($id_user != '' || $id_user != null) {
      $this->db->where('id_user', $id_user);
      $user = $this->db->get('tbl_user')->result();
    } else {
      $user = $this->db->get('tbl_user')->result();
    }

    if ($user != null) {
      $this->response([
        'status'      => 'success',
        'error'       => false,
        'user'      => $user
      ], REST_Controller::HTTP_OK);
    } else {
      $this->response([
        'status'    => 'failed',
        'error'     => true
      ], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
    }
  }


  function index_post()
  {
    $this->load->library('upload');

    $id_user = $this->post('id_user');

    // $id_user = 'SYas5p4d';

    $this->db->where('id_user', $id_user);
    $user = $this->db->get('tbl_user')->row();

    $gambar = $user->gambar;
    if (!empty($_FILES['gambar']['name'])) {
      $config['upload_path']   = './assets/uploads/images/';
      $config['allowed_types'] = 'gif|jpg|png|svg|jpeg';
      $config['max_size']      = '24000'; // KB 
      $this->upload->initialize($config);
      if (!$this->upload->do_upload('gambar')) {
        $this->response(
          [
            'status'    => 'failed',
            'error'     => true,
            'message'   => 'Select File'
          ],
          REST_Controller::HTTP_INTERNAL_SERVER_ERROR
        );
      } else {

        if ($user->gambar != '') {
          unlink($user->gambar);
        }
        $upload_data = ['uploads' => $this->upload->data()];
        $gambar  = $config['upload_path'] . $upload_data['uploads']['file_name'];
      }
    }

    $data = [
      'id_user'       => $id_user,
      'username'         => $this->post('username'),
      'namalengkap'     => $this->post('namalengkap'),
      'password'           => sha1($this->post('password')),
      'alamat'        => $this->post('alamat'),
      'email'        => $this->post('email'),
      'no_hp'        => $this->post('no_hp'),
      'latitude'        => $this->post('latitude'),
      'longitude'        => $this->post('longitude'),
      'role'        => 'user',
      'is_active'        => 1,
      'gambar'          => $gambar
    ];
    $this->db->where('id_user', $id_user);
    $this->db->update('tbl_user', $data);

    $this->response([
      'status'    => 'success',
      'error'     => false,
      'message'   => 'Sukses mengubah data',
      'data'      => $data
    ], REST_Controller::HTTP_OK);
  }
}
