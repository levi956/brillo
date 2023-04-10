class SportInterest {
  final String sportInterest;

  SportInterest({required this.sportInterest});

  factory SportInterest.fromJson(Map<String, dynamic> json) {
    return SportInterest(
      sportInterest: json['sport_interest'],
    );
  }
}
