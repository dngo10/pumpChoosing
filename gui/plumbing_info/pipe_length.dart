import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PipeLength extends StatefulWidget{
  TextEditingController pipeLengthCtrl = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return _PipeLength();
  }

}

class _PipeLength extends State<PipeLength>{
  @override
  Widget build(BuildContext context) {

    return 
    Row(children: [
      SizedBox(
        width: 150,
        child: TextField(
          controller: widget.pipeLengthCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Pipe Length:",
            suffixText: "ft",
            ),
        ),
      ),
    ],);

  }

}