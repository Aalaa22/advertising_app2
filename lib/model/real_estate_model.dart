import 'package:advertising_app/model/favorite_item_interface_model.dart';

class RealEstateModel implements FavoriteItemInterface {
  final String title;
  final String price;
  final String size;
  final String details;
  final String contact;
  final String location;
  final String date;
  final bool isPremium;
  final List<String> _images;


  RealEstateModel({
    required this.title,
    required this.contact,
    required this.price,
    required this.size,
    required this.location,
    required this.date,
    required this.details,
    required this.isPremium,
  required List<String> images, 
  }) : _images = images;


  @override
  String get line1 => "Size: $size";

  @override
  String get line2 => details;

@override
  List<String> get images => _images; 
}
