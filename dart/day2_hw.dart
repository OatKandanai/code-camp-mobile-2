void main() {
  calculateAverage([10, 20, 30, 40]);
  findMax([3, 9, 2, 15, 8]);
  isFriendExist({"Anna": 25, "Ben": 30}, "Anna");
  toUpperCaseNames(['anna', 'bob', 'charlie']);
  getStudentName({1001: 'Somchai', 1002: 'Suda'}, 1002);
  sumEvenNumbers([1, 2, 3, 4, 5, 6]);
  countWords('Dart is fun and powerful');
}

// 1
double calculateAverage(List<int> numbers) {
  int sum = numbers.fold<int>(
    0,
    (prevValue, nextValue) => prevValue + nextValue,
  );
  double avg = sum / numbers.length;
  print('ค่าเฉลี่ยคือ $avg');
  return avg;
}

// 2
int findMax(List<int> numbers) {
  numbers.sort();
  int max = numbers.last;
  print('ค่ามากที่สุดคือ $max');
  return max;
}

// 3
bool isFriendExist(Map<String, int> friends, String name) {
  bool result = friends.containsKey(name);
  print(result ? '$name อยู่ในรายชื่อเพื่อน' : '$name ไม่อยู่ในรายชื่อเพื่อน');
  return result;
}

// 4
List<String> toUpperCaseNames(List<String> names) {
  List<String> result = names.map((name) => name.toUpperCase()).toList();
  print(result);
  return result;
}

// 5
String? getStudentName(Map<int, String> students, int id) {
  bool isContain = students.containsKey(id);
  String result =
      isContain ? 'ชื่อคือ ${students[id]}' : 'ไม่พบนักเรียนรหัสนี้';
  print(result);
  return result;
}

// 6
int sumEvenNumbers(List<int> numbers) {
  int sum = 0;
  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] % 2 == 0) {
      sum += numbers[i];
    }
  }
  print(sum);
  return sum;
}

// 7
int countWords(String sentence) {
  List charactersList = sentence.split(' ');
  print('${charactersList.length} คำ');
  return charactersList.length;
}
