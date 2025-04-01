import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:wordpress_book_app/auth/HttpClientService.dart';
import 'package:wordpress_book_app/data/book/Book.dart';
import 'package:wordpress_book_app/data/order/OrderRequest.dart';
import 'package:wordpress_book_app/data/payment/pix/PixPaymentRequest.dart';
import 'package:wordpress_book_app/data/payment/pix/PixPaymentResponse.dart';

import '../cart/Cart.dart';
import '../order/OrderResponse.dart';
import '../user/User.dart';
import '../book/Genero.dart';
import 'package:http/http.dart' as http;

import 'Result.dart';

class ApiService{
  final HttpClientService _httpClientService = HttpClientService();
  Future<List<Book>> fetchBooks(BuildContext context) async {

    try{
      //10.0.2.2 é o equivalente ao localhost quando estou rodando
      //o app no emulador do android studio e o backend está no localhost
      final response = await _httpClientService.get(context, '/getBooks');



      if(response.statusCode == 200){
        print('JSON recebido antes de decodificar: ${response.body}');

        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        print('Dados recebidos e decodificados: $data');
        final books = data.map((book) => Book.fromJson(book)).toList();
        print("livros adquiridos: $books");

        return books;
      }else if(response.statusCode == 204){
        return []; //Nenhum livro disponível
      }else{
        print('Erro ao carregar livros: ${response.statusCode}');
        return [];
      }

    }catch(e){
      print('Erro ao buscar livros: $e');
      return [];
    }




  }

  Future<Cart> getCart(BuildContext context) async {
    final token = await _httpClientService.getToken();
    String userId = '';

    // Decodifica o token para pegar o userId
    if (token != null) {
      try {
        final decodedToken = JwtDecoder.decode(token);
        userId = decodedToken['userId'] ?? '';
        print("UserId extraído do token: $userId");
      } catch (e) {
        print("Erro ao decodificar token: $e");
      }
    }

    // Se o userId não for encontrado, retorna erro
    if (userId.isEmpty) {
      print("Erro: userId não encontrado no token!");
      return Future.error("Erro: userId não encontrado no token!");

    }


    final response = await _httpClientService.get(
        context,
        '/getCartWithBooks/$userId',
    );

    if (response.statusCode == 200) {
      // Supondo que o corpo da resposta seja JSON e que Cart seja uma classe que pode ser construída a partir disso
      try {
        final cartJson = json.decode(response.body);
        Cart cart = Cart.fromJson(cartJson);
        return cart;
      } catch (e) {
        print("Erro ao parsear o carrinho: $e status do erro ${response.statusCode} response: ${response.body}");
        return Future.error("Erro ao parsear o carrinho");
      }
    } else {
      print("Erro ao buscar carrinho: ${response.statusCode}");
      return Future.error("Erro ao buscar carrinho");
    }
  }

  Future<User?> getUserById(BuildContext context) async {
    try{
      String? userId = await _getUserId();

      if(userId == null){
        print("erro ApiService getUserById user ID é nulo");
        return null;
      }

      final response = await _httpClientService.get(context,
          '/getUserById/$userId');

      if(response.statusCode == 200){
        print("teste user ${response.body}");

        final Map<String, dynamic> user = jsonDecode(response.body);

        return User.fromJson(user);
      }else{
        print("erro ApiService getUserById. Erro ao pegar user por ID");
        return null;

      }

    }catch(e){
      print("erro ApiService getUserById $e");
      return null;
    }
  }

  Future<Book?> fetchBookById(BuildContext context, String bookId) async {
    try{


      final response = await _httpClientService.get(context,
          '/getBookById/$bookId');

      if(response.statusCode == 200){


        final Map<String, dynamic> book = jsonDecode(utf8.decode(response.bodyBytes));

        return Book.fromJson(book);
      }else{

        print("erro ApiService getBookById. Erro ao pegar livro por ID ${response.statusCode}");
        return null;

      }

    }catch(e){
      print("erro ApiService getBookById $e");
      return null;
    }

  }



