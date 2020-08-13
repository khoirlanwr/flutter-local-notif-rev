// To parse this JSON data, do
//
//     final responsePeminjamanOnGoing = responsePeminjamanOnGoingFromJson(jsonString);

import 'dart:convert';

ResponsePeminjamanOnGoing responsePeminjamanOnGoingFromJson(String str) => ResponsePeminjamanOnGoing.fromJson(json.decode(str));

String responsePeminjamanOnGoingToJson(ResponsePeminjamanOnGoing data) => json.encode(data.toJson());

class ResponsePeminjamanOnGoing {
    ResponsePeminjamanOnGoing({
        this.status,
        this.data,
        this.message,
    });

    bool status;
    Data data;
    String message;

    factory ResponsePeminjamanOnGoing.fromJson(Map<String, dynamic> json) => ResponsePeminjamanOnGoing(
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
        this.totalRecord,
        this.totalPage,
        this.records,
        this.offset,
        this.limit,
        this.page,
        this.prevPage,
        this.nextPage,
    });

    int totalRecord;
    int totalPage;
    List<RecordOnGoing> records;
    int offset;
    int limit;
    int page;
    int prevPage;
    int nextPage;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalRecord: json["total_record"],
        totalPage: json["total_page"],
        records: List<RecordOnGoing>.from(json["records"].map((x) => RecordOnGoing.fromJson(x))),
        offset: json["offset"],
        limit: json["limit"],
        page: json["page"],
        prevPage: json["prev_page"],
        nextPage: json["next_page"],
    );

    Map<String, dynamic> toJson() => {
        "total_record": totalRecord,
        "total_page": totalPage,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "offset": offset,
        "limit": limit,
        "page": page,
        "prev_page": prevPage,
        "next_page": nextPage,
    };
}

class RecordOnGoing {
    RecordOnGoing({
        this.dataPeminjaman,
        this.detailBuku,
        this.detailMhs,
    });

    DataPeminjaman dataPeminjaman;
    DetailBuku detailBuku;
    DetailMhs detailMhs;

    factory RecordOnGoing.fromJson(Map<String, dynamic> json) => RecordOnGoing(
        dataPeminjaman: DataPeminjaman.fromJson(json["data_peminjaman"]),
        detailBuku: DetailBuku.fromJson(json["detail_buku"]),
        detailMhs: DetailMhs.fromJson(json["detail_mhs"]),
    );

    Map<String, dynamic> toJson() => {
        "data_peminjaman": dataPeminjaman.toJson(),
        "detail_buku": detailBuku.toJson(),
        "detail_mhs": detailMhs.toJson(),
    };
}

class DataPeminjaman {
    DataPeminjaman({
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

    factory DataPeminjaman.fromJson(Map<String, dynamic> json) => DataPeminjaman(
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

class DetailBuku {
    DetailBuku({
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

    factory DetailBuku.fromJson(Map<String, dynamic> json) => DetailBuku(
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

class DetailMhs {
    DetailMhs({
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

    factory DetailMhs.fromJson(Map<String, dynamic> json) => DetailMhs(
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
