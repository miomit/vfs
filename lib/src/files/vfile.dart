import 'package:vfs/vfs.dart';

class VFile extends File {
  final List<int> _data;
  DateTime _changed;

  VFile.init(
    String path, {
    List<int>? data,
  })  : _data = data ?? [],
        _changed = DateTime.now(),
        super(path: path);

  static File Function(String) create(
    String name, {
    List<int>? data,
  }) {
    return (String parentPath) => VFile.init("$parentPath$name", data: data);
  }

  @override
  Future<Stat> stat() => Future.value(statSync());

  @override
  Stat statSync() {
    return Stat(
      name: name,
      size: _data.length,
      changed: _changed,
    );
  }
}
