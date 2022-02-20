
class KidneyModel{

 /*
 *
    "age": 20.00,
    "al": 50,
    "su": 50.00,
    "bgr": 500,
    "bu": 800,
    "sc": 50.00,
    "hemo": 55.00,
    "pcv": 555,
    "wc": 55,
    "htn": "yes"
}
 * */
  late double age;
  late double al;
  late double su;
  late double bgr;
  late double bu;
  late double sc;
  late double hemo;
  late double pcv;
  late double wc;
  late String htn;
 List<dynamic>? result1 ;
 List<dynamic>? result2 ;
  KidneyModel({
    required this.age,
    required this.al,
    required this.su,
    required this.bgr,
    required this.bu,
    required this.sc,
    required this.hemo,
    required this.pcv,
    required this.wc,
    required this.htn
  });

   KidneyModel.fromJson(Map<String,dynamic>json){
    result1 = json['result'];
    result2 = json['result2'];
  }
  Map<String,dynamic> toMap(){
    return {
      'age':age,
      'al':al,
      'su':su,
      'bgr':bgr,
      'bu':bu,
      'sc':sc,
      'hemo':hemo,
      'pcv':pcv,
      'wc':wc,
      'htn':htn,
    };
  }

}