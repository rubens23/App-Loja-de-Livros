import '../utils/TimeUtils.dart';
import 'Book.dart';

class BooksFilters{
  final List<Book> books;
  final TimeUtils timeUtils;

  BooksFilters({required this.books, required this.timeUtils});

  List<Book> getBooksAddedInTheLastWeek(){
    return books.where((book) => timeUtils.seeIfBookWasRecentlyAdded(book.timestampBookWasAdded)).toList();
  }

  List<Book> getMyBooks(){
    return books.where((book) => book.myBook).toList();
  }

  List<Book> getWishlistBooks(){
    return books.where((book) => book.isFromWishlist).toList();
  }



}