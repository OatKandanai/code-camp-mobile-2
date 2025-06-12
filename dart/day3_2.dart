void main() {}

abstract class Animal {
  factory Animal(String type) {
    if (type == 'dog') return Dog();
    if (type == 'cat') return Cat();
    throw Exception('Unknown animal');
  }
}

class Dog implements Animal {}

class Cat implements Animal {}
