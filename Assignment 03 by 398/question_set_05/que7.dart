import 'dart:io';

void main() {
  File file = File('students.csv');

  // Writing to CSV
  List<List<String>> students = [
    ['Name', 'Age', 'Address'],
    ['Amit', '22', 'Habiganj'],
    ['Jidan', '22', 'Boldi, Sylhet'],
    ['Farhan', '23', 'Shibganj, Sylhet'],
    ['Fayez', '22', 'Akhalia, Sylhet'],
    ['Aushfi', '23', 'Mirabazar, Sylhet'],
  ];

  String csvData = students.map((row) => row.join(',')).join('\n');
  file.writeAsStringSync(csvData);
  print('Data written to students.csv');

  // Reading from CSV
  print('\nReading data from students.csv:\n');
  List<String> lines = file.readAsLinesSync();
  for (var line in lines) {
    print(line);
  }
}