extension InsertBetween<T> on List<T> {
  List<T> insertBetween(T element) {
    if (length <= 1) return this;

    var newList = List<T>.generate(
      length * 2 - 1,
      (index) => index % 2 == 0 ? this[index ~/ 2] : element,
    );

    return newList;
  }
}
