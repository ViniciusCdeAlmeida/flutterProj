import 'package:curso_bipp/models/curso.dart';
import 'package:curso_bipp/providers/cursos.dart';
import 'package:curso_bipp/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CursoDetalheScreen extends StatelessWidget {
  static const routeName = '/curso_detalhe';

  @override
  Widget build(BuildContext context) {
    final cursoId = ModalRoute.of(context).settings.arguments as String;
    Curso curso = Provider.of<Cursos>(context).cursoPorId(cursoId);
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(curso.titulo),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    curso.descricao,
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: SizedBox(
                      height: 400,
                      width: 400,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: curso.imgUrl.length,
                        itemBuilder: (_, idx) {
                          return ClipRRect(
                            borderRadius: BorderRadius.all(
                              const Radius.circular(9),
                            ),
                            child: Image.network(
                              curso.imgUrl[idx],
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
