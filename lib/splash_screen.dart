import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/features/auth/presentation/bloc/get_user/get_user_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<GetUserBloc>().add(AppOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetUserBloc, GetUserState>(
      listener: (context, state) {
        if (state is GetUserSuccess) {
          Future.delayed(const Duration(seconds: 3)).then(
            (value) => context.goNamed('home', extra: state.userEntity!.id),
          );
        } else {
          Future.delayed(const Duration(seconds: 3)).then(
            (value) => context.goNamed('landing'),
          );
        }
      },
      child: const Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FlutterLogo(
                style: FlutterLogoStyle.markOnly,
                size: 64,
              ),
            )
          ],
        ),
      ),
    );
  }
}
