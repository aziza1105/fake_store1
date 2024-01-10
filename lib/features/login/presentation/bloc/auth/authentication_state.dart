part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  unknown,
  unauthenticated,
  authenticated,
}

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @Default(AuthenticationStatus.unknown)
    AuthenticationStatus authenticationStatus,
    @Default(AuthenticatedUserEntity.empty())
    AuthenticatedUserEntity authenticatedUser,
    @Default(LogoutStatus.notLoggedOut) LogoutStatus logoutStatus,

}) = _AuthenticationState;
}

enum LogoutStatus {
  notLoggedOut,
  loggedOut,
}

class AuthenticatedUserEntity {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  const AuthenticatedUserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  const AuthenticatedUserEntity.empty()
      : this(id: 0, username: '', email: '', firstName: '', lastName: '');
}
