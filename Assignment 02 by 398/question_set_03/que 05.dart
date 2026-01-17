double areaOfCircle(double r) {
  const pi = 3.1416;
  return pi * r * r;
}

void main() {
  print("Area = ${areaOfCircle(5)}");
}