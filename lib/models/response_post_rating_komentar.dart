// To parse this JSON data, do
//
//     final responsePostRatingKomentar = responsePostRatingKomentarFromJson(jsonString);

import 'dart:convert';

ResponsePostRatingKomentar responsePostRatingKomentarFromJson(String str) => ResponsePostRatingKomentar.fromJson(json.decode(str));

String responsePostRatingKomentarToJson(ResponsePostRatingKomentar data) => json.encode(data.toJson());

class ResponsePostRatingKomentar {
    ResponsePostRatingKomentar({
        this.status,
        this.data,
        this.message,
    });

    bool status;
    Data data;
    String message;

    factory ResponsePostRatingKomentar.fromJson(Map<String, dynamic> json) => ResponsePostRatingKomentar(
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
    String nama;
    int rating;
    String komentar;
    DateTime tanggal;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idRating: json["id_rating"],
        idPeminjaman: json["id_peminjaman"],
        idBuku: json["id_buku"],
        idMhs: json["id_mhs"],
        nama: json["nama"],
        rating: json["rating"],
        komentar: json["komentar"],
        tanggal: DateTime.parse(json["tanggal"]),
    );

    Map<String, dynamic> toJson() => {
        "id_rating": idRating,
        "id_peminjaman": idPeminjaman,
        "id_buku": idBuku,
        "id_mhs": idMhs,
        "nama": nama,
        "rating": rating,
        "komentar": komentar,
        "tanggal": tanggal.toIso8601String(),
    };
}
