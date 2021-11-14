const addPerson = r'''
mutation addPerson($id: ID, $name: String, $lastName: String, $age : Int){
  addPerson(id:$id, name: $name, lastName: $lastName, age: $age) {
      id
      name
      lastName
      age
  }
}
''';
