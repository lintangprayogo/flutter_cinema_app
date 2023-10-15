enum MovieCategoryParam { nowPlaying, upcoming }

class GetMovieListParam {
  final MovieCategoryParam category;
  final int page;

  GetMovieListParam({required this.category, this.page = 1});
}
