import 'package:vfs/src/virtual_file_system.dart';
import 'package:vfs/vfs.dart';

abstract class File extends VirtualFileSystemEntity {
  File({required super.path});

  static File? open(String path) {
    if (VirtualFileSystem.open(path) case File file) {
      return file;
    }
    return null;
  }
}
