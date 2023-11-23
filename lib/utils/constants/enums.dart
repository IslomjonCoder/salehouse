/// LIST of Enums
/// They cannot be created in a class.
library;
enum Languages { uz, ru, en, crylic }

enum Status { initial, loading, success, failure }

extension ExtStatus on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
}