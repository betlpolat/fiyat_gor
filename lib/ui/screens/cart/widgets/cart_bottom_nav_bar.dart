import 'package:fiyat_gor/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../state_data.dart';

class CartBottomNavBar extends StatefulWidget {
  const CartBottomNavBar({Key? key}) : super(key: key);

  @override
  State<CartBottomNavBar> createState() => _CartBottomNavBarState();
}

class _CartBottomNavBarState extends State<CartBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    String totalCount= Provider.of<StateData>(context,)
        .totalCount.toStringAsFixed(2);
    String totalListCount= Provider.of<StateData>(context,)
        .totalListCount.toStringAsFixed(2);
    return BottomAppBar(
        child: SizedBox(
      height: 60.0,
      child:  Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /* Text("Toplam: ",style: TextStyle(
            color: Constants.secondaryColor,
            fontSize: 22.0,
            fontWeight: FontWeight.bold
          ),),*/
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(  "₺ $totalListCount",style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Constants.secondaryColor,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold
              ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container (
              color: Constants.mainColor,
              alignment: Alignment.center,
              child: Text(  "₺ $totalCount",style: const TextStyle(
                  color: Constants.whiteColor,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold
              ),
              ),
            ),
          )

        ],
      ),
    ));
  }
}
