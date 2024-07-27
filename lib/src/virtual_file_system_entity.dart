import 'package:path/path.dart';
import 'package:vfs/vfs.dart';

abstract class VirtualFileSystemEntity {
  final String _path;

  String get path => _path;
  String get name => basename(path);

  VirtualFileSystemEntityType get type {
    return VirtualFileSystemEntityType.getType(this);
  }

  Future<bool> exists() => Future.value(existsSync());
  bool existsSync() => VirtualFileSystem.open(path) != null;

  Future<Stat> stat();
  Stat statSync();

  VirtualFileSystemEntity({required String path}) : _path = path;
}
