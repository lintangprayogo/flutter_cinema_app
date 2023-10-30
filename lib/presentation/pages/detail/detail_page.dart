import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/presentation/misc/constants.dart';
import 'package:cinema_app/presentation/misc/methods.dart';
import 'package:cinema_app/presentation/pages/detail/method/background.dart';
import 'package:cinema_app/presentation/pages/detail/method/cast_and_crew.dart';
import 'package:cinema_app/presentation/pages/detail/method/movie_overview.dart';
import 'package:cinema_app/presentation/pages/detail/method/short_info.dart';
import 'package:cinema_app/presentation/providers/router/router_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/movie/movie_detail/movie_detail_provider.dart';
import 'package:cinema_app/presentation/widgets/back_navigation_bar.dart';
import 'package:cinema_app/presentation/widgets/network_image_widget_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  final Movie movie;
  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncMovieDetail = ref.watch(movieDetailProvider(movie: movie));

    return Scaffold(
      body: Stack(
        children: [
          ...background(movie),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackNavigationBar(
                      title: movie.title,
                      onTap: () => ref.read(routerProvider).pop(),
                    ),
                    verticalSpace(24),
                    NetworkImageCard(
                      width: MediaQuery.of(context).size.width - 48,
                      height: (MediaQuery.of(context).size.width - 48) * 0.6,
                      imageUrl: asyncMovieDetail.valueOrNull != null
                          ? "https://image.tmdb.org/t/p/w500/${asyncMovieDetail.value?.backdropPath ?? movie.posterPath}"
                          : null,
                      boxFit: BoxFit.cover,
                    ),
                    verticalSpace(24),
                    ...shortInfo(context: context, detail: asyncMovieDetail),
                    verticalSpace(20),
                    ...movieOverview(detail: asyncMovieDetail),
                    verticalSpace(24)
                  ],
                ),
              ),
              ...castAndCrew(ref: ref, movie: movie),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                child: ElevatedButton(
                    onPressed: () {
                      MovieDetail? detail = asyncMovieDetail.valueOrNull;

                      if (detail != null) {
                        ref
                            .read(routerProvider)
                            .pushNamed("booking", extra: detail);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: backgroundColor,
                        backgroundColor: saffron,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text("Buy a Ticket")),
              )
            ],
          )
        ],
      ),
    );
  }
}
