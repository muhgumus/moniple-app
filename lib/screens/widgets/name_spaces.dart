import 'package:flutter/material.dart';

import 'package:monipleapp/constants.dart';
import 'package:monipleapp/stores/main_store.dart';

class Namespaces extends StatelessWidget {
  const Namespaces({
    Key? key,
    this.color = primaryColor,
    required this.list,
    required this.store,
  }) : super(key: key);

  final Color? color;
  final List<String> list;
  final MainStore store;

  selectNs(BuildContext context, String ns) {
    List<String> list = store.getSelectedNs();
    if (store.getSelectedNs().contains(ns)) {
      list.remove(ns);
      store.notifyListeners();
    } else {
      list.add(ns);
      store.notifyListeners();
    }
    store.setSelectedNs(context, list);
    store.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    List<String> namespace1 = List.empty(growable: true);
    List<String> namespace2 = List.empty(growable: true);
    int namespaceCount = store.nsSubject.data!.data!.length;

    for (var i = 0; i < namespaceCount; i++) {
      if (i < namespaceCount / 2) {
        namespace1.add(store.nsSubject.data!.data![i]);
      } else {
        namespace2.add(store.nsSubject.data!.data![i]);
      }
    }

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              selectNs(context, namespace1[index]);
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            // selectedBorderColor: Colors.green[700],
            // selectedColor: Colors.white,
            // fillColor: Colors.green[200],
            // color: Colors.green[400],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: namespace1
                .map((e) => store.getSelectedNs().contains(e))
                .toList(),
            children: namespace1
                .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(e)))
                .toList(),
          ),
          const SizedBox(
            height: 4,
          ),
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              selectNs(context, namespace2[index]);
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: namespace2
                .map((e) => store.getSelectedNs().contains(e))
                .toList(),
            children: namespace2
                .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(e)))
                .toList(),
          )
        ]));
  }
}
