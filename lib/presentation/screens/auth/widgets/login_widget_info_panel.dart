import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

class LoginWidgetInfoPanel extends StatefulWidget {
  const LoginWidgetInfoPanel({super.key});

  @override
  State<LoginWidgetInfoPanel> createState() => _LoginWidgetInfoPanelState();
}

class _LoginWidgetInfoPanelState extends State<LoginWidgetInfoPanel>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  DateTime seedTime = DateTime.now();
  int networkImageInterval = 20;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        if (seedTime
                .add(Duration(seconds: networkImageInterval))
                .compareTo(DateTime.now()) <
            0) {
          seedTime = DateTime.now();
        }
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          Container(
            color: Colors.grey.shade100,
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://source.unsplash.com/random/?v=${seedTime.millisecondsSinceEpoch}​',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      // child: Center(
      //   child: SizedBox(
      //     height: 500,
      //     child: Stack(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 60.0),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(24),
      //     child: BackdropFilter(
      //       filter: ImageFilter.blur(
      //         sigmaX: 18,
      //         sigmaY: 18,
      //       ),
      //       child: Container(
      //         alignment: Alignment.center,
      //         color: Colors.white.withOpacity(0.3),
      //       ),
      //     ),
      //   ),
      // ),
      //         Align(
      //           alignment: Alignment.bottomRight,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
