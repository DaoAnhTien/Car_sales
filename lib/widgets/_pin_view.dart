import 'package:flutter/material.dart';

class PinView extends StatefulWidget {
  final Function submit;
  final int count;
  final bool obscureText;
  final bool autoFocusFirstField;
  final bool enabled;
  final List<int> dashPositions;
  final TextStyle style;
  final TextStyle dashStyle;
  final InputDecoration inputDecoration;
  final EdgeInsetsGeometry margin;
  final Color underLineColor;

  PinView(
      {required this.submit,
      required this.count,
      this.obscureText: false,
      this.autoFocusFirstField: true,
      this.enabled: true,
      this.dashPositions: const [],
      this.underLineColor: Colors.red,
      this.dashStyle: const TextStyle(fontSize: 30.0, color: Colors.grey),
      this.style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
      this.inputDecoration:
          const InputDecoration(border: UnderlineInputBorder()),
      this.margin: const EdgeInsets.all(5.0)});

  @override
  _PinViewState createState() => _PinViewState();
}

class _PinViewState extends State<PinView> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late List<String> _pin;
  late int _lastIndex;

  @override
  void initState() {
    super.initState();
    _lastIndex = 0;
    _pin = List<String>.generate(widget.count, (int index) => '');
    _focusNodes =
        List.generate(widget.count, (int index) => FocusNode()).toList();
    _controllers =
        List.generate(widget.count, (int index) => TextEditingController());
  }

  Widget _dash() {
    return Flexible(flex: 1, child: Text('-', style: widget.dashStyle));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pins = List<Widget>.generate(
        widget.count, (int index) => _singlePinView(index)).toList();

    for (int i in widget.dashPositions) {
      if (i <= widget.count) {
        List<int> smaller =
            widget.dashPositions.where((int d) => d < i).toList();
        pins.insert(i + smaller.length, _dash());
      }
    }

    return Container(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: pins),
    );
  }

  Widget _singlePinView(int index) {
    return Flexible(
        flex: 3,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    width: 0.5,
                    color: Color.fromRGBO(52, 67, 86, 0.2),
                    style: BorderStyle.solid)),
            margin: widget.margin,
            child: new Theme(
                data: new ThemeData(
                    primaryColor: widget.underLineColor,
                    // accentColor: widget.underLineColor,
                    hintColor: widget.underLineColor),
                child: TextField(
                  enabled: widget.enabled,
                  controller: _controllers[index],
                  obscureText: widget.obscureText,
                  autofocus: widget.autoFocusFirstField ? index == 0 : false,
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: widget.style,
                  decoration: widget.inputDecoration,
                  textInputAction: TextInputAction.next,
                  cursorColor: widget.underLineColor,
                  onTap: () {
                    if (index != _lastIndex) {
                      FocusScope.of(context)
                          .requestFocus(_focusNodes[_lastIndex]);
                    }
                  },
                  onChanged: (String val) {
                    if (val.length == 1) {
                      _pin[index] = val;
                    } else if (val.length == 2) {
                      _controllers[index].text = val.substring(0, 1);
                      _pin[index] = val.substring(0, 1);
                      if ((index + 1) < _controllers.length) {
                        _controllers[index + 1].text = '';
                        _controllers[index + 1].text = val.substring(1);
                        _pin[index + 1] = val.substring(1);
                        _lastIndex = index + 1;
                        FocusScope.of(context)
                            .requestFocus(_focusNodes[index + 1]);
                      }
                    } else {
                      _pin[index] = '';
                      if (index != 0) {
                        _focusNodes[index].unfocus();
                        _lastIndex = index - 1;
                        FocusScope.of(context)
                            .requestFocus(_focusNodes[index - 1]);
                      }
                    }

                    if (_pin.indexOf('') == -1) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      widget.submit(_pin.join());
                    } else {
                      widget.submit('');
                    }
                  },
                ))));
  }
}
