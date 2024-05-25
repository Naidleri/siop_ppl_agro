class History {
  final String timestamp;

  History({required this.timestamp});

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      timestamp: map["timestamp"] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
    };
  }
}
