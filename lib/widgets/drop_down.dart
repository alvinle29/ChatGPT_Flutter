import 'package:flutter/material.dart';

class ModelDropDownWidget extends StatefulWidget {
  const ModelDropDownWidget({Key? key}) : super(key: key);

  @override
  State<ModelDropDownWidget> createState() => _ModelDropDownWidgetState();
}

class _ModelDropDownWidgetState extends State<ModelDropDownWidget> {
  String currentModel = "Model1";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        items: [],
        value: currentModel,
        onChanged: (value) {
          setState(() {
            currentModel = value.toString();
          });
        });
  }
}
