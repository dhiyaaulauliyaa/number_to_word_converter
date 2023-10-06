import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'error_tooltip.dart';

class GluonTextFormField extends StatelessWidget {
  GluonTextFormField({
    super.key,
    this.controller,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.enabled,
    this.style,
    this.decoration,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? enabled;
  final TextStyle? style;
  final int? maxLines;

  final InputDecoration? decoration;

  final _hideTooltip = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (decoration?.hintText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(decoration!.hintText!),
          ),
        FormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          builder: (field) => Stack(
            clipBehavior: Clip.none,
            children: [
              TextFormField(
                controller: controller,
                style: style,
                maxLines: maxLines,
                enabled: enabled,
                onFieldSubmitted: onFieldSubmitted,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                maxLength: maxLength,
                onChanged: (value) {
                  onChanged?.call(value);
                  field.didChange(value);

                  if (_hideTooltip.value) {
                    _hideTooltip.value = value.isNotEmpty;
                  }
                },
                decoration: decoration?.copyWith(
                  errorText: '',
                  suffixIcon: field.hasError
                      ? GestureDetector(
                          onTap: () => _hideTooltip.value = !_hideTooltip.value,
                          child: Icon(
                            Icons.info_rounded,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        )
                      : decoration?.suffixIcon,
                ),
              ),
              Positioned(
                top: -24,
                right: 8,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _hideTooltip,
                  builder: (_, value, child) {
                    return AnimatedCrossFade(
                      duration: const Duration(milliseconds: 150),
                      reverseDuration: const Duration(milliseconds: 50),
                      sizeCurve: Curves.easeOut,
                      firstCurve: Curves.easeOut,
                      secondCurve: Curves.easeOut,
                      crossFadeState: field.errorText == null || value
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      secondChild: child!,
                    );
                  },
                  child: ErrorTooltip(
                    text: field.errorText ?? '      ',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
