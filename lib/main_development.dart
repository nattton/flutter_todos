import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/bootstrap.dart';

void initDi() {
  // we use an async singleton that allows the app to wait for the SharedPreferences to be initialized
  // di
  //   ..registerSingletonAsync<SharedPreferences>(
  //     () async => SharedPreferences.getInstance(),
  //   )
  //   /// we ensure that the SharedPreferences is registered before the ApiClient
  //   /// we register the ApiClientImpl as the ApiClient
  //   ..registerSingletonWithDependencies<ApiClient>(
  //     () => ApiClientImpl(prefs: di<SharedPreferences>()),
  //     dependsOn: [SharedPreferences],
  //   );
}

Future<void> main() async {
  initDi();
  await bootstrap(() => const App());
}
