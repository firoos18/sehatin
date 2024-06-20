import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/core/common/widgets/custom_loading_indicator.dart';
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
      body: BlocConsumer<GetUserDetailsBloc, GetUserDetailsState>(
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
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
