import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:monipleapp/models/pod_model.dart';
import 'package:monipleapp/stores/config_store.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:monipleapp/models/fetch_model.dart';

class PodStore with ChangeNotifier {
  Dio dio = Dio();

  FetchModel<PodModel> subject = FetchModel<PodModel>();
  PodModel filteredSubject = PodModel();
  PodModel pagedSubject = PodModel();
  int sortColumnIndex = 0;
  bool sortAscending = true;
  int currentPage = 0;
  int currentPerPage = 10;
  PodStore() {
    init();
  }

  init() async {
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: false,
        maxWidth: 90));
  }

  void setPage(int page, int perPage) {
    PodModel clone = PodModel.fromJson(filteredSubject.toJson());
    if (page <= 0 || filteredSubject.data!.length < currentPerPage) {
      currentPage = 0;
    } else if (filteredSubject.data!.length <= currentPerPage) {
      currentPage = 0;
    } else if ((page + 1) * currentPerPage >= filteredSubject.data!.length) {
      currentPage = (filteredSubject.data!.length / currentPerPage).ceil() - 1;
    } else {
      currentPage = page;
    }
    currentPerPage = perPage;

    debugPrint(
        "page: $page, clone.data!.length: ${clone.data!.length},  currentPage: $currentPage ,currentPerPage:$currentPerPage,  ");

    if (clone.data!.length > currentPerPage) {
      var lastpageitems =
          (currentPage * currentPerPage) + currentPerPage > clone.data!.length
              ? (clone.data!.length % currentPerPage)
              : currentPerPage;
      pagedSubject.data = clone.data!
          .sublist((currentPage * currentPerPage),
              ((currentPage * currentPerPage) + lastpageitems))
          .toList();
    } else {
      pagedSubject.data = clone.data;
    }
    notifyListeners();
  }

  void sort(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;
    if (columnIndex == 0) {
      //Sort by Name
      if (ascending) {
        filteredSubject.data!.sort(
            (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      } else {
        filteredSubject.data!.sort(
            (a, b) => b.name!.toLowerCase().compareTo(a.name!.toLowerCase()));
      }
    } else if (columnIndex == 1) {
      //Sort by Cpu
      filteredSubject.data!.sort((a, b) {
        if (ascending) {
          return a.usage!.cpu!.compareTo(b.usage!.cpu!);
        } else {
          return b.usage!.cpu!.compareTo(a.usage!.cpu!);
        }
      });
    } else if (columnIndex == 2) {
      //Sort by Memory
      filteredSubject.data!.sort((a, b) {
        double rawa = a.usage!.memory!;
        if (a.usage!.unit!.memory == "TiB") {
          rawa = a.usage!.memory! * 1000 * 1000 * 1000;
        } else if (a.usage!.unit!.memory == "GiB") {
          rawa = a.usage!.memory! * 1000 * 1000;
        } else if (a.usage!.unit!.memory == "MiB") {
          rawa = a.usage!.memory! * 1000;
        }

        double rawb = b.usage!.memory!;
        if (b.usage!.unit!.memory == "TiB") {
          rawb = b.usage!.memory! * 1000 * 1000 * 1000;
        } else if (b.usage!.unit!.memory == "GiB") {
          rawb = b.usage!.memory! * 1000 * 1000;
        } else if (b.usage!.unit!.memory == "MiB") {
          rawb = b.usage!.memory! * 1000;
        }

        if (ascending) {
          return rawa.compareTo(rawb);
        } else {
          return rawb.compareTo(rawa);
        }
      });
    }

    setPage(currentPage, currentPerPage);
  }

  Color getTresholdColor(int usage) {
    var color = Colors.green.withAlpha(80);
    if (usage > 80) {
      color = Colors.red.withAlpha(80);
    } else if (usage > 60) {
      color = Colors.orange.withAlpha(80);
    }
    return color;
  }

  Future<FetchModel<PodModel>> getPod() async {
    try {
      subject.loading = true;
      notifyListeners();
      subject.success = false;
      subject.error = "";
      await dio
          .get("${ConfigStore().apiUrl}/pod",
              options: Options(headers: {
                "Content-Type": "application/json",
                ConfigStore().clientIdKey: ConfigStore().clientId,
                ConfigStore().clientSecretKey: ConfigStore().clientSecret,
                "Authorization": "Bearer ${ConfigStore().getAccessToken()}"
              }))
          .then((response) {
        if (response.statusCode == 200) {
          subject.success = true;
          subject.data = PodModel.fromJson(response.data);
          PodModel clone = PodModel.fromJson(subject.data!.toJson());
          filteredSubject = clone;
          setPage(currentPage, currentPerPage);
        } else {
          subject.error = response.data['tppMessages'][0].text;
        }
      }).catchError((error) {
        debugPrint('PodStore e1: ${error.toString()}');
        /*if (error.response.statusCode == 401) {
         AuthStore().logout();
        } else {
          */
        subject.error = ConfigStore().generalError;
        /*
        var errorMessage = error.message;
        if (error.response.data['tppMessages'][0]["text"] != null)
          errorMessage = error.response.data['tppMessages'][0]["text"];
        subject.error = errorMessage;
         */
        //}
      });
    } catch (e) {
      subject.error = ConfigStore().generalError;
      debugPrint('PodStore e2: ${e.toString()}');
    } finally {
      subject.loading = false;
      notifyListeners();
    }
    if (!subject.success) throw (subject.error);
    return subject;
  }
}
