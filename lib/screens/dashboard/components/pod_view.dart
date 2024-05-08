import 'package:flutter/material.dart';
import 'package:monipleapp/screens/widgets/pagination_footer.dart';
import 'package:monipleapp/screens/widgets/progress_line.dart';
import 'package:provider/provider.dart';

import 'package:monipleapp/constants.dart';
import 'package:monipleapp/stores/config_store.dart';
import 'package:monipleapp/stores/main_store.dart';
import 'package:monipleapp/stores/pod_store.dart';

class PodView extends StatefulWidget {
  const PodView({
    Key? key,
  }) : super(key: key);

  @override
  PodViewState createState() => PodViewState();
}

class PodViewState extends State<PodView> {
  MainStore mainStore = MainStore();
  PodStore podStore = PodStore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    mainStore = Provider.of<MainStore>(context);
    podStore = Provider.of<PodStore>(context);
    ConfigStore().setCurrentContext(context);
  }

  @override
  initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<MainStore>(context, listen: false).getNs().whenComplete(() {
          if (mainStore.nsSubject.success) {}
          // ignore: body_might_complete_normally_catch_error
        }).catchError((error) {
          /* _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.red.shade700,
            content: Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text("$error")),
            duration: Duration(seconds: 4),
          ));
            */
        }));

    Future.microtask(() =>
        Provider.of<PodStore>(context, listen: false).getPod().whenComplete(() {
          if (podStore.subject.success) {}
          // ignore: body_might_complete_normally_catch_error
        }).catchError((error) {
          /* _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.red.shade700,
            content: Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text("$error")),
            duration: Duration(seconds: 4),
          ));
            */
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pods",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          LayoutBuilder(builder: (context, constraint) {
            return SizedBox(
              width: constraint.maxWidth,
              child: podStore.subject.success == true
                  ? DataTable(
                      sortColumnIndex: podStore.sortColumnIndex,
                      sortAscending: podStore.sortAscending,
                      columnSpacing: defaultPadding,
                      horizontalMargin: 0,
                      columns: getDataColumn(podStore, context),
                      rows: getDataRow(podStore, context, constraint))
                  : const Center(),
            );
          }),
          const SizedBox(height: defaultPadding),
          podStore.subject.success == true
              ? PaginationFooter(
                  list: podStore.filteredSubject.data!,
                  currentPage: podStore.currentPage + 1,
                  currentPerPage: podStore.currentPerPage,
                  onNext: () {
                    podStore.setPage(
                        podStore.currentPage + 1, podStore.currentPerPage);
                  },
                  onPrevious: () async {
                    podStore.setPage(
                        podStore.currentPage - 1, podStore.currentPerPage);
                  },
                  onPageSize: (size) {
                    podStore.currentPerPage = int.parse(size);
                    podStore.setPage(
                        podStore.currentPage - 1, podStore.currentPerPage);
                  },
                )
              : const Center()
        ],
      ),
    );
  }
}

List<DataColumn> getDataColumn(PodStore podStore, BuildContext context) {
  List<DataColumn> columns = List.empty();
  columns = columns.toList();

  columns.add(DataColumn(
    label: const Text("Name"),
    onSort: (int columnIndex, bool ascending) {
      podStore.sort(columnIndex, ascending);
    },
  ));
  columns.add(DataColumn(
    label: const Text("Cpu"),
    onSort: (int columnIndex, bool ascending) {
      podStore.sort(columnIndex, ascending);
    },
  ));
  columns.add(DataColumn(
    label: const Text("Mem"),
    onSort: (int columnIndex, bool ascending) {
      podStore.sort(columnIndex, ascending);
    },
  ));
  return columns;
}

List<DataRow> getDataRow(
    PodStore podStore, BuildContext context, BoxConstraints constraint) {
  List<DataRow> rows = List.empty(growable: true);

  for (var podInfo in podStore.pagedSubject.data!) {
    List<DataCell> cells = List.empty();
    cells = cells.toList();

    cells.add(DataCell(SizedBox(
        width: constraint.maxWidth - (defaultPadding * 2 + 96),
        child: Text(
          podInfo.name!,
          overflow: TextOverflow.ellipsis,
        ))));
    cells.add(
      DataCell(SizedBox(
          width: 48,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              ProgressLine(
                color: Colors.blue.withAlpha(50),
                percentage: 0,
                size: 42,
                radius: 0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child: Text(
                      style: const TextStyle(fontSize: 14),
                      "${podInfo.usage?.cpu}"))
            ],
          ))),
    );
    cells.add(
      DataCell(SizedBox(
          width: 48,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              ProgressLine(
                color: Colors.blue.withAlpha(50),
                percentage: 0,
                size: 42,
                radius: 0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child: Text(
                      style: const TextStyle(fontSize: 14),
                      "${podInfo.usage?.memory?.toInt()} ${podInfo.usage?.unit?.memory}"))
            ],
          ))),
    );

    rows.add(DataRow(cells: cells));
  }
  return rows;
}
