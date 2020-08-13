import 'package:flutter/foundation.dart';
import 'package:flutter_background/models/response_peminjaman_ongoing.dart';
import 'package:flutter_background/services/api_services.dart';
import 'counter.dart';
import 'notification_service.dart';
import 'package:flutter_background/models/model_user_function.dart';

class CounterService {
  factory CounterService() => _instance;

  CounterService._internal();

  static final _instance = CounterService._internal();

  final _counter = Counter();

  ValueListenable<int> get count => _counter.count;


  void startCounting() {
    Stream.periodic(Duration(minutes: 1)).listen((_) {
      _counter.increment();

      getPeminjamanOngoing();
      // LocalNotificationPlugin().initializing();
      // LocalNotificationPlugin().showNotification();

      print('Counter incremented: ${_counter.count.value}');
    });
  }

  void getPeminjamanOngoing() async {

    User user = new User();
    // dapatkan id mahasiswa
    // String mhsIdFromStorage = await storage.read(key: "mhsId");
    
    String id = await user.getUser();

    List<RecordOnGoing> records = await Apiservice.peminjamanOnGoing(id);
    

    // print("Hallo bro,,");


    // print(records);
    // print(records.length);
    LocalNotificationPlugin().initializing();

    if (records.length > 0) {
      
      String buku;
      List<String> bukus = [];

      // print()
      records.forEach((element) {         
        bukus.add(element.detailBuku.judul);
      });

      if (bukus.length == 1) {
        buku = bukus[0];
      } else {
        buku = bukus[0] + " dan " + bukus[1];
      } 

      LocalNotificationPlugin().showNotification("Jangan lupa mengembalikan $buku ya!");


    } 
  }

}
