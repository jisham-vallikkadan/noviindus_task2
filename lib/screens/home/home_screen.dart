import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/provider/task_provder.dart';
import 'package:flutter_task/screens/home/widgets/result_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var home = Provider.of<TasKProvider>(context, listen: false);
    home.fetchCategoryList(context: context);
    home.fetchHome(context: context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child:const  Icon(Icons.add,color: Colors.white,),
      ),
      backgroundColor: Colors.black,
      body: Consumer<TasKProvider>(builder: (context, home, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              home.homeModel?.user?.name ?? "Maria",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Welcome back to Section",
                              style: TextStyle(
                                color: const Color(0xFFD5D5D5),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/Logo.png'),
                      )
                    ],
                  ),
                ),
                home.categoryLoding
                    ? const SizedBox()
                    : SizedBox(
                        height: 60,
                        child: ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 15),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 13),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  home.categorylist?.categories![index].title ??
                                      '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 10,
                                ),
                            itemCount:
                                home.categorylist?.categories?.length ?? 0),
                      ),
                home.isLoadingHome
                    ? const CircularProgressIndicator()
                    : const Expanded(child: ResultList())
              ],
            ),
          ),
        );
      }),
    );
  }
}
