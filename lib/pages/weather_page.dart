import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService("a237ace7533b29b479add0307ea90ebf");
  Weather? _weather;

  //fetch weather
  fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print('Error fetching weather: $e');
    }
  }
  //weather animations


  //initial state
  @override
  void initState() {
    super.initState();
    fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //city name
          Text(_weather?.cityName ?? 'Loading city...'),

          //temperature
          Text(_weather != null ? '${_weather!.temperature.round()} °C' : 'Loading temperature...'),
        ],
      ),
      )
    );
  }
}