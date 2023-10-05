import 'package:flutter/material.dart';

import '../components/widgets/gluon_text_form_field.dart';

class WidgetTestScreen extends StatefulWidget {
  const WidgetTestScreen({super.key});

  @override
  State<WidgetTestScreen> createState() => _WidgetTestScreenState();
}

class _WidgetTestScreenState extends State<WidgetTestScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Converter App')),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        'Success set name: ${_textController.text}',
                      ),
                    ),
                  );
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ],
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            GluonTextFormField(
              controller: _textController,
              onChanged: (value) => _formKey.currentState?.validate(),
              onFieldSubmitted: (value) => _formKey.currentState?.validate(),
              validator: (value) =>
                  (value?.isEmpty ?? true) ? 'Username cannot be empty' : null,
              decoration: const InputDecoration(
                hintText: 'Username',
                prefixIcon: Icon(Icons.person_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
