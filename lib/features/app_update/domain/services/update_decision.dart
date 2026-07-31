enum UpdateDecision {
  none('none'),
  optional('optional'),
  mandatory('mandatory'),
  silent('silent');

  const UpdateDecision(this.value);

  final String value;
}