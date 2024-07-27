import 'package:vfs/vfs.dart';

enum VirtualFileSystemEntityType {
  dir,
  file;

  static VirtualFileSystemEntityType getType(VirtualFileSystemEntity vfse) {
    return switch (vfse) {
      Dir _ => dir,
      _ => file,
    };
  }
}
