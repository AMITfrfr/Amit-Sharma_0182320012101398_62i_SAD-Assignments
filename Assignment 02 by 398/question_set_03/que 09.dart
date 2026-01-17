num maxNumber(num a, num b, num c) {
  return (a > b && a > c) ? a : (b > c ? b : c);
}

void main() {
  print(maxNumber(5, 10, 3));
}