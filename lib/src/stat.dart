class Stat {
  final String? path;
  final String name;
  final int size;
  final DateTime changed;
  final int count;

  Stat({
    required this.name,
    required this.size,
    required this.changed,
    this.path,
    this.count = 1,
  });
}
