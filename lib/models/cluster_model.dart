class ClusterModel {
  List<Cluster>? data;
  String? key;

  ClusterModel({this.data, this.key});

  ClusterModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Cluster>[];
      json['data'].forEach((v) {
        data!.add(new Cluster.fromJson(v));
      });
    }
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['key'] = this.key;
    return data;
  }
}

class Cluster {
  String? name;
  String? address;
  String? color;

  Cluster({this.name, this.address, this.color});

  Cluster.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['color'] = this.color;
    return data;
  }
}
