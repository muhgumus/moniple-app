class AlertModel {
  String? status;
  Data? data;
  String? key;

  AlertModel({status, data, key});

  AlertModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data!.toJson();
    data['key'] = key;
    return data;
  }
}

class Data {
  List<Alerts>? alerts;

  Data({alerts});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['alerts'] != null) {
      alerts = <Alerts>[];
      json['alerts'].forEach((v) {
        alerts!.add(Alerts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (alerts != null) {
      data['alerts'] = alerts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alerts {
  Labels? labels;
  Annotations? annotations;
  String? state;
  String? activeAt;
  String? value;

  Alerts({labels, annotations, state, activeAt, value});

  Alerts.fromJson(Map<String, dynamic> json) {
    labels = json['labels'] != null ? Labels.fromJson(json['labels']) : null;
    annotations = json['annotations'] != null
        ? Annotations.fromJson(json['annotations'])
        : null;
    state = json['state'];
    activeAt = json['activeAt'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (labels != null) {
      data['labels'] = labels!.toJson();
    }
    if (annotations != null) {
      data['annotations'] = annotations!.toJson();
    }
    data['state'] = state;
    data['activeAt'] = activeAt;
    data['value'] = value;
    return data;
  }
}

class Labels {
  String? alertname;
  String? severity;
  String? databaseName;
  String? endpoint;
  String? instance;
  String? job;
  String? namespace;
  String? pod;
  String? service;
  String? container;
  String? metricsPath;
  String? node;
  String? persistentvolumeclaim;
  String? controller;
  String? status;
  String? ruleGroup;

  Labels(
      {alertname,
      severity,
      databaseName,
      endpoint,
      instance,
      job,
      namespace,
      pod,
      service,
      container,
      metricsPath,
      node,
      persistentvolumeclaim,
      controller,
      status,
      ruleGroup});

  Labels.fromJson(Map<String, dynamic> json) {
    alertname = json['alertname'];
    severity = json['severity'];
    databaseName = json['database_name'];
    endpoint = json['endpoint'];
    instance = json['instance'];
    job = json['job'];
    namespace = json['namespace'];
    pod = json['pod'];
    service = json['service'];
    container = json['container'];
    metricsPath = json['metrics_path'];
    node = json['node'];
    persistentvolumeclaim = json['persistentvolumeclaim'];
    controller = json['controller'];
    status = json['status'];
    ruleGroup = json['rule_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alertname'] = alertname;
    data['severity'] = severity;
    data['database_name'] = databaseName;
    data['endpoint'] = endpoint;
    data['instance'] = instance;
    data['job'] = job;
    data['namespace'] = namespace;
    data['pod'] = pod;
    data['service'] = service;
    data['container'] = container;
    data['metrics_path'] = metricsPath;
    data['node'] = node;
    data['persistentvolumeclaim'] = persistentvolumeclaim;
    data['controller'] = controller;
    data['status'] = status;
    data['rule_group'] = ruleGroup;
    return data;
  }
}

class Annotations {
  String? description;
  String? runbookUrl;
  String? summary;

  Annotations({description, runbookUrl, summary});

  Annotations.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    runbookUrl = json['runbook_url'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['runbook_url'] = runbookUrl;
    data['summary'] = summary;
    return data;
  }
}
