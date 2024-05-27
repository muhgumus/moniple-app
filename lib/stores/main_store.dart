import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:monipleapp/models/ns_model.dart';
import 'package:monipleapp/stores/config_store.dart';
import 'package:monipleapp/stores/pod_store.dart';
import 'package:monipleapp/stores/pvc_store.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:monipleapp/models/node_model.dart';
import 'package:monipleapp/models/fetch_model.dart';
import 'package:provider/provider.dart';

class MainStore with ChangeNotifier {
  Dio dio = Dio();
  List<String> _selectedNs = List.empty(growable: true);

  FetchModel<NsModel> nsSubject = FetchModel<NsModel>();
  FetchModel<NodeModel> nodeSubject = FetchModel<NodeModel>();

  MainStore() {
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

  void setSelectedNs(BuildContext context, List<String> list) {
    PodStore podStore = Provider.of<PodStore>(context, listen: false);
    PvcStore pvcStore = Provider.of<PvcStore>(context, listen: false);

    _selectedNs = list;
    if (_selectedNs.isNotEmpty) {
      pvcStore.filteredSubject.data = pvcStore.subject.data!.data!
          .where((e) => _selectedNs.contains(e.namespace))
          .toList();
      podStore.filteredSubject.data = podStore.subject.data!.data!
          .where((e) => _selectedNs.contains(e.namespace))
          .toList();
    } else {
      podStore.filteredSubject.data = podStore.subject.data!.data!;
      pvcStore.filteredSubject.data = pvcStore.subject.data!.data!;
    }
    podStore.sort(podStore.sortColumnIndex, podStore.sortAscending);
    pvcStore.sort(pvcStore.sortColumnIndex, pvcStore.sortAscending);
  }

  List<String> getSelectedNs() {
    return _selectedNs;
  }

  Future<FetchModel<NsModel>> getNs() async {
    try {
      nsSubject.loading = true;
      notifyListeners();
      nsSubject.success = false;
      nsSubject.error = "";
      await dio
          .get("${ConfigStore().apiUrl}/ns",
              options: Options(headers: {
                "Content-Type": "application/json",
                ConfigStore().clientIdKey: ConfigStore().clientId,
                ConfigStore().clientSecretKey: ConfigStore().clientSecret,
                "Authorization": "Bearer ${ConfigStore().getAccessToken()}"
              }))
          .then((response) {
        if (response.statusCode == 200) {
          nsSubject.success = true;
          nsSubject.data = NsModel.fromJson(response.data);
          //nsSubject.data?.data?.forEach((e) => {});
        } else {
          nsSubject.error = response.data['tppMessages'][0].text;
        }
      }).catchError((error) {
        debugPrint(error.toString());
        /*if (error.response.statusCode == 401) {
         AuthStore().logout();
        } else {
          */
        nsSubject.error = ConfigStore().generalError;
        /*
        var errorMessage = error.message;
        if (error.response.data['tppMessages'][0]["text"] != null)
          errorMessage = error.response.data['tppMessages'][0]["text"];
        nsSubject.error = errorMessage;
         */
        //}
      });
    } catch (e) {
      nsSubject.error = ConfigStore().generalError;
      debugPrint(e.toString());
    } finally {
      nsSubject.loading = false;
      notifyListeners();
    }
    if (!nsSubject.success) throw (nsSubject.error);
    return nsSubject;
  }

  Future<FetchModel<NodeModel>> getNode() async {
    try {
      nodeSubject.loading = true;
      notifyListeners();
      nodeSubject.success = false;
      nodeSubject.error = "";
      await dio
          .get("${ConfigStore().apiUrl}/node",
              options: Options(headers: {
                "Content-Type": "application/json",
                ConfigStore().clientIdKey: ConfigStore().clientId,
                ConfigStore().clientSecretKey: ConfigStore().clientSecret,
                "Authorization": "Bearer ${ConfigStore().getAccessToken()}"
              }))
          .then((response) {
        if (response.statusCode == 200) {
          nodeSubject.success = true;
          nodeSubject.data = NodeModel.fromJson(response.data);
          nodeSubject.data?.data?.forEach((e) => {});
        } else {
          nodeSubject.error = response.data['tppMessages'][0].text;
        }
      }).catchError((error) {
        debugPrint(error.toString());
        /*if (error.response.statusCode == 401) {
         AuthStore().logout();
        } else {
          */
        nodeSubject.error = ConfigStore().generalError;
        /*
        var errorMessage = error.message;
        if (error.response.data['tppMessages'][0]["text"] != null)
          errorMessage = error.response.data['tppMessages'][0]["text"];
        nodeSubject.error = errorMessage;
         */
        //}
      });
    } catch (e) {
      nodeSubject.error = ConfigStore().generalError;
      debugPrint(e.toString());
    } finally {
      nodeSubject.loading = false;
      notifyListeners();
    }
    if (!nodeSubject.success) throw (nodeSubject.error);
    return nodeSubject;
  }
}
