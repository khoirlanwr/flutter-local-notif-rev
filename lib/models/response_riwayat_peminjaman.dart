// To parse this JSON data, do
//
//     final responseRiwayatPeminjaman = responseRiwayatPeminjamanFromJson(jsonString);

import 'dart:convert';

ResponseRiwayatPeminjaman responseRiwayatPeminjamanFromJson(String str) => ResponseRiwayatPeminjaman.fromJson(json.decode(str));

String responseRiwayatPeminjamanToJson(ResponseRiwayatPeminjaman data) => json.encode(data.toJson());

class ResponseRiwayatPeminjaman {
    ResponseRiwayatPeminjaman({
        this.status,
        this.data,
        this.message,
    });

    bool status;
    Data data;
    String message;

    factory ResponseRiwayatPeminjaman.fromJson(Map<String, dynamic> json) => ResponseRiwayatPeminjaman(
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
    List<RecordRiwayatPeminjaman> records;
    int offset;
    int limit;
    int page;
    int prevPage;
    int nextPage;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalRecord: json["total_record"],
        totalPage: json["total_page"],
        records: List<RecordRiwayatPeminjaman>.from(json["records"].map((x) => RecordRiwayatPeminjaman.fromJson(x))),
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

class RecordRiwayatPeminjaman {
    RecordRiwayatPeminjaman({
        this.dataPeminjaman,
        this.detailBuku,
        this.detailMhs,
        this.detailRating,
    });

    DataPeminjaman dataPeminjaman;
    DetailBuku detailBuku;
    DetailMhs detailMhs;
    DetailRating detailRating;

    factory RecordRiwayatPeminjaman.fromJson(Map<String, dynamic> json) => RecordRiwayatPeminjaman(
        dataPeminjaman: DataPeminjaman.fromJson(json["data_peminjaman"]),
        detailBuku: DetailBuku.fromJson(json["detail_buku"]),
        detailMhs: DetailMhs.fromJson(json["detail_mhs"]),
        detailRating: json["detail_rating"] == null ? null : DetailRating.fromJson(json["detail_rating"]),
    );

    Map<String, dynamic> toJson() => {
        "data_peminjaman": dataPeminjaman.toJson(),
        "detail_buku": detailBuku.toJson(),
        "detail_mhs": detailMhs.toJson(),
        "detail_rating": detailRating == null ? null : detailRating.toJson(),
    };
}

class DataPeminjaman {
    DataPeminjaman({
        this.idPeminjaman,
        this.idBuku,
        this.judulBuku,
        this.idMhs,
        this.idRating,
        this.tanggalPeminjaman,
        this.tanggalPengembalian,
        this.tanggalKembali,
    });

    String idPeminjaman;
    String idBuku;
    String judulBuku;
    String idMhs;
    String idRating;
    DateTime tanggalPeminjaman;
    DateTime tanggalPengembalian;
    DateTime tanggalKembali;

    factory DataPeminjaman.fromJson(Map<String, dynamic> json) => DataPeminjaman(
        idPeminjaman: json["id_peminjaman"],
        idBuku: json["id_buku"],
        judulBuku: json["judul_buku"],
        idMhs: json["id_mhs"],
        idRating: json["id_rating"],
        tanggalPeminjaman: DateTime.parse(json["tanggal_peminjaman"]),
        tanggalPengembalian: DateTime.parse(json["tanggal_pengembalian"]),
        tanggalKembali: DateTime.parse(json["tanggal_kembali"]),
    );

    Map<String, dynamic> toJson() => {
        "id_peminjaman": idPeminjaman,
        "id_buku": idBuku,
        "judul_buku": judulBuku,
        "id_mhs": idMhs,
        "id_rating": idRating,
        "tanggal_peminjaman": tanggalPeminjaman.toIso8601String(),
        "tanggal_pengembalian": tanggalPengembalian.toIso8601String(),
        "tanggal_kembali": tanggalKembali.toIso8601String(),
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
    double rating;
    String judul;
    Edisi edisi;
    String pengarang;
    KotaTerbit kotaTerbit;
    String penerbit;
    String tahunTerbit;
    String isbn;
    String klasifikasi;
    String kategori;
    UmumRes umumRes;
    Bahasa bahasa;
    String deskripsi;
    String lokasi;
    String gambar;
    DateTime tanggalDitambahkan;
    int stok;

    factory DetailBuku.fromJson(Map<String, dynamic> json) => DetailBuku(
        bukuId: json["buku_id"],
        rating: json["rating"].toDouble(),
        judul: json["judul"],
        edisi: edisiValues.map[json["edisi"]],
        pengarang: json["pengarang"],
        kotaTerbit: kotaTerbitValues.map[json["kota_terbit"]],
        penerbit: json["penerbit"],
        tahunTerbit: json["tahun_terbit"],
        isbn: json["isbn"],
        klasifikasi: json["klasifikasi"],
        kategori: json["kategori"],
        umumRes: umumResValues.map[json["umum_res"]],
        bahasa: bahasaValues.map[json["bahasa"]],
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
        "edisi": edisiValues.reverse[edisi],
        "pengarang": pengarang,
        "kota_terbit": kotaTerbitValues.reverse[kotaTerbit],
        "penerbit": penerbit,
        "tahun_terbit": tahunTerbit,
        "isbn": isbn,
        "klasifikasi": klasifikasi,
        "kategori": kategori,
        "umum_res": umumResValues.reverse[umumRes],
        "bahasa": bahasaValues.reverse[bahasa],
        "deskripsi": deskripsi,
        "lokasi": lokasi,
        "gambar": gambar,
        "tanggal_ditambahkan": "${tanggalDitambahkan.year.toString().padLeft(4, '0')}-${tanggalDitambahkan.month.toString().padLeft(2, '0')}-${tanggalDitambahkan.day.toString().padLeft(2, '0')}",
        "stok": stok,
    };
}

enum Bahasa { INDONESIA, INGGRIS }

final bahasaValues = EnumValues({
    "Indonesia": Bahasa.INDONESIA,
    "Inggris": Bahasa.INGGRIS
});

enum Edisi { EMPTY, EDISI_KEDUA_JILID_1 }

final edisiValues = EnumValues({
    "Edisi kedua jilid 1": Edisi.EDISI_KEDUA_JILID_1,
    "": Edisi.EMPTY
});

enum KotaTerbit { YOGYAKARTA, JAKARTA, EMPTY }

final kotaTerbitValues = EnumValues({
    "": KotaTerbit.EMPTY,
    "Jakarta": KotaTerbit.JAKARTA,
    "Yogyakarta": KotaTerbit.YOGYAKARTA
});

enum UmumRes { UMUM, UMUM_RES_UMUM }

final umumResValues = EnumValues({
    "Umum": UmumRes.UMUM,
    "umum": UmumRes.UMUM_RES_UMUM
});

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
    Nama nama;
    TempatLahir tempatLahir;
    DateTime tanggalLahir;
    Email email;
    Password password;
    int active;

    factory DetailMhs.fromJson(Map<String, dynamic> json) => DetailMhs(
        mhsId: json["mhs_id"],
        nama: namaValues.map[json["nama"]],
        tempatLahir: tempatLahirValues.map[json["tempat_lahir"]],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        email: emailValues.map[json["email"]],
        password: passwordValues.map[json["password"]],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "mhs_id": mhsId,
        "nama": namaValues.reverse[nama],
        "tempat_lahir": tempatLahirValues.reverse[tempatLahir],
        "tanggal_lahir": tanggalLahir.toIso8601String(),
        "email": emailValues.reverse[email],
        "password": passwordValues.reverse[password],
        "active": active,
    };
}

enum Email { YOSITAMAYARATRI_STUDENT_PPNS_AC_ID }

final emailValues = EnumValues({
    "yositamayaratri@student.ppns.ac.id": Email.YOSITAMAYARATRI_STUDENT_PPNS_AC_ID
});

enum Nama { YOSITA_MAYARATRI }

final namaValues = EnumValues({
    "Yosita Mayaratri": Nama.YOSITA_MAYARATRI
});

enum Password { AUTH_GUARD_PROTECTED }

final passwordValues = EnumValues({
    "AuthGuard Protected!": Password.AUTH_GUARD_PROTECTED
});

enum TempatLahir { LAMONGAN }

final tempatLahirValues = EnumValues({
    "Lamongan": TempatLahir.LAMONGAN
});

class DetailRating {
    DetailRating({
        this.idRating,
        this.idPeminjaman,
        this.idBuku,
        this.idMhs,
        this.nama,
        this.rating,
        this.komentar,
        this.tanggal,
    });

    String idRating;
    String idPeminjaman;
    String idBuku;
    String idMhs;
    Nama nama;
    int rating;
    String komentar;
    DateTime tanggal;

    factory DetailRating.fromJson(Map<String, dynamic> json) => DetailRating(
        idRating: json["id_rating"],
        idPeminjaman: json["id_peminjaman"],
        idBuku: json["id_buku"],
        idMhs: json["id_mhs"],
        nama: namaValues.map[json["nama"]],
        rating: json["rating"],
        komentar: json["komentar"],
        tanggal: DateTime.parse(json["tanggal"]),
    );

    Map<String, dynamic> toJson() => {
        "id_rating": idRating,
        "id_peminjaman": idPeminjaman,
        "id_buku": idBuku,
        "id_mhs": idMhs,
        "nama": namaValues.reverse[nama],
        "rating": rating,
        "komentar": komentar,
        "tanggal": tanggal.toIso8601String(),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
