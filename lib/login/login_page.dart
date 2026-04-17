import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController user = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocProvider(
        create: (_) => LoginBloc(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(controller: user, decoration: const InputDecoration(labelText: "Username")),
              TextField(controller: pass, decoration: const InputDecoration(labelText: "Password")),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(
                    LoginButtonPressed(user.text, pass.text),
                  );
                },
                child: const Text("Login"),
              ),

              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginLoading) return const CircularProgressIndicator();
                  if (state is LoginSuccess) return const Text("Login Berhasil");
                  if (state is LoginFailure) return Text(state.message);
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}