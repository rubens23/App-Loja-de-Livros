import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_book_app/data/cart/CartItem.dart';
import 'package:wordpress_book_app/data/cart/CartRepository.dart';

import '../data/api/ApiService.dart';
import '../data/book/Book.dart';

class ShoppingCartItem extends StatefulWidget{
  final Book livro;
  final CartItem item;
  final cartRepository = CartRepository();
  final VoidCallback onRemove;
  final bool unavailable;

  ShoppingCartItem({required this.livro, required this.item, required this.onRemove, required this.unavailable});

  @override
  _ShoppingCartItemState createState() => _ShoppingCartItemState();


}

class _ShoppingCartItemState extends State<ShoppingCartItem>{
  late bool isFavorito;
  //quantidade mock para os itens
  //depois esse valor vai vir do backend
  int quantidade = 1;

  @override
  void initState() {
    super.initState();
    //por enquanto o valor é fixo mesmo. Ainda vou configurar isso
    isFavorito = false;
  }

  void _toggleFavorito(){
    setState(() {
      isFavorito = !isFavorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              children: [
                //capa do livro
                Image.network(
                  widget.livro.capa_livro,
                  width: 150,
                  height: 190,
                  fit: BoxFit.contain,
                  color: widget.unavailable ? Colors.black.withOpacity(0.5) : null,
                  colorBlendMode: widget.unavailable ? BlendMode.darken : null,

                ),
                //Controle de quantidade no carrinho
                if (!widget.unavailable)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: _diminuirQuantidade,
                      iconSize: 30,
                    ),

                    Text(
                      '${widget.item.quantity}', // Exibe a quantidade
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _aumentarQuantidade,
                      iconSize: 30,
                    ),
                  ],
                ),
              ],
            ),
            //capa do livro

            //nome e preço do Livro
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  children: [
                    Text(
                      widget.unavailable ? "Indisponível" : widget.livro.nome_livro,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: widget.unavailable ? Colors.red[600] : Colors.black,

                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    if (!widget.unavailable)
                      Text(
                      "R\$ ${widget.livro.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(height: 40,),



                    //icone de favorito

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [IconButton(
                          icon: Icon(
                            isFavorito ? Icons.favorite : Icons.favorite_border,
                            color: isFavorito ? Colors.red : Colors.grey,
                          ),
                          onPressed: _toggleFavorito,
                          iconSize: 40,
                        ),


                          //icone de carrinho
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.grey,
                            ),
                            onPressed: (){
                              _confirmarRemocaoDoCarrinho(context, widget.livro.id);
                            },
                            iconSize: 40,
                          )
                        ],
                      ),
                    )


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  }


  Future<void> _confirmarRemocaoDoCarrinho(BuildContext context, String id) async {
    bool? confirmar = await showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Confirmar remoção", style: TextStyle(fontFamily: 'Rotoboto', fontSize: 18, fontWeight: FontWeight.bold),),
          content: Text("Tem certeza que deseja remover este livro do carrinho?", style: TextStyle(fontFamily: 'Rotoboto', fontSize: 18, fontWeight: FontWeight.normal),),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop(false); //cancela a remoção

        },
                child: Text("Cancelar", style: TextStyle(fontFamily: 'Roboto'),)),
            TextButton(onPressed: (){
              Navigator.of(context).pop(true);
            },
                child: Text("Remover", style: TextStyle(fontFamily: 'Roboto')))
          ],
        );
      }
    );

    if(confirmar == true){
      _removerDoCarrinho(context, id);
    }

  }

  void _removerDoCarrinho(BuildContext context, String id) async{
    bool removeuLivro = await widget.cartRepository.removeBookFromCart(context, id);
    if(removeuLivro){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Livro removido do carrinho.'),));

      //remover o item da tela
      widget.onRemove();


    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Não foi possível retirar o livro do carrinho.'),));
    }

  }

  void _aumentarQuantidade() {
    setState(() {
      quantidade++;
    });
  }

  void _diminuirQuantidade() {
    setState(() {
      if (quantidade > 1) {
        quantidade--;
      }
    });
  }
}