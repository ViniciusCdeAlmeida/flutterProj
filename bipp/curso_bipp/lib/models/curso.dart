import 'package:flutter/material.dart';

class Curso with ChangeNotifier {
  final String id;
  final String titulo;
  final String descricao;
  final List<String> imgUrl;
  final String imagemPrincipal;
  bool isFavorite;

  Curso({
    @required this.id,
    @required this.descricao,
    @required this.titulo,
    @required this.imgUrl,
    @required this.imagemPrincipal,
  });
}
