import 'package:advertising_app/model/ad_priority.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';

class CarRentModel implements FavoriteItemInterface {
  final String title;
  final String price;
  final String day_rent;
  final String month_rent;
  final String location;
  final String date;
  final String details;
  final String contact;
  final bool isPremium;
  final List<String> _images;
  final AdPriority priority;
  final String image;
  final String year;
  final String km;

  CarRentModel({
    required this.day_rent,
    required this.month_rent,
    required this.year,
    required this.km,
    required this.title,
    required this.contact,
    required this.price,
    required this.location,
    required this.image,
    required this.date,
    required this.details,
    required this.isPremium,
    required this.priority,
    required List<String> images,
  }) : _images = images;

  @override
  String get line1 => "Day Rent $day_rent  Month Rent $month_rent";

  @override
  List<String> get images => _images;
}
