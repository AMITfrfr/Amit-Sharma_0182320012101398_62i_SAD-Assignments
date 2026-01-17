void main() {
  // List of 7 friends' names
  List<String> friends = [
    "Amit",
    "Aushfi",
    "Farhan",
    "Fayez",
    "Shakil",
    "Jidan",
    "Messi",
  ];

  var namesStartingWithA = friends.where((name) => name.startsWith('A'));

  print("Friends list: $friends");
  print("Names starting with 'A': $namesStartingWithA");
}