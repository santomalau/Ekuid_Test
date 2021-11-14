import 'package:ekuidtest/bloc/person_bloc.dart';
import 'package:ekuidtest/screens/person/local_widgets/person_text_field.dart';
import 'package:ekuidtest/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    idController.text = arguments['person']?.id ?? '';
    nameController.text = arguments['person']?.name ?? '';
    lastNameController.text = arguments['person']?.lastName ?? '';
    ageController.text = (arguments['person']?.age ?? '').toString();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        // backgroundColor: const Color.fromRGBO(245, 213, 72, 1),
        backgroundColor: Colors.white,
        title: Text((arguments['action'] == 'addPerson')
            ? 'Add Student'
            : 'Edit Student'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PersonTextField(
                    label: 'ID',
                    hint: 'Enter Student ID',
                    controller: idController,
                    keyboardType: TextInputType.text,
                  ),
                  PersonTextField(
                    label: 'First Name',
                    hint: 'Enter Student First Name',
                    controller: nameController,
                    keyboardType: TextInputType.text,
                  ),
                  PersonTextField(
                    label: 'Last Name',
                    hint: 'Enter Student Last Name',
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                  ),
                  PersonTextField(
                    label: 'Age',
                    hint: 'Enter Student Age',
                    controller: ageController,
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primarycolor),
                        foregroundColor: MaterialStateProperty.all(blackcolor),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          BlocProvider.of<PersonBloc>(context).add(
                            PersonMutationEvent(
                              query: arguments['action'],
                              variables: {
                                "id": idController.text,
                                "name": nameController.text,
                                "lastName": lastNameController.text,
                                "age": int.parse(ageController.text)
                              },
                            ),
                          );
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
