import 'dart:io';

import 'package:advertising_app/data/model/car_ad_model.dart';
import 'package:advertising_app/data/repository/car_sales_ad_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CarAdProvider with ChangeNotifier {
  final CarAdRepository _carAdRepository;
  CarAdProvider(this._carAdRepository);
  
  // --- متغيرات الحالة الخاصة بـ **إنشاء** إعلان ---
  bool _isCreatingAd = false;
  String? _createAdError;
  bool get isCreatingAd => _isCreatingAd;
  String? get createAdError => _createAdError;
  
  // --- متغيرات الحالة الخاصة بـ **جلب** الإعلانات ---
  bool _isLoadingAds = false;
  String? _loadAdsError;
  List<CarAdModel> _carAds = [];
  int _totalAds = 0;
  
  bool get isLoadingAds => _isLoadingAds;
  String? get loadAdsError => _loadAdsError;
  List<CarAdModel> get carAds => _carAds;
  int get totalAds => _totalAds;

  // دالة إنشاء الإعلان: تستخدم _isCreatingAd و _createAdError
  Future<bool> submitCarAd({
    required String title, required String description, required String make,
    required String model, String? trim, required String year, required String km,
    required String price, String? specs, String? carType, required String transType,
    String? fuelType, String? color, String? interiorColor, required bool warranty,
    String? engineCapacity, String? cylinders, String? horsepower, String? doorsNo,
    String? seatsNo, String? steeringSide, required String phoneNumber, String? whatsapp,
    required String emirate, required String area, required String advertiserType,
    required String advertiserName, required File mainImage,
    required List<File> thumbnailImages,
  }) async {
    _createAdError = null;
    _isCreatingAd = true;
    notifyListeners();

    try {
      final token = await const FlutterSecureStorage().read(key: 'auth_token');
      if (token == null) {
        throw Exception('Authentication token not found. Please log in again.');
      }
      
      await _carAdRepository.createCarAd(
        title: title, description: description, make: make, model: model, trim: trim, year: year, km: km, price: price,
        specs: specs, carType: carType, transType: transType, fuelType: fuelType, color: color, interiorColor: interiorColor,
        warranty: warranty, engineCapacity: engineCapacity, cylinders: cylinders, horsepower: horsepower, doorsNo: doorsNo,
        seatsNo: seatsNo, steeringSide: steeringSide, advertiserName: advertiserName, phoneNumber: phoneNumber,
        whatsapp: whatsapp, emirate: emirate, area: area, advertiserType: advertiserType,
        mainImage: mainImage, thumbnailImages: thumbnailImages, token: token
      );

      _isCreatingAd = false;
      notifyListeners();
      return true;
    } catch (e) {
      print("Error submitting car ad: $e");
      _createAdError = e.toString();
      _isCreatingAd = false;
      notifyListeners();
      return false;
    }
  }
  
  // دالة جلب الإعلانات: تستخدم _isLoadingAds و _loadAdsError
   Future<void> fetchCarAds() async {
    if (_isLoadingAds && _carAds.isNotEmpty) return; // منع التحديث إذا كان جارياً بالفعل
    
    _isLoadingAds = true;
    _loadAdsError = null;
    notifyListeners();

    try {
      // 1. قراءة التوكن من التخزين الآمن
      final token = await const FlutterSecureStorage().read(key: 'auth_token');
      if (token == null) {
        throw Exception('User is not authenticated (token is missing).');
      }

      // 2. استدعاء دالة الـ Repository مع تمرير التوكن
      final response = await _carAdRepository.getCarAds(token: token);
      
      _carAds = response.ads;
      _totalAds = response.totalAds;

    } catch (e) {
      print("Error fetching car ads: $e");
      _loadAdsError = e.toString();
    } finally {
      _isLoadingAds = false;
      notifyListeners();
    }
  }





}