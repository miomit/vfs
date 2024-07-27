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

  void makes({
    required List<Dir Function(String)> children,
  }) {
    addChildAll(children.map((child) => child(path)).toList());
  }
}
