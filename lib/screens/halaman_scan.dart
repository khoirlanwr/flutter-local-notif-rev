import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background/models/response_get_data_id.dart';
import 'package:flutter_background/services/api_services.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter_background/models/model_user_function.dart';
import 'package:flutter_background/screens/halaman_pinjam.dart';
import 'package:flutter_background/services/size_config.dart';

SizeConfig sizeConfig = new SizeConfig();

class ScanScreen extends StatefulWidget {

  final BaseUser user;

  ScanScreen({this.user});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  Apiservice apiservice;  
  String barcode = "";

  @override 
  void initState() {
    super.initState();

    apiservice = new Apiservice();

    widget.user.getCurrentUser().then((user) {
      print(user.data.nama);
    });
    
  }

  Widget topBar(BuildContext context) {
    return Padding (
        padding: EdgeInsets.only(
          top:sizeConfig.getBlockVertical(0),
          left:sizeConfig.getBlockHorizontal(4),         
          right:sizeConfig.getBlockHorizontal(2)),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            "Scan your barcode.",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: sizeConfig.getBlockHorizontal(4)),          
          ),
          Spacer(),
          CircleAvatar(
            backgroundImage: NetworkImage("https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png"),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xfff9f9f9),
        centerTitle: true,
        title: new Text("Library Client Apps", style: TextStyle(color: Colors.black87)),                  
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            topBar(context),
            Padding(
              padding: EdgeInsets.all(0),
              child: Image.asset('images/character-illustration-people-with-creative.jpg', 
                width: sizeConfig.getBlockHorizontal(80), 
                height: sizeConfig.getBlockVertical(40)
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
              child: 
                InkWell(
                  splashColor: Color(0xFF1E90FF),
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(                    
                    width: sizeConfig.getBlockHorizontal(80),
                    height: sizeConfig.getBlockVertical(7),
                    padding: EdgeInsets.symmetric(vertical: sizeConfig.getBlockVertical(0), horizontal: sizeConfig.getBlockHorizontal(20)),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E90FF),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: ListTile(
                      title: Text('Scan barcode', style: TextStyle(color: Colors.white, fontSize: sizeConfig.getBlockHorizontal(5))),                      
                    ),
                  ),
                  onTap: () {                    
                    scan();
                  },
                ) 
            ),
          ],
        ),
      )
    );
  }

  Future<Widget> scan() async {
    barcode = await scanner.scan();

    toPinjamPage(barcode);

    ResponseGetDataId responseGetDataId = await apiservice.getDataById(barcode);
    
    if (responseGetDataId.status == false) {
      // maka tampilkan alert
      print('alert!!!, status false');
    } else {
      Navigator.push(context, 
      MaterialPageRoute(builder: (context) => HalamanPinjam(bukuId: barcode, user: widget.user, record: responseGetDataId)));

    }

    // if (responseGetDataId.status == false) {
    //   // maka tampilkan alert
    // } else {
    //         Navigator.push(context, 
    //           MaterialPageRoute(builder: (context) => HalamanPinjam(bukuId: barcode, user: widget.user, record: responseGetDataId)));
    // }

    // FutureBuilder<ResponseGetDataId>(
    //   future: apiservice.getDataById(barcode),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       print('masuk ConnectionState.waiting');
    //       return CircularProgressIndicator();
    //     } else {
    //       bool status = snapshot.data.status;
    //       print('masuk ke status $status');

    //       if (status == false) {
    //         // maka tampilkan alert
    //       } else {
    //         // maka return ke halamanpinjam
    //         ResponseGetDataId record;
    //         record = snapshot.data;
    
    //         Navigator.push(context, 
    //           MaterialPageRoute(builder: (context) => HalamanPinjam(bukuId: barcode, user: widget.user, record: record)));

    //       }
    //     }
    //   }
    // );

    // Navigator.push(context, 
    //   MaterialPageRoute(builder: (context) => HalamanPinjam(bukuId: barcode, user: widget.user)));
  }

  Widget toPinjamPage(String idBuku) {  
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: FutureBuilder<ResponseGetDataId>(
          future: apiservice.getDataById(idBuku),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('waiting data record future builder toPinjamPage');
              return Container(
                height: 0,
                width: 0,
              );

            } else {
              print('completed data record future builder toPinjamPage');

              ResponseGetDataId responseGetDataId = snapshot.data;

              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => HalamanPinjam(bukuId: barcode, user: widget.user, record: responseGetDataId)));
            }
          },
        ),
      ),
    );

  }

}