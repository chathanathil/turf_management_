class Team {
  final String id;
  final String date;
  final String time;
  final String team;
  final String name;
  final String phone;
  Team({this.id, this.date, this.time, this.team, this.name, this.phone});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
        id: json['id'],
        date: json['date'],
        time: json['time'],
        team: json['team'],
        name: json['name'],
        phone: json['phone']);
  }
}
