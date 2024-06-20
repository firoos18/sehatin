import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehatin/features/profile/presentation/bloc/get_user_details/get_user_details_bloc.dart';

class CustomProfilePicture extends StatefulWidget {
  const CustomProfilePicture({super.key});

  @override
  State<CustomProfilePicture> createState() => _CustomProfilePictureState();
}

class _CustomProfilePictureState extends State<CustomProfilePicture> {
  @override
  void initState() {
    context.read<GetUserDetailsBloc>().add(GetUserDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDetailsBloc, GetUserDetailsState>(
      builder: (context, state) {
        if (state is GetUserDetailsLoaded) {
          String? textAvatar;

          final String fullname = state.userDetailsEntity!.name!;

          String firstName = fullname.split(' ')[0][0].toUpperCase();
          String lastName = fullname.split(' ')[1][0].toUpperCase();

          textAvatar = firstName + lastName;

          return Container(
            margin: const EdgeInsets.only(left: 15),
            child: CircleAvatar(
              backgroundColor: const Color(0xff1e1e1e),
              foregroundColor: const Color(0xffF4F4F9),
              child: Text(textAvatar),
            ),
          );
        } else if (state is GetUserDetailsLoading) {
          return const CupertinoActivityIndicator();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
