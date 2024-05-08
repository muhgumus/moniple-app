class NsModel {
  List<String>? data;
  String? key;

  NsModel({data, key});

  NsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    data['key'] = key;
    return data;
  }
}
