import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubits/address%20cubit/address_cubit.dart';
import 'package:test/cubits/order%20cubit/order_cubit.dart';
import 'package:test/data/model/address_model.dart';

class AddressChooseInfo extends StatelessWidget {
  const AddressChooseInfo({
    super.key,
    required this.addressModel,
    required this.index,
  });
  final AddressModel addressModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<OrderCubit>().addressId = addressModel.addressId!;
        context.read<AddressCubit>().chooseLocation(index);
      },
      title: Text(
        addressModel.addressName!,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Text(
            addressModel.addressCity!,
            style: const TextStyle(
                fontSize: 15,
                decorationThickness: 3,
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              addressModel.addressStreet!,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
