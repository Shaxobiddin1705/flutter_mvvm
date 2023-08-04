class Result<T> {
  Status status;
  T? data;
  String? message;
  List<String>? errorCodes;
  dynamic errorData;

  Result.completed(this.data, [this.message]) : status = Status.completed;

  Result.error(
      this.message, {
        this.errorCodes,
        this.errorData,
      }) : status = Status.error;

  @override
  String toString() {
    return '$status $message $data';
  }
}

enum Status { completed, error }