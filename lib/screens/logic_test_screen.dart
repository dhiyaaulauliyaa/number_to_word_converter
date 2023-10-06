import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/extensions/string_extension.dart';
import '../components/utils/number_converter_util.dart';
import '../components/widgets/gluon_text_form_field.dart';

class LogicTestScreen extends StatefulWidget {
  const LogicTestScreen({super.key});

  @override
  State<LogicTestScreen> createState() => _LogicTestScreenState();
}

class _LogicTestScreenState extends State<LogicTestScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _inputController;
  late final TextEditingController _outputController;

  @override
  void initState() {
    _inputController = TextEditingController();
    _outputController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Converter app')),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 200),
        color: Theme.of(context).secondaryHeaderColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).popUntil(
                (route) => route.isFirst,
              ),
              behavior: HitTestBehavior.opaque,
              child: Text(
                'Home',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _onInputSubmitted(_inputController.text);
              }
            },
            child: const Text('Convert'),
          ),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Please enter an integer number in the "Input" box and tap on '
            '"Convert" to see the equivalent in words appear in the '
            '"Output box".',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              children: [
                GluonTextFormField(
                  controller: _inputController,
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onFieldSubmitted: _onInputSubmitted,
                  decoration: const InputDecoration(
                    hintText: 'Input',
                    counter: SizedBox(),
                  ),
                  validator: _inputValidator,
                ),
                GluonTextFormField(
                  controller: _outputController,
                  enabled: false,
                  maxLines: null,
                  decoration: const InputDecoration(hintText: 'Output'),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onInputSubmitted(String value) {
    var number = int.tryParse(value);
    if (number == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Invalid number')),
        );
    }

    _outputController.text = '${NumberConverterUtil.numberToWords(
      number!,
    ).toSentenceCase}.';
  }

  String? _inputValidator(value) {
    if (value?.isEmpty ?? true) {
      return 'Input cannot be empty';
    }

    var integerVal = int.tryParse(value!);

    if (integerVal == null) {
      return 'Please only input digits';
    }

    if (integerVal > 999999999999999) {
      return 'Maximum value is 999,999,999,999,999';
    }

    return null;
  }
}
