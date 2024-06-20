import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/core/common/widgets/custom_loading_indicator.dart';
import 'package:sehatin/core/common/widgets/custom_textfield.dart';
import 'package:sehatin/features/auth/data/models/auth_model.dart';
import 'package:sehatin/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:sehatin/features/auth/presentation/bloc/register/register_bloc.dart';

enum AuthState { login, register }

class AuthPage extends StatefulWidget {
  final AuthState? authState;

  const AuthPage({super.key, this.authState});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthState authState;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.authState != null) {
      setState(() {
        authState = widget.authState!;
      });
    } else {
      setState(() {
        authState = AuthState.register;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              showDialog(
                context: context,
                useRootNavigator: false,
                builder: (context) => const CustomLoadingIndicator(),
              );
            } else if (state is LoginFailed) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            } else {
              context.pop();
              context.goNamed(
                'home',
                extra: state.userEntity!.id,
              );
            }
          },
        ),
        BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              showDialog(
                context: context,
                useRootNavigator: false,
                builder: (context) => const CustomLoadingIndicator(),
              );
            } else if (state is RegisterFailed) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            } else {
              context.pop();
              context.goNamed(
                'user-details-personal',
                extra: state.userEntity!,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 38,
                bottom: 16,
                right: 15,
                left: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        authState == AuthState.login ? "Masuk" : "Daftar",
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1e1e1e),
                        ),
                      ),
                      Text(
                        authState == AuthState.login
                            ? "Isikan form di bawah dengan kredensial yang sesuai!"
                            : "Isikan form di bawah dengan data yang sesuai!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xff1e1e1e).withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: 'Email',
                          icon: FeatherIcons.mail,
                          controller: _emailController,
                          isObscure: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong!';
                            } else if (!value.contains('@')) {
                              return 'Masukkan email yang valid';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hint: 'Password',
                          icon: FeatherIcons.lock,
                          controller: _passwordController,
                          suffixIcon: FeatherIcons.eye,
                          isObscure: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong!';
                            } else {
                              return null;
                            }
                          },
                        ),
                        if (authState == AuthState.register)
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              CustomTextField(
                                hint: 'Ulangi Password',
                                icon: FeatherIcons.lock,
                                controller: _repeatPasswordController,
                                suffixIcon: FeatherIcons.eye,
                                isObscure: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password tidak boleh kosong!';
                                  } else if (value.length < 8) {
                                    return 'Karakter password tidak boleh kurang dari 8 karakter!';
                                  } else if (value !=
                                      _passwordController.text) {
                                    return 'Password tidak sama!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        SizedBox(height: authState == AuthState.login ? 16 : 0),
                        if (authState == AuthState.login)
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Lupa password?'),
                            ],
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (authState == AuthState.login) {
                          final AuthModel loginData = AuthModel(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          context
                              .read<LoginBloc>()
                              .add(LoginButtonTapped(authModel: loginData));
                        } else {
                          final AuthModel registerData = AuthModel(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          context.read<RegisterBloc>().add(
                              RegisterButtonTapped(authModel: registerData));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color(0xff1e1e1e),
                      foregroundColor: const Color(0xffF4F4F9),
                    ),
                    child: Text(
                      authState == AuthState.login ? 'Masuk' : 'Daftar',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(flex: 10),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: authState == AuthState.login
                              ? 'Belum punya akun? '
                              : 'Sudah punya akun? ',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => setState(
                                  () {
                                    if (authState == AuthState.login) {
                                      authState = AuthState.register;
                                    } else {
                                      authState = AuthState.login;
                                    }

                                    _emailController.text == '';
                                    _passwordController.text == '';
                                  },
                                ),
                          text:
                              authState == AuthState.login ? 'Daftar' : 'Masuk',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
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
