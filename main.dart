import 'package:flutter/material.dart';
import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/gui/toptab.dart';
import 'package:provider/provider.dart';

import 'calc/class_input.dart';

void main() {
  runApp(
    MultiProvider(providers: [ChangeNotifierProvider(create: (context) => AppController.inputInfo)],
      child: Consumer<InputInfo>(builder: (context, cart, child) => MyApp()
      )
    ) 
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2,
        child: TopTab(),
      )


    );
  }
}

