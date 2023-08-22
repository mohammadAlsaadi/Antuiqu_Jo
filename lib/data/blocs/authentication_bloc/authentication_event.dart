part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthOwnerChangeEvent extends AuthenticationEvent {
  final User? authOwner;
  final OwnersInfo? owner;

  const AuthOwnerChangeEvent({required this.authOwner, this.owner});

  @override
  List<Object?> get props => [authOwner, owner];
}
