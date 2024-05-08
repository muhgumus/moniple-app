class PvcModel {
  String? status;
  String? key;
  List<Data>? data;

  PvcModel({status, key, data});

  PvcModel.fromJson(Map<String, dynamic> json) {
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
  Total? total;
  String? namespace;
  String? persistentvolumeclaim;

  Data({usage, total, namespace, persistentvolumeclaim});

  Data.fromJson(Map<String, dynamic> json) {
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
    total = json['total'] != null ? Total.fromJson(json['total']) : null;
    namespace = json['namespace'];
    persistentvolumeclaim = json['persistentvolumeclaim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usage != null) {
      data['usage'] = usage!.toJson();
    }
    if (total != null) {
      data['total'] = total!.toJson();
    }
    data['namespace'] = namespace;
    data['persistentvolumeclaim'] = persistentvolumeclaim;
    return data;
  }
}

class Usage {
  int? pvc;
  Unit? unit;

  Usage({pvc, unit});

  Usage.fromJson(Map<String, dynamic> json) {
    pvc = json['pvc'];
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pvc'] = pvc;
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    return data;
  }
}

class Unit {
  String? pvc;

  Unit({pvc});

  Unit.fromJson(Map<String, dynamic> json) {
    pvc = json['pvc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pvc'] = pvc;
    return data;
  }
}

class Total {
  int? pvc;
  Unit? unit;

  Total({pvc, unit});

  Total.fromJson(Map<String, dynamic> json) {
    pvc = json['pvc'];
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pvc'] = pvc;
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    return data;
  }
}
