import '../utils/ws_response.dart';

abstract class UserInterface{
  Future<WsResponse> login(String email, String password);
  Future<WsResponse> createUserInFirebase({required String email});
}