class NodeModel {
  String? status;
  String? key;
  Summary? summary;
  List<Data>? data;

  NodeModel({status, key, summary, data});

  NodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    key = json['key'];
    summary =
        json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['key'] = key;
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Summary {
  Usage? usage;
  Usage? total;
  Severity? severity;

  Summary({usage, total, severity});

  Summary.fromJson(Map<String, dynamic> json) {
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
    total = json['total'] != null ? Usage.fromJson(json['total']) : null;
    severity =
        json['severity'] != null ? Severity.fromJson(json['severity']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usage != null) {
      data['usage'] = usage!.toJson();
    }
    if (total != null) {
      data['total'] = total!.toJson();
    }
    if (severity != null) {
      data['severity'] = severity!.toJson();
    }
    return data;
  }
}

class Usage {
  int? cpu;
  int? disk;
  int? memory;
  int? pod;
  Unit? unit;

  Usage({cpu, disk, memory, pod, unit});

  Usage.fromJson(Map<String, dynamic> json) {
    cpu = json['cpu'];
    disk = json['disk'];
    memory = json['memory'];
    pod = json['pod'];
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cpu'] = cpu;
    data['disk'] = disk;
    data['memory'] = memory;
    data['pod'] = pod;
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    return data;
  }
}

class Unit {
  String? cpu;
  String? disk;
  String? memory;
  String? pod;

  Unit({cpu, disk, memory, pod});

  Unit.fromJson(Map<String, dynamic> json) {
    cpu = json['cpu'];
    disk = json['disk'];
    memory = json['memory'];
    pod = json['pod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cpu'] = cpu;
    data['disk'] = disk;
    data['memory'] = memory;
    data['pod'] = pod;
    return data;
  }
}

class Severity {
  bool? cpu;
  bool? memory;
  bool? disk;
  bool? pod;

  Severity({cpu, memory, disk, pod});

  Severity.fromJson(Map<String, dynamic> json) {
    cpu = json['cpu'];
    memory = json['memory'];
    disk = json['disk'];
    pod = json['pod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cpu'] = cpu;
    data['memory'] = memory;
    data['disk'] = disk;
    data['pod'] = pod;
    return data;
  }
}

class Data {
  Usage? usage;
  Usage? total;
  String? name;
  String? instance;

  Data({usage, total, name, instance});

  Data.fromJson(Map<String, dynamic> json) {
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
    total = json['total'] != null ? Usage.fromJson(json['total']) : null;
    name = json['name'];
    instance = json['instance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usage != null) {
      data['usage'] = usage!.toJson();
    }
    if (total != null) {
      data['total'] = total!.toJson();
    }
    data['name'] = name;
    data['instance'] = instance;
    return data;
  }
}

class Total {
  int? memory;
  int? disk;
  int? cpu;
  int? pod;
  Unit? unit;

  Total({memory, disk, cpu, pod, unit});

  Total.fromJson(Map<String, dynamic> json) {
    memory = json['memory'];
    disk = json['disk'];
    cpu = json['cpu'];
    pod = json['pod'];
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memory'] = memory;
    data['disk'] = disk;
    data['cpu'] = cpu;
    data['pod'] = pod;
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    return data;
  }
}
