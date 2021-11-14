import 'package:ekuidtest/screens/home/home.dart';
import 'package:ekuidtest/screens/person/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekuidtest/api/api.dart';
import 'package:ekuidtest/bloc/person_bloc.dart';

// void main() => runApp(MyApp(personsApiClient: PersonApiClient.create()));
void main() async {
  runApp(
    BlocProvider(
      create: (context) =>
          PersonBloc(personsApiClient: PersonApiClient.create()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<PersonBloc>(context).add(PersonFetchStarted());

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/person': (context) => const PersonScreen(),
      },
    );
  }
}
