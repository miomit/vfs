import 'package:vfs/vfs.dart';

void main() {
  var root = Dir.root;

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
              VDir.create(
                "Documents",
                children: [
                  VFile.create("file.txt"),
                  VFile.create("file2.txt"),
                ],
              ),
              VDir.create("Pictures"),
              VDir.create("Music"),
              VFile.create("file.txt"),
            ],
          ),
        ],
      ),
    ],
  );

  Dir.open("/home/miomit")!.list(recursive: true).listen((vfse) {
    print(vfse.path);
  });
}
