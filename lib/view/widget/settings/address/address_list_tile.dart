import 'package:flutter/material.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:test/data/model/address_model.dart';
import 'package:test/view/widget/settings/address/address_info_tile.dart';

class AddressListTile extends StatelessWidget {
  const AddressListTile({
    super.key,
    required this.addressModel,
  });
  final AddressModel addressModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
          color: AppColor.secondaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          AddressInfoTile(
            addressModel: addressModel,
          ),
          const Spacer(),
          MaterialButton(
            minWidth: 20,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container();
                  });
            },
            color: AppColor.primaryColor,
            child: const Text(
              'تعديل',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
