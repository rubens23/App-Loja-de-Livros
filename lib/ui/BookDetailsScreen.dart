import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_book_app/data/cart/CartRepository.dart';
import 'package:wordpress_book_app/ui/CheckoutScreen.dart';

import '../data/book/Book.dart';
import '../data/wishlist/WishlistRepository.dart';

class BookDetailsScreen extends StatefulWidget{
  final Book book;

  const BookDetailsScreen({required this.book});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>{

  final cartRepository = CartRepository();
  final wishlistRepository = WishlistRepository();
  bool isInWishlist = false;

  @override
  void initState() {
    super.initState();
    if(!widget.book.isAvailable){
      _checkIfBookIsInWishlist(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.nome_livro, style: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 23,
        ),),
        backgroundColor: const Color(0xFF5ABD8C),
        iconTheme: IconThemeData(
          color: Colors.white
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0, top: 60.0),
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: NetworkImage('${widget.book.capa_livro}'),
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
                  Text(widget.book.nome_livro, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text(widget.book.autor_livro, style: TextStyle(color: Color(0xFF707070), fontSize: 16),),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Rating: ', style: TextStyle(color: Color(0xFF707070), fontSize: 16),),
                        StarRating(rating: widget.book.rating)

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Genre: ', style: TextStyle(color: Color(0xFF707070), fontSize: 16),),
                      Text(widget.book.genero, style: TextStyle(color: Color(0xFF707070), fontSize: 16),),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("R\$ ${widget.book.price.toStringAsFixed(2)}", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: widget.book.isAvailable ?(){
                      //book is available
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(),
                          )
                      );

                    }: (){
                      //book is not available

                      if(isInWishlist){
                        // Se já está na wishlist, remove
                        _removeBookFromWishlist(context);
                      }else{
                        // Se não está na wishlist, adiciona
                        _saveBookOnWishlist(context);
                      }


                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.book.isAvailable ? const Color(0xFF5ABD8C) : isInWishlist ? Colors.grey : const Color(0xFF5ABD8C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      padding: const EdgeInsets.only(left: 60, right: 60),
                    ),
                    child: Text(widget.book.isAvailable ? 'Comprar' : isInWishlist ? 'Remover da lista de desejos' : 'Salvar na lista de desejos', style: TextStyle(fontFamily: 'Roboto', fontSize: 20),),
                  ),
                  SizedBox(height: 20,),

        widget.book.isAvailable?
        GestureDetector(
                    onTap: (){
                      _adicionarLivroAoCarrinho(context, widget.book.id, widget.book.price);
                    },
                    child:Text(widget.book.isAvailable ? 'Adicionar ao Carrinho': 'Salvar na lista de desejos', style: TextStyle(fontFamily: 'Roboto', fontSize: 20,
                        fontWeight: FontWeight.bold, color: Colors.black, decoration: TextDecoration.underline
                    ))
                  ): SizedBox(),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
                    child: Text(widget.book.sinopse, style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: Color(0xFF707070)
                    ),),
                  )






                ]
            )

          ],
        ),
      ),
    );
  }

  void _adicionarLivroAoCarrinho(BuildContext context, String id, double price) async {
    bool adicionouLivro = await cartRepository.addBookToCart(context, id, 1, price);
    if (adicionouLivro) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Livro adicionado ao carrinho de compras!'),));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Falha ao adicionar livro ao carrinho de compras...'),));
    }

  }

  // Verifica se o livro está na wishlist
  Future<void> _checkIfBookIsInWishlist(BuildContext context) async {
    bool result = await wishlistRepository.isBookInWishlist(context, widget.book.id);
    setState(() {
      isInWishlist = result;
    });
  }

  // Adiciona o livro na wishlist
  Future<void> _saveBookOnWishlist(BuildContext context) async {
    bool result = await wishlistRepository.addBookToWishlist(context, widget.book.id);
    if (result) {
      setState(() {
        isInWishlist = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Livro adicionado à wishlist')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao adicionar livro à wishlist')));
    }
  }

  // Remove o livro da wishlist
  Future<void> _removeBookFromWishlist(BuildContext context) async {
    bool result = await wishlistRepository.removeBookFromWishlist(context, widget.book.id);
    if (result) {
      setState(() {
        isInWishlist = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Livro removido da wishlist')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao remover livro da wishlist')));
    }
  }




}



class StarRating extends StatelessWidget{
  final int rating;

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index){
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: const Color(0xFF5ABD8C),
        );
      }),
    );
  }
}