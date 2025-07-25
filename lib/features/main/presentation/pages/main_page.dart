import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
          child: SvgPicture.asset(IconAssets.mainLogo),
        ),

        actions: [
          AppBarIcon(onTap: () {}, icon: IconAssets.search),
          SizedBox(width: 7),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AppBarIcon(onTap: () {}, icon: IconAssets.notifications),
          ),
        ],
      ),

      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            margin: EdgeInsets.all(8),
            color: Colors.green,
          );
        },
      ),
    );
  }
}
