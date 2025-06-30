import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyForm extends StatefulWidget {
  final List<FormFieldData> fields;
  final String title;
  final String submitText;
  final void Function(Map<String, String>) onSubmit;

  const MyForm({
    super.key,
    required this.fields,
    required this.title,
    required this.onSubmit,
    required this.submitText,
  });

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (var field in widget.fields) {
      _controllers[field.name] = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...widget.fields.map((field) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextFormField(
                  controller: _controllers[field.name],
                  decoration: InputDecoration(
                    labelText: field.label,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: field.inputType,
                  maxLines: field.maxLines,
                  inputFormatters: field.inputFormatters,
                  validator: field.validator,
                ),
              );
            }),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final data = {
                    for (var field in widget.fields)
                      field.name: _controllers[field.name]!.text
                  };
                  widget.onSubmit(data);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('اطلاعات با موفقیت ثبت شد')),
                  );
                }
              },
              child: Text(widget.submitText),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

class FormFieldData {
  final String name;
  final String label;
  final TextInputType inputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int maxLines;

  FormFieldData({
    required this.name,
    required this.label,
    this.inputType = TextInputType.text,
    this.inputFormatters,
    this.validator,
    this.maxLines = 1,
  });
}
