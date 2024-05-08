import 'package:flutter/material.dart';
import 'package:monipleapp/screens/dashboard/components/node_infos_card.dart';
import 'package:provider/provider.dart';

import 'package:monipleapp/constants.dart';
import 'package:monipleapp/models/node_info.dart';
import 'package:monipleapp/responsive.dart';
import 'package:monipleapp/stores/config_store.dart';
import 'package:monipleapp/stores/main_store.dart';

class NodeInfos extends StatelessWidget {
  const NodeInfos({
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
              "Nodes Summary",
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
            childAspectRatio: size.width < 650 && size.width > 350 ? 1.3 : 1,
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

    Future.microtask(() => mainStore.getNode().whenComplete(() {
          if (mainStore.nodeSubject.success) {}
          // ignore: body_might_complete_normally_catch_error
        }).catchError((error) {
          debugPrint("ERROR:  $error");
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
    List nodeInfos = [
      NodeInfo(
          title: "Cpu",
          usage: mainStore.nodeSubject.data?.summary?.usage?.cpu,
          svgSrc: "assets/icons/cpu.svg",
          totalStorage:
              "${mainStore.nodeSubject.data?.summary?.total?.cpu} ${mainStore.nodeSubject.data?.summary?.total?.unit?.cpu}",
          color: primaryColor,
          percentage: mainStore.nodeSubject.data?.summary?.usage?.cpu,
          severity: mainStore.nodeSubject.data?.summary?.severity?.cpu),
      NodeInfo(
          title: "Memory",
          usage: mainStore.nodeSubject.data?.summary?.usage?.memory,
          svgSrc: "assets/icons/memory.svg",
          totalStorage:
              "${mainStore.nodeSubject.data?.summary?.total?.memory} ${mainStore.nodeSubject.data?.summary?.total?.unit?.memory}",
          color: const Color(0xFFFFA113),
          percentage: mainStore.nodeSubject.data?.summary?.usage?.memory,
          severity: mainStore.nodeSubject.data?.summary?.severity?.memory),
      NodeInfo(
          title: "Disk",
          usage: mainStore.nodeSubject.data?.summary?.usage?.disk,
          svgSrc: "assets/icons/disk.svg",
          totalStorage:
              "${mainStore.nodeSubject.data?.summary?.total?.disk} ${mainStore.nodeSubject.data?.summary?.total?.unit?.disk}",
          color: const Color(0xFF1DB9C3),
          percentage: mainStore.nodeSubject.data?.summary?.usage?.disk,
          severity: mainStore.nodeSubject.data?.summary?.severity?.disk),
      NodeInfo(
          title: "Pod",
          usage: mainStore.nodeSubject.data?.summary?.usage?.pod,
          svgSrc: "assets/icons/block.svg",
          totalStorage: "${mainStore.nodeSubject.data?.summary?.total?.pod}",
          color: const Color(0xFFFFFFC7),
          percentage: mainStore.nodeSubject.data?.summary?.usage?.pod,
          severity: mainStore.nodeSubject.data?.summary?.severity?.pod)
    ];
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: nodeInfos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => NodeInfoCard(
          info: mainStore.nodeSubject.loading
              ? loadingNodeInfos[index]
              : nodeInfos[index]),
    );
  }
}
