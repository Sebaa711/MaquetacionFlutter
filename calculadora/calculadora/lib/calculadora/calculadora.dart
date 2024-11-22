import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _Calculadora();
}

class _CalculadoraButton extends StatelessWidget {
  final String text;
  final void Function(String text) onPressed;
  final Map<String, Icon> icons = {
    "DEL": const Icon(
      Icons.backspace,
      color: Colors.black,
      size: 24,
    ),
    "%": const Icon(
      Icons.percent,
      color: Colors.black,
      size: 24,
    ),
    "*": const Icon(
      Icons.close,
      color: Colors.black,
      size: 24,
    ),
    "-": const Icon(
      Icons.remove,
      color: Colors.black,
      size: 24,
    ),
    "+": const Icon(
      Icons.add,
      color: Colors.black,
      size: 24,
    ),
  };

  final List<String> secondaryButtons = ["DEL", "AC", "%", "/", "*", "-", "+"];
  final List<String> primaryButtons = ["="];

  _CalculadoraButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => onPressed(text),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primaryButtons.contains(text)
            ? Theme.of(context).primaryColor
            : secondaryButtons.contains(text)
                ? Theme.of(context).colorScheme.secondary
                : Colors.transparent),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          text == "="
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
              : const CircleBorder(),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.all(5),
        ),
        fixedSize: text == "="
            ? const WidgetStatePropertyAll(Size.fromHeight(35))
            : const WidgetStatePropertyAll(Size(55, 55)),
      ),
      child: icons.containsKey(text)
          ? icons[text]
          : Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: text == "=" ? Colors.white : Colors.black),
            ),
    );
  }
}

class _Calculadora extends State<Calculadora> {
  String currentInput = "";
  String? currentResult;

  void _onPressed(String text) {
    if (text == "." &&
        (currentInput.isEmpty || !RegExp(r'\d$').hasMatch(currentInput))) {
      return;
    } else if (RegExp(r'[+\-*/%=]').hasMatch(text) &&
        (currentInput.isEmpty || RegExp(r'[+\-*/%]$').hasMatch(currentInput))) {
      return;
    }

    setState(() {
      if (text == "AC") {
        currentInput = "";
        currentResult = null;
      } else if (text == "DEL") {
        currentInput = currentInput.substring(0, currentInput.length - 1);
      } else if (text == "=") {
        currentResult = _calculate(currentInput).toString();
        currentInput = "";
      } else {
        currentInput += text;
      }
    });
  }

  double? _calculate(String input) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(currentInput,
                          style: const TextStyle(
                              fontSize: 24, color: Colors.grey)),
                      const SizedBox(height: 10),
                      Text(
                        currentResult?.toString() ?? '',
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Column(
                children: _buildButtonRows([
                  ["AC", "DEL", "%", "/"],
                  ["7", "8", "9", "*"],
                  ["4", "5", "6", "-"],
                  ["1", "2", "3", "+"],
                  ["0", ".", "="],
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildButtonRows(List<List<String>> buttons) {
    return buttons.map((row) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: row.map((text) {
          return Expanded(
            flex: text == "=" ? 2 : 1,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: _CalculadoraButton(text: text, onPressed: _onPressed),
            ),
          );
        }).toList(),
      );
    }).toList();
  }
}
