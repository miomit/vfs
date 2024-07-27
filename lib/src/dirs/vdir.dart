import 'package:vfs/vfs.dart';

class VDir extends Dir {
  DateTime _changed;
  final List<VirtualFileSystemEntity> _children = [];

  VDir.init(String path)
      : _changed = DateTime.now(),
        super(path: path);

  static Dir Function(String) create(
    String name, {
    List<Dir Function(String)>? children,
  }) {
    return (String parentPath) {
      final path = "$parentPath$name/";
      final dir = VDir.init(path);
      if (children != null) {
        dir.addChildAll(children.map((child) => child(path)).toList());
      }
      return dir;
    };
  }

  @override
  Future<Stat> stat() => Future.value(statSync());

  @override
  Stat statSync() {
    int size = 0;
    int count = 0;

    for (var child in _children) {
      final childStat = child.statSync();
      size += childStat.size;
      count += childStat.count;
    }

    return Stat(
      name: name,
      size: size,
      changed: _changed,
      count: count,
    );
  }

  @override
  VirtualFileSystemEntity? getChildByName(String name) {
    for (var child in _children) {
      if (child.name == name) {
        return child;
      }
    }
    return null;
  }

  @override
  void addChild(VirtualFileSystemEntity child) {
    final dirChild = getChildByName(child.name);
    if (dirChild == null) {
      _children.add(child);
      _changed = DateTime.now();
    } else {
      final typeDC = dirChild.type;
      final typeC = child.type;

      if (typeDC != typeC) {
        throw "[${typeDC.name}] and [${typeC.name}] can't have the same name.";
      } else {
        throw "[${typeDC.name}] with the same name already exists.";
      }
    }
  }

  @override
  void addChildAll(List<VirtualFileSystemEntity> children) {
    for (var child in children) {
      addChild(child);
    }
  }

  @override
  Stream<VirtualFileSystemEntity> list({
    bool recursive = false,
    void Function(Exception e, VirtualFileSystemEntity fse)? onException,
  }) async* {
    for (var child in _children) {
      try {
        yield child;
        if (recursive && child is Dir) {
          yield* child.list(
            recursive: true,
            onException: onException,
          );
        }
      } on Exception catch (e) {
        if (onException != null) {
          onException(e, child);
        } else {
          rethrow;
        }
      } catch (_) {
        rethrow;
      }
    }
  }
}
