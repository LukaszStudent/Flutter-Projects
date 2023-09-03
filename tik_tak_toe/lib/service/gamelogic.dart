class GameLogic {
  bool isEnd = false;
  List<int> indexesPlayerX = [];
  List<int> indexesPlayerO = [];
  bool endGame(List coordinates) {
    if (coordinates.contains(0) &&
        coordinates.contains(1) &&
        coordinates.contains(2)) {
      //row 1
      return true;
    } else if (coordinates.contains(3) &&
        coordinates.contains(4) &&
        coordinates.contains(5)) {
      //row2
      return true;
    } else if (coordinates.contains(6) &&
        coordinates.contains(7) &&
        coordinates.contains(8)) {
      //row3
      return true;
    } else if (coordinates.contains(0) &&
        coordinates.contains(3) &&
        coordinates.contains(6)) {
      //col1
      return true;
    } else if (coordinates.contains(1) &&
        coordinates.contains(4) &&
        coordinates.contains(7)) {
      //col2
      return true;
    } else if (coordinates.contains(2) &&
        coordinates.contains(5) &&
        coordinates.contains(8)) {
      //col3
      return true;
    } else if (coordinates.contains(0) &&
        coordinates.contains(4) &&
        coordinates.contains(8)) {
      //cross1
      return true;
    } else if (coordinates.contains(2) &&
        coordinates.contains(4) &&
        coordinates.contains(6)) {
      //cross2
      return true;
    }
    return false;
  }
}
