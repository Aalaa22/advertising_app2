import 'package:advertising_app/constants.dart';
import 'package:advertising_app/model/top_dealer_model.dart';
import 'package:flutter/material.dart';

class DealerCarCard extends StatelessWidget {
  final DealerCarModel car;

  const DealerCarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 129,
      height: 148,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              car.image,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            car.price,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          Text(
            car.name,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 12, color: KTextColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "${car.year}",
                style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(165, 164, 162, 1),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "${car.km} KM",
                style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(165, 164, 162, 1),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
