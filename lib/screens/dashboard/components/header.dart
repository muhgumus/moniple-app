import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monipleapp/models/cluster_model.dart';
import 'package:monipleapp/stores/config_store.dart';
import 'package:monipleapp/stores/main_store.dart';
import 'package:monipleapp/stores/pod_store.dart';
import 'package:monipleapp/stores/pvc_store.dart';
import 'package:provider/provider.dart';

import 'package:monipleapp/constants.dart';
import 'package:monipleapp/controllers/menu_app_controller.dart';
import 'package:monipleapp/responsive.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        const Expanded(child: SearchField()),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  ProfileCardState createState() => ProfileCardState();
}

class ProfileCardState extends State<ProfileCard> {
  MainStore mainStore = MainStore();
  ConfigStore configStore = ConfigStore();
  PodStore podStore = PodStore();
  PvcStore pvcStore = PvcStore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    mainStore = Provider.of<MainStore>(context);
    configStore = Provider.of<ConfigStore>(context);
    podStore = Provider.of<PodStore>(context);
    pvcStore = Provider.of<PvcStore>(context);
  }

  @override
  initState() {
    super.initState();

    Future.microtask(() => Provider.of<MainStore>(context, listen: false)
            .getCluster()
            .whenComplete(() {
          if (mainStore.nodeSubject.success) {}
        }).catchError((error) {
          //TODO
        }));
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController colorController = TextEditingController();

    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),

      child: DropdownMenu<Cluster>(
        initialSelection: mainStore.clusterSubject.data!.data![0],
        controller: colorController,
        // requestFocusOnTap is enabled/disabled by platforms when it is null.
        // On mobile platforms, this is false by default. Setting this to true will
        // trigger focus request on the text field and virtual keyboard will appear
        // afterward. On desktop platforms however, this defaults to true.
        requestFocusOnTap: true,
        label: const Text('Cluster'),
        onSelected: (Cluster? cluster) {
          configStore.setApiUrl("${cluster!.address}");
          mainStore.getNs();
          mainStore.getNode();
          podStore.getPod();
          pvcStore.getPvc();
        },
        dropdownMenuEntries: mainStore.clusterSubject.data!.data!
            .map<DropdownMenuEntry<Cluster>>((Cluster cluster) {
          return DropdownMenuEntry<Cluster>(
            value: cluster,
            label: "${cluster.name}",
            leadingIcon: Icon(
              Icons.circle,
              color: HexColor("${cluster.color}"),
            ),
            style: MenuItemButton.styleFrom(
              foregroundColor: Colors.white,
            ),
          );
        }).toList(),
      ),
      // Row(
      //   children: [
      //     Image.asset(
      //       "assets/images/profile_pic.png",
      //       height: 38,
      //     ),
      //     if (!Responsive.isMobile(context))
      //       const Padding(
      //         padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      //         child: Text("Angelina Jolie"),
      //       ),
      //     const Icon(Icons.keyboard_arrow_down),
      //   ],
      // ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
