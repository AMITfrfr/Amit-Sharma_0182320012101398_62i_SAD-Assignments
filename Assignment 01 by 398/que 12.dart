void main() {
  double distance = 25; // km
  double speed = 40;    // km/hr
  
  double time = distance / speed; // hours
  double minutes = time * 60;
  
  print("Time to reach office: ${minutes.toStringAsFixed(2)} minutes");
}