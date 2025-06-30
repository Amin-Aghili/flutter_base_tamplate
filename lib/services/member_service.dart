import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/member_model.dart';
import 'dio_client.dart';

class MemberService with ChangeNotifier {
  // final DioClient dioClient = DioClient();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<MemberModel> _memberList = [];
  List<MemberModel> get memberList => _memberList;

  Future<void> getMembers() async {
    _memberList = [
      MemberModel(
        memberId: 1,
        name: 'John Doe',
        phone: '1234567890',
        email: 'gmail.com',
        address: '123 Main St',
      )
    ];
    // Uncomment the following lines if you want to use DioClient for fetching data
    // _isLoading = true;
    // _memberList = [];
    // notifyListeners();

    // try {
    //   final response = await dioClient.client.get('/member');

    //   if (response.statusCode == 200) {
    //     _memberList = memberModelFromJson(response.data);
    //     // notifyListeners();
    //   }
    // } catch (e) {
    //   debugPrint('Error fetching Member: $e');
    // }
    // _isLoading = false;
    // notifyListeners();
  }
}
