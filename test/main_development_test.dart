import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/local_api_client.dart';
import 'package:flutter_todos/main_development.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await di.reset();
    const channel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          channel,
          (MethodCall methodCall) async {
            return '.';
          },
        );
  });

  tearDown(() async {
    await di.reset();
  });

  test('configureDependencies registers LocalApiClient', () async {
    await configureDependencies();
    expect(di.isRegistered<ApiClient>(), isTrue);
    expect(di<ApiClient>(), isA<LocalApiClient>());
  });
}
