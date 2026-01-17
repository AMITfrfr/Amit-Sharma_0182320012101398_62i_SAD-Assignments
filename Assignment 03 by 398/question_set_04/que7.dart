void main() {
  Map<String, String> contacts = {
    'Amit': '017000890123',
    'Sharma': '018000780456',
    'Jinwoo': '016009980789',
    'Paimon': '0178900012',
  };

  var keysWithLength4 = contacts.keys.where((key) => key.length == 4);
  print("Keys with length 4: $keysWithLength4");
}