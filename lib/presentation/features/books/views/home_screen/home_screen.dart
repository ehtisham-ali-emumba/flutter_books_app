import 'package:books/components/shared_widgets/app_color_toggle.dart';
import 'package:books/core/constants/app_strings.dart';
import 'package:books/core/responsive/space.dart';
import 'package:books/presentation/features/books/views/home_screen/new_books_video_carousel.dart';
import 'package:books/presentation/features/books/views/home_screen/scifi_books_carousel.dart';
import 'package:flutter/material.dart';

import '../../../../../components/shared_widgets/app_dark_mode_toggle.dart';
import '../../../../../components/shared_widgets/app_drawer_icon.dart';
import 'bestseller_books_carousel.dart';
import 'history_books_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsetsGeometry.only(left: 0),
          child: AppDrawerIcon(),
        ),
        title: Text(AppStrings.appName),
        centerTitle: true,
        actions: [AppDarkModeToggle(), AppColorToggle()],
        actionsPadding: EdgeInsetsGeometry.only(right: 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Sp.h24,
            const NewBooksCarousel(),
            Sp.h16,
            const BestsellerBooksCarousel(),
            Sp.h16,
            const HistoryBooksCarousel(),
            Sp.h16,
            const SciFiBooksCarousel(),
          ],
        ),
      ),
    );
  }
}
