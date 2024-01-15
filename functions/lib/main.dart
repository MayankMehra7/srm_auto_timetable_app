Future<dynamic> main(final context) async {
  String department = context.req.query['dept'];
  String section = context.req.query['sec'];

  // TODO: implement JSON query of the TT
  List todayClass = [];
  return context.res.json({'periods': todayClass});
}
