class FetchModel<T> {
  bool success = false;
  String error = "";
  bool loading = false;
  T? data;
  List<T> list = <T>[];
}
