final String url =
    'https://run.mocky.io/v3/bcd4e56c-a0fd-45e6-8045-52308279bb21';

class Data {
  final int id;
  final String data;
  final String token;
  final String tnumber;

  Data({required this.token, required this.tnumber, required this.data, required this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["data"] = this.data;
    data["token"] = this.token;
    data["tnumber"] = this.tnumber;
    return data;
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      data: json['data'],
      token: json['token'],
      tnumber: json['tnumber'],
    );
  }
}
