part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  @override
  List<Object> get props => [];
}

class PersonInitialData extends PersonState {}

class PersonLoadInProgress extends PersonState {}

class PersonLoadSuccess extends PersonState {}

class PersonLoadFailure extends PersonState {}

class PersonAddState extends PersonState {}

class PersonEditState extends PersonState {
  final Person person;

  PersonEditState({required this.person});
}

class PersonNewState extends PersonState {}

class PersonMutationState extends PersonState {}
