class MathUtils{
  int getMoviesIndicatorPointOfPassage(String unknown, int totalOfBooks){
    switch(unknown){
      case "x":
        return totalOfBooks ~/ 3;
      case "y":
        int x = totalOfBooks ~/ 3;
        return (totalOfBooks + x) ~/2;
      case "z":
        return totalOfBooks - 2;


    }
    return 0;
  }
}