

class TreeVO<T extends TreeData> {
  TreeVO({this.data});

  T data;

  TreeVO<T> parent;

  List<TreeVO<T>> children = [];

  bool isExpanded = false;

  bool checked = false;
}

class TreeData {

  TreeData(this.id, this.parentId);

  String id;
  String parentId;
  bool checked;
}
