import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InflowUI extends StatefulWidget{
  final TextEditingController inflowCtroller = TextEditingController();
  String selectedText = "gpm";

  InflowUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InflowUi();
  }
}

class _InflowUi extends State<InflowUI>{
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 200,
        child: TextField(
          decoration: InputDecoration(
            labelText: "inflow",
            suffix: DropdownButton(items: <String>['gpm', 'dfu'].map((String value){
                        return DropdownMenuItem(
                          child: Text(value,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary
                            ),
                          ),
                          value: value,
                        );
                      }
                    ).toList(),
                    onChanged: (value){
                      setState(() {
                        widget.selectedText = value! as String;
                      });
                    },
                    value: widget.selectedText,
                    underline: const SizedBox(),
                    )
          ),
          keyboardType: TextInputType.number,
          controller: widget.inflowCtroller,
        ),
      ),
    );
  }

}