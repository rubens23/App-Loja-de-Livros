T safeParse<T>(dynamic value, String fieldName, String className) {
  try {
    if (value == null) {
      // Trata valores nulos de acordo com o tipo T
      if (T == int) return null as T;
      if (T == double) return null as T;
      if (T == String) return null as T;
      if (T == bool) return null as T;
      throw Exception("Valor nulo não permitido para o tipo '$T'");
    }

    if (T == String) return value.toString() as T;
    if (T == int) return int.parse(value.toString()) as T;
    if (T == double) return double.parse(value.toString()) as T;
    if (T == bool) return (value is bool) ? value as T : (value.toString().toLowerCase() == 'true') as T;

    return value as T;
  } catch (e) {
    print("Erro ao parsear o campo '$fieldName': $e | Valor recebido: $value | classe: $className" );
    throw Exception("Erro ao parsear o campo '$fieldName'");
  }
}