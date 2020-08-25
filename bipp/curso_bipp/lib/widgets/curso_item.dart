import 'dart:ui';

import 'package:curso_bipp/models/curso.dart';
import 'package:curso_bipp/screens/curso_detalhe_screen.dart';
import 'package:flutter/material.dart';

class CursoItem extends StatefulWidget {
  Curso curso;

  CursoItem({@required this.curso});

  @override
  _CursoItemState createState() => _CursoItemState();
}

class _CursoItemState extends State<CursoItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                  ),
                  child: Text(
                    widget.curso.titulo,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(
                  const Radius.circular(15),
                ),
                child: Image.network(
                  widget.curso.imagemPrincipal,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          CursoDetalheScreen.routeName,
          arguments: widget.curso.id,
        );
      },
    );
  }
}
