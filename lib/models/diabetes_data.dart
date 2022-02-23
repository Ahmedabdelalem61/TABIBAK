
  /*
  {
        "id": 1,
        "age": "50.00",
        "date": "2021-10-01T23:00:26.475894Z",
        "Pregnancies": 120,
        "Glucose": 250,
        "SkinThickness": 360,
        "Insulin": 150,
        "result": 0,
        "result2": 0
    },
  */
class DiabetesModel {
  late dynamic age;
  late dynamic Pregnancies;
  late dynamic Glucose;
  late dynamic SkinThickness;
  late dynamic Insulin;
  late dynamic result1;
  late dynamic result2; //this value should be double but when the backend make it 
  DiabetesModel(
      {required this.age,
      required this.Pregnancies,
      required this.Glucose,
      required this.SkinThickness,
      required this.Insulin,
      required this.result1,
      required this.result2,
      });

  DiabetesModel.fromJson(Map<String, dynamic> json) {
    result1 = json['result'];
    result2 = json['result2'];
    age = json['age'];
    Pregnancies = json['Pregnancies'];
    Glucose = json['Glucose'];
    SkinThickness = json['SkinThickness'];
    Insulin = json['Insulin'];
  }
  /*
  {
        "age": "50.00",
        "Pregnancies": 120,
        "Glucose": 250,
        "SkinThickness": 360,
        "Insulin": 150
  }
  */
  Map<String, String> toMap() {
    return {
      "age": age,
      "Pregnancies": Pregnancies,
      "Glucose": Glucose,
      "SkinThickness": SkinThickness,
      "Insulin": Insulin,
    };
  }
}
