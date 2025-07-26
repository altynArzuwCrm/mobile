// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';
// import 'package:go_router/go_router.dart';
// import 'package:kitaphana/common/controllers/internet_bloc/internet_bloc.dart';
// import 'package:kitaphana/common/widgets/bottom_sheet_widget.dart';
// import 'package:kitaphana/common/widgets/error_widget.dart';
// import 'package:kitaphana/common/widgets/offline_widget.dart';
// import 'package:kitaphana/core/config/route/routes_path.dart';
// import 'package:kitaphana/core/utilities/get_file_format.dart';
// import 'package:kitaphana/core/utilities/share_book.dart';
// import 'package:kitaphana/features/auth/presentation/blocs/auth_bloc/user_auth_bloc.dart';
// import 'package:kitaphana/features/home/domain/entities/book_details/book_detials_entity.dart';
// import 'package:kitaphana/features/home/presentation/blocs/details/book_details/book_details_bloc.dart';
// import 'package:kitaphana/features/home/presentation/blocs/details/chapters_cubit/chapters_cubit.dart';
// import 'package:kitaphana/features/home/presentation/blocs/details/reading_settings/bg_color_cubit/bg_color_cubit.dart';
// import 'package:kitaphana/features/home/presentation/pages/details_page/widgets/bottom_btns.dart';
// import 'package:kitaphana/features/home/presentation/pages/details_page/widgets/not_logged_in_widget.dart';
// import 'package:kitaphana/features/my_books/presentation/blocs/download_epub/download_epub_cubit.dart';
// import 'package:kitaphana/features/my_books/presentation/blocs/downloaded_books/downloaded_books_bloc.dart';
// import 'package:kitaphana/features/my_books/presentation/blocs/my_reading_books/my_reading_book_bloc.dart';
// import 'package:kitaphana/features/reading_book/presentation/controller/reading_book_controller/reading_book_controller.dart';
// import 'package:kitaphana/features/review/presentation/cubit/review_cubit/review_cubit.dart';
// import 'package:kitaphana/features/review/presentation/pages/leave_review_page.dart';
// import 'package:kitaphana/features/review/presentation/pages/review_page.dart';
// import 'package:kitaphana/features/statistics/domain/usecases/add_to_statistics_usecase.dart';
// import 'package:kitaphana/features/statistics/presentation/blocs/statistics/statistics_bloc.dart';
// import 'package:kitaphana/locator.dart';
// import 'package:toastification/toastification.dart';
// import 'package:flutter/material.dart';
// import 'e_contents_list.dart';
// import 'widgets/annotation_widget.dart';
// import 'widgets/comment_btn.dart';
// import 'widgets/detail_appbar.dart';
// import 'widgets/download_toast.dart';
// import 'widgets/review_not_logged_in_btn.dart';
// import 'widgets/settings_dialog.dart';
// import 'widgets/tab_child_widget.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// List<String> images = [
//   'https://admin.turkmenmetbugat.gov.tm/storage/articles/92379/KuennL2HW9qvQZS2iWxpwzT6zwcJdrbMH8xItgUwnBIk3SCQSsdO3QAyaiGi.jpg',
//   'https://images.pexels.com/photos/27429933/pexels-photo-27429933.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load'
// ];
//
// class BookDetailsPage extends StatefulWidget {
//   const BookDetailsPage({super.key, required this.slug});
//
//   final String slug;
//
//   @override
//   State<BookDetailsPage> createState() => _BookDetailsPageState();
// }
//
// class _BookDetailsPageState extends State<BookDetailsPage> {
//   final ReviewCubit reviewCubit = locator<ReviewCubit>();
//   final bookDetailsBloc = locator<BookDetailsBloc>();
//   final EpubController epubController = EpubController();
//
//   int bookId = 0;
//   BookDetailsEntity? bookDetail;
//   List<String> downloadUrl = List.empty(growable: true);
//
//   @override
//   void initState() {
//     super.initState();
//     bookDetailsBloc.add(GetBookDetails(widget.slug));
//     locator<ReadingBookController>().checkIsLocal(widget.slug);
//     reviewCubit.getAllReviews(widget.slug);
//   }
//
//   @override
//   void dispose() {
//     bookId = 0;
//     locator<ChaptersCubit>().clear();
//     super.dispose();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     context.read<BgColorCubit>().initializeColor(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         body: BlocBuilder<BookDetailsBloc, BookDetailsState>(
//           bloc: bookDetailsBloc,
//           builder: (context, state) {
//          if (state is BookDetailsLoaded) {
//
//
//               return Column(
//                 children: [
//                   Expanded(
//                     child: NestedScrollView(
//                       floatHeaderSlivers: false,
//                       headerSliverBuilder:
//                           (BuildContext context, bool innerBoxIsScrolled) {
//                         return [
//                           BookDetailAppbar(
//                             image: bookImage,
//                             bookTitle: bookTitle,
//                             author: bookAuthor,
//                             bookLanguage: bookLanguage,
//                             totalPage: bookTotalPage,
//                             publishedYear: bookPublished,
//                             onSettings: () {
//                               _openSettings(context);
//                             },
//                             addBooks: addToMyBooks,
//                           )
//                         ];
//                       },
//                       body: TabBarView(
//                         children: [
//                           TabChildWidget(
//                             childKey:
//                             AppLocalizations.of(context)!.annotation,
//                             delegate: SliverList(
//                               delegate: SliverChildListDelegate([
//                                 AnnotationWidget(
//                                   annotation: annotation,
//                                   genres: genres,
//                                   authorName: bookAuthor,
//                                   authorSlug: authorSlug ?? '',
//                                   authorImage: authorImage,
//                                   audio: authorAudio ?? 0,
//                                   electronic: authorElectronic ?? 0,
//                                   sameBookIds: sameBookIds,
//                                   sameBookImages: sameBookImages,
//                                   sameBookTitles: sameBookTitles,
//                                   sameBookAuthors: sameBookAuthors,
//                                   sameBookSlugs: sameBookSlugs,
//                                   sameBooksLength: sameBooks.length,
//                                 ),
//                               ]),
//                             ),
//                           ),
//                           TabChildWidget(
//                             childKey: AppLocalizations.of(context)!.content,
//                             delegate: EContentsList(
//                               detailsEntity: book,
//                               bookUrl: bookUrl ?? '',
//                               isMainContent: true,
//                               chapters: children,
//                             ),
//                           ),
//                           TabChildWidget(
//                             childKey: AppLocalizations.of(context)!.comments,
//                             delegate: SliverPadding(
//                               padding: const EdgeInsets.only(top: 13),
//                               sliver: ReviewPage(
//                                 slug: widget.slug,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   BottomBtns(
//                     audio: bookAudio,
//                     electronic: bookElectronic,
//                     readingBtn: () {
//                       context.push(
//                         AppRoutes.epubReadingPage,
//                         extra: {
//                           'book': book,
//                           'bookUrl': bookUrl,
//                         },
//                       );
//                     },
//                     audioBtn: () {
//                       //  _openPlayer(context);
//                     },
//                   ),
//                 ],
//               );
//             } else {
//               return Scaffold(
//                   appBar: AppBar(),
//                   body: const Center(child: KErrorWidget()));
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//
// }