void main() {
  // 1 พื้นที่
  int width = 10;
  int height = 10;
  print('พื้นที่คือ ${width * height}');

  // 2 เช็คเลขคู่เลขคี่
  int input1 = 8;
  String result1 = input1 % 2 == 0 ? 'เลขคู่' : 'เลขคี่';
  print(result1);

  // 3 ผลรวมของ 1 ถึง input2
  int input2 = 5;
  int result2 = input2 * (input2 + 1) ~/ 2;
  print('ผลรวมคือ $result2');

  // 4 คำนวณเกรด
  int score = 49;
  String? grade;
  if (score > 80) {
    grade = 'A';
  } else if (score > 69) {
    grade = 'B';
  } else if (score > 59) {
    grade = 'C';
  } else if (score > 49) {
    grade = 'D';
  } else {
    grade = 'F';
  }
  print('เกรดของคุณคือ $grade');

  // 5 แม่สูตรคูณ
  int input3 = 8;
  for (int i = 1; i <= 12; i++) {
    print('$input3 x $i = ${input3 * i}');
  }
}
