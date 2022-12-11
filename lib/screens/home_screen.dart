import 'package:chat/helpers.dart';
import 'package:chat/pages/calls_page.dart';
import 'package:chat/pages/contacts_page.dart';
import 'package:chat/pages/messages_page.dart';
import 'package:chat/pages/notifications_page.dart';
import 'package:chat/theme.dart';
import 'package:chat/widgets/avatar.dart';
import 'package:chat/widgets/icon_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage()
  ];

  final pageTitles = const ['Messages', 'Notifications', 'Calls', 'Contacts'];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    pageIndex.addListener(() {
      print(pageIndex.value);
    });
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        leadingWidth: 54.w,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {
              print("todo search");
            },
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: Avatar.small(
              url: Helpers.randomPictureUrl(),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        // title: ValueListenableBuilder(
        //   valueListenable: title,
        //   builder: (BuildContext context, String value, _) {
        //     return Text(value,
        //         style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16.sp,
        //             color: AppColors.textDark));
        //   },
        // ),
      ),
      body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          }),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: EdgeInsets.only(top: 16.h, left: 8.w, right: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
                isSelected: (selectedIndex == 0),
                onTap: handleItemSelected,
                label: 'Messages',
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
              ),
              _NavigationBarItem(
                index: 1,
                isSelected: (selectedIndex == 1),
                onTap: handleItemSelected,
                label: 'Notifications',
                icon: CupertinoIcons.bell_solid,
              ),
              _NavigationBarItem(
                index: 2,
                isSelected: (selectedIndex == 2),
                onTap: handleItemSelected,
                label: 'Calls',
                icon: CupertinoIcons.phone_fill,
              ),
              _NavigationBarItem(
                index: 3,
                isSelected: (selectedIndex == 3),
                onTap: handleItemSelected,
                label: 'Contacts',
                icon: CupertinoIcons.person_2_fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.index,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final ValueChanged<int> onTap;

  final int index;
  final String label;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 70.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              label,
              style: isSelected
                  ? TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold)
                  : TextStyle(fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }
}
