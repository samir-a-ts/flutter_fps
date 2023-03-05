import 'package:flutter/widgets.dart';
import 'package:flutter_fps/features/app/app.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}
