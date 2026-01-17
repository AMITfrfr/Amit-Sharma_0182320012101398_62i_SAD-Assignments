num calculateArea({num length = 1, num width = 1}) {
  return length * width;
}

void main() {
  print("Area: ${calculateArea(length: 5, width: 3)}");
  print("Default Area: ${calculateArea()}");
}