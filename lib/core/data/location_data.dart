class LocationData {
  static const Map<String, List<String>> provinceCities = {
    "Gauteng": [
      "Johannesburg",
      "Pretoria",
      "Sandton",
      "Soweto",
      "Midrand",
      "Centurion",
    ],

    "Western Cape": [
      "Cape Town",
      "Stellenbosch",
      "George",
      "Paarl",
      "Hermanus",
      "Worcester",
      "Knysna",
    ],

    "KwaZulu-Natal": [
      "Durban",
      "Pietermaritzburg",
      "Richards Bay",
      "Newcastle",
      "Ladysmith",
      "Empangeni",
    ],

    "Eastern Cape": [
      "Gqeberha (Port Elizabeth)",
      "East London",
      "Mthatha",
      "Grahamstown",
      "Uitenhage",
      "Queenstown",
    ],

    "Free State": [
      "Bloemfontein",
      "Welkom",
      "Bethlehem",
      "Kroonstad",
      "Sasolburg",
    ],

    "Limpopo": ["Polokwane", "Thohoyandou", "Tzaneen", "Mokopane", "Musina"],

    "Mpumalanga": [
      "Nelspruit (Mbombela)",
      "Witbank (Emalahleni)",
      "Secunda",
      "Middelburg",
      "Ermelo",
    ],

    "North West": [
      "Mahikeng",
      "Rustenburg",
      "Klerksdorp",
      "Potchefstroom",
      "Brits",
    ],

    "Northern Cape": [
      "Kimberley",
      "Upington",
      "Springbok",
      "De Aar",
      "Kuruman",
    ],
  };

  static List<String> get provinces => provinceCities.keys.toList();

  static List<String> getCities(String province) =>
      provinceCities[province] ?? [];
}

class AdsDurationData {
  static const List<String> durations = [
    "1 Day",
    "3 Days",
    "7 Days",
    "15 Days",
    "30 Days",
  ];
}
