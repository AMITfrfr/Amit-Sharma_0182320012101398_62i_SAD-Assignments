String reverseString(String str) {
  return str.split('').reversed.join();
}

void main() {
  print(reverseString("Dart"));
}