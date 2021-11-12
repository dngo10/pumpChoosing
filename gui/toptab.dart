import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/calc/class_input.dart';
import 'package:my_app/gui/graphic_page/graphic_page.dart';
import 'package:my_app/gui/plumbing_info/column_plumbing.dart';
import 'package:provider/provider.dart';

class TopTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TopTab();
  }
}

class _TopTab extends State<TopTab>{
  @override
  Widget build(BuildContext context) {
    return  
      Consumer<InputInfo>(builder: (context, cart, child) => DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.edit)),
            Tab(icon: Icon(Icons.image)),
          ]),
          title: const Text("Pump App"),
        ),
        body: TabBarView(children: [
          ColumnPlumbing(),
          const Image(image: AssetImage('assets/images/pump1.png')),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => GraphicPage())
              );
          },
          child: const Icon(Icons.auto_graph),),
      )
    )
    );
  }

} 