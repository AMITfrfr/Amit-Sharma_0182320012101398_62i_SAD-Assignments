class Camera {
  int _id;
  String _brand;
  String _color;
  double _price;
  Camera(this._id, this._brand, this._color, this._price);
  int get id => _id;
  String get brand => _brand;
  String get color => _color;
  double get price => _price;
  set price(double value) => _price = value;
}

void main() {
  var c1 = Camera(1, 'Canon', 'Black', 45000);
  var c2 = Camera(2, 'Nikon', 'Red', 52000);
  var c3 = Camera(3, 'Sony', 'Silver', 60000);
  for (var c in [c1, c2, c3]) {
    print('ID: ${c.id}, Brand: ${c.brand}, Color: ${c.color}, Price: ${c.price}');
  }
}