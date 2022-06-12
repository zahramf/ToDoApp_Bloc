import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_bloc/home/bloc/bloc/home_bloc.dart';
import 'package:to_do_app_bloc/home/services/authentication.dart';
import 'package:to_do_app_bloc/home/services/todo.dart';
import 'package:to_do_app_bloc/todos/bloc/todos.dart';

class LoginPage extends StatelessWidget {
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login to Todo App"),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(RegisterServicesEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
          if (state is SuccessfulLoginState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TodosPage(username: "username")));
          }
        }, builder: (context, state) {
          if (State is HomeInitial) {
            return Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'username'),
                  controller: usernameField,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'password'),
                  controller: passwordField,
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context).add(
                      LoginEvent(usernameField.text, passwordField.text),
                    );
                  },
                  child: Text("LogIn"),
                ),
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
