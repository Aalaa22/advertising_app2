import 'dart:io';

import 'package:advertising_app/data/model/car_ad_model.dart';
import 'package:advertising_app/data/web_services/api_service.dart';


class CarAdRepository {
  final ApiService _apiService;
  CarAdRepository(this._apiService);

  // --- تم تحديث نوع الإرجاع (Return Type) للدالة ---
  Future<CarAdResponse> getCarAds({required String token}) async {
    final response = await _apiService.get('/api/car-sales-ads', token: token,);
    
    
    // 2. التأكد من أن الرد هو Map (لأنه يحتوي على 'data', 'current_page', etc.)
    if (response is Map<String, dynamic>) {
      // 3. تحويل الـ Map الكامل إلى كائن CarAdResponse باستخدام الـ factory constructor
      return CarAdResponse.fromJson(response);
    }
    
    // في حالة عدم تطابق شكل الرد، يتم إرسال خطأ
    throw Exception('API response format is not as expected.');
  }
  
  // دالة إنشاء الإعلان تبقى كما هي
  Future<void> createCarAd({
    required String title, required String description, required String make,
    required String model, String? trim, required String year, required String km,
    required String price, String? specs, String? carType, required String transType,
    String? fuelType, String? color, String? interiorColor, required bool warranty,
    String? engineCapacity, String? cylinders, String? horsepower, String? doorsNo,
    String? seatsNo, String? steeringSide, required String phoneNumber, String? whatsapp,
    required String emirate, required String area, required String advertiserType,
    required String advertiserName, required File mainImage,
    required List<File> thumbnailImages, required String token,
  }) async {
    final String warrantyValue = warranty ? '1' : '0';
    
    final Map<String, dynamic> textData = {
      'title': title, 'description': description, 'make': make, 'model': model,
      'trim': trim, 'year': year, 'km': km, 'price': price, 'specs': specs,
      'car_type': carType, 'trans_type': transType, 'fuel_type': fuelType,
      'color': color, 'interior_color': interiorColor, 
      'warranty': warrantyValue,
      'engine_capacity': engineCapacity, 'cylinders': cylinders, 'horsepower': horsepower,
      'doors_no': doorsNo, 'seats_no': seatsNo, 'steering_side': steeringSide,
      'advertiser_name': advertiserName, 'phone_number': phoneNumber, 'whatsapp': whatsapp,
      'emirate': emirate, 'area': area, 'advertiser_type': advertiserType,
    };

    await _apiService.postFormData(
      '/api/car-sales-ads',
      data: textData,
      mainImage: mainImage,
      thumbnailImages: thumbnailImages,
      token: token,
    );
  }
}