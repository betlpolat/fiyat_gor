import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../state_data.dart';

class CartTotal extends StatelessWidget {
  const CartTotal({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    double totalCount= Provider.of<StateData>(context,)
        .totalCount;
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Constants.whiteColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0)),
              color: Constants.secondaryColor,
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Constants.whiteColor,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child:  Text(
              "₺ $totalCount",
              style: const TextStyle(
                  color: Constants.mainColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
