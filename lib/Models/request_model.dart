
class RequestModel {
  late String id;
  late String title;
  late int submittedTime;
  late int completedTime;
  late var detail;
  late String status;

  RequestModel(
      {required this.id,
      required this.title,
      required this.submittedTime,
      required this.completedTime,
      required this.detail,
      required this.status});

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Title': title,
        'SubmittedTime': submittedTime,
        'CompletedTime': completedTime,
        'Detail': detail.toJson(),
        'Status': status
      };

  static RequestModel fromJson(Map<dynamic, dynamic> parsedJson) => RequestModel(
      id: parsedJson['Id'],
      title: parsedJson['Title'],
      submittedTime: parsedJson['SubmittedTime'],
      completedTime: parsedJson['CompletedTime'],
      detail: parsedJson['Detail'],
      status: parsedJson['Status']);
}

class Details {
  String name;
  String number;
  String email;
  String extra;

  Details(
      {required this.name,
      required this.number,
      required this.email,
      required this.extra});

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Number': number,
        'Email': email,
        'Extra': extra,
      };

  static Details fromJson(Map<String, dynamic> parsedJson) => Details(
      name: parsedJson['Name'],
      number: parsedJson['Number'],
      email: parsedJson['Email'],
      extra: parsedJson['Extra']);
}

class EstampDetails {
  String article;
  String purchaseBy;
  String desc;
  String firstParty;
  String secondParty;
  String dutyPaid;
  String dutyAmount;
  String quantity;
  String number;

  EstampDetails(
      {required this.article,
      required this.purchaseBy,
      required this.desc,
      required this.firstParty,
      required this.secondParty,
      required this.dutyPaid,
      required this.dutyAmount,
      required this.quantity,
      required this.number});

  Map<String, dynamic> toJson() => {
        'Article': article,
        'PurchasedBy': purchaseBy,
        'Desc': desc,
        'FirstParty': firstParty,
        'SecondParty': secondParty,
        'DutyPaid': dutyPaid,
        'DutyAmount': dutyAmount,
        'Quantity': quantity,
        'Number': number,
      };

  static EstampDetails fromJson(Map<String, dynamic> parsedJson) =>
      EstampDetails(
          article: parsedJson['Article'],
          purchaseBy: parsedJson['PurchasedBy'],
          desc: parsedJson['Desc'],
          firstParty: parsedJson['FirstParty'],
          secondParty: parsedJson['SecondParty'],
          dutyPaid: parsedJson['DutyPaid'],
          dutyAmount: parsedJson['DutyAmount'],
          quantity: parsedJson['Quantity'],
          number: parsedJson['Number']);
}

class RentDetails {
  String article;
  String owner;
  String property;
  String tenaut;
  String rent;
  String security;
  String electricity;
  String starting;
  String extra;

  RentDetails(
      {required this.article,
      required this.owner,
      required this.property,
      required this.tenaut,
      required this.rent,
      required this.security,
      required this.electricity,
      required this.starting,
      required this.extra});

  Map<String, dynamic> toJson() => {
        'Article': article,
        'Owner': owner,
        'Property': property,
        'Tenaut': tenaut,
        'Rent': rent,
        'Security': security,
        'Electricity': electricity,
        'Starting': starting,
        'Extra': extra,
      };

  static RentDetails fromJson(Map<String, dynamic> parsedJson) => RentDetails(
      article: parsedJson['Article'],
      owner: parsedJson['Owner'],
      property: parsedJson['Property'],
      tenaut: parsedJson['Tenaut'],
      rent: parsedJson['Rent'],
      security: parsedJson['Security'],
      electricity: parsedJson['Electricity'],
      starting: parsedJson['Starting'],
      extra: parsedJson['Extra']);
}

class AffidavitDetails {
  String name;
  String sonOf;
  String address;
  String number;
  String email;
  String extra;

  AffidavitDetails(
      {required this.name,
      required this.sonOf,
      required this.address,
      required this.number,
      required this.email,
      required this.extra});

  Map<String, dynamic> toJson() => {
        'Name': name,
        'SonOf': sonOf,
        'Address': address,
        'Number': number,
        'Email': email,
        'Extra': extra,
      };

  static AffidavitDetails fromJson(Map<String, dynamic> parsedJson) => AffidavitDetails(
      name: parsedJson['Name'],
      sonOf: parsedJson['SonOf'],
      address: parsedJson['Address'],
      number: parsedJson['Number'],
      email: parsedJson['Email'],
      extra: parsedJson['Extra']);
}

class AdvertiseDetails {
  String adName;
  String name;
  String number;
  String email;
  String extra;

  AdvertiseDetails(
      {
        required this.adName,
        required this.name,
        required this.number,
        required this.email,
        required this.extra});

  Map<String, dynamic> toJson() => {
    'AdName':adName,
    'Name': name,
    'Number': number,
    'Email': email,
    'Extra': extra,
  };

  static AdvertiseDetails fromJson(Map<String, dynamic> parsedJson) => AdvertiseDetails(
      adName: parsedJson['AdName'],
      name: parsedJson['Name'],
      number: parsedJson['Number'],
      email: parsedJson['Email'],
      extra: parsedJson['Extra']);
}

class Url{
  String url;
  Url({required this.url});

  Map<String, dynamic> toJson() => {
    'Url': url,
  };
  static Url fromJson(Map<String, dynamic> parsedJson) => Url(
      url: parsedJson['Url']);
}
