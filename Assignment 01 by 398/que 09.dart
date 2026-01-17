void main() {
  String text = "  Hello   Dart   Language  ";
  String result = text.replaceAll(" ", "");
  print("String without spaces: '$result'");
}