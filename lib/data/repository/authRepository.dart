abstract class Authrepository {
  Future<void> signInEmail(String emailAddress, String password);

  Future<void> createUser(String emailAddress, String password);

  Future<void> signInWithGoogle();
}
