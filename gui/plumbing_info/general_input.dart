import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralInput extends StatefulWidget{
  TextEditingController pipeLengthCtrl = TextEditingController();
  String unit;
  String label;
  String tip;
  int flag = 1;
  Function func;

  GeneralInput(this.unit, this.label, this.pipeLengthCtrl, this.tip, this.func, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GeneralInput();
  }

}

class _GeneralInput extends State<GeneralInput>{
  @override
  Widget build(BuildContext context) {

    return 
    SizedBox(
      width: 200,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Tooltip(
              message: widget.tip,
              child: TextField(
                style: const TextStyle(
                  fontSize: 14
                ),
                controller: widget.pipeLengthCtrl,
                decoration: InputDecoration(
                  labelText: "${widget.label}:",
                  suffixText: widget.unit,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  suffixStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary
                  )
                  ),
                  onChanged:(value) {
                    widget.func(value);
                  },
              ),
            ),
          ),
        ],
      ),
    );

  }
}

class TitleText extends StatelessWidget{
  String title;
  TitleText(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
          title.toUpperCase(), 
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        );
  }

}