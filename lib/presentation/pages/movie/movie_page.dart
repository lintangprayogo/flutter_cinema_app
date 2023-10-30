import 'package:cinema_app/presentation/misc/methods.dart';
import 'package:cinema_app/presentation/pages/movie/method/header_user_info.dart';
import 'package:cinema_app/presentation/pages/movie/method/movie_list.dart';
import 'package:cinema_app/presentation/pages/movie/method/promotion_list.dart';
import 'package:cinema_app/presentation/pages/movie/method/search_bar.dart';
import 'package:cinema_app/presentation/providers/movie/now_playing/now_playing_provider.dart';
import 'package:cinema_app/presentation/providers/movie/upcoming/upcoming_provider.dart';
import 'package:cinema_app/presentation/providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionImageFiles = const [
    "assets/buy1get1.jpg",
    "assets/popcorn.jpg"
  ];

  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerUserInfo(ref),
            verticalSpace(40),
            searchBar(context),
            verticalSpace(24),
            ...movieList(
              title: "Now Playing",
              movies: ref.watch(nowPlayingProvider),
              onTap: (movie) {
                ref.read(routerProvider).pushNamed('detail',extra: movie);
              },
            ),
            verticalSpace(30),
            ...promotionList(promotionImageFiles),
            verticalSpace(30),
            ...movieList(
              title: "Upcoming",
              movies: ref.watch(upcomingProvider),
            ),
            verticalSpace(100),
          ],
        )
      ],
    );
  }
}
