import 'package:fiyat_gor/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../../state_data.dart';

class DeleteCart extends StatelessWidget {
  const DeleteCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      child: IconButton(
        onPressed: () {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.confirm,
            title: "Sepeti boşaltmak isteğinizden emin misiniz?",
            confirmBtnText: 'Evet',
            cancelBtnText: 'Hayır',
              confirmBtnColor: Constants.mainColor,
            onConfirmBtnTap: () async{
               await Provider.of<StateData>(context, listen: false)
              .deleteProductList();
               Navigator.pop(context);
            }
          );

        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
