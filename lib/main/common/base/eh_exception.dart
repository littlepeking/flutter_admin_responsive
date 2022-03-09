class EHException implements Exception {
  String message;

  EHException(this.message) {
    this.message = message;
  }
  @override
  String toString() {
    return message;
  }
}
