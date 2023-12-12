import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

abstract class IEduService {
  //User
  Future<bool> register(RegisterUserRequest registerUserRequest);
  Future<bool> isExistUser(String username);
   Future<bool> login(String phoneNumber, String password);
}

class EduService extends IEduService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 
  @override
  Future<bool> register(RegisterUserRequest registerUserRequest) async {
   
      var isExist = await isExistUser(registerUserRequest.fullName);
      if (!isExist) {
        await _firestore.collection('Users').add(registerUserRequest.toJson());
        return true;
      } else {
        throw  Exception('User already exists');
      }
    
  }

  @override
  Future<bool> isExistUser(String username) async {  
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('fullName', isEqualTo: username)
          .get();
      return querySnapshot.docs.isNotEmpty;
   
  }
  
  @override
  Future<bool> login(String phoneNumber, String password)async {
  try {
    final prefs = await SharedPreferences.getInstance();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .where('password', isEqualTo: password)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final currentUser = querySnapshot.docs.first;
      final data = currentUser.data() as Map<String, dynamic>;  // Explicit cast to Map<String, dynamic>
      String? userId = data['id'];  // Accessing the property using the index operator on the casted map
      if (userId != null) {
        prefs.setString("id", userId);
        return true;
      } else {
        throw Exception('User ID not found in data');
      }
    } else {
      throw Exception('User not found');
    }
  } catch (e) {
    // Handle the error, you can log it or show a message to the user
   print(e);
    return false;
  }
    
  }
}
class UserInfo{
  String fullName;
  String phoneNumber;
  String address;
  String password;
  String userType;
  late String id=const Uuid().v4();
  String? parentId;
  UserInfo(
      {required this.fullName,
      required this.phoneNumber,
      required this.address,
      required this.password,
      required this.userType,     
      });
  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'address': address,
        'password': password,
        'userType': userType,
        'id':id,
        'parentId':parentId
      };
}
class RegisterUserRequest extends UserInfo {
  RegisterUserRequest({required super.fullName, required super.phoneNumber, required super.address, required super.password, required super.userType});
  
}
