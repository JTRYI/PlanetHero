class User {
  
  //declare the variables
  String username;
  String email;
  String password;
  int actionsCompleted;
  int heroPoints;

  //Constructor
  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.actionsCompleted,
      required this.heroPoints});
      
}
