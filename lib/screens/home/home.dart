import 'package:ekuidtest/api/models/models.dart';
import 'package:ekuidtest/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekuidtest/bloc/person_bloc.dart';

import 'local_widgets/person_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PersonBloc? bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PersonBloc>(context, listen: false);
    bloc?.add(PersonFetchStarted());
    // BlocProvider.of<PersonBloc>(context).add(PersonFetchStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 213, 72, 1),
        title: const Text(
          "EKUID TEST",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: BlocConsumer<PersonBloc, PersonState>(
            listener: (context, state) {},
            builder: (context, state) {
              return StreamBuilder<List<Person>>(
                stream: bloc?.listStream,
                builder: (context, snapshot) {
                  print(snapshot.connectionState);
                  return RefreshIndicator(
                    color: primarycolor,
                    onRefresh: () async {
                      bloc?.add(PersonFetchStarted());
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state is PersonLoadInProgress) ...[
                            CircularProgressIndicator(
                              color: primarycolor,
                            )
                          ] else if (state is PersonLoadSuccess) ...[
                            if (snapshot.hasData) ...[
                              Container(
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 1),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Total Student : ' +
                                      snapshot.data!.length.toString(),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final person = snapshot.data![index];

                                  return PersonListTile(person: person);
                                },
                              )
                            ]
                          ] else
                            SizedBox(
                              child: Text('Oops something went wrong!'),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );

              // if (state is PersonLoadSuccess) {

              //     },
              //   );
              // }

              // if (state is PersonDeleteState) {
              //   bloc?.add(PersonFetchStarted());
              // }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/person',
            arguments: {'action': 'addPerson'},
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: primarycolor,
      ),
    );
  }
}
