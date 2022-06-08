import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{

  static String sharedpreferenceLoginKey ="isLoding";
  static String sharedpreferenceuserNameKey ="USERNAMEKEY";
  static String sharedprefereceuserEmailKey="USEREMAILKEY";

  // save data to sheredpreference
  static Future<bool> saveuserLoginsheredpreference( bool isUserLoggedin) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setBool(sharedpreferenceLoginKey, isUserLoggedin);

  }

  static Future<bool> saveusernamesheredpreference( String userName) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceuserNameKey, userName);

  }

  static Future<bool> saveUserEmailSharedPreference( String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceuserNameKey, userEmail);
  }

  // get data from sharedpreferances
  static Future<bool?> getuserLoginsheredpreference( ) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.getBool(sharedpreferenceLoginKey,);

  }


  static Future<String?> getuserNamesheredpreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedpreferenceuserNameKey, );
  }

  static Future<String?> getuserEmailsheredpreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedprefereceuserEmailKey, );
  }
  }