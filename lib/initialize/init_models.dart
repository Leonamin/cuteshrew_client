import 'package:cuteshrew/model/community_model.dart';
import 'package:cuteshrew/model/posting_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final communityModel = Provider((ref) => CommunityModel());
final postingModel = Provider((ref) => PostingModel());
