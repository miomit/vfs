import 'package:vfs/src/virtual_file_system.dart';
import 'package:vfs/vfs.dart';

abstract class Dir extends VirtualFileSystemEntity {
  Dir({required super.path});

  Stream<VirtualFileSystemEntity> list({
    bool recursive = false,
    void Function(Exception e, VirtualFileSystemEntity fse)? onException,
  });

  VirtualFileSystemEntity? getChildByName(String name);

  void addChild(VirtualFileSystemEntity child);
  void addChildAll(List<VirtualFileSystemEntity> children);

  void mount(VirtualFileSystemEntity child) {
    addChild(child);
  }

  void mounts({
    required List<Dir Function(String)> children,
  }) {
    addChildAll(children.map((child) => child(path)).toList());
  }

  static Dir get root => open("/")!;

  static Dir? open(String path) {
    if (VirtualFileSystem.open(path) case Dir dir) {
      return dir;
    }
    return null;
  }
}
