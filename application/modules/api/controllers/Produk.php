<?php

use Restserver\Libraries\REST_Controller;

defined('BASEPATH') or exit('No direct script access allowed');
require APPPATH . '/libraries/REST_Controller.php';


class Produk extends REST_Controller
{


  public function __construct()
  {
    parent::__construct();
  }

  public function index_get()
  {
    $id_user = $this->get('id_user');
    $produk = null;
    if ($id_user != '' || $id_user != null) {
      $this->db->where('id_user', $id_user);
      $produk = $this->db->get('tbl_produk')->result();
    } else {
      $produk = $this->db->get('tbl_produk')->result();
    }



    if ($produk != null) {
      $this->response([
        'status'      => 'success',
        'error'       => false,
        'produk'      => $produk
      ], REST_Controller::HTTP_OK);
    } else {
      $this->response([
        'status'    => 'failed',
        'error'     => true
      ], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
    }
  }


  public function index_post()
  {

    $this->load->library('upload');
    $this->load->helper('string');


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
        $upload_data = ['uploads' => $this->upload->data()];

        $data = [
          'id_produk'       => random_string(),
          'id_user'         => $this->post('id_user'),
          'nama_produk'     => $this->post('nama_produk'),
          'harga'           => $this->post('harga'),
          'kategori'        => $this->post('kategori'),
          'gambar'          => $config['upload_path'] . $upload_data['uploads']['file_name']
        ];
        $this->db->insert('tbl_produk', $data);

        $this->response([
          'status'    => 'success',
          'error'     => false,
          'message'   => 'Sukses menambahkan',
          'data'      => $data
        ], REST_Controller::HTTP_OK);
      }
    }
  }




  public function update_post()
  {

    $this->load->library('upload');

    $id_produk = $this->post('id_produk');

    // $id_produk = 'SYas5p4d';

    $this->db->where('id_produk', $id_produk);
    $produk = $this->db->get('tbl_produk')->row();


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
            'message'   => 'Select File',
            'produk'    => $produk
          ],
          REST_Controller::HTTP_INTERNAL_SERVER_ERROR
        );
      } else {

        if ($produk->gambar != '') {
          unlink($produk->gambar);
        }

        $upload_data = ['uploads' => $this->upload->data()];


        $data = [
          'id_produk'       => $id_produk,
          'id_user'         => $this->post('id_user'),
          'nama_produk'     => $this->post('nama_produk'),
          'harga'           => $this->post('harga'),
          'kategori'        => $this->post('kategori'),
          'gambar'          => $config['upload_path'] . $upload_data['uploads']['file_name']
        ];
        $this->db->where('id_produk', $id_produk);
        $this->db->update('tbl_produk', $data);

        $this->response([
          'status'    => 'success',
          'error'     => false,
          'message'   => 'Sukses mengubah data',
          'data'      => $data
        ], REST_Controller::HTTP_OK);
      }
    } else {
      $this->response(
        [
          'status'    => 'failed',
          'error'     => true,
          'message'   => 'Select File',
          'id_produk' => $id_produk,
          'produk'    => $produk
        ],
        REST_Controller::HTTP_INTERNAL_SERVER_ERROR
      );
    }
  }


  function index_delete()
  {
    $id_produk = $this->delete('id_produk');
    $this->db->where('id_produk', $id_produk);


    $produk = $this->db->get('tbl_produk')->row();
    // print_r($produk);
    // die;
    if ($produk->gambar != '') {
      unlink($produk->gambar);
    }
    $this->db->where('id_produk', $id_produk);
    $delete = $this->db->delete('tbl_produk');
    if ($delete) {
      $this->response([
        'status'    => 'success',
        'error'     => false,
        'message'   => 'Sukses menghapus'
      ], REST_Controller::HTTP_OK);
    } else {
      $this->response([
        'status'    => 'failed',
        'error'     => true,
        'message'   => 'Gagal menghapus'
      ], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
    }
  }
}
