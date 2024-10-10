abstract class ShowsListEvents {}

class ShowsListLoadNextPage extends ShowsListEvents {
  ShowsListLoadNextPage({required this.locale});

  final String locale;
}

class ShowsListSearch extends ShowsListEvents {
  ShowsListSearch({required this.query});
  final String query;
}

class ShowsListReset extends ShowsListEvents {}
