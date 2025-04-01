class Genero{
  final int id;
  final String nomeGenero;
  final String imgGenero;


  Genero({
   required this.id,
   required  this.nomeGenero,
    required this.imgGenero
});

  factory Genero.fromJson(Map<String, dynamic> json){
    return Genero(id: json['id'], nomeGenero: json['nomeGenero'], imgGenero: json['nomeGenero']);
  }
}