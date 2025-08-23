import 'package:advertising_app/constant/string.dart';
import 'package:advertising_app/data/model/ad_priority.dart';

// 1. الموديل الرئيسي الذي يمثل كائن "data" في الـ JSON
class CarAdModel {
  final int id;
  final String title;
  final String description;
  final String make;
  final String model;
  final String? trim;
  final String year;
  final int km;
  final String price;
  final String? specs;
  final String? carType;
  final String transType;
  final String? fuelType;
  final String? color;
  final String? interiorColor;
  final bool warranty;
  final String? engineCapacity;
  final String? cylinders;
  final String? horsepower;
  final String? doorsNo;
  final String? seatsNo;
  final String? steeringSide;
  final String advertiserName;
  final String phoneNumber;
  final String? whatsapp;
  final String emirate;
  final String? area;
  final String? advertiserType;
  final String mainImage;
  final List<String> thumbnailImages;
  final String createdAt;
  final AdPriority priority;

  CarAdModel({
    required this.priority,
    required this.id,
    required this.title,
    required this.description,
    required this.make,
    required this.model,
    this.trim,
    required this.year,
    required this.km,
    required this.price,
    this.specs,
    this.carType,
    required this.transType,
    this.fuelType,
    this.color,
    this.interiorColor,
    required this.warranty,
    this.engineCapacity,
    this.cylinders,
    this.horsepower,
    this.doorsNo,
    this.seatsNo,
    this.steeringSide,
    required this.advertiserName,
    required this.phoneNumber,
    this.whatsapp,
    required this.emirate,
    this.area,
    this.advertiserType,
    required this.mainImage,
    required this.thumbnailImages,
    required this.createdAt,
  });

  factory CarAdModel.fromJson(Map<String, dynamic> json) {
    
    // --- هنا هو الإصلاح: إعادة بناء الرابط الكامل للصور ---
    // التأكد من أن المسار القادم من الـ API لا يبدأ بـ "/"
   const String storagePath = '/storage/';

    String sanitizePath(String? path) {
      if (path == null || path.isEmpty) return '';
      // إزالة أي شرطة مائلة في البداية لضمان عدم تكرارها
      return path.startsWith('/') ? path.substring(1) : path;
    }
    
    String mainImagePath = sanitizePath(json['main_image']);
    // 2. بناء الرابط الكامل: baseUrl + storagePath + imagePath
    String mainImageUrl = mainImagePath.isNotEmpty ? 'http://192.168.1.7:8000$storagePath$mainImagePath' : '';

    List<String> thumbnailUrls = (json['thumbnail_images'] as List<dynamic>?)
            ?.map((imgPath) => 'http://192.168.1.7:8000$storagePath${sanitizePath(imgPath)}')
            .toList() ?? [];
     AdPriority _getPriority(String? planType) {
      switch (planType) {
        case 'premium_star':
          return AdPriority.PremiumStar;
        case 'premium':
          return AdPriority.premium;
        case 'featured':
          return AdPriority.featured;
        default:
          return AdPriority.free;
      }
     


    }

    return CarAdModel(
      priority: _getPriority(json['plan_type']),
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      make: json['make'] ?? 'N/A',
      model: json['model'] ?? 'N/A',
      trim: json['trim'],
      year: json['year']?.toString() ?? 'N/A',
      km: json['km'] is int ? json['km'] : (int.tryParse(json['km'].toString()) ?? 0),
      price: json['price'] ?? '0.00',
      specs: json['specs'],
      carType: json['car_type'],
      transType: json['trans_type'] ?? 'N/A',
      fuelType: json['fuel_type'],
      color: json['color'],
      interiorColor: json['interior_color'],
      warranty: json['warranty'] ?? false,
      engineCapacity: json['engine_capacity']?.toString(),
      cylinders: json['cylinders']?.toString(),
      horsepower: json['horsepower']?.toString(),
      doorsNo: json['doors_no']?.toString(),
      seatsNo: json['seats_no']?.toString(),
      steeringSide: json['steering_side'],
      advertiserName: json['advertiser_name'] ?? 'N/A',
      phoneNumber: json['phone_number'] ?? 'N/A',
      whatsapp: json['whatsapp'],
      emirate: json['emirate'] ?? 'N/A',
      area: json['area'],
      advertiserType: json['advertiser_type'],
      mainImage: mainImageUrl,
      thumbnailImages: thumbnailUrls,
      createdAt: json['created_at'] ?? '',
    );
  }
}

// 2. موديل إضافي يمثل الاستجابة الكاملة (مع معلومات Pagination)
class CarAdResponse {
  final List<CarAdModel> ads;
  final int currentPage;
  final int lastPage;
  final int totalAds;

  CarAdResponse({
    required this.ads,
    required this.currentPage,
    required this.lastPage,
    required this.totalAds,
  });

  factory CarAdResponse.fromJson(Map<String, dynamic> json) {
    // تحويل كل عنصر في قائمة 'data' إلى CarAdModel
    var adList = (json['data'] as List<dynamic>?)
            ?.map((adJson) => CarAdModel.fromJson(adJson))
            .toList() ?? [];
    
    return CarAdResponse(
      ads: adList,
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      totalAds: json['total'] ?? 0,
    );
  }
}