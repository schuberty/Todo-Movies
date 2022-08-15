class ErrorData {
  final int? statusCode;
  final String? detail;

  bool get isClientError => (statusCode == null) && (detail == null);

  ErrorData({this.statusCode, this.detail});

  @override
  String toString() {
    final statusString = statusCode ?? '_';
    final detailString = detail != null ? '=> $detail' : '';
    return 'ErrorData($statusString) $detailString';
  }
}
