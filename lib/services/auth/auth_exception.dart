// Login Exceptions

class UserNotFoundException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// Weak Exceptions

class WeakPasswordAuthExcption implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// Generic Exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class NetworkAuthException implements Exception {}
