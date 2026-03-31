class PolicyModel {
  final String id;
  final String type; // "PRIVACY_POLICY" | "TERMS_AND_CONDITIONS"
  final String content;
  final DateTime effectiveDate;
  final DateTime updatedAt;

  const PolicyModel({
    required this.id,
    required this.type,
    required this.content,
    required this.effectiveDate,
    required this.updatedAt,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      id: json['id'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      effectiveDate: DateTime.parse(json['effectiveDate'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'content': content,
    'effectiveDate': effectiveDate.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  bool get isPrivacyPolicy => type == 'PRIVACY_POLICY';
  bool get isTermsAndConditions => type == 'TERMS_AND_CONDITIONS';
}
