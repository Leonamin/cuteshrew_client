enum CommonRoutes {
  home,
}

extension CommonRoutesExt on CommonRoutes {
  String get name => toString();

  String get path {
    switch (this) {
      case CommonRoutes.home:
        return '/';
    }
  }
}
