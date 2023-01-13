import 'package:cuteshrew/presentation/config/constants/color.dart';
import 'package:flutter/material.dart';

class CommunityCard extends StatelessWidget {
  final String? communityShowName;
  final Function()? onTitlePressed;
  final List<Widget>? postingPanel;

  const CommunityCard({
    super.key,
    this.communityShowName,
    this.onTitlePressed,
    this.postingPanel,
  });
  static const double borderRadius = 8.0;
  static const double defaultPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        color: communityPrimaryColor,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              communityShowName ?? "",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            // 분류 패널
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Container(
                height: 40,
                color: communitySecondaryColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '제목',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '댓글',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            '조회수',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: postingPanel ?? [],
            )
          ],
        ),
      ),
    );
  }
}
