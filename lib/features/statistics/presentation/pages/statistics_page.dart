import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/core/network/internet_bloc/internet_bloc.dart';
import 'package:crm/features/orders/presentation/widgets/custom_dropdown.dart';
import 'package:crm/features/settings/presentation/widgets/tabbar_btn.dart';
import 'package:crm/features/statistics/presentation/pages/components/item1.dart';
import 'package:crm/features/statistics/presentation/pages/components/item3.dart';
import 'package:crm/features/statistics/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'components/item2.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // final statisticsBloc = locator<StatisticsBloc>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // statisticsBloc.setType(StatisticsTime.year);

    _tabController.addListener(fetchStatistics);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  fetchStatistics() {
    setState(() {
      // switch (_tabController.index) {
      //   case 0:
      //     statisticsBloc.setType(StatisticsTime.year);
      //
      //     break;
      //   case 1:
      //     statisticsBloc.setType(StatisticsTime.week);
      //
      //     break;
      //   case 2:
      //     statisticsBloc.setType(StatisticsTime.month);
      //
      //     break;
      //   default:
      //     statisticsBloc.setType(StatisticsTime.year);
      //
      //     break;
      // }
    });
  }

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xff1372F0),
            expandedHeight: 200.0,
            floating: true,
            pinned: true,
            leading: Container(
              margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: SvgPicture.asset(IconAssets.mainLogo),
            ),
            actions: [
              AppBarIcon(
                onTap: () {},
                icon: IconAssets.search,
                color: AppColors.white,
              ),
              SizedBox(width: 7),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: AppBarIcon(
                  onTap: () {
                    context.push(AppRoutes.notifications);
                  },
                  icon: IconAssets.notifications,
                  color: AppColors.white,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff6FADFF), Color(0xff1372F0)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Итого'.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '150 000 тмт'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 23,
                            color: Colors.white,
                          ),
                        ),
                        CustomDropdown(
                          value: selectedCategory,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          onChanged: (val) {
                            setState(() {
                              selectedCategory = val;
                            });
                          },
                          color: Color.fromRGBO(250, 250, 250, 0.7),
                          iconColor: Colors.white,
                          items: const [
                            DropdownMenuItem(value: 'a', child: Text("Week")),
                            DropdownMenuItem(value: 'l', child: Text("Month")),
                            DropdownMenuItem(value: 'm', child: Text("Year")),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset(IconAssets.increase),
                        SizedBox(width: 10),
                        Text(
                          '+1.7% ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Этот месяц ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: const SizedBox(height: 18)),

          SliverToBoxAdapter(
            child: TabBarHeader(
              tabController: _tabController,
              tabBarColor: AppColors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),

              tabs: [
                Tab(
                  child: Center(
                    child: Text(
                      'Выручка',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Tab(
                  child: Center(
                    child: Text(
                      'Заказы',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Tab(
                  child: Center(
                    child: Text(
                      'Эффективность',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 18)),
          SliverToBoxAdapter(
            child: BlocListener<InternetBloc, InternetState>(
              listener: (context, internetState) {
                if (internetState is InternetConnected) {
                  fetchStatistics();
                }
              },
              child: Container(
                height: 355 ,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [Item1(), Item2(), Item3()],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Последние заказы',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.accent,
                          ),
                        ),
                        Text(
                          'Все',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: AppColors.divider, thickness: 1),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        5,
                        (item) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Название заказа',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.darkBlue,
                            ),
                          ),
                          subtitle: Text(
                            'Ответственный',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.gray,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 80)),
        ],
      ),
    );
  }
}
