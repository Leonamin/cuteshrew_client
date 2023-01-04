import 'package:flutter/material.dart';

class SmallUserInfo extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  const SmallUserInfo({
    super.key,
    this.userName,
    this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 12),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userName ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userEmail ?? "",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            // child: Image.network(
            //   headerImage,
            //   fit: BoxFit.cover,
            //   height: 30,
            //   width: 30,
            // ),
          ),
        ],
      ),
    );
  }
}
