import 'steps.dart';

class AnalyzedInstruction {
  String? name;
  List<Steps>? steps;

  AnalyzedInstruction({this.name, this.steps});

  factory AnalyzedInstruction.fromJson(json) {
    return AnalyzedInstruction(
      name: json['name'] as String?,
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => Steps.fromJson(e))
          .toList(),
    );
  }

  toJson() => {
        'name': name,
        'steps': steps?.map((e) => e.toJson()).toList(),
      };
}