  // metodo de adicionar livro ao carrinho
  Future<bool> saveBookInCart(BuildContext context, String bookId, int quantity, double price, int stockQnt) async{
    try{
      String? userId = await _getUserId();

      if(userId == null){
        return false;
      }

      final Map<String, dynamic> cartItem = {
        'productId': bookId,
        'quantity': quantity,
        'price': price,
        'userId': userId,
        'itemType': 'BOOK',
        'stockQnt': stockQnt
      };

      final response = await _httpClientService.put(
        context,
        '/putNewProductInCart/$userId',
        body: jsonEncode(cartItem)
      );

      if (response.statusCode == 200) {
        print("Item adicionado ao carrinho com sucesso!");
        return true;
      } else if (response.statusCode == 400) {
        print("Falha ao adicionar o item ao carrinho: ${response.body}");
        return false;
      } else {
        print("Erro inesperado ao adicionar o item: ${response.statusCode}");
        return false;
      }

    }catch(e){
      return false;

    }
  }

  Future<PixPaymentResponse?> payByPix(PixPaymentRequest request, BuildContext context) async{
    try{
      final response = await _httpClientService.post(
        context,
        '/v1/payments/mercadopago',
        json.encode(request.toJson())
      );

      if(response.statusCode == 200){
        return PixPaymentResponse.fromJson(json.decode(response.body));
      }else{
        print("erro payByPix falha no pagamento ${response.statusCode}");
        return null;

      }

    }catch(e){
      print("erro payByPix ApiService $e");
      return null;

    }
  }

  Future<Result<OrderResponse>>makeNewOrder(OrderRequest orderRequest, BuildContext context) async {
    try{
      final response = await _httpClientService.post(
          context,
          "/makeNewBooksOrder",
          json.encode(orderRequest.toJson()));

      //201 order created
      if(response.statusCode == 201){
        print("resposta de order recebida ${response.body}");
        return Result.success(OrderResponse.fromJson(jsonDecode(response.body)));
      }else{
        print("erro makeNewOrder ${response.statusCode}");
        return Result.failure(response.body);
      }

    }catch(e){
      print("erro makeNewOrder $e");
      return Result.failure("Ocorreu um erro inesperado.");
    }
  }

  Future<bool> removeBookFromCart(BuildContext context, String bookId) async {
    try{
      String? userId = await _getUserId();

      final response = await _httpClientService.delete(
        context,
        '/deleteProductFromCart/$userId/$bookId'
      );

      if(response.statusCode == 200){
        return true;
      }else{
        print("erro removeBookFromCart ApiService status ${response.statusCode}");

        return false;
      }



    }catch(e){
      print("erro removeBookFromCart ApiService $e");
      return false;
    }
  }




  Future<List<Genero>> fetchGeneros() async {

    await Future.delayed(Duration(seconds: 2));

    List<Genero> generos = [
      Genero(id: 1,
          nomeGenero: 'Fantasy',
          imgGenero: 'https://thetolkien.forum/wiki-asset/?pid=216&d=1627722014'),
      Genero(id: 2,
          nomeGenero: 'Fiction',
          imgGenero: 'https://static01.nyt.com/images/2016/07/24/books/review/0724-BKS-OpenBook/0724-BKS-OpenBook-articleLarge-v2.jpg?quality=75&auto=webp&disable=upscale'),
      Genero(id: 3,
          nomeGenero: 'Crime',
          imgGenero: 'https://www.cbc.ca/news2/pointofview/crime_scene.jpg'),
      Genero(id: 4,
          nomeGenero: 'Comedy',
          imgGenero: 'https://www.bang2write.com/wp-content/uploads/2017/02/Comedy1.jpg'),
      Genero(id: 5,
          nomeGenero: 'Horror',
          imgGenero: 'https://i0.wp.com/darklongbox.com/wp-content/uploads/2024/01/sub-genres-of-horror.jpg?fit=960%2C768&ssl=1'),
      Genero(id: 6,
          nomeGenero: 'Romance',
          imgGenero: 'https://thehowler.org/wp-content/uploads/2021/05/Romance-Hate.png'),

    ];

    return generos;


  }

