class Laptop {
  int id;
  String name;
  int ram;
  Laptop(this.id, this.name, this.ram);
}

void main() {
  var l1 = Laptop(1, 'HP', 8);
  var l2 = Laptop(2, 'Dell', 16);
  var l3 = Laptop(3, 'Lenovo', 4);
  for (var l in [l1, l2, l3]) {
    print('ID: ${l.id}, Name: ${l.name}, RAM: ${l.ram}GB');
  }
}