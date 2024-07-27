import 'package:vfs/vfs.dart';

abstract class File extends VirtualFileSystemEntity {
  File({required super.path});
}
