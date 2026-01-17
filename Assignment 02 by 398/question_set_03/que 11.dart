void createUser(String name, int age, {bool isActive = true}) {
  print("Name: $name, Age: $age, Active: $isActive");
}

void main() {
  createUser("Sharma", 21);
  createUser("Amit", 25, isActive: false);
}