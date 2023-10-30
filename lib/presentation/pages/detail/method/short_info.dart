import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/presentation/misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> shortInfo(
        {required BuildContext context,
        required AsyncValue<MovieDetail?> detail}) =>
    [
      Row(
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset("assets/duration.png"),
          ),
          horizontalSpace(5),
          SizedBox(
              width: 95,
              child: Text("${detail.when(
                data: (data) => (data?.runtime ?? 0).toString(),
                error: (error, stackTrace) => '-',
                loading: () => '-',
              )} Minutes")),
          horizontalSpace(5),
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset("assets/genre.png"),
          ),
          horizontalSpace(5),
          SizedBox(
            width: MediaQuery.of(context).size.width -
                48 -
                95 -
                14 -
                14 -
                5 -
                5 -
                5,
            child: detail.when(
              data: (data) {
                String genres = data?.genres.join(",") ?? "-";
                return Text(
                  genres,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                );
              },
              error: (error, stackTrace) =>
                  const Text('-', style: TextStyle(fontSize: 12)),
              loading: () => const Text('-', style: TextStyle(fontSize: 12)),
            ),
          )
        ],
      ),
      horizontalSpace(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset("assets/star.png"),
          ),
          horizontalSpace(5),
          Text((detail.valueOrNull?.voteAverage ?? 0).toStringAsFixed(1))
        ],
      )
    ];
