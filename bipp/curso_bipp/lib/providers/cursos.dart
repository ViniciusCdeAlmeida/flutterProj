import 'package:curso_bipp/models/curso.dart';
import 'package:flutter/material.dart';

class Cursos with ChangeNotifier {
  List<Curso> _cursos = [
    Curso(
      id: 'p1',
      titulo: '1Red Shirt',
      descricao:
          '3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!3A red shirt - it is pretty red!',
      imgUrl: [
        'https://cdn.pixabay.com/photo/2013/11/28/10/02/photo-camera-219958_1280.jpg',
        'https://cdn.pixabay.com/photo/2016/12/23/12/40/night-1927265_1280.jpg',
        'https://cdn.pixabay.com/photo/2020/08/08/20/41/seagulls-5473897_1280.jpg',
        'https://cdn.pixabay.com/photo/2013/11/28/10/02/photo-camera-219958_1280.jpg',
        'https://cdn.pixabay.com/photo/2016/12/23/12/40/night-1927265_1280.jpg',
        'https://cdn.pixabay.com/photo/2020/08/08/20/41/seagulls-5473897_1280.jpg'
      ],
      imagemPrincipal:
          'https://cdn.pixabay.com/photo/2013/11/28/10/02/photo-camera-219958_1280.jpg',
    ),
    Curso(
      id: 'p2',
      titulo: '2Red Shirt',
      descricao: '3A red shirt - it is pretty red!',
      imgUrl: [
        'https://cdn.pixabay.com/photo/2013/11/28/10/02/photo-camera-219958_1280.jpg',
        'https://cdn.pixabay.com/photo/2016/12/23/12/40/night-1927265_1280.jpg',
        'https://cdn.pixabay.com/photo/2020/08/08/20/41/seagulls-5473897_1280.jpg'
      ],
      imagemPrincipal:
          'https://cdn.pixabay.com/photo/2016/12/23/12/40/night-1927265_1280.jpg',
    ),
    Curso(
      id: 'p3',
      titulo: '3Red Shirt',
      descricao: '3A red shirt - it is pretty red!',
      imgUrl: [
        'https://cdn.pixabay.com/photo/2013/11/28/10/02/photo-camera-219958_1280.jpg',
        'https://cdn.pixabay.com/photo/2016/12/23/12/40/night-1927265_1280.jpg',
        'https://cdn.pixabay.com/photo/2020/08/08/20/41/seagulls-5473897_1280.jpg'
      ],
      imagemPrincipal:
          'https://cdn.pixabay.com/photo/2020/08/08/20/41/seagulls-5473897_1280.jpg',
    ),
    Curso(
      id: 'p4',
      titulo: '4Red Shirt',
      descricao: '4A red shirt - it is pretty red!',
      imgUrl: [
        'https://cdn.pixabay.com/photo/2013/11/28/10/02/photo-camera-219958_1280.jpg',
        'https://cdn.pixabay.com/photo/2016/12/23/12/40/night-1927265_1280.jpg',
        'https://cdn.pixabay.com/photo/2020/08/08/20/41/seagulls-5473897_1280.jpg'
      ],
      imagemPrincipal:
          'https://cdn.pixabay.com/photo/2015/02/19/00/38/peru-641632_1280.jpg',
    ),
  ];

  List<Curso> get getCursos {
    return [..._cursos];
  }

  Curso cursoPorId(String id) {
    return _cursos.firstWhere((curso) => curso.id == id);
  }

  void adicionarCurso(Curso product) {
    _cursos.add(product);

    notifyListeners();
  }

  void atualizarCurso(String id, Curso novoCurso) {
    final crusoIdx = _cursos.indexWhere((prod) => prod.id == id);
    if (crusoIdx >= 0) {
      _cursos[crusoIdx] = novoCurso;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void removerCurso(String id) {
    _cursos.removeWhere((curso) => curso.id == id);
    notifyListeners();
  }
}
