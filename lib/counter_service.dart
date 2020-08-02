import 'package:flutter/foundation.dart';

import 'counter.dart';
import 'notification_service.dart';


class CounterService {
  factory CounterService() => _instance;

  CounterService._internal();

  static final _instance = CounterService._internal();

  final _counter = Counter();

  ValueListenable<int> get count => _counter.count;

  void startCounting() {
    Stream.periodic(Duration(seconds: 20)).listen((_) {
      _counter.increment();

      Notification().initializing();
      Notification().showNotification();

      print('Counter incremented: ${_counter.count.value}');
    });
  }
}
