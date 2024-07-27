import 'package:path/path.dart';
import 'package:vfs/vfs.dart';

class VirtualFileSystem {
  static final Dir root = VDir.init("/");
  static VirtualFileSystemEntity? open(String path) {
    VirtualFileSystemEntity? res;

    for (var name in split(path)) {
      if (name == "/") {
        res = root;
      } else if (res case Dir dir) {
        res = dir.getChildByName(name);
      } else {
        return null;
      }
    }

    return res;
  }
}
