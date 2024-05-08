import 'package:flutter/material.dart';

import 'package:monipleapp/constants.dart';
import 'package:monipleapp/responsive.dart';
import 'package:monipleapp/screens/dashboard/components/header.dart';
import 'package:monipleapp/screens/dashboard/components/node_infos.dart';
import 'package:monipleapp/screens/dashboard/components/ns_view.dart';
import 'package:monipleapp/screens/dashboard/components/pod_view.dart';
import 'package:monipleapp/screens/dashboard/components/pvc_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const NodeInfos(),
                      const SizedBox(height: defaultPadding),
                      const NsView(),
                      const SizedBox(height: defaultPadding),
                      const PodView(),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) const PvcView(),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      // if (Responsive.isMobile(context)) const AlertView(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  const Expanded(flex: 2, child: PvcView()),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                // if (!Responsive.isMobile(context))
                //   const Expanded(flex: 2, child: AlertView()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
