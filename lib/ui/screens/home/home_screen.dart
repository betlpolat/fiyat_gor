import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fiyat_gor/constants.dart';
import 'package:fiyat_gor/service/sql_connect_service.dart';
import 'package:fiyat_gor/ui/commonWidgets/search_text_field.dart';
import 'package:fiyat_gor/ui/screens/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:open_file/open_file.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared_pref.dart';
import '../../../state_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  int activeIndex=0;
  final controller = CarouselController();
  bool isLoading=false;
  final SqlConnectService _sqlConnectService=SqlConnectService();

  Future<void> callSql() async{

    setState(() {
      isLoading=true;
    });
  await  _sqlConnectService.sharedConn(context);
    setState(() {
      isLoading=false;
    });
  }

  @override
  void initState() {
    super.initState();
    callSql();
  }

  @override
  Widget build(BuildContext context) {
    List<File> filePaths= Provider.of<StateData>(context)
        .filePaths;
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      appBar: AppBar(
        backgroundColor: Constants.mainColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(Constants.appTitle),
        actions: [
         /* Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: const SettingScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings)),
          )*/
        ],
      ),
      body: isLoading ? Constants().customCircularProggressIndicator :Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const ScrollPhysics(),
          children: [
            const SearchTextField( index: 0,),
            const SizedBox(
              height: 10,
            ),
           filePaths.length==0 ? const SizedBox.shrink() : CarouselSlider.builder(
              carouselController: controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    height: 180,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index)),
              itemCount: filePaths.length,
              itemBuilder: (context, index,realIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: const BoxDecoration(
                            ),
                          child: Image.file(File(filePaths[index].path)),
                        ),
                      ],
                    ))
                  ],
                );
              },
            ),
            const SizedBox(height: 10,),
            filePaths.length==0 ? const SizedBox.shrink() :Center(child: buildIndicator()),
          ],
        ),
      ),
    );
  }
  Widget buildIndicator()=>AnimatedSmoothIndicator(effect: const ExpandingDotsEffect(
    dotWidth: 15,
    activeDotColor: Constants.mainColor
  ),
    activeIndex: activeIndex,
    count: 5,
  );

}
