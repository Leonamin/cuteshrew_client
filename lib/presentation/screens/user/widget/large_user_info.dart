import 'package:flutter/material.dart';

class LargeUserInfo extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? introduction;
  const LargeUserInfo({
    super.key,
    this.userName,
    this.userEmail,
    this.introduction,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              // child: Image.network(
              //   userImage,
              //   fit: BoxFit.cover,
              //   height: 100,
              //   width: 100,
              // ),
              child: Container(
                color: Colors.white,
                child: Icon(Icons.person_outline_outlined, size: 100),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            userName ?? "",
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(userEmail ?? ""),
          const SizedBox(
            height: 8,
          ),
          Text(
            introduction ?? "",
          ),
        ],
      ),
    );
  }
}
