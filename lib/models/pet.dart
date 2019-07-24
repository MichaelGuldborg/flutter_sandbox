class Pet {
  String animal;
  String sex;
  int months;
  String weight;

  Map<String, dynamic> toJson() => {
        "animal": animal,
        "sex": sex,
        "months": months,
        "weight": weight,
      };

}
