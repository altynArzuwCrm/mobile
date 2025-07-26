import 'package:crm/common/widgets/shimmer_image.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

  var num = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Товары',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(height: 20),
        MainCardWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageWithShimmer(imageUrl: img, width: 70, height: 70),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Siberia 800',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.accent,
                    overflow:TextOverflow.ellipsis
                  ),
                  maxLines: 2,
                ),
              ),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.orange),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          num--;
                        });
                      },
                      icon: Icon(Icons.remove, color: AppColors.orange),
                    ),
                    Text(
                      num.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: AppColors.accent,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          num++;
                        });
                      },
                      icon: Icon(Icons.add, color: AppColors.orange),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
