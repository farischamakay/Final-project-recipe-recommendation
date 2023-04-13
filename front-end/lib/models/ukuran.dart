class Us {
  double? amount;
  String? unitShort;
  String? unitLong;
  Us({this.amount, this.unitShort, this.unitLong});

  factory Us.fromJson(json) => Us(
        amount: (json['amount'] as num?)?.toDouble(),
        unitShort: json['unitShort'] as String?,
        unitLong: json['unitLong'] as String?,
      );

  toJson() => {
        'amount': amount,
        'unitShort': unitShort,
        'unitLong': unitLong,
      };
}

class Metric {
  double? amount;
  String? unitShort;
  String? unitLong;

  Metric({this.amount, this.unitShort, this.unitLong});

  factory Metric.fromJson(json) => Metric(
        amount: (json['amount'] as num?)?.toDouble(),
        unitShort: json['unitShort'] as String?,
        unitLong: json['unitLong'] as String?,
      );

  toJson() => {
        'amount': amount,
        'unitShort': unitShort,
        'unitLong': unitLong,
      };
}

class Ukuran {
  Us? us;
  Metric? metric;

  Ukuran({this.us, this.metric});

  factory Ukuran.fromJson(json) => Ukuran(
        us: json['us'] == null ? null : Us.fromJson(json['us']),
        metric: json['metric'] == null ? null : Metric.fromJson(json['metric']),
      );

  toJson() => {
        'us': us?.toJson(),
        'metric': metric?.toJson(),
      };
}
