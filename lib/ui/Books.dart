import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_book_app/data/book/BooksRepository.dart';
import 'package:wordpress_book_app/data/wishlist/WishlistRepository.dart';

import '../data/book/Book.dart';
import '../data/book/BooksFilters.dart';
import '../data/book/Genero.dart';
import '../data/utils/MathUtils.dart';
import '../data/utils/TimeUtils.dart';
import '../main.dart';
import 'BookDetailsScreen.dart';
import 'CategoryWidget.dart';

class Books extends StatefulWidget{

  final List<Book> books;
  final List<Genero> generos;

  Books({required this.books, required this.generos});

  @override
  State<StatefulWidget> createState() => BooksState(books: books, generos: generos);



}

class BooksState extends State<Books> {
  final List<Book> books;
  final List<Genero> generos;
  final wishlistRepository = WishlistRepository();
  final bookRepository = BooksRepository();

  var _selectedIndexRecentlyAdded = 0;
  var _selectedIndexMyBooks = 0;
  var _selectedIndexWishlist = 0;
  MathUtils mathUtils = MathUtils();
  TimeUtils timeUtils = TimeUtils();

  late BooksFilters booksFilters;
  late List<Book> booksRecentlyAdded;
  late List<Book> myBooks;
  List<Book> booksFromWishList = [];
  late List<Book> allBooks;

  int indicatorPointOfPassage1 = 0;
  int indicatorPointOfPassage2 = 0;
  int indicatorPointOfPassage3 = 0;



  BooksState({required this.books, required this.generos});


