enum UserType {
  user,
  driver,
  authority,
  RTO,
}

class Constants {
  static String baseUrl = 'http://192.168.68.119/Wee/api/';
  static String imageUrl = 'http://192.168.68.119/Wee/img/';

  static List dummyBuses = [
    {
      'name': 'blsymukk-nadakkav',
      'from': '11.445698273816243, 75.83544220211205',
      'to': '11.27411841284013, 75.77827942434402',
    },
    {
      'name': 'beach-kakkodi',
      'from': '11.28055476016943, 75.76526608012549',
      'to': '11.31882008414346, 75.80091105260588',
    },
    {
      'name': 'ulliyeri-beypore',
      'from': '11.448798015876964, 75.7740457581745',
      'to': '11.172632670769469, 75.80417858484633',
    },
  ];
}
