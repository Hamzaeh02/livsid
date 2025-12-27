import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherController extends GetxController {
  var location = 'Canada'.obs;
  var temp = '0'.obs;
  var feelsLike = '0'.obs;
  var condition = 'Clear'.obs;
  var humidity = '0'.obs;
  var windSpeed = '0'.obs;
  var pressure = '0'.obs;
  var isLoading = true.obs;

  final String apiKey = "4b1668c53eca26e38f3802322c53b859";

  @override
  void onInit() {
    super.onInit();
    fetchWeather('karachi');
  }

  Future<void> fetchWeather(String city) async {
    try {
      isLoading.value = true;

      final url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

      final response = await http.get(url);


      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        location.value = data['name'];
        temp.value = data['main']['temp'].round().toString();
        feelsLike.value = data['main']['feels_like'].round().toString();
        condition.value = data['weather'][0]['main'];
        humidity.value = data['main']['humidity'].toString();
        windSpeed.value = "${data['wind']['speed']} m/s";
        pressure.value = data['main']['pressure'].toString();
      } else {
        Get.snackbar("Error", "City not found!",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
      }
    } catch (e) {
      Get.snackbar("Error", "Check your internet connection",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}