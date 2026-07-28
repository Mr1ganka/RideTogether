enum RideStatus {
  planned, 
  recruiting, 
  active, 
  paused, 
  completed, 
  cancelled;

  bool get isJoinable => this != RideStatus.completed && this != RideStatus.cancelled;
}