import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  await get();
}

Future get() async {
  var url = Uri.parse(
      "https://newsapi.org/v2/everything?q=Apple&from=2024-03-22&sortBy=popularity&apiKey=31a4b02527bd4706b0e4a2a6b1867089");

  var response = await http.get(url, headers: {"Content-Type": "application/json"});
  final List body = json.decode(response.body)["articles"];
  print(body);
}
