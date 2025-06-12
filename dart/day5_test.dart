void main() {
  // 1
  test1();

  // 2
  int sumAB = sum(a: 1, b: 5);
  print(sumAB);
  printTextSum('test', sum: sumAB);

  // 3
  final user = User(name: 'user_name', age: 30);
  print(user.name);
  print(user.age);

  // 4
  print(sumN(1000));
}

// 1
void test1() {
  List<int> number = [1, 2, 3];
  String text = 'test';
  for (int n in number) {
    print(text + ": ${n + 5}");
  }
}

// 2
int sum({required int a, required int b}) {
  return a + b;
}

void printTextSum(msg, {required sum}) {
  print('$msg : $sum');
}

// 3
class User {
  final String name;
  final int age;
  User({required String this.name, required int this.age});
}

// 4
int sumN(int n) {
  if (n == 0) return 0;
  return n + sumN(n - 1);
}
