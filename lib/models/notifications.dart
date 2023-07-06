class Notificationcard {
  final int notificationid;
  final int chairid;
  final String sensorname;
  final String datetime;
  final double value;

  Notificationcard( {
    required this.notificationid,
    required this.chairid,
    required this.sensorname,
    required this.datetime,
    required this.value,
  });
}
