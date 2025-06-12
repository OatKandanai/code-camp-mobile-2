void main() {
  /*List<String> animals = ['cat', 'bird', 'dog'];
  List<String> names = ['oat', 'jame', 'yok', 'c', 'berm'];
  names.insert(1, 'art');
  names.remove('oat');
  print(names.join('-'));*/

  /*for (int i = 0; i < animals.length; i++) {
    print(animals[i]);
  }

  for (String item in animals) {
    print(item);
  }*/

  /*final growableList = List<int>.generate(
    6,
    (int index) => index * index,
    growable: true,
  );
  print(growableList);

  final growableList2 = List<int>.generate(5, (i) => i + 1000);
  print(growableList2);

  List<List<int>> matrix = List.generate(
    3,
    (i) => List.generate(3, (j) => (i + j)),
  );
  print(matrix);

  final result = List<String>.generate(200, (int index) => 'test_$index');
  print(result);
  print(result.reversed.toList());*/

  /*
  // convert List to have difference pointer
  dynamic usersList = <String>['a', 'b', 'c'];
  dynamic newUsersList = List<String>.from(usersList);*/

  /*
  // add key-value to Map, if key-value doesn't exist then add it
  Map<int, String> users = {1: 'axe', 2: 'invoker'};
  users.update(2, (value) => 'riki');
  users.update(3, (value) => 'lina', ifAbsent: () => 'cm');*/

  /*func1(1, 1);
  func2(1);
  func3(a: 1);
  int result1 = cal(1, 5, add);
  int result2 = cal(1, 5, sub);
  print(result1);
  print(result2);*/
}

int func1(int a, int b) {
  print(a + b);
  return a + b;
}

int func2(int a, [int b = 1]) {
  print(a + b);
  return a + b;
}

int func3({required int a, int b = 1}) {
  print(a + b);
  return a + b;
}

int cal(int a, int b, Function c) {
  return c(a, b);
}

int add(int a, int b) {
  return a + b;
}

int sub(int a, int b) {
  return a - b;
}
