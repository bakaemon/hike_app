import 'package:flutter/material.dart';

class TextInputUtil {
  static Widget input({
    String? label,
    String? hint,
    String? initialValue,
    bool obscureText = false,
    bool readOnly = false,
    bool enabled = true,
    bool autofocus = false,
    bool autocorrect = true,
    bool enableSuggestions = true,
    bool autovalidate = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
    void Function()? onTap,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      initialValue: initialValue,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      autofocus: autofocus,
      autocorrect: autocorrect,
      keyboardType: keyboardType,
      enableSuggestions: enableSuggestions,
      autovalidateMode: autovalidate ? AutovalidateMode.always : null,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // radio group of buttons
  static Widget radioGroup<T>({
    required String label,
    required Map<String, T> items,
    required T groupValue,
    String? errorText,
    required void Function(T?) onChanged,
  }) {
    return Column(
      children: [
        Text(label),
        ...items.entries
            .map(
              (e) => Row(
                children: [
                  Radio<T>(
                    value: e.value,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    // show red border if error
                    fillColor: MaterialStateProperty.all<Color>(
                      errorText != null ? Colors.red : Colors.blue,
                    ),
                  ),
                  Text(e.key),
                ],
              ),
            )
            .toList(),
        if (errorText != null)
          Text(
            errorText,
            style: const TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
