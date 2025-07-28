import 'package:crm/common/widgets/shimmer_image.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({super.key});

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  var num = 1;


  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
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
    );
  }
}
