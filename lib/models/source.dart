// make source model class so that it will be easier to parse the Json

class Source {
  String id;
  String name;

  //create constructor
  Source({required this.id, required this.name});

  //create factory function to map the json
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'] ?? '', name: json['name'] ?? '');
  }
}
