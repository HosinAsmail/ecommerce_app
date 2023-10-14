import 'package:test/cubits/cart%20cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/generated/l10n.dart';

class CustomCartBar extends StatelessWidget {
  const CustomCartBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  S.of(context).cart,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                )),
          ),
          Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    context.read<CartCubit>().getAsyncCart();
                  },
                  icon: const Icon(Icons.update))),
        ],
      ),
    );
  }
}
