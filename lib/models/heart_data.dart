

class HeartModel {
  late dynamic age;
  late dynamic cp;
  late dynamic trestbps;
  late dynamic chol;
  late dynamic thalach;
  late dynamic exang;
  late dynamic oldpeak;
  late dynamic ca;
  late int result1;
  late dynamic result2; //this value should be double but when the backend make it 
  HeartModel(
      {required this.age,
      required this.trestbps,
      required this.ca,
      required this.chol,
      required this.cp,
      required this.exang,
      required this.oldpeak,
      required this.result1,
      required this.result2,
      required this.thalach});

  HeartModel.fromJson(Map<String, dynamic> json) {
    result1 = json['result'];
    result2 = json['result2'];
    age = json['age'];
    cp = json['cp'];
    trestbps = json['trestbps'];
    chol = json['chol'];
    thalach = json['thalach'];
    exang = json['exang'];
    oldpeak = json['oldpeak'];
    ca = json['ca'];
  }
  Map<String, dynamic> toMap() {
    return {
      "age": age,
      "cp": cp,
      "trestbps": trestbps,
      "chol": chol,
      "thalach": thalach,
      "exang": exang,
      "oldpeak": oldpeak,
    };
  }
}
  /*
  {
        "id": 2,
        "date": "2021-10-01T23:01:27.882909Z",
        "age": "50.00",
        "cp": "200.01",
        "trestbps": "350.00",
        "chol": "50.00",
        "thalach": "100.00",
        "exang": "360.00",
        "oldpeak": "140.00",
        "ca": "900.00",
        "result": 0,
        "result2": 1
    }
  */