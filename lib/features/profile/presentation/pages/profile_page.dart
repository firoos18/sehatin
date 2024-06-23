import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/core/common/widgets/custom_loading_indicator.dart';
import 'package:sehatin/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:sehatin/features/auth/presentation/pages/auth_page.dart';
import 'package:sehatin/features/profile/presentation/bloc/get_user_details/get_user_details_bloc.dart';
import 'package:sehatin/features/profile/presentation/widgets/options_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<GetUserDetailsBloc>().add(GetUserDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff1e1e1e),
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(FeatherIcons.arrowLeft),
        ),
      ),
      body: BlocListener<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutLoading) {
            showDialog(
              context: context,
              builder: (context) => const CustomLoadingIndicator(),
            );
          } else if (state is LogoutFailed) {
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          } else {
            context.pop();
            context.goNamed('auth', extra: AuthState.login);
          }
        },
        child: BlocConsumer<GetUserDetailsBloc, GetUserDetailsState>(
          listener: (context, state) {
            if (state is GetUserDetailsLoading) {
              showDialog(
                context: context,
                builder: (context) => const CustomLoadingIndicator(),
              );
            } else if (state is GetUserDetailsFailed) {
              context.pop();

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message!)));
            } else {
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is GetUserDetailsLoaded) {
              String? textAvatar;

              final String fullname = state.userDetailsEntity!.name!;

              String firstName = fullname.split(' ')[0][0].toUpperCase();
              String lastName = fullname.split(' ')[1][0].toUpperCase();

              textAvatar = firstName + lastName;

              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 72),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff1e1e1e),
                        foregroundColor: const Color(0xffF4F4F9),
                        radius: 52,
                        child: Text(
                          textAvatar,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.userDetailsEntity!.name!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1e1e1e),
                      ),
                    ),
                    Text(
                      state.userDetailsEntity!.email!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff1e1e1e).withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 64),
                    const OptionsContainer(
                      icon: FeatherIcons.clock,
                      route: 'history',
                      title: 'Riwayat',
                    ),
                    const SizedBox(height: 16),
                    const OptionsContainer(
                      icon: FeatherIcons.heart,
                      route: 'favorite',
                      title: 'Favorit',
                    ),
                    const SizedBox(height: 16),
                    const OptionsContainer(
                      icon: FeatherIcons.settings,
                      route: 'preferences',
                      title: 'Pengaturan',
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Log Out?'),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => context
                                  .read<LogoutBloc>()
                                  .add(LogOutButtonTapped()),
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FeatherIcons.logOut,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 16),
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              FeatherIcons.chevronRight,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
