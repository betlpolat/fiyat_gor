import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fiyat_gor/constants.dart';
import 'package:fiyat_gor/ui/screens/cart/widgets/cart_bottom_nav_bar.dart';
import 'package:fiyat_gor/ui/screens/cart/widgets/cart_item_samples.dart';
import 'package:fiyat_gor/ui/commonWidgets/search_text_field.dart';
import 'package:fiyat_gor/ui/screens/cart/widgets/delete_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../state_data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Constants.mainColor,
        title: const SearchTextField(
          index: 1,
        ),
        leading: IconButton(
          onPressed: () async {
            await Provider.of<StateData>(context, listen: false).stopTimer();
            if (!mounted) return;
            await Provider.of<StateData>(context, listen: false)
                .deleteProductList();
            if (!mounted) return;
            await Provider.of<StateData>(context, listen: false)
                .changeProductNotFound(false);
            if (!mounted) return;
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: const [
          // CartTotal(),
          DeleteCart()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          children: const [
            // SearchTextField(index: 1,),
            CartItemSamles(),
          ],
        ),
      ),
      bottomNavigationBar: const CartBottomNavBar(),
    );
  }
}