  @override
  void initState() {
    super.initState();

    booksFilters = BooksFilters(timeUtils: timeUtils, books: books);


    booksRecentlyAdded = booksFilters.getBooksAddedInTheLastWeek();

    myBooks = booksFilters.getMyBooks();
    _fetchWishlist(context);
    allBooks = books;

  }
  @override
  Widget build(BuildContext context) {




    indicatorPointOfPassage1 = 10;
    indicatorPointOfPassage2 =  20;
    indicatorPointOfPassage3 = 30;



    Widget content =

    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [



        Column(
          children: [

            Container(
              color: const Color(0xFF5ABD8C),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recently Added', style: TextStyle(color: const Color(
                            0xFFFFFFFF), fontFamily: 'Roboto', fontSize: 20),),

                      ],
                    ),
                  ),

                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        height: 300,
                        decoration: const BoxDecoration(
                          //color: Color(0xFFFF3D00)
                        ),
                        child:
                        PageView.builder(
                          padEnds: true,
                          onPageChanged: (index){
                            setState((){
                              _selectedIndexRecentlyAdded = index;

                              indicatorPointOfPassage1 = 10;
                              indicatorPointOfPassage2 =  20;
                              indicatorPointOfPassage3 = 30;
                            });
                          },
                          controller: PageController(viewportFraction: 0.4),
                          itemCount: booksRecentlyAdded.length,
                          itemBuilder: (context, index){
                            var _scale = _selectedIndexRecentlyAdded == index ? 1.0 : 0.8;
                            return  GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookDetailsScreen(book: booksRecentlyAdded[index]),
                                    )
                                );
                              },
                              child: TweenAnimationBuilder(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 16.0),
                                      height: 200,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        image: DecorationImage(
                                          image: NetworkImage('${booksRecentlyAdded[index].capa_livro}'),
                                          fit: BoxFit.fill,

                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.25),
                                              spreadRadius: 2,
                                              blurRadius: 8,
                                              offset: Offset(0, 4)
                                          )
                                        ],
                                      ),




                                    ),
                                    const SizedBox(height: 16.0),
                                    Column(
                                        children: [
                                          Text(booksRecentlyAdded[index].nome_livro, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,  maxLines: 2,overflow: TextOverflow.ellipsis,),
                                          Text(booksRecentlyAdded[index].autor_livro, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18), textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),



                                        ]
                                    )






                                  ],
                                ),
                                duration: const Duration(milliseconds: 350),
                                tween: Tween(begin: _scale, end: _scale),
                                curve: Curves.ease,
                                builder: (context, value, child){
                                  return Transform.scale(scale: value, child: child, );
                                },

                              ),
                            );
                          },),

                      ),

                    ],
                  ),
                ],
              ),
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('My books', style: TextStyle(color: const Color(0xFF5ABD8C), fontFamily: 'Roboto', fontSize: 20),),

                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: 300,
                  decoration: const BoxDecoration(
                    //color: Color(0xFFFF3D00)
                  ),
                  child:
                  PageView.builder(
                    padEnds: false,
                    pageSnapping: true,
                    onPageChanged: (index){
                      setState((){
                        print('to aqui dentro do callback, index: $index');
                        _selectedIndexMyBooks = index;

                        indicatorPointOfPassage1 = 10;
                        indicatorPointOfPassage2 =  20;
                        indicatorPointOfPassage3 = 30;
                      });
                    },
                    controller: PageController(viewportFraction: 0.4),
                    itemCount: myBooks.length,
                    itemBuilder: (context, index){
                      return
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetailsScreen(book: myBooks[index]),
                                )
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 16.0 : 0.0),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 16.0),
                                  height: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                      image: NetworkImage('${myBooks[index].capa_livro}'),
                                      fit: BoxFit.fill,

                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                          offset: Offset(0, 4)
                                      )
                                    ],
                                  ),



                                ),
                                const SizedBox(height: 16.0),
                                Column(
                                    children: [
                                      Text(myBooks[index].nome_livro, style: TextStyle(color: Color(0xFF707070),
                                          fontSize: 18, fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                                          maxLines: 2,overflow: TextOverflow.ellipsis),
                                      Text(myBooks[index].autor_livro, style: TextStyle(color: Color(0xFF707070),
                                          fontSize: 16),textAlign: TextAlign.center, maxLines: 2,overflow: TextOverflow.ellipsis),



                                    ]
                                )






                              ],
                            ),
                          ),
                        );



                    },),

                ),

              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Wishlist', style: TextStyle(color: const Color(0xFF5ABD8C), fontFamily: 'Roboto', fontSize: 20),),

                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: 300,
                  decoration: const BoxDecoration(
                    //color: Color(0xFFFF3D00)
                  ),
                  child:
                  PageView.builder(
                    padEnds: false,
                    pageSnapping: true,
                    onPageChanged: (index){
                      setState((){
                        print('to aqui dentro do callback, index: $index');
                        _selectedIndexWishlist = index;

                        indicatorPointOfPassage1 = 10;
                        indicatorPointOfPassage2 =  20;
                        indicatorPointOfPassage3 = 30;
                      });
                    },
                    controller: PageController(viewportFraction: 0.4),
                    itemCount: booksFromWishList.length,
                    itemBuilder: (context, index){
                      return
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetailsScreen(book: booksFromWishList[index]),
                                )
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 16.0 : 0.0),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 16.0),
                                  height: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                      image: NetworkImage('${booksFromWishList[index].capa_livro}'),
                                      fit: BoxFit.fill,

                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                          offset: Offset(0, 4)
                                      )
                                    ],
                                  ),



                                ),
                                const SizedBox(height: 16.0),
                                Column(
                                    children: [
                                      Text(booksFromWishList[index].nome_livro, style: TextStyle(color: Color(0xFF707070), fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center, maxLines: 2,overflow: TextOverflow.ellipsis),
                                      Text(booksFromWishList[index].autor_livro, style: TextStyle(color: Color(0xFF707070), fontSize: 18),textAlign: TextAlign.center, maxLines: 1,overflow: TextOverflow.ellipsis),



                                    ]
                                )






                              ],
                            ),
                          ),
                        );



                    },),

                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('All books', style: TextStyle(color: const Color(0xFF5ABD8C), fontFamily: 'Roboto', fontSize: 20),),

                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: 300,
                  decoration: const BoxDecoration(
                    //color: Color(0xFFFF3D00)
                  ),
                  child:
                  PageView.builder(
                    padEnds: false,
                    pageSnapping: true,
                    onPageChanged: (index){
                      setState((){
                        _selectedIndexWishlist = index;

                        indicatorPointOfPassage1 = 10;
                        indicatorPointOfPassage2 =  20;
                        indicatorPointOfPassage3 = 30;
                      });
                    },
                    controller: PageController(viewportFraction: 0.4),
                    itemCount: allBooks.length,
                    itemBuilder: (context, index){
                      return
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetailsScreen(book: allBooks[index]),
                                )
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 16.0 : 0.0),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 16.0),
                                  height: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                      image: NetworkImage('${allBooks[index].capa_livro}'),
                                      fit: BoxFit.fill,

                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                          offset: Offset(0, 4)
                                      )
                                    ],
                                  ),



                                ),
                                const SizedBox(height: 16.0),
                                Column(
                                    children: [
                                      Text(allBooks[index].nome_livro, style: TextStyle(color: Color(0xFF707070), fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center, maxLines: 2,overflow: TextOverflow.ellipsis),
                                      Text(allBooks[index].autor_livro, style: TextStyle(color: Color(0xFF707070), fontSize: 18),textAlign: TextAlign.center, maxLines: 1,overflow: TextOverflow.ellipsis),



                                    ]
                                )






                              ],
                            ),
                          ),
                        );



                    },),

                ),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Categories', style: TextStyle(color: const Color(0xFF5ABD8C), fontFamily: 'Roboto', fontSize: 20)),
                      SizedBox(height: 10,),

                      GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height / 1.4)
                          ),
                          itemCount: generos.length,
                          itemBuilder: (context, index){
                            return CategoryWidget(imgGenero: generos[index].imgGenero,
                                nomeGenero: generos[index].nomeGenero);
                          }
                      ),



                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
                //       child: GridView.builder(
                //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisCount: 2,
                //           crossAxisSpacing: 8,
                //           mainAxisSpacing: 8,
                //           childAspectRatio: 1
                //         ),
                //         itemCount: generos.length,
                //         itemBuilder: (context, index){
                //           return CategoryWidget(imgGenero: generos[index].imgGenero,
                //               nomeGenero: generos[index].nomeGenero);
                //         }
                //       )
                //
                //
                //
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: Row(
                    children: [
                      Spacer(),

                      Spacer(),
                      Spacer(),

                    ],
                  ),
                ),


              ],
            ),

          ],
        )

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Indicator(
        //       isActive: true,
        //       selectedIndex: _selectedIndex,
        //       indicatorPointOfPassage1: indicatorPointOfPassage1,
        //       indicatorPointOfPassage2: indicatorPointOfPassage2,
        //       indicatorPointOfPassage3: indicatorPointOfPassage3,
        //     )
        //
        //   ],
        // )
      ],
    );


    return Padding(padding: const EdgeInsets.only(top: 0.0, left: 0.0),
      child: content,);
  }

  Future<void> _fetchWishlist(BuildContext context) async{
    try {
      // Recupera a lista de IDs de livros da wishlist
      List<String>? wishList = await wishlistRepository.fetchWishlistByUser(context);

      if (wishList != null) {
        List<Book?> books = await Future.wait(
          wishList.map((bookId) async {
            return await bookRepository.fetchBookById(context, bookId);
          }).toList(),
        );

        // Filtra os livros nulos e atualiza a lista de livros
        setState(() {
          booksFromWishList = books.whereType<Book>().toList(); // Onde 'whereType<Book>()' filtra os livros não-nulos
        });

      }
    } catch (error) {
      print('Erro ao carregar wishlist ou livros: $error');

    }


  }
}