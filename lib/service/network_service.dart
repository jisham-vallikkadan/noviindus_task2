import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/homw_model.dart';
import '../models/login_model.dart';
import '../utils/toast_util.dart';
import '../utils/urls.dart';
import 'network_helper.dart';

class NetworkService {
  Future<CategoryModel?> getCategoryList({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await NetworkHelper().getRequest(
      context: context,
      url:Urls.categoryUrl,
    );

    if (response!.statusCode == 200||response!.statusCode == 202) {
      return  CategoryModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
    }
  }

  Future<LoginModel?> loginOtpVerify({
    required BuildContext context,
    required String? number,
    required String? code,
  }) async {
    var response;
    response = await NetworkHelper().postRequest(
      header: {
      },
        url: Urls.otpVerifyUrl, body: {"country_code": code, "phone": number});
    if (response.statusCode == 200||response.statusCode == 202) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      var error = jsonDecode(response.request);
      print(error.toString());
      ToastUtil.show(error['message']);
      debugPrint(response.body);
      return null;
    }
  }


  Future<HomeModel?> getHome({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await NetworkHelper().getRequest(
      context: context,
      url:Urls.homeUrl,
    );

    if (response!.statusCode == 200||response!.statusCode == 202) {
      return    HomeModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
    }
  }


}
