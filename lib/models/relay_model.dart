

// relay_model.dart
class Node {
  final String id;
  final String status;
  final String postDataId;

  Node(this.id, this.status, this.postDataId);
}

class Edge {
  final Node startNode;
  final Node endNode;
  final int duration;

  Edge(this.startNode, this.endNode, this.duration);

  get data => null;
}

