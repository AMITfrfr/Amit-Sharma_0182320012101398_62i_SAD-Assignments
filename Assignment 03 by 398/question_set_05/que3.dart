import 'dart:io';

void main() {
  Directory current = Directory.current;
  print('Current working directory: ${current.path}');
}