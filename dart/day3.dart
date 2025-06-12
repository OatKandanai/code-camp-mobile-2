void main() {
  Developer person0 = Developer.setDetail(
    name: 'tickkie',
    age: 100,
    gender: 'male',
    career: 'web dev',
    salaryTHB: 50000,
    techStack: 'mern',
  );
  person0.setSalaryTHB = '70,000';
  person0.showSalary();
  person0.showResponsibility();
  person0.working();
  print(person0.workingStatus);
}

abstract class Employee {
  String? name;
  int? age;
  String? gender;
  String? career;
  double? _salaryTHB;

  // default constructor
  Employee() {
    print('Employee default constructor');
  }

  // named constructor
  Employee.setDetail({
    required String this.name,
    required int this.age,
    required String this.gender,
    required String this.career,
    required double salaryTHB,
  }) {
    _salaryTHB = salaryTHB;
  }

  // method
  void showDetail() {
    String info =
        'name:$name ,age:$age, gender:$gender, career:$career, salary:$_salaryTHB';
    print(info);
  }

  // getter
  String get getSalaryUSD {
    double salaryUSD = _salaryTHB! / 30;
    return '${salaryUSD.toStringAsFixed(2)} USD';
  }

  // setter
  set setSalaryTHB(String value) {
    var convert = value.split(',').join();
    _salaryTHB = double.parse(convert);
  }

  // abstract method
  void showResponsibility();
  void showSalary();
}

// mixins
mixin Active {
  bool atWork = false;
  String get workingStatus =>
      atWork ? 'currently working' : 'not in active hour';

  void working() {
    atWork = true;
    print('on work');
  }

  void stopWorking() {
    atWork = false;
    print('stopped work');
  }
}

class Developer extends Employee with Active {
  String? techStack;

  // default constructor
  Developer() {
    print('Developer constructor');
  }

  // named constructor
  Developer.setDetail({
    required String name,
    required int age,
    required String gender,
    required String career,
    required double salaryTHB,
    required String techStack,
  }) : super.setDetail(
         name: name,
         age: age,
         gender: gender,
         career: career,
         salaryTHB: salaryTHB,
       ) {
    this.techStack = techStack.toUpperCase();
    showDetail();
  }

  @override
  void showDetail() {
    String info =
        'name:$name ,age:$age, gender:$gender, career:$career, salary:$_salaryTHB, stack:$techStack';
    print(info);
  }

  @override
  void showResponsibility() {
    print('responsibility: developing web app');
  }

  @override
  void showSalary() {
    print('salary(thai baht): $_salaryTHB');
  }
}
