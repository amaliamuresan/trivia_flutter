import 'package:flutter/material.dart';
import 'package:trivia_app/src/style/style.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, this.photoUrl, this.avatarSize = 48});

  final String? photoUrl;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: avatarSize,
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage: isPhotoUrlProvided ? NetworkImage(photoUrl!) : null,
      child: !isPhotoUrlProvided ? Icon(Icons.person, size: avatarSize, color: AppColors.white) : null,
    );
  }

  bool get isPhotoUrlProvided => photoUrl != null && photoUrl != '';
}
