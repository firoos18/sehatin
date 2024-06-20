abstract class Failures {
  final String message;

  const Failures(this.message);
}

class RequestFailures implements Failures {
  @override
  final String message;

  RequestFailures(this.message);
}
