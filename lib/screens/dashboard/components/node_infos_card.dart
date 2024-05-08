import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:monipleapp/constants.dart';
import 'package:monipleapp/models/node_info.dart';
import 'package:monipleapp/screens/widgets/progress_line.dart';

class NodeInfoCard extends StatelessWidget {
  const NodeInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final NodeInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: info.severity! ? const Color(0xFFFFA113) : secondaryColor,
              width: 0.2),
          shape: BoxShape.rectangle),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(defaultPadding * 0.64),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: info.color!.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  info.svgSrc!,
                  colorFilter: ColorFilter.mode(
                      info.color ?? Colors.black, BlendMode.srcIn),
                ),
              ),
              if (info.severity == true) ...[
                SvgPicture.asset(
                  "assets/icons/warning.svg",
                  colorFilter: const ColorFilter.mode(
                      Color(0xFFF58634), BlendMode.srcIn),
                )
              ]
            ],
          ),
          Text(
            info.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          ProgressLine(
            color: info.color,
            percentage: info.percentage,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${info.usage}%",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
              ),
              Text(
                info.totalStorage!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
