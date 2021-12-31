import 'package:flutter/material.dart';

class MemberInformation extends StatelessWidget {
  const MemberInformation({
    Key? key,
    required this.image,
    required this.name,
    required this.id,
    this.isLeader = false,
    this.isMember = false,
  }) : super(key: key);
  final bool isLeader;
  final bool isMember;
  final String image;
  final String name;
  final String id;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        top: 10,
        bottom: 20,
      ),
      width: size.width * 0.4,
      child: Column(
        children: [
          Container(
            width: size.width * 0.4,
            height: size.height * 0.2,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(blurRadius: 3),
              ],
            ),
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(blurRadius: 3),
              ],
            ),
            child: Row(
              children: [
                RichText(
                    text: TextSpan(
                      children: [
                        if(isLeader)
                          const TextSpan(
                            text: "Leader\n",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        if(isMember)
                          const TextSpan(
                              text: "Member\n",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        TextSpan(
                            text: name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )
                        ),
                        TextSpan(
                          text: id,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}