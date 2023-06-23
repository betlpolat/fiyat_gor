import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fiyat_gor/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../service/sql_connect_service.dart';
import '../../../shared_pref.dart';
import '../../../state_data.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();
  String ip = "";
  String port = "";
  String databaseName = "";
  String filePath="";
  String username = "";
  String password = "";
  String errorMessage = "";
  final SqlConnectService _sqlConnectService=SqlConnectService();
  final SharedPref _sharedPref = SharedPref();
  bool _isLoading=false;


  @override
  void initState() {
    super.initState();
    callShared();
  }

  bool isSharedNone(String a) {
    bool isNone = false;
    if (a == "none") {
      isNone = true;
    }
    return isNone;
  }

  void callShared() async {
    ip = await _sharedPref.getString("ip");
    if (isSharedNone(ip) == true) {
      setState(() {
        ip = "";
      });
    }
    port = await _sharedPref.getString("port");
    if (isSharedNone(port) == true) {
      setState(() {
        port = "";
      });
    }
    filePath =await _sharedPref.getString("filePath");
    if (isSharedNone(filePath) == true) {
      setState(() {
        filePath = "";
      });
    }
    databaseName = await _sharedPref.getString("databaseName");
    if (isSharedNone(databaseName) == true) {
      setState(() {
        databaseName = "";
      });
    }
    username = await _sharedPref.getString("userName");
    if (isSharedNone(username) == true) {
      setState(() {
        username = "";
      });
    }
    password = await _sharedPref.getString("password");
    if (isSharedNone(password) == true) {
      setState(() {
        password = "";
      });
    }

    setState(() {
      ip;
      port;
      databaseName;
      filePath;
      username;
      password;
    });
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController ipController = TextEditingController(text: ip);
    TextEditingController portController = TextEditingController(text: port);
    TextEditingController filePathController =TextEditingController(text: filePath);
    TextEditingController databaseNameController =
        TextEditingController(text: databaseName);
    TextEditingController usernameController =
        TextEditingController(text: username);
    TextEditingController passwordController =
        TextEditingController(text: password);
    bool isConnected= Provider.of<StateData>(context, listen: false).isConnected;
    bool isNotConnected= Provider.of<StateData>(context, listen: false).isNotConnected;
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          backgroundColor: Constants.secondaryColor,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: ()async{
              await Provider.of<StateData>(context, listen: false)
                  .changeIsConnected(false);
              await Provider.of<StateData>(context, listen: false)
                  .changeIsNotConnected(false);
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        progressIndicator: Constants().customCircularProggressIndicator,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children:[
              Form(
              key: _formKey,
              child: Flex(
                mainAxisSize: MainAxisSize.min,
                direction: Axis.vertical,
                children: [
                   const Flexible(
                    child: Text(
                      "Giriş Yap",
                      style: TextStyle(
                          color: Constants.backColor,
                          fontSize: 50,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Flexible(
                      child: Column(

                        children: [
                          isConnected ?Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildConnectedSqlText(),
                          ) : isNotConnected ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildErrorText(),
                          ) : const SizedBox.shrink(),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: buildIpText(ipController),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: buildPortText(portController),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: buildDatabaseText(databaseNameController),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Expanded(child: buildFilePathText(filePathController)),
                                IconButton(onPressed: ()async{
                                  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
                                    filePathController.text=selectedDirectory ?? "";

                                  FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
                                    filePathController.text=selectedDirectory ?? "";
                                  print(selectedDirectory);
                                  if(result==null)return;
                                  final files=result.files;
                                  print("fsdrfd");
                                  //openFiles(file);
                                  final newFile=await saveFilePermanently(files);
                                  if(!mounted)return;
                                  await Provider.of<StateData>(context, listen: false)
                                      .changeFilePaths(newFile);
                                  print(newFile);
                                }, icon: const Icon(Icons.file_copy_sharp))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: buildUsernameText(usernameController),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: buildPasswordText(passwordController),
                          ),
                          const SizedBox(height: 12,),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ElevatedButton(onPressed:() async {
                              await Provider.of<StateData>(context, listen: false)
                                  .changeIsConnected(false);
                              if(!mounted)return;

                              await Provider.of<StateData>(context, listen: false)
                                  .changeIsNotConnected(false);
                              setState(() {
                                _isLoading=true;

                              });
                            setState(() {
                            ip = ipController.text;
                            port = portController.text;
                            databaseName = databaseNameController.text;
                            filePath=filePathController.text;
                            username = usernameController.text;
                            password = passwordController.text;
                            });
                            if (_formKey.currentState!.validate()) {
                              if(!mounted)return;
                              bool response= await _sqlConnectService.sqlConnect(
                                  context,
                                 ip,port,databaseName,filePath,username,password);
                              if( response==true){
                                if(!mounted)return;
                                await Provider.of<StateData>(context, listen: false)
                                    .changeIsConnected(true);
                              }
                              else{
                                if(!mounted)return;
                                await Provider.of<StateData>(context, listen: false)
                                    .changeIsNotConnected(true);
                              }

                               setState(() {
                                 _isLoading=false;

                               });
                            }
                            }, child: const Text(
                              "BAĞLAN",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),

                            )),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
  void openFiles(PlatformFile file){
      OpenFile.open(file.path!);
  }

  Future<List<File>> saveFilePermanently(List<PlatformFile> files) async{
    final appStorage= await getExternalStorageDirectory();
    List<File> filePaths=[];
    int i=0;
    print(files[0].path);
    while(i<files.length) {
      final newFile= File("${appStorage!.path}/${files[i].name}");
      filePaths.add(await File(files[i].path!).copy(newFile.path));
      i++;
    }
    //print(filePaths);
    return filePaths;
  }

  TextFormField buildIpText(TextEditingController ipController) {
    return TextFormField(
      controller: ipController,
      decoration: const InputDecoration(
        hintText: "İp adresi",
        prefixIcon: Icon(FontAwesomeIcons.computer,size: 20,),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "İp adresi boş bırakılamaz";
        }
        return null;
      },
    );
  }

  TextFormField buildPortText(TextEditingController portController) {
    return TextFormField(
      controller: portController,
      decoration: const InputDecoration(
        hintText: "Port",
        prefixIcon: Icon(Icons.compare_arrows,size: 20,),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Port boş bırakılamaz";
        }
        return null;
      },
    );
  }

  TextFormField buildDatabaseText(
      TextEditingController databaseNameController) {
    return TextFormField(
      controller: databaseNameController,
      decoration: const InputDecoration(
        hintText: "Veritabanı Adı",
        prefixIcon: Icon(FontAwesomeIcons.database,size: 20,),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Veritabanı adı boş bırakılamaz";
        }
        return null;
      },
    );
  }

  TextFormField buildFilePathText(
      TextEditingController filePathController) {
    return TextFormField(
      readOnly: true,
      controller: filePathController,
      decoration: const InputDecoration(
        hintText: "Dosya Yolu",
        prefixIcon: Icon(FontAwesomeIcons.fileCode,size: 20,),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Dosya yolu adı boş bırakılamaz";
        }
        return null;
      },
    );
  }

  TextFormField buildUsernameText(TextEditingController usernameController) {
    return TextFormField(
      controller: usernameController,
      decoration: const InputDecoration(
        hintText: "Kullanıcı adı",
        prefixIcon: Icon(Icons.person,size: 20,),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Kullanıcı adı boş bırakılamaz";
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordText(TextEditingController passwordController) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Şifre",
        prefixIcon: Icon(Icons.lock,size: 20,),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Şifre alanı boş bırakılamaz";
        }
        return null;
      },
    );
  }
  Text buildConnectedSqlText() {
    return const Text(
      "Bağlantı Başarılı",
      style: TextStyle(
          color: Constants.greenColor, fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Text buildErrorText() {
    return const Text(
      "Bağlantıda bir sorun oluştu",
      style: TextStyle(
          color:  Constants.mainColor, fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
