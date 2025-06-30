import 'package:flutter/material.dart';
import '../models/payment_model.dart';
import 'dio_client.dart';

class PaymentService with ChangeNotifier {
  final DioClient dioClient = DioClient();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<PaymentModel> _unconfirmedPayments = [];
  List<PaymentModel> get unconfirmedPayments => _unconfirmedPayments;

  Future<void> getUnconfirmedPayments() async {
    _isLoading = true;
    _unconfirmedPayments = [];
    notifyListeners();

    try {
      final response =
          await dioClient.client.get('/Payment/GetUnconfirmedPayments/1');

      if (response.statusCode == 200) {
        _unconfirmedPayments = paymentModelFromJson(response.data);
        // notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching unconfirmed payments: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> confirmPayment(int id) async {
    try {
      final response = await dioClient.client
          .get('/Payment/GetUnconfirmedPayments/??', data: {id: id});
      if (response.statusCode == 200) {}
    } catch (e) {
      debugPrint('Error get unconfirmed payments : $e');
    }
  }

  Future<void> paymentError(String deposit) async {
    try {
      final response =
          await dioClient.client.get('/Payment/GetUnconfirmedPayments/??');
      if (response.statusCode == 200) {}
    } catch (e) {
      debugPrint('Error get unconfirmed payments : $e');
    }
  }
}
