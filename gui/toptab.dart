import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/gui/graphic_page/graphic_page_main.dart';
import 'package:my_app/gui/plumbing_info/column_plumbing.dart';

class TopTab extends StatefulWidget{
  

  @override
  State<StatefulWidget> createState() {
    return _TopTab();
  }
}

class _TopTab extends State<TopTab>{
  @override
  void initState() {
    super.initState();

    AppController.readData();

  }

  @override
  Widget build(BuildContext context) {
    return  
      DefaultTabController(
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
            AppController.inputInfo.reCalculateData();
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => GraphicPage())
              );
          },
          child: const Icon(Icons.auto_graph),),
      )
    );
  }

} 