void main() {
  // 1
  Person person0 = Person(name: 'Alice', age: 25);
  person0.introduce();

  // 2
  BankAccount account0 = BankAccount();
  account0.deposit(1000);
  account0.withdraw(1200);
  print(account0.balance);

  // 3
  Dog dog = Dog();
  dog.makeSound();
  Cat cat = Cat();
  cat.makeSound();

  // 4
  Rectangle rect = Rectangle.set(width: 10, height: 5);
  rect.area();

  // 5
  List<Student> allStudent = [
    Student(name: 'a', score: [10, 20, 30]),
    Student(name: 'b', score: [40, 50, 60]),
    Student(name: 'c', score: [70, 80, 90]),
  ];
  allStudent.sort((a, b) => b.getAverageScore().compareTo(a.getAverageScore()));
  allStudent.sort();
  print(
    'นักเรียนที่มีคะแนนเฉลี่ยสูงสุดคือ: ${allStudent.first.name} (${allStudent.first.getAverageScore()})',
  );
}

// 1
class Person {
  String name;
  int age;
  Person({required String this.name, required int this.age});
  void introduce() {
    print('สวัสดี ฉันชื่อ $name อายุ $age ปี');
  }
}

// 2
class BankAccount {
  double _balance = 0;

  void deposit(double amount) {
    _balance += amount;
    print('ฝาก $amount บาท');
  }

  void withdraw(double amount) {
    if (_balance - amount < 0) {
      print('เงินคงเหลือไม่พอ');
    } else {
      _balance -= amount;
      print('ถอน $amount บาท');
    }
  }

  String get balance => 'คงเหลือ $_balance บาท';
}

// 3
class Animal {
  void makeSound() {
    print('animal sound');
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print('Woof!');
  }
}

class Cat extends Animal {
  @override
  void makeSound() {
    print('Meow!');
  }
}

// 4
class Rectangle {
  int width;
  int height;
  Rectangle.set({required int this.width, required int this.height});
  int area() {
    int area = width * height;
    print('พื้นที่คือ $area');
    return area;
  }
}

// 5
class Student {
  String name;
  List<double> score;
  Student({required String this.name, required List<double> this.score});
  double getAverageScore() {
    double total = score.fold<double>(
      0,
      (prevValue, nextValue) => prevValue + nextValue,
    );
    double avg = total / score.length;
    return avg;
  }
}
