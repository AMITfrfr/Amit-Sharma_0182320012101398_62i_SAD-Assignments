enum Gender { Male, Female, Other }

class Person {
  String? Name;
  Gender? gender;

  Person(this.Name, this.gender);

  void display() {
    print("Name: $Name");
    print("Gender: $gender");
  }
}

void main() {
  Person p1 = Person("Amit", Gender.Male);
  p1.display();

  Person p2 = Person("Piku", Gender.Female);
  p2.display();
}