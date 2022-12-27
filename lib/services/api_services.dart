import 'dart:convert';

import 'package:chat_app/model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiServices{
  static Future<Data?> getApi() async{
    // var queryParam={
    //   "MI_Id": "22"
    // };
    var queryParam={
      "category": "movies",
      "language": "kannada",
      "genre": "all",
      "sort": "voting"
    };
   final url =Uri.parse('https://hoblist.com/api/movieList');
    // final url =Uri.parse('https://vmsrecruitmentservicehub.azurewebsites.net/api/RoomWebFacade/onloadgetdetails/');
   // final url =Uri.parse('https://jsonplaceholder.typicode.com/albums/1');
    final response = await http.post(
        url,
        headers:{"Accept": "application/json"},
         body: queryParam,
    );

    // final response =await http.get(url,
    //   headers: {
    //     "Content-Type": "application/json",
    //     // "Authorization": "Bearer " + token,
    //     "Access-Control-Allow-Methods": "GET",
    //     "Access-Control-Allow-Origin": "*",
    //   },
    // );
      if(response.statusCode==200){

        print('Body:${response.body}');
        print('Status code:${response.statusCode}');

        return Data.fromJson(json.decode(response.body));
      }
      return null;

}
}