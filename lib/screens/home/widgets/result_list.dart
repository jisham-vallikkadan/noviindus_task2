import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/provider/task_provder.dart';
import 'package:flutter_task/screens/home/widgets/vedio_play.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

class ResultList extends StatelessWidget {
  const ResultList({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<TasKProvider>(builder: (context, home, _) {
      // home.controller = VideoPlayerController.networkUrl(Uri.parse(
      //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
      return home.isLoadingHome
          ? const CircularProgressIndicator()
          : ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.grey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/Logo.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    home.homeModel?.results![index].user
                                            ?.name ??
                                        "Maria",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "5 days ago",
                                    style: TextStyle(
                                      color: const Color(0xFFD5D5D5),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      videoPlayer(
                        result: home.homeModel?.results![index],
                      ),


                      ReadMoreText(
                        home.homeModel?.results![index].description ?? '',
                        trimMode: TrimMode.Line,
                        trimLines: 2,
                        colorClickableText: const Color(0xFFCDCDCD),
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCDCDCD)),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
              itemCount: home.homeModel?.results?.length ?? 0);
    });
  }
}
