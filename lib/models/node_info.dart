import 'package:flutter/material.dart';

import '../constants.dart';

class NodeInfo {
  final String? svgSrc, title, totalStorage;
  final int? usage, percentage;
  final Color? color;
  final bool? severity;

  NodeInfo(
      {this.svgSrc,
      this.title,
      this.totalStorage,
      this.usage,
      this.percentage,
      this.color,
      this.severity});
}

List loadingNodeInfos = [
  NodeInfo(
      title: "Cpu",
      usage: 0,
      svgSrc: "assets/icons/cpu.svg",
      totalStorage: "0 Core",
      color: primaryColor,
      percentage: 0,
      severity: false),
  NodeInfo(
      title: "Memory",
      usage: 0,
      svgSrc: "assets/icons/memory.svg",
      totalStorage: "0 GB",
      color: const Color(0xFFFFA113),
      percentage: 0,
      severity: false),
  NodeInfo(
      title: "Disk",
      usage: 0,
      svgSrc: "assets/icons/disk.svg",
      totalStorage: "0 GB",
      color: const Color(0xFF1DB9C3),
      percentage: 0,
      severity: false),
  NodeInfo(
      title: "Pod",
      usage: 0,
      svgSrc: "assets/icons/block.svg",
      totalStorage: "0 GB",
      color: const Color(0xFFFFFFC7),
      percentage: 0,
      severity: false)
];
