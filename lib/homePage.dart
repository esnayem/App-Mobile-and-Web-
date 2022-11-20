import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  @override
  void initState() {
    // TODO: implement initState
    getWeather();
    super.initState();
  }

  var iconId,temperature,description,currentCityName;
  TextEditingController cityNameController = new TextEditingController();



  getWeather() async{
    print("clicked");
    String cityName = cityNameController.text;
    // String cityName = "dhaka";
    final queryparameter = {
      "q": cityName,
      "key": "fab373dba6fa48e39e241801222011"
    };
    Uri uri = new Uri.http("api.weatherapi.com","/v1/current.json",queryparameter);
    final jsonData = await get(uri);
    final json = jsonDecode(jsonData.body);
    print(json);
    setState(() {
      currentCityName = json["location"]["name"];
      temperature = json["current"]["temp_c"];
      description = json["current"]["condition"]["text"];
      iconId = json["current"]["condition"]["icon"];
      iconId = iconId.substring(2);
    });
    print(iconId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Weather App"),
          ),
          body:  Center(
            child: Container(
              width: 500,
              height: 800,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 4),
                borderRadius: BorderRadius.all(Radius.circular(200)),
              ),
              child: Center(
                child: Column(
                  children: [
                    // Image.network("http://"+iconId.toString()),
                    // Image(image: NetworkImage("https://"+iconId)),
                    // NetworkImage(iconId);

                    // I tried to add icon but it is not working, I will try this again

                    Text((currentCityName == null ? "loading" : currentCityName),
                    style: TextStyle(
                      fontSize: 30
                    )
                    ),
                    Text((temperature == null ? "loading" : temperature.toString())+"\u00B0C",
                      style: TextStyle(
                          fontSize: 40
                      ),

                    ),
                    SizedBox(height: 40,),
                    Text((description == null ? "loading" : description.toString()),
                      style: TextStyle(
                          fontSize: 30
                      ),
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      width: 300,
                      child:
                      TextField(
                        controller: cityNameController,
                      )
                    ),

                    SizedBox(height: 80,),
                    ElevatedButton(onPressed: getWeather, child: Text("Search")),

                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}

