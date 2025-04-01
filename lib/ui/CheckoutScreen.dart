import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_book_app/data/api/ApiService.dart';
import 'package:wordpress_book_app/data/book/BooksRepository.dart';
import 'package:wordpress_book_app/data/cart/Cart.dart';
import 'package:wordpress_book_app/data/cart/CartItem.dart';
import 'package:wordpress_book_app/data/cart/CartRepository.dart';
import 'package:wordpress_book_app/ui/AddressScreen.dart';
import 'package:wordpress_book_app/ui/CheckoutScreen2.dart';

import '../data/user/Address.dart';
import 'ShoppingCartItem.dart';
import 'colors.dart';


class CheckoutScreen extends StatefulWidget{
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();

}

class _CheckoutScreenState extends State<CheckoutScreen>{
  CartRepository _cartRepository = CartRepository();
  BooksRepository _booksRepository = BooksRepository();
  List<CartItem> cartItems = [];
  Cart? cart;
  List<String> _unavailableBooks = [];
  List<String>? bookIds = [];
  bool theresBooksUnavailable = false;


  double total = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor,
      title: Center(
        child: Text("Finalização de Compra",style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            )),
      )),
      body: Padding(padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //endereço:
          Row(
            children: [
              Icon(
                Icons.place_outlined,
                color: Colors.black,
                size: 30,
              ),
              SizedBox(width: 10,),
              Text("Endereço de Entrega", style: TextStyle(color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 24),)
            ],
          ),


          Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Alinha os textos à esquerda
                      children: [
                        Text(
                          "Endereço:",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8), // Espaço entre os textos
                        Text(
                          "Rua dos limoeiros, 422, Santa Mena, Guarulhos, 0809675",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                          softWrap: true, // Permite quebra de linha
                        ),
                      ],
                    ),
                  ),
                  // Ícone de edição sem ocupar espaço extra
                  IconButton(
                    onPressed: _editarEndereco,
                    icon: Icon(Icons.edit, color: Colors.black, size: 30),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20,),


          //quantidade itens
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "${cartItems.length} ${cartItems.length == 1 ? 'item' : 'itens'}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),

            ),
          ),
          SizedBox(height: 10,),
          //lista de itens
          Expanded(
              child: cartItems.isNotEmpty ? Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index){
                      print("cartItem aqui no checkoutscreen ${cartItems[index].productId}");
                      print("unavailable books ${_unavailableBooks}");

                      bool isUnavailable = _unavailableBooks.contains(cartItems[index].productId);
                      theresBooksUnavailable = isUnavailable;
                      print("isUnavailable aqui no checkoutscreen $isUnavailable");
                      return ShoppingCartItem(
                          livro: cartItems[index].book,
                          item: cartItems[index],
                        onRemove: () => _removeItem(index),
                        unavailable: isUnavailable
               );
                    }),
              ): Center(
                child: Text("O carrinho está vazio",
                style: TextStyle(fontSize: 20, fontFamily: 'Roboto',
                fontWeight: FontWeight.bold),),
              )),
        Row(
          children: [
            Text(
              'Total: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal, // Total em negrito
              ),),
            Text(
              'R\$${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, // Total em negrito
              ),)
          ],
        ),
          SizedBox(height: 20,),

          // Botão de pagamento
          Center(
            child: ElevatedButton(
              onPressed: _goToPayment,
              child: Text('Ir para pagamento',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal
                ),),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  )
              ),
            ),
          ),


        ],

      ),),
    );

  }


  void _goToPayment() async{
    if(cart != null){
      if(cart!.items.isNotEmpty){


        if(!theresBooksUnavailable){
          //address ainda vai ser mockado por enquanto
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreen2(cart: cart!, address: Address(id: "", userId: cart!.id, street: "rua das palmeiras", city: "Rio de Janeiro", state: "Rio de Janeiro", postalCode: "0809876", country: "Brasil"),),
              )
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Cheque o carrinho e retire itens que não estão disponíveis!'),));

        }


      }

    }


  }

  void _editarEndereco() {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       //ou eu passo o address aqui ou passo só o id e busco
    //       //la na outra tela
    //       // builder: (context) => AddressScreen(Address(
    //       //
    //       // )),
    //     )
    // );
  }

  Future<void> _loadCart() async {
    //qual metodo sera terminado primeiro?
    try{
      //esse?
      Cart cart = await _cartRepository.fetchCartWithBooks(context);
      setState(() {
        print("livros adquiridos do carrinho ${cart.items}");
        this.cart = cart;
        cartItems = cart.items;
        total = cart.totalAmount;
        bookIds = _createBookIdsList(cartItems);


      });


      //ou esse?
      List<String>? unavailableBooks = await _booksRepository.getUnavailableBooksList(bookIds, context);


      setState(() {
        _unavailableBooks = unavailableBooks ?? []; // Atualiza _unavailableBooks e garante que não seja null
      });
    }catch(e){
      print("Erro ao carregar o carrinho: $e");


    }


  }


  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  List<String>? _createBookIdsList(List<CartItem> items) {
    List<String>? bookIds = items.map((item)=> item.productId
    ).toList();

    for(var a in cartItems){
      print("cartItems aqui no createBookIds ${a.productId}");

    }

    return bookIds;
  }
}


