class HelpCenterModel {
  final String message;

  const HelpCenterModel({required this.message});

  factory HelpCenterModel.fromJson(Map<String, dynamic> json) {
    return HelpCenterModel(message: json['message'] as String);
  }
}
