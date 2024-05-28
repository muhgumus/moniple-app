import 'package:flutter/material.dart';
import 'package:monipleapp/screens/widgets/name_spaces.dart';
import 'package:provider/provider.dart';

import 'package:monipleapp/constants.dart';
import 'package:monipleapp/stores/config_store.dart';
import 'package:monipleapp/stores/main_store.dart';

class NsView extends StatefulWidget {
  const NsView({
    Key? key,
  }) : super(key: key);

  @override
  NsViewState createState() => NsViewState();
}

class NsViewState extends State<NsView> {
  MainStore mainStore = MainStore();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    mainStore = Provider.of<MainStore>(context);
    ConfigStore().setCurrentContext(context);
  }

  @override
  initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<MainStore>(context, listen: true).getNs().whenComplete(() {
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
            "Namespaces",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          mainStore.nsSubject.data != null
              ? Namespaces(
                  store: mainStore, list: mainStore.nsSubject.data!.data!)
              : const Center(),
        ],
      ),
    );
  }
}
