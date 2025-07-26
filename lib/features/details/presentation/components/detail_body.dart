// import 'dart:io';
//
// import 'package:crm/common/widgets/appbar_icon.dart';
// import 'package:crm/core/constants/colors/app_colors.dart';
// import 'package:crm/core/constants/strings/assets_manager.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class DetailBody extends StatelessWidget {
//   const DetailBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverOverlapAbsorber(
//       handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//       sliver: SliverAppBar(
//         toolbarHeight: 96,
//         iconTheme: const IconThemeData(color: AppColors.white),
//         automaticallyImplyLeading: true,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: Container(
//               margin: const EdgeInsets.only(top: 40.0),
//               padding: const EdgeInsets.only(top: 10),
//               child: Icon(Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,)
//
//           ),
//         ),
//         actions: [AppBarIcon(icon: IconAssets.edit, onTap: () {})],
//
//         primary: false,
//         pinned: true,
//         // expandedHeight: expandedHeight,
//         //580,
//         // expandedHeight: height,
//
//         flexibleSpace: FlexibleSpaceBar(
//           collapseMode: CollapseMode.pin,
//           stretchModes: const [StretchMode.zoomBackground],
//           background: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // SizedBox(height: 22),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(bookTitle,
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.titleLarge,
//                         maxLines: adjustedMaxLines,
//                         overflow: maxLines > 5
//                             ? TextOverflow.ellipsis
//                             : TextOverflow.clip),
//                     const SizedBox(height: 6),
//                     Text(
//                       author,
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         color: Theme.of(context)
//                             .colorScheme
//                             .onTertiaryContainer,
//                       ),
//                     ),
//                     const SizedBox(height: 14),
//                     InfoCardWidget(
//                       title1: bookLanguage,
//                       body1: AppLocalizations.of(context)!.languageOfBook,
//                       title2: totalPage.toString(),
//                       body2: AppLocalizations.of(context)!.page,
//                       title3: publishedYear.toString(),
//                       body3: AppLocalizations.of(context)!.yearOfPublication,
//                     ),
//                   ],
//                 ),
//               ),
//               // SizedBox(height: 20),
//               // Divider(thickness: 3,)
//             ],
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(55.0),
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               Container(
//                 height: 2.0,
//                 color: Theme.of(context).dividerColor,
//                 margin:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 2.5),
//               ),
//               CustomTabBar(
//                 isScrollable: false,
//                 indicatorPadding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
//                 selectedLabelColor:
//                 Theme.of(context).textTheme.bodyLarge!.color!,
//                 unSelectedLabelColor: Theme.of(context).secondaryHeaderColor,
//                 tabs: [
//                   Tab(
//                     text: AppLocalizations.of(context)!.annotation,
//                   ),
//                   Tab(
//                     text: AppLocalizations.of(context)!.content,
//                   ),
//                   Tab(
//                     text: AppLocalizations.of(context)!.comments,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
