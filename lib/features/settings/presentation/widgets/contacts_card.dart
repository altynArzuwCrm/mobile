import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/presentation/pages/ui_model/user_ui_model.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.onTap,
    required this.onDelete,
    required this.data,
  });

  final VoidCallback onTap;
  final UserEntity data;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkBlue,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'delete') {
                    onDelete();
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      'Удалить',
                      style: TextStyle(color: AppColors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),


          Divider(color: AppColors.divider, thickness: 1),
          Text(
            AppStrings.phone,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.normalGray,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 4),
          Text(
            data.phone,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.primary,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          // SizedBox(height: 14),
          // if (data.email != null)
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         AppStrings.email,
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w400,
          //           color: AppColors.normalGray,
          //         ),
          //         overflow: TextOverflow.ellipsis,
          //         maxLines: 1,
          //       ),
          //       SizedBox(height: 4),
          //       Text(
          //         data.email ?? '',
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w400,
          //           color: AppColors.darkBlue,
          //         ),
          //         overflow: TextOverflow.ellipsis,
          //         maxLines: 1,
          //       ),
          //     ],
          //   ),
          // SizedBox(height: 14),
          // if (data.phone != null)
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       if (data.phone != null)
          //         Text(
          //           AppStrings.phone,
          //           style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w400,
          //             color: AppColors.normalGray,
          //           ),
          //           overflow: TextOverflow.ellipsis,
          //           maxLines: 1,
          //         ),
          //       SizedBox(height: 4),
          //       if (data.phone != null)
          //         Text(
          //           data.phone ?? '',
          //           style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.w400,
          //             color: AppColors.darkBlue,
          //           ),
          //           overflow: TextOverflow.ellipsis,
          //           maxLines: 1,
          //         ),
          //       SizedBox(height: 14),
          //       InkWell(
          //         onTap: onTap,
          //         //     (){
          //         //   context.push(AppRoutes.contactDetails);
          //         // },
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             Text(
          //               AppStrings.moreDetails,
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w400,
          //                 color: AppColors.primary,
          //               ),
          //               overflow: TextOverflow.ellipsis,
          //               maxLines: 1,
          //             ),
          //             SizedBox(width: 10),
          //             Padding(
          //               padding: const EdgeInsets.only(top: 4),
          //               child: Icon(
          //                 Icons.arrow_forward_ios_outlined,
          //                 size: 16,
          //                 color: AppColors.primary,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
        ],
      ),
    );
  }
}
