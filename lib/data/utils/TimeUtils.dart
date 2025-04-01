class TimeUtils{

  bool seeIfBookWasRecentlyAdded(int timestamp){
    int oneWeekInMilliseconds = 7 * 24 * 60 * 60 * 1000; //7 dias em millisegundos

    int now = DateTime.now().millisecondsSinceEpoch;


    return now - timestamp < oneWeekInMilliseconds;
  }

}