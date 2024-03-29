import 'package:mocktail/mocktail.dart';

extension VerificationResultExt on VerificationResult {
  void calledOnce() => called(1);
}