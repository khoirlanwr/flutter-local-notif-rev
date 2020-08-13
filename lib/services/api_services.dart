import 'dart:convert';

import 'package:flutter_background/models/response_post_rating_komentar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_background/models/model_user_login.dart';
import 'package:flutter_background/models/response_peminjaman_ongoing.dart';
import 'package:flutter_background/models/response_post.dart';
import 'package:flutter_background/models/response_get_data_id.dart';
import 'package:flutter_background/models/response_post_user.dart';
import 'package:flutter_background/models/response_post_peminjaman.dart';
import 'package:flutter_background/models/response_register.dart';
import 'package:flutter_background/models/response_riwayat_peminjaman.dart';
import 'package:flutter_background/models/response_list_kategori.dart';
import 'package:flutter_background/models/response_kategori.dart';


class Apiservice {

  static final String _url = 'http://192.168.43.119:6996/perpustakaan/api/v1/data_buku';
  static final String _userURI = 'http://192.168.43.119:6996/perpustakaan/api/v1/data_mhs';
  static final String _urlPeminjaman = 'http://192.168.43.119:6996/perpustakaan/api/v1/peminjaman';
  static final String _urlKategori = 'http://192.168.43.119:6996/perpustakaan/api/v1/kategori';

  static String timeParser(String time) {
    String timeSubString1 = time.substring(0, 17);
    String timeFinal = timeSubString1 + "00Z";
    return timeFinal;
  }


