import 'package:books/presentation/features/books/views/home_screen/app_color_toggle.dart';
import 'package:books/presentation/features/books/views/home_screen/scifi_books_carousel.dart';
import 'package:flutter/material.dart';

import 'app_dark_mode_toggle.dart';
import 'app_drawer_icon.dart';
import 'bestseller_books_carousel.dart';
import 'history_books_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppDrawerIcon(),
        title: Text("Books Home"),
        centerTitle: true,
        actions: [AppDarkModeToggle(), AppColorToggle()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            BestsellerBooksCarousel(),
            SizedBox(height: 20),
            HistoryBooksCarousel(),
            SizedBox(height: 20),
            SciFiBooksCarousel(),
          ],
        ),
      ),
    );
  }
}
