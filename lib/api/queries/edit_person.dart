const editPerson = r'''
mutation editPerson($id: ID, $name: String, $lastName: String, $age : Int){
  editPerson(id:$id, name: $name, lastName: $lastName, age: $age) {
      id
      name
      lastName
      age
  }
}
''';
