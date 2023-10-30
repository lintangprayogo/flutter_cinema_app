import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/domain/entities/transaction.dart';
import 'package:cinema_app/presentation/pages/booking_page/booking_page.dart';
import 'package:cinema_app/presentation/pages/detail/detail_page.dart';
import 'package:cinema_app/presentation/pages/login_page.dart';
import 'package:cinema_app/presentation/pages/main_page.dart';
import 'package:cinema_app/presentation/pages/register_page.dart';
import 'package:cinema_app/presentation/pages/seat_booking_page/seat_booking_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(routes: [
      GoRoute(
        path: "/main",
        name: "main",
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: "/login",
        name: "login",
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: '/detail',
        name: 'detail',
        builder: (context, state) => DetailPage(movie: state.extra as Movie),
      ),
      GoRoute(
        path: '/booking',
        name: 'booking',
        builder: (context, state) => BookingPage(
          movieDetail: state.extra as MovieDetail,
        ),
      ),
       GoRoute(
        path: '/seat-booking',
        name: 'seat-booking',
        builder: (context, state) => SeatBookingPage(transactionDetail: state.extra as (MovieDetail, Transaction)),
      )
    ], initialLocation: '/login', debugLogDiagnostics: false);
