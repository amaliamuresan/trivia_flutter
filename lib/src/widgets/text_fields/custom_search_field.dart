import 'package:flutter/material.dart';
import 'package:trivia_app/src/style/colors.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField(
      {super.key, this.onEditingComplete, this.isEnabled = true});

  final void Function(String)? onEditingComplete;
  final bool isEnabled;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onEditingComplete: widget.onEditingComplete != null
          ? () => widget.onEditingComplete!(textController.text)
          : null,
      enabled: widget.isEnabled,
      decoration: InputDecoration(
        filled: true,
        prefixIconColor: AppColors.greyLight,
        fillColor: AppColors.surface,
        hintText: 'Search something',
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
        focusedBorder: inputBorder,
        prefixIcon: const Icon(Icons.search),
        border: inputBorder,
      ),
    );
  }

  InputBorder get inputBorder => const OutlineInputBorder(
        borderSide: BorderSide(style: BorderStyle.none),
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      );

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
