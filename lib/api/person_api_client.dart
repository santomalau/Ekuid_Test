import 'package:ekuidtest/api/api.dart';
import 'package:ekuidtest/api/queries/queries.dart' as queries;
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GetPersonRequestFailure implements Exception {}

class PersonApiClient {
  const PersonApiClient({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;

  factory PersonApiClient.create() {
    final httpLink = HttpLink('https://examplegraphql.herokuapp.com/graphql');
    final link = Link.from([httpLink]);
    return PersonApiClient(
      graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link),
    );
  }

  final GraphQLClient _graphQLClient;

  Future<List<Person>> getPerson() async {
    final result = await _graphQLClient.query(
      QueryOptions(
          document: gql(queries.getPerson),
          fetchPolicy: FetchPolicy.cacheAndNetwork),
    );
    if (result.hasException) throw GetPersonRequestFailure();
    final data = result.data?['persons'] as List;
    print("Panjang GET: " + data.length.toString());
    return data.map((e) => Person.fromJson(e)).toList();
  }

  Future<QueryResult?> performMutation(String query,
      {required Map<String, dynamic> variables}) async {
    var documentNode = gql(queries.getPerson);
    switch (query) {
      case "addPerson":
        documentNode = gql(queries.addPerson);
        break;
      case "editPerson":
        documentNode = gql(queries.editPerson);
        break;
      case "deletePerson":
        documentNode = gql(queries.deletePerson);
        break;
      default:
    }
    try {
      final response = await _graphQLClient.mutate(
          MutationOptions(document: documentNode, variables: variables));
      print(response);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
