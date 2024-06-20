import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/core/common/widgets/custom_loading_indicator.dart';
import 'package:sehatin/features/history/presentation/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:sehatin/features/history/presentation/widgets/history_item_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<GetUserHistoryBloc>().add(GetUserHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat',
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
      body: BlocConsumer<GetUserHistoryBloc, GetUserHistoryState>(
        listener: (context, state) {
          if (state is GetUserHistoryLoading) {
            showDialog(
              context: context,
              builder: (context) => const CustomLoadingIndicator(),
            );
          } else if (state is GetUserHistoryFailed) {
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          } else {
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is GetUserHistoryLoaded) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: state.historyItemEntity!.length,
                  itemBuilder: (context, index) => HistoryItemCard(
                    historyItemEntity: state.historyItemEntity![index],
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
