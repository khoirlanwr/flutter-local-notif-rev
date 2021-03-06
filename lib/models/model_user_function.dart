import 'package:flutter_background/models/model_user_login.dart';
import 'package:flutter_background/services/api_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


abstract class BaseUser {

  Future<String> signIn(String username, String password);  // return berupa NRP mahasiswa
  Future<ResponseUserLogin> getCurrentUser();
  Future<void> signOut();

}

class User implements BaseUser {

  final storage = new FlutterSecureStorage();
  final Apiservice _api = new Apiservice(); 
  ResponseUserLogin _responseUserLogin = new ResponseUserLogin();
  bool _alreadyLogin = false;


  Future<String> signIn(String username, String password) async {
    // _responseUserLogin = await _api.loginUser(username, password);
    // if (_responseUserLogin.status == true) {
    //   await storage.write(key: "mhsId", value: _responseUserLogin.data.mhsId);
    //   await storage.write(key: "password", value: password);
    //   _alreadyLogin = true;
    // }  
      
    // return _responseUserLogin.data.mhsId;

    String result = await _api.login(username, password);
    
    if (result != "404") {
      await storage.write(key: "mhsId", value: result);
      await storage.write(key: "password", value: password);

      _responseUserLogin = await _api.loginUser(username, password);      
      _alreadyLogin = true;      
    }

    return result;
  }

  Future<ResponseUserLogin> getCurrentUser() async {
    
    String mhsIdFromStorage = await storage.read(key: "mhsId");
    String passwordFromText = await storage.read(key: "password");

    print('will enter if');

    if (_alreadyLogin) {
      
      print('already login');
      return _responseUserLogin;

    } else {
      print('not yet login');
      if ((mhsIdFromStorage != null) && (mhsIdFromStorage.length > 0)) {
        print(mhsIdFromStorage);
        _responseUserLogin = await _api.loginUser(mhsIdFromStorage, passwordFromText);
        return _responseUserLogin;
      } else {
        return null;
      }
    }
  }

  Future<String> getUser() async {
    String mhsIdFromStorage = await storage.read(key: "mhsId");
    return mhsIdFromStorage;
  }

  Future<void> signOut() async {
    await storage.delete(key: "mhsId");
    await storage.delete(key: 'password');
    _responseUserLogin = null;
    _alreadyLogin = false;    
  }

}