  Future<String?> _getUserId() async{
    final token = await _httpClientService.getToken();

    if(token == null){
      return null;
    }

    try{
      final decodedToken = JwtDecoder.decode(token);
      final String userId = decodedToken['userId'] ?? '';

      if(userId.isEmpty){
        return null;
      }

      return userId;

    }catch(e){
      print("Erro ao decodificar token: $e");
      return null;
    }
  }

  // Adicionar livro à wishlist
  Future<bool> addToWishList(BuildContext context, String bookId) async {
    try {

      String? userId = await _getUserId();

      if(userId == null){
        return false;
      }

      final Map<String, String> wishlistItem = {
        'userId': userId,
        'productId': bookId,
      };

      final response = await _httpClientService.post(
        context,
        '/wishlist/add',
        jsonEncode(wishlistItem),
      );

      if (response.statusCode == 201) {
        print("Livro adicionado à wishlist com sucesso!");
        return true;
      } else if (response.statusCode == 400) {
        print("Falha ao adicionar livro à wishlist: ${response.body}");
        return false;
      } else {
        print("Erro inesperado ao adicionar à wishlist: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Erro ao adicionar à wishlist: $e");
      return false;
    }
  }

  // Remover livro da wishlist
  Future<bool> removeFromWishlist(BuildContext context, String bookId) async {
    try {

      String? userId = await _getUserId();

      if(userId == null){
        return false;
      }

      final response = await _httpClientService.delete(
        context,
        '/wishlist/remove/$userId/$bookId',  // Passando os parâmetros na URL
      );

      if (response.statusCode == 200) {
        print("Livro removido da wishlist com sucesso!");
        return true;
      } else {
        print("Erro ao remover livro da wishlist: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Erro ao remover da wishlist: $e");
      return false;
    }
  }

  Future<List<String>> getWishlistByUser(BuildContext context) async {
    try {

      String? userId = await _getUserId();

      if(userId == null){
        return [];
      }
      final response = await _httpClientService.get(
        context,
        '/wishlist/$userId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        // Mapear diretamente para uma lista de strings
        final wishlist = List<String>.from(data);
        print("Wishlist recebida: $wishlist");
        return wishlist;
      } else if (response.statusCode == 204) {
        return []; // Nenhuma wishlist encontrada
      } else {
        print("Erro ao carregar wishlist: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro ao buscar wishlist: $e");
      return [];
    }
  }

  Future<List<String>>fetchUnavailableBooksList(List<String>? bookIds, BuildContext context) async{
    try{

      if(bookIds == null || bookIds.isEmpty){
        return [];
      }
      final response = await _httpClientService.post(
          context,
          '/books/unavailable',
      jsonEncode({
        'bookIds': bookIds
      }));

      if (response.statusCode == 200) {
        // Converte a resposta em uma lista de strings (livros indisponíveis)
        final List<dynamic> data = jsonDecode(response.body);
        final unavailableBooks = List<String>.from(data);

        print("Livros indisponíveis recebidos: $unavailableBooks");
        return unavailableBooks;
      } else if (response.statusCode == 204) {
        return []; // Nenhum livro indisponível encontrado
      } else {
        print("Erro ao carregar livros indisponíveis: ${response.statusCode}");
        return [];
      }
      

    }catch(e){
      print("Erro ao pegar lista de livros indisponiveis: $e");
      return [];
    }
  }











}

// Modelo de livro
class Livro {
  final String nome;
  final String preco;
  final String imagemUrl;
  final bool favorito;

  Livro({
    required this.nome,
    required this.preco,
    required this.imagemUrl,
    this.favorito = false,
  });
}

// Lista mockada de livros
List<Livro> mockLivros = [
  Livro(
    nome: "Clean Code",
    preco: "99.90",
    imagemUrl: "https://m.media-amazon.com/images/I/41SH-SvWPxL.jpg",
    favorito: true,
  ),
  Livro(
    nome: "The Pragmatic Programmer dddddddddddddddddddddddddd",
    preco: "120.00",
    imagemUrl: "https://http2.mlstatic.com/D_NQ_NP_643410-MLB74292634337_012024-O.webp",
    favorito: false,
  ),
];