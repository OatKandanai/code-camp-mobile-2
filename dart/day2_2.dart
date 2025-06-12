void main() {
  var result1 = mom();
  result1();
  result1();
  result1();
  result1();
  print(result1());

  var result2 = greet('hello', 'john');
  print(result2);
}

Function mom() {
  int a = 0;
  int son() {
    a++;
    return a;
  }

  return son;
}

String greet(String greetMsg, String name) {
  String greetByName(name) {
    return '$greetMsg $name';
  }

  return greetByName(name);
}
