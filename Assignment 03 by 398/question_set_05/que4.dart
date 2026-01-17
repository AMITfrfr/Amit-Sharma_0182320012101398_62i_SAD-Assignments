import 'dart:io';

void main() async {
  File source = File('hello.txt');
  File destination = File('hello_copy.txt');
  await destination.writeAsBytes(await source.readAsBytes());
  print('File copied to hello_copy.txt');
}