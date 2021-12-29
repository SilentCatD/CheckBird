import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class PickColor extends StatefulWidget {
  const PickColor(
      {Key? key,
      required this.backgroundColor,
      required this.textColor,
      required this.setBackgroundColor,
      required this.setTextColor})
      : super(key: key);
  final Color backgroundColor;
  final Color textColor;
  final void Function(Color color) setBackgroundColor;
  final void Function(Color color) setTextColor;

  @override
  _PickColorState createState() => _PickColorState();
}

class _PickColorState extends State<PickColor> {
  bool _preview = false;

  Future<Color?> _pickColor(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Color? pickedColor;
    Color? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: MaterialColorPicker(
            colors: fullMaterialColors,
            onMainColorChange: (color) {
              pickedColor = color;
            },
            allowShades: false,
          ),
          actions: [
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop(pickedColor);
              },
            ),
          ],
        );
      },
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: Column(
            children: [
              ListTile(
                title: const Text("Background color"),
                trailing: CircleColor(
                  color: widget.backgroundColor,
                  circleSize: 30,
                ),
                onTap: () async {
                  final color = await _pickColor(context);
                  if (color != null) widget.setBackgroundColor(color);
                },
              ),
              ListTile(
                title: const Text("Text color"),
                trailing: CircleColor(
                  color: widget.textColor,
                  circleSize: 30,
                ),
                onTap: () async {
                  final color = await _pickColor(context);
                  if (color != null) widget.setTextColor(color);
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _preview = !_preview;
                      });
                    },
                    child: const Text("Toggle preview")),
              ),
              if (_preview)
                Container(
                  width: constraints.maxWidth,
                  color: Colors.black12,
                  child: Center(
                    child: SizedBox(
                      width: constraints.maxWidth * 0.3,
                      height: constraints.maxWidth * 0.3,
                      child: Card(
                        child: Container(
                          color: widget.backgroundColor,
                          child: Center(
                              child: Text(
                            "Hello world",
                            style: TextStyle(
                              color: widget.textColor,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
