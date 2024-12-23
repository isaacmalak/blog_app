import 'dart:developer';
import 'package:blog_app/core/ui/auth_gradiant_button.dart';
import 'package:blog_app/core/ui/auth_text_field.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController? nameController = TextEditingController();
  final TextEditingController? emailController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign UP.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              AuthTextField(hintText: 'Name', controller: nameController!),
              const SizedBox(height: 10),
              AuthTextField(hintText: 'Email', controller: emailController!),
              const SizedBox(height: 10),
              AuthTextField(
                hintText: 'Password',
                controller: passwordController!,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: AuthGradiantButton(
                          textButtonChild: () {
                                if (state is AuthRegisterLoading) {
                                  return const CircularProgressIndicator();
                                } else if (state is AuthInitial) {
                                  return const Text('Sign UP');
                                } else if (state is AuthRegisterFailed) {
                                  return const Text(
                                    'Signing up Failed',
                                    style: TextStyle(color: Colors.red),
                                  );
                                } else if (state is AuthRegisterSuccess) {
                                  return const Text(
                                    'successful Signing Up',
                                    style: TextStyle(color: Colors.green),
                                  );
                                }
                              }() ??
                              const Text('Sign UP'),
                          onPressed: () async {
                            log(emailController!.text);
                            // AuthRepoImplementation authRepoImplementation =
                            //     AuthRepoImplementation(Supabase.instance.client);
                            // authRepoImplementation.register(
                            //     email: emailController.text,
                            //     password: passwordController.text);

                            // try {
                            //   final response = await Supabase.instance.client.auth
                            //       .signUp(
                            //           email: emailController.text,
                            //           password: passwordController.text);
                            //   log(response.user!.id.toString());
                            // } catch (e) {
                            //   log(e.toString());
                            // }
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthRegister(
                                      data: {
                                        'name': nameController!.text.trim(),
                                      },
                                      email: emailController!.text,
                                      password: passwordController!.text.trim(),
                                    ),
                                  );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  SizedBox(
                    width: 62,
                    height: 35,
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).goNamed('login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: AppPallete.gradient1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
