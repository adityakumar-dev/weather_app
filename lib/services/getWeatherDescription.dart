Map<String, String> getWeatherDescription(weatherCode) {
  switch (weatherCode) {
    case 0:
      return {
        'day': 'assets/lottie/sunny.json',
        'night': 'assets/lottie/night.json',
        'desc': 'Clear Sky'
      };
    case 1:
    case 2:
    case 3:
      return {
        'day': 'assets/lottie/cloud.json',
        'night': 'assets/lottie/cloud_night.json',
        'desc': 'Cloudy'
      };
    case 45:
    case 48:
      return {
        'day': 'assets/lottie/fog.json',
        'night': 'assets/lottie/fog.json',
        'desc': 'Foggy'
      };
    case 51:
    case 53:
    case 55:
      return {
        'day': 'assets/lottie/rain.json',
        'night': 'assets/lottie/rain.json',
        'desc': 'Rainy'
      };
    case 61:
    case 63:
    case 65:
      return {
        'day': 'assets/lottie/day_cloud_rain.json',
        'night': 'assets/lottie/cloud_rain_night.json',
        'desc': 'Drizzle'
      };
    case 66:
    case 67:
      return {
        'day': 'assets/lottie/cloud_snow.json',
        'night': 'assets/lottie/cloud_snow.json',
        'desc': 'Freezing Rain'
      };
    case 71:
    case 73:
    case 75:
      return {
        'day': 'assets/lottie/sunny.json',
        'night': 'assets/lottie/night.json',
        'desc': 'Clear Sky'
      };
    case 80:
    case 81:
    case 82:
      return {
        'day': 'assets/lottie/sunny.json',
        'night': 'assets/lottie/night.json',
        'desc': 'Clear Sky'
      };
    case 95:
      return {
        'day': 'assets/lottie/sunny.json',
        'night': 'assets/lottie/night.json',
        'desc': 'Clear Sky'
      };
    case 96:
    case 99:
      return {
        'day': 'assets/lottie/sunny.json',
        'night': 'assets/lottie/night.json',
        'desc': 'Clear Sky'
      };
    default:
      return {
        'day': 'assets/lottie/sunny.json',
        'night': 'assets/lottie/night.json',
        'desc': 'Clear Sky'
      };
  }
}
