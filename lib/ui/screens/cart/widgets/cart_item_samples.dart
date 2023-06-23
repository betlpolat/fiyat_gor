import 'package:fiyat_gor/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../../constants.dart';
import '../../../../state_data.dart';

class CartItemSamles extends StatelessWidget {
  const CartItemSamles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products =Provider.of<StateData>(context)
        .productList;
    bool productNotFound =Provider.of<StateData>(context)
        .productNotFound;
    return
      Container(
          color: Constants.secondaryColor,
          child: Column(
            children: [
           productNotFound ? Container(
                constraints: BoxConstraints(minHeight: 50 , minWidth: MediaQuery.of(context).size.width) ,
                decoration: BoxDecoration(
border: Border.all(color: Constants.whiteColor),
              ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "ÜRÜN BULUNAMADI",
                        style: TextStyle(
                          fontSize: 25
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ) : const SizedBox.shrink()
              ,
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          height:100,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          //padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Constants.lightColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            children: [
                              Radio(
                                value: "",
                                groupValue: "",
                                onChanged: (index) {},
                                activeColor: Constants.mainColor,
                              ),
                            /*  Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.only(right: 15.0),
                                child: const Icon(
                                  FontAwesomeIcons.book,
                                 size: 25,
                                ),
                              ),*/
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    Text(
                                      products[index].ad ?? "",
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Constants.secondaryColor),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "₺${((products[index].fiyatListe ?? 0.00 )* (products[index].adet ?? 0)).toStringAsFixed(2)} "
                                          ,
                                          style: const TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                              color: Constants.secondaryColor),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "₺${((products[index].fiyat ?? 0.00 )* (products[index].adet ?? 0)).toStringAsFixed(2)} "
                                          ,
                                          style: const TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                              color: Constants.mainColor),
                                        ),
                                        Text(
                                              "( ₺${(products[index].fiyat ?? 0.00 ).toStringAsFixed(2)} x ${(products[index].adet ?? 0)} Adet )",
                                          style: const TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                              color: Constants.secondaryColor),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Constants.whiteColor,
                                          borderRadius: BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1.0,
                                                blurRadius: 10.0)
                                          ]),
                                      child:  IconButton(
                                        alignment: Alignment.center,

                                        onPressed: ()async{
                                          if((products[index].adet ?? 0)>1) {
                                            await Provider.of<StateData>(
                                                context, listen: false)
                                                .changeProductCount(
                                                (products[index].adet ?? 0) - 1,
                                                index);
                                          }
                                        },
                                        style: const ButtonStyle(
                                          alignment: Alignment.center,
                                        ),
                                        icon: const Icon(
                                          CupertinoIcons.minus,
                                          size: 18.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child:  Text(
                                        (products[index].adet ?? 0).toString(),
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Constants.whiteColor,
                                          borderRadius: BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1.0,
                                                blurRadius: 10.0)
                                          ]),
                                      child:  IconButton(
                                        style: const ButtonStyle(
                                         alignment: Alignment.center,
                                        ),
                                        onPressed: ()async{
                                          await Provider.of<StateData>(context, listen: false)
                                              .changeProductCount((products[index].adet ?? 0) +1, index);
                                        },
                                        icon: const Icon(

                                          CupertinoIcons.plus,
                                          size: 18.0,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Constants.mainColor,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0)
                                        ),
                              ),
                                    margin: const EdgeInsets.only(left: 40.0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10,horizontal: 15),
                                    child:  IconButton(
                                      onPressed: () async{
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.confirm,
                                            title: "Ürünü silmek isteğinizden emin misiniz?",
                                            confirmBtnText: 'Evet',
                                            cancelBtnText: 'Hayır',
                                            confirmBtnColor: Constants.mainColor,

                                            onConfirmBtnTap: () async{
                                              await Provider.of<StateData>(context, listen: false)
                                                  .deleteProduct(index);
                                              Navigator.pop(context);
                                            }
                                        );

                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Constants.whiteColor,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        );
  }
}
