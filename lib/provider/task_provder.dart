import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/login_screen/login_screen.dart';
import 'package:video_player/video_player.dart';

import '../models/category_model.dart';
import '../models/homw_model.dart';
import '../models/login_model.dart';
import '../screens/home/home_screen.dart';
import '../service/network_service.dart';
import '../utils/constants.dart';
import '../utils/shared_preference.dart';
import '../utils/toast_util.dart';

class TasKProvider with ChangeNotifier {
  String? selectedCode = '+91';
  List<String> code = ['+91', '+971'];

  LoginModel? loginModel;

  bool isLoading = false;

  otpLogin({
    required BuildContext context,
    required String? number,
  }) async {
    isLoading = true;
    notifyListeners();
    loginModel = await NetworkService()
        .loginOtpVerify(context: context, number: number, code: selectedCode);
    print('[------${jsonEncode(loginModel)}');
    if (loginModel?.status == true) {
      await SharedPrefUtil.writeString(
          keyAccessToken, loginModel!.token!.access.toString());
      ToastUtil.show(loginModel!.message.toString());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      ToastUtil.show(loginModel!.message.toString());
    }
    isLoading = false;
    notifyListeners();
  }


  CategoryModel?  categorylist;
  bool categoryLoding=false;

  fetchCategoryList({
    required BuildContext context,
  }) async {
    categoryLoding = true;
    notifyListeners();
    categorylist = (await NetworkService().getCategoryList(
      context: context,
    ))!;
    print('----${jsonEncode(categorylist)}');
    categoryLoding = false;
    notifyListeners();
  }

  HomeModel? homeModel;
  bool isLoadingHome=false;
  fetchHome({
    required BuildContext context,
  }) async {
    isLoadingHome = true;
    notifyListeners();
    homeModel = (await NetworkService().getHome(
      context: context,
    ))!;
    print('----${jsonEncode(homeModel)}');
    isLoadingHome = false;
    notifyListeners();
  }

  late VideoPlayerController controller;

}
