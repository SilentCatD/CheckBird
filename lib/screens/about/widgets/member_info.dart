import 'package:flutter/material.dart';

class MemberInformation extends StatelessWidget {
  const MemberInformation({
    super.key,
    required this.image,
    required this.name,
    required this.id,
    this.isLeader = false,
  });

  final bool isLeader;
  final String image;
  final String name;
  final String id;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const borderRadius = 10.0;
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      width: size.width * 0.45,
      child: Column(
        children: [
          Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
              boxShadow: const [
                BoxShadow(blurRadius: 3),
              ],
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius),
              ),
              boxShadow: [
                BoxShadow(blurRadius: 3),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isLeader)
                  const Text(
                    "Leader",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  const Text(
                    "Member",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 40,
                  ),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  id,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
