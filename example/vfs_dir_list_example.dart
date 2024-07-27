import 'package:vfs/vfs.dart';

void main() {
  var root = VirtualFileSystem.root;

  root.makes(
    children: [
      VDir.create("tmp"),
      VDir.create("mnt"),
      VDir.create(
        "home",
        children: [
          VDir.create(
            "miomit",
            children: [
              VDir.create("Documents"),
              VDir.create("Pictures"),
              VDir.create("Music"),
            ],
          ),
        ],
      ),
    ],
  );

  (VirtualFileSystem.open("/home/")! as Dir)
      .list(recursive: true)
      .listen((vfse) {
    print(vfse.path);
  });
}
