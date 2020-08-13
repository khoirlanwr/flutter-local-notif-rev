// To parse this JSON data, do
//
//     final responseUserLogin = responseUserLoginFromJson(jsonString);

import 'dart:convert';

ResponseUserLogin responseUserLoginFromJson(String str) => ResponseUserLogin.fromJson(json.decode(str));

String responseUserLoginToJson(ResponseUserLogin data) => json.encode(data.toJson());

class ResponseUserLogin {
    ResponseUserLogin({
        this.status,
        this.data,
        this.message,
    });

    bool status;
    Data data;
    String message;

    factory ResponseUserLogin.fromJson(Map<String, dynamic> json) => ResponseUserLogin(
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
