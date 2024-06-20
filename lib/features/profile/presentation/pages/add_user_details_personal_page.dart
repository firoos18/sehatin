import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/core/common/widgets/custom_loading_indicator.dart';
import 'package:sehatin/core/common/widgets/custom_textfield.dart';
import 'package:sehatin/features/auth/domain/entities/user_entity.dart';
import 'package:sehatin/features/auth/presentation/pages/auth_page.dart';
import 'package:sehatin/features/profile/data/models/add_user_details_model.dart';
import 'package:sehatin/features/profile/data/models/user_details_model.dart';
import 'package:sehatin/features/profile/presentation/bloc/add_user_details/add_user_details_bloc.dart';

class AddUserDetailsPersonalPage extends StatefulWidget {
  final UserEntity? userEntity;

  const AddUserDetailsPersonalPage({super.key, required this.userEntity});

  @override
  State<AddUserDetailsPersonalPage> createState() =>
      _AddUserDetailsPersonalPageState();
}

class _AddUserDetailsPersonalPageState
    extends State<AddUserDetailsPersonalPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bodyWeightController = TextEditingController();
  final TextEditingController _bodyHeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUserDetailsBloc, AddUserDetailsState>(
      listener: (context, state) {
        if (state is AddUserDetailsLoading) {
          showDialog(
            context: context,
            builder: (context) => const CustomLoadingIndicator(),
          );
        } else if (state is AddUserDetailsFailed) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
        } else {
          context.pop();
          context.goNamed('auth', extra: AuthState.login);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 38),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Lengkapi Data",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1e1e1e),
                        ),
                      ),
                      Text(
                        "Isikanlah form di bawah dengan data yang sesuai.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xff1e1e1e).withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Spacer(flex: 5),
                  Column(
                    children: [
                      CustomTextField(
                        hint: 'Nama Lengkap',
                        icon: FeatherIcons.user,
                        controller: _nameController,
                        isObscure: false,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hint: 'Tinggi Badan',
                        icon: FeatherIcons.info,
                        controller: _bodyHeightController,
                        isObscure: false,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hint: 'Berat Badan',
                        icon: FeatherIcons.info,
                        controller: _bodyWeightController,
                        isObscure: false,
                      ),
                    ],
                  ),
                  const Spacer(flex: 10),
                  ElevatedButton(
                    onPressed: () {
                      final AddUserDetailsModel addUserDetailsData =
                          AddUserDetailsModel(
                        uuid: widget.userEntity!.id,
                        userDetailsEntity: UserDetailsModel(
                          email: widget.userEntity!.email,
                          name: _nameController.text.trim(),
                          bodyHeight: double.parse(_bodyHeightController.text),
                          bodyWeight: double.parse(
                            _bodyWeightController.text.trim(),
                          ),
                        ),
                      );

                      context.read<AddUserDetailsBloc>().add(
                            AddUserDetailsButtonTapped(
                                userDetailsModel: addUserDetailsData),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color(0xff1e1e1e),
                      foregroundColor: const Color(0xffF4F4F9),
                    ),
                    child: const Text(
                      'Lanjutkan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(flex: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
