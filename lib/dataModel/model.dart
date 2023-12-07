

abstract class Person {
  int age;
  double height;
  int? weight;
  Person(this.age, this.height);

  num getIdealWeight();
}

class Male extends Person {
  Male(int age, double height) : super(age, height);

  @override
  num getIdealWeight() {
    return height / age * 10;
  }
}

class Female extends Person {
  Female(int age, double height) : super(age, height);

  @override
  num getIdealWeight() {
    return height / age * 9;
  }
}
