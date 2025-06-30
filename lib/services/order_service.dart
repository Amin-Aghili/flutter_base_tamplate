import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/order_model.dart';
import 'package:flutter_base_template/services/dio_client.dart';

class OrderService with ChangeNotifier {
  final DioClient dioClient = DioClient();
  CancelToken? _cancelToken;

  List<OrderModel> _orders = [];
  List<OrderModel> _ordersByStatus = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<OrderModel> get orders => _orders;
  List<OrderModel> get ordersByStatus => _ordersByStatus;

  Future<void> fetchOrders() async {
    try {
      final response = await dioClient.client.get('/order');
      if (response.statusCode == 200) {
        _orders = orderModelFromJson(response.data);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching orders: $e');
    }
  }

  Future<void> fetchOrdersByStatus(int step) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    _isLoading = true;
    _ordersByStatus = [];
    notifyListeners();

    try {
      final response = await dioClient.client.get(
        '/order/$step',
        cancelToken: _cancelToken,
      );

      if (response.statusCode == 200) {
        _ordersByStatus = orderModelFromJson(response.data);
        // notifyListeners();
      }
    } catch (e) {
      if (e is DioException && CancelToken.isCancel(e)) {
        debugPrint('Request canceled');
        return;
      } else {
        debugPrint('Error fetching orders by step: $e');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void updateOrderStep({
    required int updateStep,
    required int orderDetailId,
    String? description,
    int? weight,
    String? trackingCode,
  }) async {
    final Map<String, dynamic> data = {
      "order_status_id": updateStep,
    };

    if (trackingCode != null) data["package_code"] = trackingCode;
    if (weight != null) data["weight"] = weight;
    if (description != null) data["description"] = description;

    try {
      final response = await dioClient.client.put(
        '/Order/UpdateOrder/$orderDetailId',
        data: json.encode(data),
      );

      if (response.statusCode == 200) {
        _ordersByStatus
            .removeWhere((item) => item.orderDetailId == orderDetailId);
        // todo fetch order
      }
    } catch (e) {
      debugPrint('Error update step : $e');
    }

    notifyListeners();
  }

  Future<void> cancelOrder(
      {required int orderDetailId, String? description = ""}) async {
    try {
      var data = json.encode({"description": description});
      final response = await dioClient.client
          .put('/Order/CancelOrder/$orderDetailId', data: data);
      if (response.statusCode == 200) {
        _ordersByStatus
            .removeWhere((order) => order.orderDetailId == orderDetailId);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting order: $e');
    }
  }

  void nextOrderStep(
    int step,
    int orderDetailId,
    String? description,
    int? weight,
    String trackingCode,
  ) async {
    var data = json.encode({
      "order_status_id": step + 1,
      "package_code": "aaa",
      "weight": 10,
      "description": "A"
    });
    try {
      final response = await dioClient.client
          .put('/Order/UpdateOrder/$orderDetailId', data: data);
      if (response.statusCode == 200) {
        _ordersByStatus
            .removeWhere((item) => item.orderDetailId == orderDetailId);
      }
    } catch (e) {
      debugPrint('Error Next step : $e');
    }

    notifyListeners();
  }

  void previousOrderStep(int orderDetailId, int step) async {
    final data = {
      "order_status_id": step - 1,
      "package_code": "aaa",
      "weight": 10,
      "description": "A",
    };
    try {
      final response = await dioClient.client
          .put('/Order/UpdateOrder/$orderDetailId', data: data);
      if (response.statusCode == 200) {
        _ordersByStatus
            .removeWhere((item) => item.orderDetailId == orderDetailId);
      }
    } catch (e) {
      debugPrint('Error Next step : $e');
    }
    notifyListeners();
  }
}
