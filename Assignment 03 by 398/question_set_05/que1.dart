import 'dart:io';

void main() {
  File file = File('hello.txt');
  file.writeAsStringSync('Amit\n');
  print('Your name has been written to hello.txt');
}