  static Future<List<Record>> getDataBuku(int pageNumber, int bookSize) async {    
    List<Record> records = []; 
    final response = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/data_buku/list', body: {
      'page': pageNumber.toString(),
      'size': bookSize.toString()
    });


    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);

      print(json);
      ResponsePost responsePost = ResponsePost.fromJson(json);
      responsePost.data.records.forEach((value){
        print('rating');
        print(value.rating);
        records.add(value);  
      });

      print(records.length);
      return records;
    } else {
      return [];
    }
  }


  // Edited for search by judul buku
  static Future<List<Record>> searchBookByTitle(String keywords, int pageNumber, int bookSize) async {
    List<Record> records = [];
    Map data = {
      'search': keywords,
      'page': pageNumber.toString(),
      'size': bookSize.toString()
    };

    String bodyJson = json.encode(data);
    final response = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/data_buku/list', body: bodyJson);

    if (response.statusCode == 200) {
      print('status code == 200');
      final json = jsonDecode(response.body);
      print(json);
      
      ResponsePost responsePost = ResponsePost.fromJson(json);
      // ResponseSearchBook responseSearchBook = ResponseSearchBook.fromJson(json);

      // tambahkan setiap data hasil search ke records;
      responsePost.data.records.forEach((value) {
        print(value.judul);
        records.add(value);
      });

      print(records.length);
      return records;

    } else {
      print('status code != 200');
      return [];
    }
  }

  // Edited: for post data pinjam buku ke mariaDB
  Future<String> postPeminjamanBuku(String idBuku, String idMhs) async {
    String timeBorrowedBook = DateTime.now().toIso8601String();
    timeBorrowedBook = timeParser(timeBorrowedBook);    
    var now = new DateTime.now();
    var timeReturnedBook = now.add(new Duration(days: 14));
    String timeReturnedBooks = timeParser(timeReturnedBook.toIso8601String());

    Map data = {
      'id_buku': idBuku,
      'id_mhs': idMhs,
      'tanggal_peminjaman': timeBorrowedBook,
      'tanggal_pengembalian': timeReturnedBooks      
    };
    print(data['tanggal_peminjaman']);
    print(data['tanggal_pengembalian']);
    String bodyJson = json.encode(data);
    final response = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/peminjaman/pinjam', body: bodyJson);

    print('status code');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      ResponsePostPeminjaman responsePostPeminjaman = ResponsePostPeminjaman.fromJson(json);

      return responsePostPeminjaman.data.peminjaman.idPeminjaman;
    } else {
      return null;
    }   
  }

  // Edited: for post data buku
  // Future<ResponseCreateViewId> createRecord(String nama, String pengarang, String penerbit, String tahun, String stok) async {
  //   Map data = {
  //     'nama': nama,
  //     'pengarang': pengarang,
  //     'penerbit': penerbit,
  //     'tahun': tahun,
  //     'stok': int.parse(stok)
  //   };
    
  //   String bodyJson = json.encode(data);
  //   final response = await http.post('$_url/create', body: bodyJson);
  //   if (response.statusCode == 200) {

  //     final json = jsonDecode(response.body);
  //     // ResponsePost responsePost = ResponsePost.fromJson(json);
  //     ResponseCreateViewId responseCreateViewId = ResponseCreateViewId.fromJson(json);
            
  //     return responseCreateViewId;   
  //   } else {
  //     return null;
  //   }
  // }

  Future<ResponseGetDataId> getDataById(String bukuId) async {
    final response = await http.get('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/data_buku/view/$bukuId');
    
    print(response.statusCode);
    if (response.statusCode == 200) {

      // get pure json
      final json = jsonDecode(response.body);
      print(json);
      
      // convert to model space
      ResponseGetDataId responseGetDataId = ResponseGetDataId.fromJson(json);
      print('setelah masuk ke from json class');
      print(responseGetDataId.data.judul);

      
      return responseGetDataId;

    } else {
      return null;
    }
  }
  
  // Fungsi get data user 
  static Future<List<RecordMhs>> getDataUser() async {    
    List<RecordMhs> recordsMhs = [];
    final responseUser = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/data_mhs/list');

    if (responseUser.statusCode == 200) {
      final json_pure = jsonDecode(responseUser.body);
      ResponseGetDataUser responseGetDataUser = ResponseGetDataUser.fromJson(json_pure);
      
      responseGetDataUser.data.records.forEach((item) {
        recordsMhs.add(item);
      });

      return recordsMhs;       
    } else {
      return [];
    }
  }

  // Fungsi login user mahasiswa
  Future<ResponseUserLogin> loginUser(String username, String password) async {
    Map data = {
      'mhs_id': username,
      'password': password,
    };

    String bodyJson = json.encode(data) ;
    final response = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/data_mhs/login', body: bodyJson);
    
    if(response.statusCode == 200) {
      print("Status koneksi loginUser == 200");
      
      final json = jsonDecode(response.body);

      // print(json['status']);
      if (json['status'] == true) {
        ResponseUserLogin responseUserLogin = ResponseUserLogin.fromJson(json);      
        return responseUserLogin;
      } else {

      }

    } else {
      print('data tidak ditemukan');
      return null;
    }

  }

  Future<String> login(String username, String password) async {
    Map data = {
      'mhs_id': username,
      'password': password,
    };

    String bodyJson = json.encode(data) ;
    final response = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/data_mhs/login', body: bodyJson);
    
    String result = "";

    if(response.statusCode == 200) {
      print("Status koneksi loginUser == 200");
      
      final json = jsonDecode(response.body);

      print(json['status']);
      if (json['status'] == true) {
        ResponseUserLogin responseUserLogin = ResponseUserLogin.fromJson(json);      
        print(responseUserLogin);
        result = responseUserLogin.data.mhsId;
      } else {
        result = "404";
      }

      return result;

    } else {
      print('status koneksi gagal!');
      return null;
    }

  }


  Future<String> register(String idMhs, String password, String confirmPassword, String tglLahir) async {
    
    if (password != confirmPassword) {
      return "PasswordNotSame!";
    } else {

      Map data = {
        "mhs_id" : idMhs,
        "password": password,
        "tanggal_lahir": tglLahir  
      };  

      String bodyJson = json.encode(data);
      final response = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/data_mhs/register', body: bodyJson);
      
      if (response.statusCode == 200) {
        
        final json = jsonDecode(response.body);
        print(json);

        ResponseRegister responseRegister = ResponseRegister.fromJson(json);

        if (responseRegister.data.active == 1) {
          // maka berhasil register
          return "Akun berhasil diaktivasi!";
        } else {
          // maka gagal register
          return "Akun tidak ditemukan!";
        }
      } else {
        return null;
      }
    }
  } 


  // fungsi untuk cek user ada atau tidak
  Future<String> cekUser(String idMhs) async {
    final response = await http.get('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/data_mhs/view/$idMhs');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);

      // memakai register kelas karena strukturnya sama
      ResponseRegister responseCekUser = ResponseRegister.fromJson(json);
      if (responseCekUser.status == false) {
        return "false";
      } else {
        return responseCekUser.data.nama;
      }     
    } else {
      return "koneksi gagal!";
    }

  }

  Future<bool> postRatingKomentar(String idBuku, String idMhs, String idPeminjaman, int rating, String komentar) async {
    
    print('masuk fungsi api postRatingKomentar');
    
    Map data = {
      "id_buku": idBuku,
      "id_mhs": idMhs,
      "id_peminjaman": idPeminjaman,
      "rating": rating,
      "komentar": komentar
    };

    var bodyJson = jsonEncode(data);

    print(bodyJson);
    
    final response = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/data_buku/rating/create',     
    headers: {"Content-type": "application/json"}, 
    body: bodyJson);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      ResponsePostRatingKomentar responsePostRatingKomentar = ResponsePostRatingKomentar.fromJson(json);
      if (responsePostRatingKomentar.status == true) {
        print('status create rating dan komentar true');
        return true;
      } else {
        print('status create rating dan komentar false');
        return false;
      }
    } else {
      print('response status code not 200');
      return null;
    }
  }

  // Fungsi untuk melihat daftar buku yang sedang dipinjam
  static Future<List<RecordOnGoing>> peminjamanOnGoing(String idMhs) async {
    
    List<RecordOnGoing> records = [];
    Map data = {
      "id": idMhs,
      "page": "1",
      "size": "5"
    };

    var bodyJson = jsonEncode(data);
    final response = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/peminjaman/berlangsung',
    headers: {"Content-type": "application/json"}, 
    body: bodyJson);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // print('json: ');
      // print(json);

      ResponsePeminjamanOnGoing responsePost = ResponsePeminjamanOnGoing.fromJson(json);

      responsePost.data.records.forEach((value){
        records.add(value);
      });

      print("Panjang records: ");
      print(records.length);
      return records;      
    } else {
      return [];
    }
  }

  // Fungsi untuk melihat daftar buku yang sudah selesai dikembalikan
  static Future<List<RecordRiwayatPeminjaman>> peminjamanRiwayat(String idMahasiswa) async {
    List<RecordRiwayatPeminjaman> records = [];
    Map data = {
      "id": idMahasiswa,
      "page": "1",
      "size": "5"
    };

    var bodyJson = jsonEncode(data);
    final response = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/peminjaman/riwayat',
    headers: {"Content-type": "application/json"}, 
    body: bodyJson);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print('peminjaman riwayat status code 200');     
      print(json);

      ResponseRiwayatPeminjaman responseRiwayatPeminjaman = ResponseRiwayatPeminjaman.fromJson(json);

      responseRiwayatPeminjaman.data.records.forEach((value) {
        records.add(value);
      });

      print('panjang records peminjaman riwayat: ');
      print(records.length);
      return records;


    } else {
      return [];
    }
  } 

  // Edited for: return list of kategori buku
  static Future<List<Datum>> listKategori() async {
    
    List<Datum> records = [];
    final response = await http.get('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/kategori/list');

    if (response.statusCode == 200) {
      
      final json = jsonDecode(response.body);
      ResponseListKategori responseListKategori = ResponseListKategori.fromJson(json);

      responseListKategori.data.forEach((value){
        records.add(value);
      });

      return records;

    } else {
      return [];
    }

  }   


  // Edited for melihat data buku dalam kategori
  static Future<List<RecordKategori>> getDataBukuKategori(String kategori, String namaBuku, int pageNumber, int bookSize) async {    
    List<RecordKategori> records = []; 
    Map data = {
      'category': kategori,
      'search': namaBuku,
      'page': pageNumber.toString(),
      'size': bookSize.toString()
    };
    String bodyJson = jsonEncode(data);
    final response = await http.post('https://lib-ws-mdb.herokuapp.com/perpustakaan/api/v1/data_buku/list', body: bodyJson);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // print(json);
      ResponseKategori responseKategori = ResponseKategori.fromJson(json);
      // ResponsePost responsePost = ResponsePost.fromJson(json);
      responseKategori.data.records.forEach((value){
        records.add(value);  
      });

      // print(records.length);
      return records;
    } else {
      return [];
    }
  }



}