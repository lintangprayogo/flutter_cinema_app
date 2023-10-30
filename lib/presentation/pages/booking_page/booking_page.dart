import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/domain/entities/transaction.dart';
import 'package:cinema_app/presentation/extensions/build_extensions.dart';
import 'package:cinema_app/presentation/misc/constants.dart';
import 'package:cinema_app/presentation/misc/methods.dart';
import 'package:cinema_app/presentation/pages/booking_page/method/options.dart';
import 'package:cinema_app/presentation/providers/router/router_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/user_data/user_data_provider.dart';
import 'package:cinema_app/presentation/widgets/back_navigation_bar.dart';
import 'package:cinema_app/presentation/widgets/network_image_widget_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;

  const BookingPage({super.key, required this.movieDetail});

  @override
  ConsumerState<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  final List<String> theaters = const [
    "XXI TAMANAN ANGREK",
    "XXI SENAYAN CITY",
    "CINEPOLIS SPARK",
    "CGV SLIPI",
    "XXI MAL CIPUTRA"
  ];

  String? selectedTheater;

  final List<DateTime> dates = List.generate(
    7,
    (index) {
      DateTime now = DateTime.now();
      DateTime date = DateTime(now.year, now.month, now.day);
      return date.add(Duration(days: index));
    },
  );

  DateTime? selectedDate;

  final List<DateTime> date = List.generate(
    7,
    (index) {
      DateTime now = DateTime.now();
      DateTime date = DateTime(now.year, now.month, now.day);
      return date.add(Duration(days: index));
    },
  );

  final List<int> hours = List.generate(8, (index) => index + 12);
  int? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: BackNavigationBar(
                title: widget.movieDetail.title,
                onTap: () {
                  ref.read(routerProvider).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: NetworkImageCard(
                  width: MediaQuery.of(context).size.width - 48,
                  height: (MediaQuery.of(context).size.width - 48) * 0.6,
                  borderRadius: 15,
                  imageUrl:
                      "https://image.tmdb.org/t/p/w500/${widget.movieDetail.backdropPath ?? widget.movieDetail.posterPath}",
                  boxFit: BoxFit.cover),
            ),
            ...options(
                title: "Select a Theater",
                options: theaters,
                onTap: (theater) {
                  setState(() {
                    selectedTheater = theater;
                  });
                },
                selectedItem: selectedTheater),
            verticalSpace(24),
            ...options(
                title: "Select a Date",
                options: dates,
                onTap: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
                converter: (date) => DateFormat("EEE, d MMMM y").format(date),
                selectedItem: selectedDate),
            verticalSpace(24),
            ...options(
                title: "Select a Time",
                options: hours,
                onTap: (hours) {
                  setState(() {
                    selectedTime = hours;
                  });
                },
                isOptionEnabled: (hour) =>
                    selectedDate != null &&
                    DateTime(selectedDate!.year, selectedDate!.month,
                            selectedDate!.day, hour)
                        .isAfter(DateTime.now()),
                converter: (object) => "$object:00",
                selectedItem: selectedTime),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (selectedDate == null ||
                          selectedTheater == null ||
                          selectedTime == null) {
                        context.showSnackBar("Please Fill The Options");
                      } else {
                        Transaction transaction = Transaction(
                            uid: ref.read(userDataProvider).value!.uid,
                            title: widget.movieDetail.title,
                            adminFee: 3000,
                            total: 0,
                            watchingTime: DateTime(
                                    selectedDate!.year,
                                    selectedDate!.month,
                                    selectedDate!.day,
                                    selectedTime!)
                                .microsecondsSinceEpoch,
                            theaterName: selectedTheater,
                            transactionImage: widget.movieDetail.posterPath);

                        ref.read(routerProvider).pushNamed("seat-booking",
                            extra: (widget.movieDetail, transaction));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: backgroundColor,
                        backgroundColor: saffron,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text("Next")),
              ),
            )
          ],
        ),
      ],
    ));
  }
}
