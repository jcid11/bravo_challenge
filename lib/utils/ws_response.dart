class WsResponse {
  final String? message;
  final bool success;
  final dynamic data;
  final int? statusCode;

  WsResponse(
      {this.message,
        required this.success,
        this.data,
        this.statusCode});
}