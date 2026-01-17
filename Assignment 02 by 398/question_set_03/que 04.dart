import 'dart:math';

String generatePassword(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#\$%&';
  Random rnd = Random();
  return List.generate(length, (index) => chars[rnd.nextInt(chars.length)]).join();
}

void main() {
  print(generatePassword(10));
}