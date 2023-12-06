import 'package:check_bird/screens/about/widgets/member_info.dart';
import 'package:check_bird/screens/about/widgets/play_video_url.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  static const routeName = '/about-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("About us"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              width: size.width * 0.9,
              child: const Column(children: [
                SizedBox(height: 8),
                Icon(
                  Icons.people_alt,
                  size: 25,
                ),
                Text("Techlosophy",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                Text(
                  "\nOur core values are to bring about happiness to everyone!\n",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                )
              ]),
            ),
            PlayVideoURL(
              videoPlayerController: VideoPlayerController.networkUrl(
                Uri.parse(
                    'https://res.cloudinary.com/dgci6plhk/video/upload/v1640971476/KNM_-_K19_HCMUS_Value_of_Life_gese1d.mp4'),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MemberInformation(
                    image: "assets/images/Phuoc.jpg",
                    name: "Nguyen Ngoc Phuoc",
                    id: "19127519",
                    isLeader: true),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MemberInformation(
                  image: "assets/images/duy.jpg",
                  name: "Ho Van Duy",
                  id: "19127373",
                ),
                MemberInformation(
                  image: "assets/images/ha.jpg",
                  name: "Pham Le Ha",
                  id: "19127385",
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MemberInformation(
                  image: "assets/images/giang.jpg",
                  name: "Nguyen Truong Giang",
                  id: "19127384",
                ),
                MemberInformation(
                  image: "assets/images/duc.jpg",
                  name: "Le Minh Duc",
                  id: "19127369",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
