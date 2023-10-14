import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubits/search%20cubit/search_cubit.dart';
import 'package:test/generated/l10n.dart';
import 'package:test/view/widget/home/notification_icon.dart';
import 'package:test/view/widget/home/text_search_field.dart';
import 'package:flutter/material.dart';

class SearchProductBar extends StatelessWidget {
  const SearchProductBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SearchCubit searchCubit = context.read<SearchCubit>();
    String search = '';
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(children: [
        Expanded(
            child: TextSearchField(
          onPressed: () {
            searchCubit.search(search);
          },
          text: S.of(context).find_product,
          onChanged: (text) {
            search = text.trim();
            searchCubit.checkSearch(text);
          },
          onFieldSubmitted: (search) {
            searchCubit.search(search);
          },
        )),
        const SizedBox(width: 10),
        const NotificationIcon()
      ]),
    );
  }
}
