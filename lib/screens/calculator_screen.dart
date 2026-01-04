import "package:flutter/material.dart";
import "package:math_expressions/math_expressions.dart";

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String _calculatorInput = "";
  String _calculatorOutput = "";
  String _calculatorError = "";

  static const List<List<String>> _buttons = [
    ["C", "()", "%", "÷"],
    ["7", "8", "9", "×"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+"],
    ["±", "0", ",", "="],
  ];

  void _handleButtonClick(String value) {
    setState(() {
      // Clear errors
      _calculatorError = "";

      if (value == "C") {
        _calculatorInput = "";
        _calculatorOutput = "";
        _calculatorError = "";
      } else if (value == "=") {
        if (_calculatorInput.isEmpty) return;

        try {
          // replace screen symbols with math symbols
          String expressionSymbols = _calculatorInput
              .replaceAll("÷", "/")
              .replaceAll("×", "*")
              .replaceAll("%", "*0.01");

          // Parse and evaluate expression
          ExpressionParser parser = ShuntingYardParser();
          Expression expression = parser.parse(expressionSymbols);
          ContextModel contextModel = ContextModel();

          var evaluator = RealEvaluator(contextModel);
          num result = evaluator.evaluate(expression);

          // Format the result
          _calculatorOutput = _formatNumber(result);

          // Set the result as new input for further calculations
          _calculatorInput = _calculatorOutput;
        } catch (e) {
          _calculatorError = "Invalid expression";
          _calculatorOutput = "Error";
        }
      } else if (value == "±") {
        // Toggle positive/negative
        if (_calculatorInput.isNotEmpty && !_endsWithOperator()) {
          // Find the last number
          final numbers = _calculatorInput.split(RegExp(r"[+\-×÷%]"));
          if (numbers.isNotEmpty) {
            final lastNumber = numbers.last;
            if (lastNumber.isNotEmpty) {
              if (lastNumber.startsWith("-")) {
                _calculatorInput =
                    _calculatorInput.substring(
                      0,
                      _calculatorInput.length - lastNumber.length,
                    ) +
                    lastNumber.substring(1);
              } else {
                _calculatorInput =
                    _calculatorInput.substring(
                      0,
                      _calculatorInput.length - lastNumber.length,
                    ) +
                    "-" +
                    lastNumber;
              }
            }
          }
        }
      } else if (value == "()") {
        // Parentheses logic
        int openCount = _calculatorInput.split("(").length - 1;
        int closeCount = _calculatorInput.split(")").length - 1;

        if (openCount == closeCount ||
            _endsWithOperator() ||
            _calculatorInput.isEmpty) {
          _calculatorInput += "(";
        } else {
          _calculatorInput += ")";
        }
      } else {
        // Prevent multiple decimal points in a number
        if (value == "." && _endsWithNumberContainingDecimal()) {
          return;
        }

        // Prevent operators at the start (except minus for negative numbers)
        if (_isOperator(value) && _calculatorInput.isEmpty && value != "-") {
          return;
        }

        // Prevent consecutive operators
        if (_isOperator(value) && _endsWithOperator()) {
          return;
        }

        _calculatorInput += value;
      }
    });
  }

  bool _isOperator(String value) {
    return ["+", "-", "×", "÷", "%"].contains(value);
  }

  bool _endsWithOperator() {
    if (_calculatorInput.isEmpty) return false;

    final lastCharacter = _calculatorInput[_calculatorInput.length - 1];

    return _isOperator(lastCharacter);
  }

  bool _endsWithNumberContainingDecimal() {
    if (_calculatorInput.isEmpty) return false;

    // Find the last number in the expression
    final numbers = _calculatorInput.split(RegExp(r"[+\-×÷%]"));

    if (numbers.isEmpty) return false;

    final lastNumber = numbers.last;

    return lastNumber.contains(".");
  }

  String _formatNumber(num number) {
    // If it's an integer, remove decimal
    if (number % 1 == 0) {
      return number.toInt().toString();
    }

    // Remove trailing zeros
    String string = number.toString();
    if (string.contains(".")) {
      string = string.replaceAll(RegExp(r"0+$"), "");
      string = string.replaceAll(RegExp(r"\.$"), "");
    }

    // Handle very large/small numbers with scientific notation
    if (string.length > 12) {
      return number.toStringAsExponential();
    }

    return string;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(title: const Text("Calculator"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 312,
                      child: Card(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            crossAxisAlignment: .end,
                            children: [
                              // Display
                              _buildDisplay(),

                              const SizedBox(height: 8),
                              const Divider(),
                              const SizedBox(height: 8),

                              // Buttons
                              _buildButtons(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDisplay() {
    return Column(
      mainAxisAlignment: .end,
      crossAxisAlignment: .end,
      children: [
        // Input
        Text(
          _calculatorInput.isEmpty ? "0" : _calculatorInput,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        const SizedBox(height: 8),

        // Output
        Text(
          _calculatorOutput,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        // Error
        if (_calculatorError.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            _calculatorError,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildButtons() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _buttons.expand((e) => e).length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final value = _buttons.expand((row) => row).toList()[index];
        final isPrimary = value == "C" || value == "=";
        final isOperator = _isOperator(value);

        return isPrimary
            ? FilledButton(
                onPressed: () => _handleButtonClick(value),
                child: Text(value),
              )
            : OutlinedButton(
                onPressed: () => _handleButtonClick(value),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isOperator
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                child: Text(value, style: const TextStyle(fontSize: 18)),
              );
      },
    );
  }
}
