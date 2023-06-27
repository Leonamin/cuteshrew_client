import 'package:cuteshrew/initialize/init_models.dart';
import 'package:cuteshrew/view/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModel = Provider(
    (ref) => HomeViewModel(ref.read(communityModel), ref.read(postingModel)));
