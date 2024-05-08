import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:monipleapp/models/pvc_model.dart';
import 'package:monipleapp/stores/config_store.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:monipleapp/models/fetch_model.dart';

class PvcStore with ChangeNotifier {
  Dio dio = Dio();

  FetchModel<PvcModel> subject = FetchModel<PvcModel>();
  PvcModel filteredSubject = PvcModel();
  PvcModel pagedSubject = PvcModel();
  int sortColumnIndex = 0;
  bool sortAscending = true;
  int currentPage = 0;
  int currentPerPage = 10;
  PvcStore() {
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
    PvcModel clone = PvcModel.fromJson(filteredSubject.toJson());
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
        filteredSubject.data!.sort((a, b) => a.persistentvolumeclaim!
            .toLowerCase()
            .compareTo(b.persistentvolumeclaim!.toLowerCase()));
      } else {
        filteredSubject.data!.sort((a, b) => b.persistentvolumeclaim!
            .toLowerCase()
            .compareTo(a.persistentvolumeclaim!.toLowerCase()));
      }
    } else if (columnIndex == 1) {
      //Sort by Disk
      filteredSubject.data!.sort((a, b) {
        int rawa = a.total!.pvc!;
        if (a.total!.unit!.pvc == "TiB") {
          rawa = a.total!.pvc! * 1000 * 1000 * 1000;
        } else if (a.total!.unit!.pvc == "GiB") {
          rawa = a.total!.pvc! * 1000 * 1000;
        } else if (a.total!.unit!.pvc == "MiB") {
          rawa = a.total!.pvc! * 1000;
        }

        int rawb = b.total!.pvc!;
        if (b.total!.unit!.pvc == "TiB") {
          rawb = b.total!.pvc! * 1000 * 1000 * 1000;
        } else if (b.total!.unit!.pvc == "GiB") {
          rawb = b.total!.pvc! * 1000 * 1000;
        } else if (b.total!.unit!.pvc == "MiB") {
          rawb = b.total!.pvc! * 1000;
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

  Future<FetchModel<PvcModel>> getPvc() async {
    try {
      subject.loading = true;
      notifyListeners();
      subject.success = false;
      subject.error = "";
      await dio
          .get("${ConfigStore().apiUrl}/pvc",
              options: Options(headers: {
                "Content-Type": "application/json",
                ConfigStore().clientIdKey: ConfigStore().clientId,
                ConfigStore().clientSecretKey: ConfigStore().clientSecret,
                "Authorization": "Bearer ${ConfigStore().getAccessToken()}"
              }))
          .then((response) {
        if (response.statusCode == 200) {
          subject.success = true;
          subject.data = PvcModel.fromJson(response.data);
          PvcModel clone = PvcModel.fromJson(subject.data!.toJson());
          filteredSubject = clone;
          setPage(currentPage, currentPerPage);
        } else {
          subject.error = response.data['tppMessages'][0].text;
        }
      }).catchError((error) {
        debugPrint('PvcStore e1: ${error.toString()}');
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
      debugPrint('PvcStore e2: ${e.toString()}');
    } finally {
      subject.loading = false;
      notifyListeners();
    }
    if (!subject.success) throw (subject.error);
    return subject;
  }
}
