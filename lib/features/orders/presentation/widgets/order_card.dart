import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_decorated_container/flutter_decorated_container.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      margin: EdgeInsets.only(bottom: 20, right: 25, left: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.white,
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightBlue,
                ),
                child: Row(
                  children: [
                    Text(
                      'Дизайн',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.blue,
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  border: Border.all(color: AppColors.blue, width: 2),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Название заказа',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.darkBlue,
                ),
              ),
              Text(
                'Проект',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.normalGray,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(color: AppColors.divider, thickness: 1),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Начало',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.normalGray,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '2d 4h',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Ответственный',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.normalGray,
                    ),
                  ),
                  SizedBox(height: 2),

                  Text(
                    'Марал Маралова',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Дедлайн',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.normalGray,
                    ),
                  ),
                  SizedBox(height: 2),

                  Text(
                    '1d 2h',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // DecoratedContainer(
              //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              //   strokeWidth: 1,
              //   dashSpace: 1,
              //   dashWidth: 1,
              //   cornerRadius: null,
              //   strokeColor: AppColors.black,
              //   child: Text(
              //     'В работе',
              //     style: TextStyle(
              //       fontWeight: FontWeight.w400,
              //       fontSize: 12,
              //       color: AppColors.black,
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,

                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Принять работу',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.green,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.red,style: BorderStyle.solid)
                ),
                child: Text(
                  'Отклонить',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Подробнее',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
