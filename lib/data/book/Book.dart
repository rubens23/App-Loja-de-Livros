import '../utils/jsonUtils.dart';

class Book{
  final String id;
  final String nome_livro;
  final String autor_livro;
  final String genero;
  final int rating;
  final bool isAvailable;
  final String capa_livro;
  final String sinopse;
  final bool isFromWishlist;
  final bool myBook;
  final int timestampBookWasAdded;
  final double price;
  final int stock;


  Book({
    required this.id,
    required this.nome_livro,
    required this.autor_livro,
    required this.genero,
    required this.rating,
    required this.isAvailable,
    required this.capa_livro,
    required this.sinopse,
    required this.isFromWishlist,
    required this.myBook,
    required this.timestampBookWasAdded,
    required this.price,
    required this.stock
});

  factory Book.fromJson(Map<String, dynamic> json){
    String capaLivro = json['bookCover'] ?? '';

    // Log o JSON completo para conferir a estrutura
    print("JSON recebido: $json");

    // Log para cada campo, verificando se há null ou tipos inesperados
    print("Preço: ${json['price']}");
    double price = (json['price'] as num?)?.toDouble() ?? 0.0;

    if(capaLivro.contains('localhost')){
      capaLivro = capaLivro.replaceFirst('localhost', '10.0.2.2');
    }

    return Book(
      id: safeParse<String>(json['id'], 'id', 'Book'),
      nome_livro: safeParse<String>(json['name'], 'name', 'Book'),
      autor_livro: safeParse<String>(json['author'], 'author', 'Book'),
      genero: safeParse<String>(json['category'], 'category', 'Book'),
      rating: 1, // ajustar a lógica do rating
      isAvailable: safeParse<int>(json['stock'], 'stock', 'Book') > 0,
      capa_livro: capaLivro,
      sinopse: safeParse<String>(json['description'], 'description', 'Book'),
      isFromWishlist: false,
      myBook: false,
      timestampBookWasAdded: safeParse<int>(json['createdAt'], 'createdAt', 'Book'),
      price: safeParse<double>(json['price'], 'price', 'Book'),
      stock: safeParse<int>(json['stock'], 'stock', 'Book')
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nome_livro,
      'author': autor_livro,
      'category': genero,
      'rating': rating,
      'isAvailable': isAvailable,
      'bookCover': capa_livro,
      'description': sinopse,
      'isFromWishlist': isFromWishlist,
      'myBook': myBook,
      'createdAt': timestampBookWasAdded,
      'price': price,
      'stock': stock,
    };
  }
}