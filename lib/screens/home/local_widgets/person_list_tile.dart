import 'package:ekuidtest/api/models/models.dart';
import 'package:ekuidtest/bloc/person_bloc.dart';
import 'package:ekuidtest/screens/home/local_widgets/person_menu_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonListTile extends StatelessWidget {
  final Person person;
  const PersonListTile({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String fullname;
    if (person.lastName == null) {
      fullname = person.name.toString();
    } else {
      fullname = person.name.toString() + " " + person.lastName.toString();
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => Container(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PersonMenuPopUp(
                      content: "Edit",
                      function: () {
                        print("object");
                        Navigator.pop(context, true);
                        Navigator.pushNamed(
                          context,
                          '/person',
                          arguments: {'action': 'editPerson', 'person': person},
                        ); // Navigator.pop(context, true);
                      },
                    ),
                    Container(
                      color: Colors.grey.withOpacity(0.1),
                      height: 1,
                    ),
                    PersonMenuPopUp(
                      content: "Delete",
                      function: () {
                        BlocProvider.of<PersonBloc>(context).add(
                            PersonMutationEvent(
                                query: "deletePerson",
                                variables: {"id": "${person.id}"}));
                        Navigator.pop(context, true);
                      },
                    ),
                    Container(
                      color: Colors.grey.withOpacity(0.1),
                      height: 4,
                    ),
                    PersonMenuPopUp(
                      content: "Cancel",
                      function: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              offset: new Offset(2.0, 2.0),
            ),
          ],
        ),
        child: ListTile(
          leading: Image.asset('assets/images/ic_student.png'),
          title: Text(
            fullname,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          subtitle: Text(
            person.age.toString(),
          ),
        ),
      ),
    );
  }
}
