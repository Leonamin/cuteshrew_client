import 'package:cuteshrew/data/network_result.dart';
import 'package:cuteshrew/model/dto/login_dto.dart';
import 'package:cuteshrew/model/dto/posting_dto.dart';

abstract class PostingModel {
  Future<NetworkResult<PostingDetailInfo>> getPosting({
    required int communityName,
    required int postId,
    String? password,
  });

  // 페이지 단위로 게시글 가져오기
  Future<NetworkResult<List<PostingSummaryInfo>>> getPostingPage({
    required int communityId,
    required int pageNum,
    required int loadCount,
  });

  // 유저 이름으로 게시글 가져오기
  // userName은 필수
  // startAtId는 순서에 따라 (지금은 순서를 정하는게 없으니 최신순) 지정 아이디부터 혹은 순서 처음부터(지금은 가장 최신부터)
  // loadCount는 한번에 가져올 때 얼마나 가져올지 정하기
  Future<NetworkResult<List<PostingSummaryInfo>>> getPostingsByUser({
    required int userId,
    int? startOffset,
    int? loadCount,
  });

  // 게시글 생성하기
  Future<NetworkResult<void>> createPosting({
    required int communityId,
    required PostingCreateForm newPosting,
    required LoginToken loginToken,
  });

  // 게시글 업데이트
  Future<NetworkResult<void>> updatePosting({
    required int communityId,
    required int postId,
    required PostingCreateForm newPosting,
    required LoginToken loginToken,
  });

  // 게시글 삭제
  Future<NetworkResult<void>> deletePosting({
    required int communityName,
    required int postId,
    required LoginToken loginToken,
  });
}
