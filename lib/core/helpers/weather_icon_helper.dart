String getWeatherAssetIcon(String iconCode){
  switch(iconCode){
    case '01d':
    return 'assets/images/Sun (1).png';
    case '01n':
    return 'assets/images/08.full-moon-dark-removebg-preview.png';
    case '02d':
    return 'assets/images/⛅.png';
    case '02n':
    return 'assets/images/05.partial-cloudy-dark-removebg-preview.png';
    case '03d':
    return 'assets/images/03.sunrise-light (1).png';
    case '03n':
    return 'assets/images/03.sunrise-light (2).png';
    case '04d':
    return 'assets/images/11.mostly-cloudy-light-removebg-preview.png';
    case '04n':
      return 'assets/images/11.mostly-cloudy-dark.png';
    case '09d':
    return 'assets/images/🌧.png';
    case '09n':
    return 'assets/images/🌧.png';
    case '10d':
    return 'assets/images/🌦.png';
    case '10n':
       return 'assets/images/🌦.png';
    case '11d':
    return 'assets/images/13.thunderstorm-light-removebg-preview.png';
    case '11n':
      return 'assets/images/13.thunderstorm-dark-removebg-preview.png';
    case '13d':
    return 'assets/images/22.snow-light.png';
    case '13n':
      return 'assets/images/14.heavy-snowfall-dark.png';
    case '50d':
    return 'assets/images/21.heavy-wind-light.png';
    case '50n':
      return 'assets/images/14.heavy-snowfall-dark.png';
    default:
      return 'assets/images/Sun (1).png';
    
  }

}