import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.url,
    required this.radius,
    this.onTap,
  }) : super(key: key);

  Avatar.small({
    Key? key,
    this.url,
    this.onTap,
  })  : radius = 18.r,
        super(key: key);

  Avatar.medium({
    Key? key,
    this.url,
    this.onTap,
  })  : radius = 26.r,
        super(key: key);

  Avatar.large({
    Key? key,
    this.url,
    this.onTap,
  })  : radius = 34.r,
        super(key: key);

  final double radius;
  final String? url;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _avatar(context),
    );
  }

  Widget _avatar(BuildContext context) {
    if (url != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(url!),
        backgroundColor: Theme.of(context).cardColor,
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).cardColor,
        child: Center(
          child: Text(
            '?',
            style: TextStyle(fontSize: radius),
          ),
        ),
      );
    }
  }
}
