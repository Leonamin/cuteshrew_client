import 'package:cuteshrew/pages/auth_page.dart';
import 'package:cuteshrew/pages/home_page.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginProvider(),
      child: Container(
        height: 100,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            height: 80,
            width: 150,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Image.asset('assets/images/logo.png')),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _NavBarIcon(Icons.shuffle, _onShufflePressed),
              _NavBarIcon(Icons.category, _onCategoryPressed),
              // context.watch<Counts>().count.toString()
              ((context.select((LoginProvider login) => login.loginToken)) ==
                      null)
                  ? _NavBarIcon(Icons.login, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AuthWidget()),
                      );
                    })
                  : _NavBarIcon(Icons.logout, () {
                      context.read<LoginProvider>().removeToken();
                    }),
            ],
          )
        ]),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  const _NavBarItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 18),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final Function onClick;
  const _NavBarIcon(this.icon, this.onClick);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onClick(),
      child: Icon(
        icon,
        color: Colors.black,
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 0.0,
        shadowColor: Colors.transparent,
      ),
    );
  }
}

void _onShufflePressed() {
  print("onShuffle");
}

void _onCategoryPressed() {
  print("onCategory");
}

void _onLoginPressed() {
  print("onLogin");
}
