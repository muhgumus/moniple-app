// import 'package:flutter/material.dart';
// import 'package:monipleapp/screens/widgets/pagination_footer.dart';
// import 'package:monipleapp/screens/widgets/progress_line.dart';
// import 'package:monipleapp/stores/alert_store.dart';
// import 'package:monipleapp/stores/pvc_store.dart';
// import 'package:provider/provider.dart';

// import 'package:monipleapp/constants.dart';
// import 'package:monipleapp/stores/config_store.dart';

// class AlertView extends StatefulWidget {
//   const AlertView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   AlertViewState createState() => AlertViewState();
// }

// class AlertViewState extends State<AlertView> {
//   AlertStore pvcStore = AlertStore();

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     pvcStore = Provider.of<AlertStore>(context);
//     ConfigStore().setCurrentContext(context);
//   }

//   @override
//   initState() {
//     super.initState();

//     Future.microtask(() =>
//         Provider.of<PvcStore>(context, listen: false).getPvc().whenComplete(() {
//           if (pvcStore.subject.success) {}
//           // ignore: body_might_complete_normally_catch_error
//         }).catchError((error) {
//           /* _scaffoldKey.currentState.showSnackBar(SnackBar(
//             backgroundColor: Colors.red.shade700,
//             content: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 6),
//                 child: Text("$error")),
//             duration: Duration(seconds: 4),
//           ));
//             */
//         }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(defaultPadding),
//       decoration: const BoxDecoration(
//         color: secondaryColor,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Alerts",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: defaultPadding),
//           LayoutBuilder(builder: (context, constraint) {
//             return SizedBox(
//               width: constraint.maxWidth,
//               child: pvcStore.subject.success == true
//                   ? DataTable(
//                       sortAscending: pvcStore.sortAscending,
//                       sortColumnIndex: pvcStore.sortColumnIndex,
//                       columnSpacing: defaultPadding,
//                       horizontalMargin: 0,
//                       columns: getDataColumn(pvcStore, context),
//                       rows: getDataRow(pvcStore, context, constraint))
//                   : const Center(),
//             );
//           }),
//           const SizedBox(height: defaultPadding),
//           pvcStore.subject.success == true
//               ? PaginationFooter(
//                   list: pvcStore.filteredSubject.data!,
//                   currentPage: pvcStore.currentPage + 1,
//                   currentPerPage: pvcStore.currentPerPage,
//                   onNext: () {
//                     pvcStore.setPage(
//                         pvcStore.currentPage + 1, pvcStore.currentPerPage);
//                   },
//                   onPrevious: () {
//                     pvcStore.setPage(
//                         pvcStore.currentPage - 1, pvcStore.currentPerPage);
//                   },
//                   onPageSize: () {},
//                 )
//               : const Center()
//         ],
//       ),
//     );
//   }
// }

// List<DataColumn> getDataColumn(PvcStore pvcStore, BuildContext context) {
//   List<DataColumn> columns = List.empty();
//   columns = columns.toList();

//   columns.add(DataColumn(
//     label: const Text("Name"),
//     onSort: (int columnIndex, bool ascending) {
//       pvcStore.sort(columnIndex, ascending);
//     },
//   ));
//   columns.add(DataColumn(
//     label: const Text("Size"),
//     onSort: (int columnIndex, bool ascending) {
//       pvcStore.sort(columnIndex, ascending);
//     },
//   ));
//   return columns;
// }

// List<DataRow> getDataRow(
//     PvcStore pvcStore, BuildContext context, BoxConstraints constraint) {
//   List<DataRow> rows = List.empty(growable: true);

//   for (var pvcInfo in pvcStore.pagedSubject.data!) {
//     List<DataCell> cells = List.empty();
//     cells = cells.toList();

//     cells.add(DataCell(SizedBox(
//         width: constraint.maxWidth - (defaultPadding * 1 + 72),
//         child: Text(
//           pvcInfo.persistentvolumeclaim!,
//           overflow: TextOverflow.ellipsis,
//         ))));
//     cells.add(
//       DataCell(SizedBox(
//           width: 72,
//           child: Stack(
//             alignment: Alignment.centerLeft,
//             children: <Widget>[
//               ProgressLine(
//                 color: ConfigStore.getTresholdColor(pvcInfo.usage!.pvc!),
//                 percentage: pvcInfo.usage!.pvc,
//                 size: 42,
//                 radius: 0,
//               ),
//               Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: defaultPadding / 2),
//                   child:
//                       Text("${pvcInfo.total?.pvc} ${pvcInfo.total?.unit?.pvc}"))
//             ],
//           ))),
//     );

//     rows.add(DataRow(cells: cells));
//   }
//   return rows;
// }
