import 'package:check_bird/screens/about/widgets/member_info.dart';
import 'package:check_bird/screens/about/widgets/play_video_url.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
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
              margin: const EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              width: size.width * 0.9,
              child: const Column(children: [
                Icon(
                  Icons.people_alt,
                  size: 25,
                  color: Colors.white,
                ),
                Text("Techlosophy",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                Text(
                  "\nOur core values are to bring about happiness to everyone!\n",
                  style: TextStyle(
                    color: Colors.white,
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
                    name: "Nguyen Ngoc Phuoc\n",
                    id: "19127519",
                    isLeader: true),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MemberInformation(
                    image: "assets/images/duy.jpg",
                    name: "Ho Van Duy\n",
                    id: "19127373",
                    isMember: true),
                MemberInformation(
                    image: "assets/images/ha.jpg",
                    name: "Pham Le Ha\n",
                    id: "19127385",
                    isMember: true),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MemberInformation(
                    image: "assets/images/giang.jpg",
                    name: "Nguyen Truong Giang\n",
                    id: "19127384",
                    isMember: true),
                MemberInformation(
                    image: "assets/images/duc.jpg",
                    name: "Le Minh Duc\n",
                    id: "19127369",
                    isMember: true),
              ],
            )
          ],
        ),
      ),
    );
  }
}
