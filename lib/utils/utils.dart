class Utils {
  // timestamp 초단위임
  static String formatTimeStamp(int timeStamp) {
    DateTime postTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    DateTime now = DateTime.now();
    final gap = now.difference(postTime);
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int timeGap = currentTime - timeStamp * 1000;

    /*
      1분 이내: x초 전
      1시간 이내: x분 전
      하루 이내: x시간 전
      3일 이내: x일 전
      이후: xxxx년 xx월 x일 
    */

    if (gap.inMinutes < 1) {
      return "${gap.inSeconds}초 전";
    }
    if (gap.inHours < 1) {
      return "${gap.inMinutes}분 전";
    }
    if (gap.inDays < 1) {
      return "${gap.inHours}시간 전";
    }
    if (gap.inDays < 4) {
      return "${gap.inDays}일 전";
    }
    return "${postTime.year.toString()}년 ${postTime.month.toString().padLeft(2, '0')}월 ${postTime.day.toString().padLeft(2, '0')}일";
  }
}
