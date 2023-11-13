import '../../design/color/color_manager.dart';
import '../../export.dart';
import '../../feature/common/widget/app_scroll_behavior.dart';
import '../router/app_router.dart';

Future<void> bootStrap() async {
  await registerSingletons();
  _registerErrorHandler();
  runApp(const BootStrapApp());
}

void _registerErrorHandler() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    log.e('flutter Error Occurred', error: details.exception, stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    log.e('Platform Error Occurred', error: exception, stackTrace: stackTrace);
    return true;
  };
}

class BootStrapApp extends StatelessWidget with WatchItMixin {
  const BootStrapApp({super.key});

  @override
  Widget build(BuildContext context) {
    var isDarkMode = watchPropertyValue((ColorManager settings) => settings.isDarkMode);

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme.instance.createTheme(Brightness.light),
      darkTheme: AppTheme.instance.createTheme(Brightness.dark),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      scrollBehavior: const AppScrollBehavior(),
    );
  }
}
