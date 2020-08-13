import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/models/model_user_function.dart';
import 'package:flutter_background/models/response_riwayat_peminjaman.dart';
import 'package:flutter_background/screens/halaman_root.dart';
import 'package:flutter_background/services/size_config.dart';
import 'package:flutter_background/services/api_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HalamanRiwayatPeminjaman extends StatefulWidget {
  static const String id = "HALAMANRIWAYATPEMINJAMAN";
  final BaseUser user;

  HalamanRiwayatPeminjaman({this.user}); 
  
  @override
  _HalamanRiwayatPeminjamanState createState() => _HalamanRiwayatPeminjamanState();
}

class _HalamanRiwayatPeminjamanState extends State<HalamanRiwayatPeminjaman> {
  
  SizeConfig sizeConfig;
  Apiservice apiservice;

  String namaMahasiswa = "";
  String idMahasiswa = "";

  final _rating = TextEditingController();
  final _komentar = TextEditingController();


  @override 
  void initState() {
    
    super.initState();

    apiservice = new Apiservice();
    _getIdentity();
    sizeConfig = new SizeConfig();    
  }

  _getIdentity() async {
    await widget.user.getCurrentUser().then((value) {
      setState(() {        
        idMahasiswa = value.data.mhsId;      
      });
    });    
  }


  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      appBar: appBar(),
      body: body(),
    );
  }

  Widget topBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: sizeConfig.getBlockHorizontal(2)),
      child: Row(
        children: <Widget>[
          Text(          
            "Riwayat Peminjaman",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: sizeConfig.getBlockHorizontal(5)),          
          ),
          Spacer(),
          CircleAvatar(
            backgroundImage: NetworkImage("https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png"),
          )
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xFF1E90FF),
      centerTitle: true,
      title: new Text("Library Client Apps", style: TextStyle(color: Colors.white)),      
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.getBlockHorizontal(2)),      
      child: Column(
        children: <Widget>[
          SizedBox(height: sizeConfig.getBlockHorizontal(5)),          
          topBar(context),
          SizedBox(height: sizeConfig.getBlockHorizontal(5)),
          Expanded(child: dataRecords()),
        ],
      ),
    );
  }

  Widget dataRecords() {
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: FutureBuilder<List<RecordRiwayatPeminjaman>>(
          future: Apiservice.peminjamanRiwayat(idMahasiswa),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('waiting data record future builder peminjaman on going');
              return CircularProgressIndicator();
            } else {
              print('completed data record future builder peminjaman on going');

              // siapkan variable penampung
              List<RecordRiwayatPeminjaman> listPeminjamanOnGoing = [];

              
              if (snapshot.data == null ) {

              } else {
                // assign hasil future query ke list records
                listPeminjamanOnGoing = snapshot.data;
              }

              print('panjang list riwayat peminnjaman: ');
              print(listPeminjamanOnGoing.length);

              return ListView.builder(
                itemCount: listPeminjamanOnGoing?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: item(listPeminjamanOnGoing[index]),
                    onTap: null,
                  );
                }
              );

            }
          },
        ),
      ),
    );
  }


  void tambahKomentar(String bukuId, String mhsId, String idPeminjaman) {

    Alert(
      context: context,
      title: "Survey buku",
      content: Column(
        children: <Widget>[
          TextField(
            controller: _rating,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              icon: Icon(Icons.text_fields),
              labelText: 'Rating buku (1 - 5)',
            ),
          ),

          TextField(
            controller: _komentar,
            decoration: InputDecoration(
              icon: Icon(Icons.text_fields),
              labelText: 'Komentar singkat',
            ),
          ),


        ],
      ),
    buttons: [
      DialogButton(
        // onPressed: printData,
        // onPressed: () => Navigator.pop(context),
        onPressed: () {
          printData(bukuId, mhsId, idPeminjaman);
        },
        child: Text(
          "Submit",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ]).show();
  }


  Widget printData(String bukuId, String idMhs, String idPeminjaman) {
    String ratingbuku = _rating.text;
    int rating = int.parse(ratingbuku);
    
    apiservice.postRatingKomentar(bukuId, idMhs, idPeminjaman, rating, _komentar.text);    
    // Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanPrint(idUser: idMhs, namaMhs: namaMhs, idBuku: widget.bukuId, judulBuku: namaBuku)));

    Navigator.pop(context);
    setState(() {
      
    });
    // return new HalamanRoot(user: widget.user);
    // Navigator.push(context,
    //   MaterialPageRoute(builder: (context) => HalamanRiwayatPeminjaman()) 
    // );

  }


  Widget item(RecordRiwayatPeminjaman object) {

    String tanggalPeminjaman = object.dataPeminjaman.tanggalPeminjaman.toString();
    tanggalPeminjaman = tanggalPeminjaman.substring(0, 16);

    var tanggalPengembalianDay = object.dataPeminjaman.tanggalPengembalian.day;
    var tanggalPengembalianMonth = object.dataPeminjaman.tanggalPengembalian.month;
    
    String tanggalPengembalian = object.dataPeminjaman.tanggalPengembalian.toString();
    tanggalPengembalian = tanggalPengembalian.substring(0, 16);

    var now = new DateTime.now();
    var nowDay = now.day;
    var nowMonth = now.month;

    String estimasiDay = "";
    if (tanggalPengembalianMonth >= nowMonth) {
      
      if (tanggalPengembalianDay > nowDay) {
        print(tanggalPengembalianDay - nowDay);
        estimasiDay = (tanggalPengembalianDay - nowDay).toString();
      } else if (tanggalPengembalianDay < nowDay) {
        var a = (30 - nowDay.toInt()) + tanggalPengembalianDay.toInt();
        estimasiDay = a.toString();
      }                 
    } 

    // Duration difference = now.difference(tanggalPengembalian);
    // print(tanggalPengembalian);
    // print(now);

    String judulBuku = object.detailBuku.judul;
  
    return Card(
      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
      elevation: 8,
      child: ListTile(
        // onTap: ,
        leading: Icon(
          Icons.subdirectory_arrow_right,
          color: Colors.lightGreen,
        ),
        title: Text(
          '$judulBuku',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: object.detailRating != null ? Text('Tanggal pengembalian: $tanggalPengembalian, sudah diberi ulasan') : Text('Tanggal pengembalian: $tanggalPengembalian, belum diberi ulasan'),
        // subtitle: Text('Tanggal pengembalian: $tanggalPengembalian'),
        isThreeLine: true,
        trailing: Text(
          "",
          style: TextStyle(color:Colors.orangeAccent),
        ),
        onTap: () {
          object.detailRating == null ? tambahKomentar(object.detailBuku.bukuId, object.detailMhs.mhsId, object.dataPeminjaman.idPeminjaman) : null;     
        }
      ),
    );
  }  

}


