import 'package:clean_architecture_note/di/provider_setup.dart';
import 'package:clean_architecture_note/presentation/notes/notes_screen.dart';
import 'package:clean_architecture_note/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final providers = await getProviders();

  runApp(MultiProvider(
    providers: providers,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        unselectedWidgetColor: Colors.white,
          primaryColor: Colors.white,
          backgroundColor: darkgray,
          canvasColor: darkgray,
          floatingActionButtonTheme:
              Theme.of(context).floatingActionButtonTheme.copyWith(
                    backgroundColor: Colors.white,
                    foregroundColor: darkgray,
                  ),
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                backgroundColor: darkgray,
              ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
              )),
      home: const NoteScreen(),
    );
  }
}
