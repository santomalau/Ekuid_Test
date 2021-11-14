part of 'person_bloc.dart';

class PersonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PersonFetchStarted extends PersonEvent {}

class PersonAddEvent extends PersonEvent {
  final String query;
  final Map<String, dynamic> variables;

  PersonAddEvent({required this.query, required this.variables});
}

class PersonEditEvent extends PersonEvent {
  final String query;
  final Map<String, dynamic> variables;

  PersonEditEvent({required this.query, required this.variables});
}

class PersonMutationEvent extends PersonEvent {
  final String query;
  final Map<String, dynamic> variables;

  PersonMutationEvent({required this.query, required this.variables});
}
