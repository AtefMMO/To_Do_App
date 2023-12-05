import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  Widget? icon;
  bool isObsecure;
  TextInputType? keyboardType;
  String? Function(String?) validator;
  Function(String?) onChanged;
  CustomTextFormField(
      {required this.label,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.isObsecure = false,
      this.icon,
      this.onChanged = _defaultOnChanged});
  static void _defaultOnChanged(
      String?
          value) {} //function that does nothing just to give def value to onChnaged
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: icon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 3)),
          label: Text(
            '$label',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 3)),
        ),
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isObsecure,
      ),
    );
  }
}
