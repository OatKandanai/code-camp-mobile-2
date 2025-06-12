void main() {
  // 1
  evenOdd(num: 5);
  // 2
  findNumInList(
    input: [
      [1, 2, 99, 99, 100],
      99,
    ],
  );
  // 3
  findAvg(input: [1, 2, 3, 4, 5, 6]);
  // 4
  removeDuplicate(input: [1, 2, 2, 3, 4, 4, 5]);
  // 5
  calculate(num1: 5, num2: 5, symbol: '+');
  // 6
  print(fact(5));
  // 7
  dividendByThree(input: [1, 3, 6, 8, 9, 10, 12, 13]);
  // 8
  findMaxBetweenList(list1: [1, 2, 3], list2: [1, 4, 6]);
  // 8 challenge 1
  tree1();
  // 8 challenge 2
  tree2();
}

// 1
String evenOdd({required int num}) {
  String msg = num.isEven ? '$num is an Even number' : '$num is an Odd number';
  print(msg);
  return msg;
}

// 2
int findNumInList({required List<dynamic> input}) {
  List<int> list = input.first;
  int num = input.last;
  int index = list.indexOf(num);
  if (index == -1) {
    print('ไม่พบเลขที่ค้นหา');
  } else {
    print('พบเลขที่ค้นหาในตัวที่ ${index + 1}');
  }
  return index;
}

// 3
int findAvg({required List<int> input}) {
  if (input.isEmpty) return 0;
  int sum = input.fold<int>(0, (prevValue, nextValue) => prevValue + nextValue);
  int avg = (sum / input.length).round();
  print('ค่าเฉลี่ยของ List คือ $avg');
  return avg;
}

// 4
List<int> removeDuplicate({required List<int> input}) {
  return input.toSet().toList();
}

// 5
num calculate({required int num1, required int num2, required String symbol}) {
  switch (symbol) {
    case '+':
      print(num1 + num2);
      return num1 + num2;
    case '-':
      print(num1 - num2);
      return num1 - num2;
    case '*':
      print(num1 * num2);
      return num1 * num2;
    case '/':
      print(num1 / num2);
      return num1 / num2;
    default:
      print('ตัวดำเนินการไม่ถูกต้อง');
      return 0;
  }
}

// 6
int fact(n) {
  if (n == 0) {
    return 1;
  }
  return n * fact(n - 1);
}

// 7
void dividendByThree({required List<int> input}) {
  input = input.where((num) => num % 3 == 0).toList();
  print('เลขที่ 3 หารลงตัวมีทั้งหมด ${input.length} ตัว คือ $input');
}

// 8
void findMaxBetweenList({required List<int> list1, required List<int> list2}) {
  List<int> list3 = [...list1, ...list2];
  list3.sort();
  int max = list3.last;
  int index1 = list1.indexOf(max);
  String msg;
  if (index1 != -1) {
    msg = 'Input1 ในลำดับที่ ${index1 + 1}';
  } else {
    int index2 = list2.indexOf(max);
    msg = 'Input2 ในลำดับที่ ${index2 + 1}';
  }
  print('เลขที่มากที่สุดคือ $max มาจาก List ของ $msg');
}

// 8 challenge
void tree1() {
  for (int j = 1; j <= 6; j++) {
    print('*' * j);
  }
}

void tree2() {
  for (int j = 0; j < 6; j++) {
    print(' ' * (5 - j) + '*' * (2 * j + 1));
  }
}
