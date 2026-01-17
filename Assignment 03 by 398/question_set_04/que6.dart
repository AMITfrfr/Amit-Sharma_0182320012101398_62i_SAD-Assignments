void main() {
  
  Map<String, dynamic> person = {
    "name": "Amit Sharma",
    "address": "Sylhet, Bangladesh",
    "age": 22,
    "country": "Bangladesh",
  };

  print("Before update:");
  print(person);

  person["country"] = "United Kingdom";

  print("\nAfter update:");
  person.forEach((key, value) {
    print("$key: $value");
  });
}