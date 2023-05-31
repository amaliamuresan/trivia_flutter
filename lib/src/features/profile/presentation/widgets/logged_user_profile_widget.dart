import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trivia_app/src/features/profile/data/firestore_user_public_repository.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/user_statistics_widget.dart';
import 'package:trivia_app/src/style/style.dart';

class LoggedUserProfileWidget extends StatefulWidget {
  const LoggedUserProfileWidget({super.key, required this.userData});

  final FirestoreUserPublicData userData;

  @override
  State<StatefulWidget> createState() => LoggedUserProfileWidgetState();
}

class LoggedUserProfileWidgetState extends State<LoggedUserProfileWidget> {
  late String? photoUrl;
  @override
  void initState() {
    super.initState();
    photoUrl = widget.userData.photoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppMargins.regularMargin),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              AvatarWidget(
                photoUrl: photoUrl,
              ),
              GestureDetector(
                onTap: pickPhoto,
                child: const _EditProfileIcon(),
              ),
            ],
          ),
          const SizedBox(height: AppMargins.regularMargin),
          Text(
            widget.userData.displayName ?? '',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppMargins.bigMargin),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              UserStatisticsWidget(
                upperText: '${widget.userData.nrOfMatchesPlayed ?? 0}',
                lowerText: 'matches',
              ),
              divider,
              UserStatisticsWidget(
                upperText:
                    '${((widget.userData.nrOfMatchesWon ?? 0) / (widget.userData.nrOfMatchesPlayed ?? 1) * 100).toInt()}%',
                lowerText: 'win rate',
              ),
              divider,
              UserStatisticsWidget(
                upperText: '${widget.userData.friendsUids?.length ?? 0}',
                lowerText: 'friends',
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> pickPhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final referenceRoot = FirebaseStorage.instance.ref();
    final referenceChild = referenceRoot.child('profileImages');
    final referenceImageToUpload = referenceChild.child(widget.userData.id);

    await referenceImageToUpload.putFile(File(image.path));

    await referenceImageToUpload.getDownloadURL().then((value) async {
      await FirestoreUserPublicRepository().updateProfilePictureUrl(widget.userData.id, value);
      setState(() => photoUrl = value);
    });
  }

  Widget get divider => const SizedBox(
        height: 36,
        child: VerticalDivider(
          thickness: .8,
          color: AppColors.greyLight,
        ),
      );
}

class _EditProfileIcon extends StatelessWidget {
  const _EditProfileIcon();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.white,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.edit_rounded,
          color: AppColors.white,
          size: 16,
        ),
      ),
    );
  }
}
