class PodModel {
  String? status;
  String? key;
  List<Data>? data;

  PodModel({status, key, data});

  PodModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    key = json['key'];
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
    data['data'] = this.data!.map((v) => v.toJson()).toList();
      return data;
  }
}

class Data {
  Usage? usage;
  String? namespace;
  String? phase;
  String? name;

  Data({usage, namespace, phase, name});

  Data.fromJson(Map<String, dynamic> json) {
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
    namespace = json['namespace'];
    phase = json['phase'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usage != null) {
      data['usage'] = usage!.toJson();
    }
    data['namespace'] = namespace;
    data['phase'] = phase;
    data['name'] = name;
    return data;
  }
}

class Usage {
  Unit? unit;
  double? cpu;
  double? memory;

  Usage({unit, cpu, memory});

  Usage.fromJson(Map<String, dynamic> json) {
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    cpu = (json['cpu'] ?? 0.0).toDouble();
    memory = (json['memory'] ?? 0.0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    data['cpu'] = cpu;
    data['memory'] = memory;
    return data;
  }
}

class Unit {
  String? cpu;
  String? memory;

  Unit({cpu, memory});

  Unit.fromJson(Map<String, dynamic> json) {
    cpu = json['cpu'];
    memory = json['memory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cpu'] = cpu;
    data['memory'] = memory;
    return data;
  }
}
