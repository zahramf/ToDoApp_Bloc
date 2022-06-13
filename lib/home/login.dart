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
                builder: (context) => TodosPage(username: state.username)));
          }

          if (state is HomeInitial) {
            if (state.error != null) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Error"),
                  content: Text(state.error!),
                ),
              );
            }
          }
        }, builder: (context, state) {
          if (state is HomeInitial) {
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
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context).add(
                          LoginEvent(usernameField.text, passwordField.text),
                        );
                      },
                      child: Text("LogIn"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(
                            RegisterAccountEvent(
                                usernameField.text, passwordField.text),
                          );
                        },
                        child: Text("Register"))
                  ],
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
