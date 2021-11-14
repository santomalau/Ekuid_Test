import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ekuidtest/api/models/models.dart';
import 'package:ekuidtest/api/person_api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonApiClient _personsApiClient;
  List<Person> _persons = [];

  PersonBloc({required PersonApiClient personsApiClient})
      : _personsApiClient = personsApiClient,
        super(PersonLoadInProgress());

  final StreamController<List<Person>> _listController =
      StreamController.broadcast();

  Stream<List<Person>> get listStream => _listController.stream;
  StreamSink<List<Person>> get _listSink => _listController.sink;

  @override
  Future<void> close() {
    _listController.close();
    return super.close();
  }

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event is PersonFetchStarted) {
      yield* _mapInitialEventToState();
    }
    if (event is PersonMutationEvent) {
      print("Event Start");
      yield* _mapPersonMutationEventToState(
          query: event.query, variables: event.variables);
    }
  }

  // Stream Functions
  Stream<PersonState> _mapInitialEventToState() async* {
    yield PersonLoadInProgress();

    await _getPersons();

    yield PersonLoadSuccess();
  }

  Stream<PersonState> _mapPersonMutationEventToState(
      {required String query, required Map<String, dynamic> variables}) async* {
    print("Step 1: LoadInProgress");
    yield PersonLoadInProgress();
    print("Step 2: StartToDelete");
    await _mutatePerson(query: query, variables: variables);
    print("Step 6: TaskComplete");
    yield PersonLoadSuccess();
    print("Step 7: Finish");
  }

  // Helper Functions
  Future<void> _getPersons() async {
    print("Step 5: _getPerson()");

    _persons.clear();
    _persons = await _personsApiClient.getPerson();
    print("Panjang _personNew : " + _persons.length.toString());
    _listSink.add(_persons);
  }

  Future<void> _mutatePerson(
      {required String query, required Map<String, dynamic> variables}) async {
    await _personsApiClient.performMutation(query, variables: variables);
    await _getPersons();
  }
}
