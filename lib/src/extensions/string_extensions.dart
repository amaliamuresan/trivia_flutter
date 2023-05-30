import 'package:html/parser.dart';

extension StringExtensions on String {
  String convertFromHtmlText() {
    return parse(this).body!.text;
  }
}
