const deletePerson = r'''
mutation deletePerson($id: ID!){
  deletePerson(id:$id) {
      id
  }
}
''';
