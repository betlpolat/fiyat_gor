import 'dart:convert';

import 'package:fiyat_gor/model/product_model.dart';
import 'package:provider/provider.dart';
import 'package:sql_conn/sql_conn.dart';

import '../state_data.dart';

class FindBarcodeService{

  Future<Object> findBarcode(context,String barcode) async{
    try{
      var res= await SqlConn.readData(
          "SELECT TOP 1 *  FROM vw_fiyatgor_urun WHERE Barkod=$barcode order by Id desc");

      var parsedJson = jsonDecode(res.toString());
      ProductModel product;

        product= ProductModel.fromJson(parsedJson[0]);
    print(product.adet);
      await Provider.of<StateData>(context, listen: false)
          .addProduct(product);
      Provider.of<StateData>(context,listen: false).changeProductNotFound(false
      );
      return product;
    }
    catch (e){
      print("ddfgb");
     await Provider.of<StateData>(context,listen: false).changeProductNotFound(true);
      print(e);
      return e.toString();
    }
  }
}