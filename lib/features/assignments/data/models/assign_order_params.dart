class AssignOrderParams {
  final int userId;
  final String role;
  final int? stageId;

  AssignOrderParams( {required this.userId, required this.role,this.stageId,});

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['user_id'] = userId;
    params['role_type'] = role;
    params['is_primary'] = true;

    return params;
  }
}

class BulkAssignOrderParams {
  final List<AssignOrderParams> assignments;
  final int id;

  BulkAssignOrderParams({required this.id, required this.assignments});

  Map<String, dynamic> toJson() {
    return {
      'assignments': assignments.map((e) => e.toQueryParameters()).toList(),
    };
  }
}