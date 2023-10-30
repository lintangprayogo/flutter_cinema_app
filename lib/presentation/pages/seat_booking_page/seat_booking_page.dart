import 'dart:math';

import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/domain/entities/transaction.dart';
import 'package:cinema_app/presentation/misc/methods.dart';
import 'package:cinema_app/presentation/pages/seat_booking_page/method/movie_screen.dart';
import 'package:cinema_app/presentation/pages/seat_booking_page/method/seat_section.dart';
import 'package:cinema_app/presentation/providers/router/router_provider.dart';
import 'package:cinema_app/presentation/widgets/back_navigation_bar.dart';
import 'package:cinema_app/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const SeatBookingPage({super.key, required this.transactionDetail});

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int> reserveredSeats = [];

  @override
  void initState() {
    super.initState();
    int reseverdNumber = Random().nextInt(36) + 1;

    while (reserveredSeats.length < 8) {
      if (!reserveredSeats.contains(reseverdNumber)) {
        reserveredSeats.add(reseverdNumber);
      }
      reseverdNumber = Random().nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              BackNavigationBar(
                title: movieDetail.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
              movieScreen(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatSection(
                    seatNumbers: List.generate(18, (index) => index + 1),
                    onTap: (seatNumber) {
                      if (!selectedSeats.contains(seatNumber)) {
                        setState(() {
                          selectedSeats.add(seatNumber);
                        });
                      } else {
                        setState(() {
                          selectedSeats.remove(seatNumber);
                        });
                      }
                    },
                    seatStatusChecker: (seatNumber) =>
                        reserveredSeats.contains(seatNumber)
                            ? SeatStatus.reserved
                            : selectedSeats.contains(seatNumber)
                                ? SeatStatus.selected
                                : SeatStatus.available,
                  ),
                  horizontalSpace(30),
                  seatSection(
                    seatNumbers: List.generate(18, (index) => index + 18),
                    onTap: (seatNumber) {
                      if (!selectedSeats.contains(seatNumber)) {
                        setState(() {
                          selectedSeats.add(seatNumber);
                        });
                      } else {
                        setState(() {
                          selectedSeats.remove(seatNumber);
                        });
                      }
                    },
                    seatStatusChecker: (seatNumber) =>
                        reserveredSeats.contains(seatNumber)
                            ? SeatStatus.reserved
                            : selectedSeats.contains(seatNumber)
                                ? SeatStatus.selected
                                : SeatStatus.available,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
