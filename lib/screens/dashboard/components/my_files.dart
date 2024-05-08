import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:monipleapp/constants.dart';
import 'package:monipleapp/responsive.dart';
import 'package:monipleapp/stores/config_store.dart';
import 'package:monipleapp/stores/main_store.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Node Status",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Add New"),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: size.width < 650 ? 2 : 4,
            childAspectRatio: size.width < 650 ? 1.3 : 1,
          ),
          tablet: const FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  FileInfoCardGridViewState createState() => FileInfoCardGridViewState();
}

class FileInfoCardGridViewState extends State<FileInfoCardGridView> {
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

    Future.microtask(() => Provider.of<MainStore>(context, listen: false)
            .getNode()
            .whenComplete(() {
          if (mainStore.nodeSubject.success) {}
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
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: const Text("He'd have you all unravel at the"),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
          child: const Text('Heed not the rabble'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[300],
          child: const Text('Sound of screams but the'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[400],
          child: const Text('Who scream'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[500],
          child: const Text('Revolution is coming...'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[600],
          child: const Text('Revolution, they...'),
        ),
      ],
    );
    /*GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mainStore.nodeSubject.data!.data!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
    );*/
  }
}
