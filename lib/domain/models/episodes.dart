
class Episodes {
  final int ?id;
  final String name;
  final String ?air_date;
  final String ?episode;
  final int episodeNumber; 


  Episodes({required this.id, required this.name, required this.air_date, required this.episode, required this.episodeNumber});

  factory Episodes.fromJson(Map<String, dynamic> json) {
    return Episodes(
      id: json['id'],
      name: json['name'],
      air_date: json['air_date'],
      episode: json['episode'],
      episodeNumber: int.parse(json['episode'].split('E').last), // Parsea el número del episodio
    );
  }

  
}

