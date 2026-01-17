class House {
  int? id;
  String? name;
  double? price;

  House(int id, String name, double price) {
    this.id = id;
    this.name = name;
    this.price = price;
  }

  void display() {
    print("House ID: ${this.id}");
    print("House Name: ${this.name}");
    print("House Price: \$${this.price}\n"); //
  }
}

void main() {
  House house1 = House(1, "Sharma Tower", 6000000.0);
  House house2 = House(2, "Sharma Villa", 4200000.0);
  House house3 = House(3, "Sharma Mansion", 3300000.0);

  List<House> houseList = [house1, house2, house3];

  print("\n--- House Details ---");
  for (var house in houseList) {
    house.display();
  }
}