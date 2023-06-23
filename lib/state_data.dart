import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'model/product_model.dart';

class StateData with ChangeNotifier{
  bool isConnected=false;
  bool isNotConnected=false;
  List<ProductModel> productList=[];
  double totalCount=0.00;
  double totalListCount=0.00;
  Timer? timer;
  static const maxSeconds=600;
  int seconds=maxSeconds;
  bool productNotFound=false;
  List<File> filePaths=[];
  Future<void>? changeIsConnected(bool value) async{
    isConnected=value;

    notifyListeners();
  }
  Future<void>? changeFilePaths(List<File> filePaths) async{
    this.filePaths=filePaths;
    notifyListeners();
  }

  Future<void>? changeProductNotFound(bool value) async{
    productNotFound=value;
    notifyListeners();
  }
  Future<void>? changeIsNotConnected(bool value) async{
    isNotConnected=value;
    notifyListeners();
  }
  Future<void>? addProduct(ProductModel product) async{
    int i=0;
   for( i=0;i< productList.length ;i++){

     //print("1");
     if(product.barkod==productList[i].barkod){
      await changeProductCount(1+(productList[i].adet ?? 0),i );
       break;
     }
   }
   if(i==productList.length){
     //print("2");
     productList.add(product);
     await changeProductCount(1,productList.length-1);

     notifyListeners();
   }

  }

  Future<void>? deleteProduct(int index) async{
    resetTimer();
    productList.removeAt(index);
    await changeTotalCount();
    notifyListeners();
  }
  Future<void>? deleteProductList() async{
    resetTimer();
    productList=[];
    totalCount=0.00;
    totalListCount=0.00;
    notifyListeners();
  }

  Future<void>? changeProductCount(int count,int index) async{
    resetTimer();
    productList[index].adet=count;
    await changeTotalCount();
    notifyListeners();
  }

  Future<void>? changeTotalCount() async{
    int i=0;
    int j=0;
    totalCount=0.00;
    totalListCount=0.00;
    for( i=0;i< productList.length ;i++){
      totalCount+=(productList[i].adet ?? 0) * (productList[i].fiyat ?? 0.0);
    }
    for( j=0;j< productList.length ;j++){
      totalListCount+=(productList[j].adet ?? 0) * (productList[j].fiyatListe ?? 0.0);
    }
    notifyListeners();
  }

  void startTimer(context) {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async{
      if(seconds>0){
        seconds--;
      }
      else{
       await stopTimer();
        Navigator.pop(context);

      }
    });
  }

  void resetTimer(){
    seconds=maxSeconds;
    notifyListeners();
  }

  Future<void> stopTimer() async{
    timer?.cancel();deleteProductList();
    notifyListeners();
  }

}