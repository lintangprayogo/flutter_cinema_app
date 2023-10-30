import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/presentation/misc/methods.dart';
import 'package:cinema_app/presentation/providers/movie/actors/actors_provider.dart';
import 'package:cinema_app/presentation/widgets/network_image_widget_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> castAndCrew({required WidgetRef ref, required Movie movie}) => [
      const Padding(
        padding: EdgeInsets.only(left: 24),
        child: Text(
          "Crews And Actors",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      verticalSpace(10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            horizontalSpace(24),
            ...(ref.watch(actorsProvider(movieId: movie.id)).whenOrNull(
                    data: (data) => data.map(
                          (actor) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NetworkImageCard(
                                    width: 100,
                                    height: 152,
                                    imageUrl: actor.profilePath != null
                                        ? "https://image.tmdb.org/t/p/w185/${actor.profilePath}"
                                        : null,
                                    boxFit: BoxFit.fill),
                                SizedBox(
                                    width: 100,
                                    child: Text(
                                      actor.name,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12),
                                    )),
                              ],
                            ),
                          ),
                        )) ??
                []),
            horizontalSpace(14),
          ],
        ),
      )
    ];
