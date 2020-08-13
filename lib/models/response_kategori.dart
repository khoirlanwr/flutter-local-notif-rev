// To parse this JSON data, do
//
//     final responseKategori = responseKategoriFromJson(jsonString);

import 'dart:convert';

ResponseKategori responseKategoriFromJson(String str) => ResponseKategori.fromJson(json.decode(str));

String responseKategoriToJson(ResponseKategori data) => json.encode(data.toJson());

class ResponseKategori {
    ResponseKategori({
        this.status,
        this.data,
        this.message,
    });

    bool status;
    Data data;
    String message;

    factory ResponseKategori.fromJson(Map<String, dynamic> json) => ResponseKategori(
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
    List<RecordKategori> records;
    int offset;
    int limit;
    int page;
    int prevPage;
    int nextPage;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalRecord: json["total_record"],
        totalPage: json["total_page"],
        records: List<RecordKategori>.from(json["records"].map((x) => RecordKategori.fromJson(x))),
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

class RecordKategori {
    RecordKategori({
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
    String edisi;
    String pengarang;
    String kotaTerbit;
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

    factory RecordKategori.fromJson(Map<String, dynamic> json) => RecordKategori(
        bukuId: json["buku_id"],
        rating: json["rating"].toDouble(),
        judul: json["judul"],
        edisi: json["edisi"],
        pengarang: json["pengarang"],
        kotaTerbit: json["kota_terbit"],
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
        "edisi": edisi,
        "pengarang": pengarang,
        "kota_terbit": kotaTerbit,
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

enum UmumRes { UMUM, UMUM_RES_UMUM }

final umumResValues = EnumValues({
    "Umum": UmumRes.UMUM,
    "umum": UmumRes.UMUM_RES_UMUM
});

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
