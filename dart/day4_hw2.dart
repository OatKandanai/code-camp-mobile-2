void main() {
  // 1
  Car car = Car(brand: 'toyota', year: 2020);
  car.showDetails();
  // 2
  Student student = Student(name: 'Alice');
  student.addScore(score: 80);
  student.addScore(score: 90);
  student.addScore(score: 100);
  student.showDetails();
  // 3
  Inventory inv = Inventory();
  inv.addItem(name: 'ipad', qty: 5);
  inv.showInv();
  inv.addItem(name: 'ipad', qty: 5);
  inv.showInv();
  inv.removeItem(name: 'ipad', qty: 5);
  inv.showInv();
  inv.removeItem(name: 'ipad', qty: 10);
  inv.showInv();
  inv.removeItem(name: 'iphone', qty: 1);
  // 4
  ElecBill bill = ElecBill(unitsConsumed: 250);
  print(bill.calculateBill());
}

// 1
class Car {
  final String brand;
  final int year;

  Car({required String this.brand, required int this.year});

  void showDetails() {
    print('This car is a $brand from $year');
  }
}

// 2
class Student {
  final String name;
  final List<double> scores = [];

  Student({required String this.name});

  void addScore({required double score}) {
    scores.add(score);
  }

  double calculateAvg() {
    return scores.fold<double>(
          0,
          (prevValue, nextValue) => prevValue + nextValue,
        ) /
        scores.length;
  }

  void showDetails() {
    print('Name: $name, Average Score: ${calculateAvg()}');
  }
}

// 3
class Inventory {
  final Map<String, int> items = {};

  void addItem({required String name, required int qty}) {
    items.update(name, (value) => value += qty, ifAbsent: () => qty);
  }

  void removeItem({required String name, required int qty}) {
    if (!items.containsKey(name)) {
      return print('no item found');
    } else if (items[name]! - qty < 0) {
      return print('not enough items to remove');
    } else {
      items.update(name, (value) => value -= qty);
    }
  }

  void showInv() {
    items.forEach((value, key) => print('$value: $key'));
  }
}

// 4
class ElecBill {
  int unitsConsumed;

  ElecBill({required int this.unitsConsumed});

  int calculateBill() {
    if (unitsConsumed > 200) {
      int cost1 = (unitsConsumed - 200) * 10;
      unitsConsumed -= (unitsConsumed - 200);
      int cost2 = (unitsConsumed - 100) * 7;
      unitsConsumed -= (unitsConsumed - 100);
      int cost3 = unitsConsumed * 5;
      return cost1 + cost2 + cost3;
    } else if (unitsConsumed > 100) {
      int cost1 = (unitsConsumed - 100) * 7;
      unitsConsumed -= (unitsConsumed - 100);
      int cost2 = unitsConsumed * 5;
      return cost1 + cost2;
    } else {
      int cost1 = unitsConsumed * 5;
      return cost1;
    }
  }
}
