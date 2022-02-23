class KidneyModel {
  late dynamic age;
  late dynamic al;
  late dynamic su;
  late dynamic bgr;
  late dynamic bu;
  late dynamic sc;
  late dynamic hemo;
  late dynamic pcv;
  late dynamic wc;
  late dynamic htn;
  late dynamic result1;
  late dynamic result2;
  KidneyModel(
      {required this.age,
      required this.al,
      required this.su,
      required this.bgr,
      required this.bu,
      required this.sc,
      required this.hemo,
      required this.pcv,
      required this.wc,
      required this.htn});

  KidneyModel.fromJson(Map<String, dynamic> json) {
    result1 = json['result'];
    result2 = json['result2'];
    age = json['age'];
    al = json['al'];
    su = json['su'];
    bgr = json['bgr'];
    bu = json['bu'];
    sc = json['sc'];
    hemo = json['hemo'];
    pcv = json['pcv'];
    wc = json['wc'];
    htn = json['htn'];
  }
  /*
   {
        "age": "50.00",
        "al": 20,
        "su": "20.00",
        "bgr": 10,
        "bu": 250,
        "sc": "20.00",
        "hemo": "50.02",
        "pcv": 28,
        "wc": 55,
        "htn": "yes"
}
*/
  Map<String, String> toMap() {
    return {
      'age': age,
      'al': al,
      'su': su,
      'bgr': bgr,
      'bu': bu,
      'sc': sc,
      'hemo': hemo,
      'pcv': pcv,
      'wc': wc,
      'htn': htn,
    };
  }
}
