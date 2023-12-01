class LocationModel {
  final String location_name;
  final String location_description;
  final double latitude;
  final double longitude;
  final String place_id;

  LocationModel(
      {required this.location_name,
      required this.location_description,
      required this.latitude,
      required this.longitude,
      required this.place_id});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      location_name: json['location_name'],
      location_description: json['location_description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      place_id: json['place_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location_name': location_name,
      'location_description': location_description,
      'latitude': latitude,
      'longitude': longitude,
      'place_id': place_id
    };
  }
}
