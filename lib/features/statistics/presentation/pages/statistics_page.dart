import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/widgets/custom_dropdown.dart';
import 'package:crm/features/settings/presentation/widgets/tabbar_btn.dart';
import 'package:crm/features/statistics/presentation/cubits/last_activity/last_activity_cubit.dart';
import 'package:crm/features/statistics/presentation/cubits/order_stat/order_stat_cubit.dart';
import 'package:crm/features/statistics/presentation/cubits/user_stat/user_stat_cubit.dart';
import 'package:crm/features/statistics/presentation/pages/components/item1.dart';
import 'package:crm/features/statistics/presentation/pages/components/item3.dart';
import 'package:crm/features/statistics/presentation/widgets/card_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../cubits/revenue/revenue_stat_cubit.dart';
import 'components/item2.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final revenueCubit = locator<RevenueStatCubit>();
  final orderStatCubit = locator<OrderStatCubit>();
  final userStatCubit = locator<UserStatCubit>();
  final activityCubit = locator<LastActivityCubit>();

  final currentYear = DateTime.now().year;
  late List<int> availableYears;

  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    availableYears = List.generate(7, (i) => currentYear - 3 + i);

    _fetchAllStats();
  }

  void _fetchAllStats() async {
    revenueCubit.getRevenue(currentYear);
    orderStatCubit.getOrderStats();
    userStatCubit.getUserStats();
    activityCubit.getLastActivity();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: revenueCubit,
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),
            _buildTabBarHeader(),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),
            _buildTabBarView(),
            _buildActivityCard(),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    const titleStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      color: Colors.white,
    );
    const valueStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 23,
      color: Colors.white,
    );

    return SliverAppBar(
      backgroundColor: const Color(0xff1372F0),
      expandedHeight: 200,
      floating: true,
      pinned: true,
      leadingWidth: 100,
      leading: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
        child: SvgPicture.asset(ImageAssets.splashLogo,height: 20, width: 54,fit: BoxFit.contain,),
      ),
      actions: [
        const SizedBox(width: 7),
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: AppBarIcon(
            onTap: () => context.push(AppRoutes.notifications),
            icon: IconAssets.notifications,
            color: Colors.white,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff6FADFF), Color(0xff1372F0)],
            ),
          ),
          child: BlocBuilder<RevenueStatCubit, RevenueStatState>(
            builder: (context, state) {
              String totalRevenue = '0.0';
              int? year = currentYear;

              if (state is RevenueStatLoaded) {
                final data = state.data;
                totalRevenue = data.totalRevenueFormatted;
                year = int.tryParse(data.year);
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(AppStrings.allSum, style: titleStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$totalRevenue тмт'.toUpperCase(),
                        style: valueStyle,
                      ),
                      CustomDropdown<int>(
                        value: year,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.white,
                        ),
                        items: availableYears
                            .map(
                              (y) => DropdownMenuItem(
                            value: y,
                            child: Text(y.toString()),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            locator<RevenueStatCubit>().getRevenue(value);
                          }
                        },
                        color: const Color.fromRGBO(250, 250, 250, 0.7),
                        iconColor: Colors.white,
                      )

                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTabBarHeader() {
    return SliverToBoxAdapter(
      child: TabBarHeader(
        tabController: _tabController,
        tabBarColor: AppColors.white,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        tabs: const [
          Tab(
            child: Center(
              child: Text(
                AppStrings.revenue,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Tab(
            child: Center(
              child: Text(
                AppStrings.orders,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Tab(
            child: Center(
              child: Text(
                AppStrings.efficiency,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildTabBarView() {
    return SliverToBoxAdapter(
      child: Container(
        height: 375,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            Item1(),
            BlocProvider.value(value: orderStatCubit, child: Item2()),
            BlocProvider.value(value: userStatCubit, child: Item3()),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildActivityCard() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CardWidget(
          child: BlocProvider.value(
            value: activityCubit,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildActivityHeader(),
                const SizedBox(height: 10),
                const Divider(thickness: 1, color: AppColors.divider),
                const SizedBox(height: 10),
                _buildActivityListInsideCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityListInsideCard() {
    return BlocBuilder<LastActivityCubit, LastActivityState>(
      builder: (context, state) {
        if (state is LastActivityLoaded) {
          final data = state.data;

          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final activity = data[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  activity.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.darkBlue,
                  ),
                ),
                subtitle: Text(
                  activity.time,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.gray,
                  ),
                ),
                // trailing: const Icon(
                //   Icons.arrow_forward_ios_outlined,
                //   size: 16,
                // ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Row _buildActivityHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.lastActivity,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.accent,
          ),
        ),
        // TextButton(
        //   onPressed: () {
        //     context.push(AppRoutes.activities);
        //   },
        //   child: Text(
        //     AppStrings.all,
        //     style: const TextStyle(
        //       fontWeight: FontWeight.w400,
        //       fontSize: 14,
        //       color: AppColors.gray,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
