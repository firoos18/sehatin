import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/features/auth/presentation/pages/auth_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 80,
              left: 15,
              right: 15,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/landing.svg'),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Tidak pernah terlambat untuk memulai hidup sehat. Mulai hidup sehat bersama ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: '“Sehatin”!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () {
                    context.goNamed(
                      'auth',
                      extra: AuthState.register,
                    );
                  },
                  customBorder: const CircleBorder(),
                  child: const CircleAvatar(
                    backgroundColor: Color(0xff1e1e1e),
                    radius: 32,
                    child: Icon(
                      FeatherIcons.chevronRight,
                      color: Color(0xffF4F4F9),
                      size: 28,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Sudah punya akun? ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.goNamed(
                                'auth',
                                extra: AuthState.login,
                              ),
                        text: 'Masuk',
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
    );
  }
}
