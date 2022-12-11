import 'package:chat/helpers.dart';
import 'package:chat/theme.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';

import '../widgets/avatar.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _Stories(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(_delegate),
        ),
      ],
    );
  }

  Widget _delegate(BuildContext context, int index) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();
    return _MessageTile(
      messageData: MessageData(
          senderName: faker.person.name(),
          message: faker.lorem.sentence(),
          messageDate: date,
          dateMessage: Jiffy(date).fromNow(),
          profilePicture: Helpers.randomPictureUrl()),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({super.key, required this.messageData});

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Avatar.medium(
            url: messageData.profilePicture,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  messageData.senderName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      letterSpacing: 0.2,
                      wordSpacing: 1.5,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                  height: 18.h,
                  child: Text(
                    messageData.message,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 12.sp, color: AppColors.textFaded),
                  ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 4.h,
              ),
              Text(
                messageData.dateMessage.toUpperCase(),
                style: TextStyle(
                  fontSize: 11.sp,
                  letterSpacing: -0.2,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textFaded,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width: 18.w,
                height: 18.h,
                decoration: BoxDecoration(
                    color: AppColors.secondary, shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  "1",
                  style: TextStyle(fontSize: 10.sp, color: AppColors.textLigth),
                )),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 134.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 16.h),
              child: Text(
                'Stories',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15.sp,
                    color: AppColors.textFaded),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final faker = Faker();
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                      child: SizedBox(
                        width: 60.w,
                        child: _StoryCard(
                          storyData: StoryData(
                              name: faker.person.firstName(),
                              url: Helpers.randomPictureUrl()),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 16.0.h),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
