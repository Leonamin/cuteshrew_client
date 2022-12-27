import 'package:flutter/material.dart';

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabcontroller;
  final List<Tab> tabs;

  TabBarDelegate({
    required this.tabcontroller,
    required this.tabs,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: TabBar(
          controller: tabcontroller,
          indicatorWeight: 2,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: tabs),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
