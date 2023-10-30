import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/presentation/misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieOverview({required AsyncValue<MovieDetail?> detail}) => [
      const Text(
        "Overview",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(10),
      detail.when(
        data: (data) => Text(data?.overview ?? ""),
        error: (error, stackTrace) =>
            const Text("Failed To Load Movie Overview.Please Try Again"),
        loading: () => const Center(child: CircularProgressIndicator()),
      )
    ];
