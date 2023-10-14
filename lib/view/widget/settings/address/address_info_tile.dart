import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:test/core/functions/alert_dialog.dart';
import 'package:test/cubits/address%20cubit/address_cubit.dart';
import 'package:test/data/model/address_model.dart';

class AddressInfoTile extends StatelessWidget {
  const AddressInfoTile({
    super.key,
    required this.addressModel,
  });
  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        addressModel.addressName!,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              addressModel.addressCity!,
              style: const TextStyle(
                  fontSize: 15,
                  decorationThickness: 3,
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 3,
            child: Text(
              addressModel.addressStreet!,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                onPressed: () {
                  alertDialog(
                      context: context,
                      title: "warning!!",
                      content: "are you sure you want to delete this location",
                      confirmText: 'yes',
                      confirmButtonColor: AppColor.primaryColor,
                      onPressed: () {
                        context.read<AddressCubit>().deleteAddress(addressModel);
                      });
                },
                icon: const Icon(
                  Icons.delete_outline,
                  size: 30,
                  color: Colors.redAccent,
                )),
          ),
        ],
      ),
    );
  }
}
