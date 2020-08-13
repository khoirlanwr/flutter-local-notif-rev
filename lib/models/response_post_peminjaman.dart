// To parse this JSON data, do
//
//     final responsePostPeminjaman = responsePostPeminjamanFromJson(jsonString);

import 'dart:convert';

ResponsePostPeminjaman responsePostPeminjamanFromJson(String str) => ResponsePostPeminjaman.fromJson(json.decode(str));

String responsePostPeminjamanToJson(ResponsePostPeminjaman data) => json.encode(data.toJson());

class ResponsePostPeminjaman {
    ResponsePostPeminjaman({
        this.status,
        this.data,
        this.message,
    });

    bool status;
    Data data;
    String message;

    factory ResponsePostPeminjaman.fromJson(Map<String, dynamic> json) => ResponsePostPeminjaman(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        this.buku,
        this.mahasiswa,
        this.peminjaman,
    });

    Buku buku;
    Mahasiswa mahasiswa;
    Peminjaman peminjaman;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        buku: Buku.fromJson(json["buku"]),
        mahasiswa: Mahasiswa.fromJson(json["mahasiswa"]),
        peminjaman: Peminjaman.fromJson(json["peminjaman"]),
    );

    Map<String, dynamic> toJson() => {
        "buku": buku.toJson(),
        "mahasiswa": mahasiswa.toJson(),
        "peminjaman": peminjaman.toJson(),
    };
}

class Buku {
    Buku({
        this.bukuId,
        this.rating,
        this.judul,
        this.edisi,
        this.pengarang,
        this.kotaTerbit,
        this.penerbit,
        this.tahunTerbit,
        this.isbn,
        this.klasifikasi,
        this.kategori,
        this.umumRes,
        this.bahasa,
        this.deskripsi,
        this.lokasi,
        this.gambar,
        this.tanggalDitambahkan,
        this.stok,
    });

    String bukuId;
    int rating;
    String judul;
    String edisi;
    String pengarang;
    String kotaTerbit;
    String penerbit;
    String tahunTerbit;
    String isbn;
    String klasifikasi;
    String kategori;
    String umumRes;
    String bahasa;
    String deskripsi;
    String lokasi;
    String gambar;
    DateTime tanggalDitambahkan;
    int stok;

    factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        bukuId: json["buku_id"],
        rating: json["rating"],
        judul: json["judul"],
        edisi: json["edisi"],
        pengarang: json["pengarang"],
        kotaTerbit: json["kota_terbit"],
        penerbit: json["penerbit"],
        tahunTerbit: json["tahun_terbit"],
        isbn: json["isbn"],
        klasifikasi: json["klasifikasi"],
        kategori: json["kategori"],
        umumRes: json["umum_res"],
        bahasa: json["bahasa"],
        deskripsi: json["deskripsi"],
        lokasi: json["lokasi"],
        gambar: json["gambar"],
        tanggalDitambahkan: DateTime.parse(json["tanggal_ditambahkan"]),
        stok: json["stok"],
    );

    Map<String, dynamic> toJson() => {
        "buku_id": bukuId,
        "rating": rating,
        "judul": judul,
        "edisi": edisi,
        "pengarang": pengarang,
        "kota_terbit": kotaTerbit,
        "penerbit": penerbit,
        "tahun_terbit": tahunTerbit,
        "isbn": isbn,
        "klasifikasi": klasifikasi,
        "kategori": kategori,
        "umum_res": umumRes,
        "bahasa": bahasa,
        "deskripsi": deskripsi,
        "lokasi": lokasi,
        "gambar": gambar,
        "tanggal_ditambahkan": "${tanggalDitambahkan.year.toString().padLeft(4, '0')}-${tanggalDitambahkan.month.toString().padLeft(2, '0')}-${tanggalDitambahkan.day.toString().padLeft(2, '0')}",
        "stok": stok,
    };
}

class Mahasiswa {
    Mahasiswa({
        this.mhsId,
        this.nama,
        this.tempatLahir,
        this.tanggalLahir,
        this.email,
        this.password,
        this.active,
    });

    String mhsId;
    String nama;
    String tempatLahir;
    DateTime tanggalLahir;
    String email;
    String password;
    int active;

    factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        mhsId: json["mhs_id"],
        nama: json["nama"],
        tempatLahir: json["tempat_lahir"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        email: json["email"],
        password: json["password"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "mhs_id": mhsId,
        "nama": nama,
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": tanggalLahir.toIso8601String(),
        "email": email,
        "password": password,
        "active": active,
    };
}

class Peminjaman {
    Peminjaman({
        this.idPeminjaman,
        this.idBuku,
        this.judulBuku,
        this.idMhs,
        this.tanggalPeminjaman,
        this.tanggalPengembalian,
        this.tanggalKembali,
        this.pengembalian,
    });

    String idPeminjaman;
    String idBuku;
    String judulBuku;
    String idMhs;
    DateTime tanggalPeminjaman;
    DateTime tanggalPengembalian;
    DateTime tanggalKembali;
    int pengembalian;

    factory Peminjaman.fromJson(Map<String, dynamic> json) => Peminjaman(
        idPeminjaman: json["id_peminjaman"],
        idBuku: json["id_buku"],
        judulBuku: json["judul_buku"],
        idMhs: json["id_mhs"],
        tanggalPeminjaman: DateTime.parse(json["tanggal_peminjaman"]),
        tanggalPengembalian: DateTime.parse(json["tanggal_pengembalian"]),
        tanggalKembali: DateTime.parse(json["tanggal_kembali"]),
        pengembalian: json["pengembalian"],
    );

    Map<String, dynamic> toJson() => {
        "id_peminjaman": idPeminjaman,
        "id_buku": idBuku,
        "judul_buku": judulBuku,
        "id_mhs": idMhs,
        "tanggal_peminjaman": tanggalPeminjaman.toIso8601String(),
        "tanggal_pengembalian": tanggalPengembalian.toIso8601String(),
        "tanggal_kembali": tanggalKembali.toIso8601String(),
        "pengembalian": pengembalian,
    };
}
