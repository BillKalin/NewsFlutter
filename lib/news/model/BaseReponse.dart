class BaseResponse {
  final bool error;
  final List results;

  BaseResponse({this.error, this.results});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(error: json['error'], results: json['results'] as List);
  }

  Map<String, dynamic> toJson() {
    return {'error': error, 'results': results};
  }
}
