enum AssetImageIcon {
  logo,
}

extension AssetImageIconExtension on AssetImageIcon {
  String get path {
    switch (this) {
      case AssetImageIcon.logo:
        return 'assets/icons/logo.png';
    }
  }
}
