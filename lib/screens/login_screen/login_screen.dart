import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/provider/task_provder.dart';
import 'package:provider/provider.dart';

import '../common_widgets/custom_textfield.dart';
import '../common_widgets/field_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();

late TextEditingController? number = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<TasKProvider>(builder: (context, otp, _) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                print(otp.selectedCode);
                print(number?.text);
                otp.otpLogin(context: context, number: number?.text.trim());
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50)),
              child: otp.isLoading
                  ?const  Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          ),
          backgroundColor: Colors.black12,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                height:
                    ScreenUtil().screenHeight - ScreenUtil().statusBarHeight,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 39.h,
                        ),
                        Text(
                          "Enter Your \nMobile Number",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet consectetur. Porta at id hac vitae. Et tortor at vehicula euismod mi viverra.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 5),
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (val) {
                                    if (val == null) {
                                      return "Select code ";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  dropdownColor: Colors.white,
                                  decoration: InputDecoration(
                                      counter: const SizedBox.shrink(),
                                      fillColor: Colors.black,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                      constraints:
                                          BoxConstraints(minHeight: 65.h),
                                      suffixIconConstraints:
                                          BoxConstraints(maxHeight: 65.h),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.white)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD9D9D9))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFD9D9D9),
                                          ))),
                                  hint: Text(
                                    "+91",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300,
                                      height: 1,
                                    ),
                                  ),
                                  value: otp.selectedCode,
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    size: 24.sp,
                                    color: Colors.white,
                                  ),
                                  items: otp.code.map((items) {
                                    return DropdownMenuItem(
                                      value: items ?? "",
                                      child: Text(
                                        items ?? "",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {},
                                ),
                              ),
                            ),
                            Expanded(
                              child: CustomTextField(
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                fillColor: Colors.black,
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  // height: 0.12,
                                ),
                                controller: number,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Enter Mobile Number ";
                                  } else if (val.length != 10) {
                                    return "Enter valied Mobile Number ";
                                  } else {
                                    return null;
                                  }
                                },
                                hintText: "Enter Mobile Number",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
