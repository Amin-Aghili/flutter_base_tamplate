import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/shop_info_model.dart';
import 'package:flutter_base_template/services/dio_client.dart';

class ShopInfoService with ChangeNotifier {
  final DioClient dioClient = DioClient();
  ShopInfoModel? _shopInfo;
  final Map<String, bool> _loadingFields = {};

  ShopInfoModel? get shopInfo => _shopInfo;

  bool isFieldLoading(String fieldName) => _loadingFields[fieldName] ?? false;

  Future<void> getShopInfo() async {
    try {
      final response = await dioClient.client.get('/shop');
      if (response.statusCode == 200) {
        final dataParse = jsonDecode(response.data);
        _shopInfo = ShopInfoModel.fromJson(dataParse[0]);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('❌ خطا در گرفتن اطلاعات فروشگاه: $e');
    }
  }

  Future<void> updateShopInfo({
    required String fieldName,
    required dynamic newValue,
  }) async {
    _loadingFields[fieldName] = true;
    notifyListeners();

    Map<String, dynamic> data = {fieldName: newValue};

    try {
      final response = await dioClient.client.post(
        '/shop/UpdateShop',
        data: json.encode(data),
      );

      if (response.statusCode == 200) {
        await getShopInfo();
        debugPrint('✅ اطلاعات فروشگاه با موفقیت به‌روزرسانی شد');
      }
    } catch (e) {
      debugPrint('❌ خطا در به‌روزرسانی اطلاعات فروشگاه: $e');
    }

    _loadingFields[fieldName] = false;
    notifyListeners();
  }
}
