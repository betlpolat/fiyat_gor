
import 'package:fiyat_gor/service/find_barcode_service.dart';
import 'package:fiyat_gor/state_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_with_keyboard_control/input_with_keyboard_control.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/setting/setting_screen.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key,required this.index}) : super(key: key);
  final int index;
  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController searchController = TextEditingController();
  final FindBarcodeService _barcodeService=FindBarcodeService();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }


  @override
  Widget build(BuildContext context) {
    searchController.selection = TextSelection(
        baseOffset: searchController.text.length,
        extentOffset: searchController.text.length);
    return RawKeyboardListener(
      focusNode: FocusNode(onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          return KeyEventResult.handled; // prevent passing the event into the TextField
        }
        return KeyEventResult.ignored; // pass the event to the TextField
      }),
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          print("cvbc");
          if(searchController.text=="1234q5w6"){

            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                child: const SettingScreen(),

              ),
            );
            setState(() {
              searchController.text="";
            });

          }
          else{
            searchWithBarcode();
          }
        }
      },
      child:/* InputWithKeyboardControl(
        focusNode: InputWithKeyboardControlFocusNode(),

        onSubmitted: (value) {
          print(value);
        },
        autofocus: true,
        controller: searchController,
        width: 300,
        startShowKeyboard: false,
        buttonColorEnabled: Constants.mainColor,
        buttonColorDisabled: Constants.blackColor,
        underlineColor: Constants.blackColor,
        showUnderline: true,
        showButton: true,
        style: TextStyle(

        ),
      )*/TextField(
        controller: searchController,
        autofocus: true,
        showCursor: true,
        keyboardType: TextInputType.number,
        textInputAction:TextInputAction.search,
        onSubmitted: (value){
          if(value=="1234q5w6"){
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                child: const SettingScreen(),
              ),
            );
            setState(() {
              searchController.text="";
            });
          }
          else{
            searchWithBarcode();
          }


        },
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Constants.darkGreyColor,
            ),
            fillColor: Constants.lightColor,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Constants.greyColor),
              borderRadius: BorderRadius.circular(100.0),
            ),
            hintText: Constants.searchBarcodeText,
            hintStyle: const TextStyle(color: Constants.greyColor)),

      ),
    );
  }

 /* Future<void> catchBarcodeEnter(String value) async {
    print(value);
    if (value.length > 1) {
      if (value[value.length - 1] == "r" && value[value.length - 2] == "\\") {
        //print("enter");
        setState(() {
          searchController.text = searchController.text
              .substring(0, searchController.text.length - 2);
          //  print(searchController.text);
        });
        await searchWithBarcode();
      }
    }
    if (value.length > 3) {
      if (value[value.length - 1] == "D" &&
          value[value.length - 2] == "0" &&
          value[value.length - 3] == "x" &&
          value[value.length - 4] == "\\") {
        setState(() {
          searchController.text = searchController.text
              .substring(0, searchController.text.length - 4);
          // print(searchController.text);
        });
        await searchWithBarcode();
      }
    }
  }*/
//9786057497901
  Future<void> searchWithBarcode() async {
    String quote = '\'';
    String text=quote+searchController.text+quote;
    print(text);
    if(searchController.text!=""){
      await _barcodeService.findBarcode(context,text);
    }


    if(!mounted)return;
    if(widget.index==0) {
      if(!mounted)return;
      Provider.of<StateData>(context,listen: false).startTimer(context);
      setState(() {
        searchController.text="";
      });

      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.bottomToTop,
          child: const CartScreen(),
        ),
      );
    }
    else{

      if(Provider.of<StateData>(context,listen: false).productNotFound==false){
        setState(() {
          searchController.text="";
        });
      }

      Provider.of<StateData>(context,listen: false).resetTimer();
    }
  }
}


