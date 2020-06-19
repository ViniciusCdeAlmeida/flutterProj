import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _descFocus = FocusNode();
  final _imgUrlController = TextEditingController();
  final _imgUrlFocus = FocusNode();
  final _form = GlobalKey<FormState>();
  var _edtidedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imgUrl: '',
  );

  var _isInit = true;
  var _isLoading = false;
  var _initValues = {
    'title': '',
    'description': '',
    'imgUrl': '',
    'price': '',
  };

  @override
  void initState() {
    _imgUrlFocus.addListener(_updateImgUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _edtidedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _edtidedProduct.title,
          'description': _edtidedProduct.description,
          'imgUrl': '',
          'price': _edtidedProduct.price.toString(),
        };
        _imgUrlController.text = _edtidedProduct.imgUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImgUrl() {
    if (!_imgUrlFocus.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imgUrlFocus.removeListener(_updateImgUrl);
    _descFocus.dispose();
    _priceFocus.dispose();
    _imgUrlController.dispose();
    _imgUrlFocus.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_edtidedProduct.id != null) {
      await Provider.of<Products>(
        context,
        listen: false,
      ).updateProduct(_edtidedProduct.id, _edtidedProduct);
      setState(() {
        _isLoading = true;
      });
    } else {
      try {
        await Provider.of<Products>(
          context,
          listen: false,
        ).addProduct(_edtidedProduct);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error!!!!'),
            content: Text(error.toString()),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('OK'))
            ],
          ),
        );
      } 
      // finally {
      //   setState(() {
      //     _isLoading = true;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = true;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Provide a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _edtidedProduct = Product(
                          description: _edtidedProduct.description,
                          id: _edtidedProduct.id,
                          isFavorite: _edtidedProduct.isFavorite,
                          imgUrl: _edtidedProduct.imgUrl,
                          price: _edtidedProduct.price,
                          title: value,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Provide a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Provide a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Provide a valid number greater than 0';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descFocus);
                      },
                      onSaved: (value) {
                        _edtidedProduct = Product(
                          description: _edtidedProduct.description,
                          id: _edtidedProduct.id,
                          isFavorite: _edtidedProduct.isFavorite,
                          imgUrl: _edtidedProduct.imgUrl,
                          price: double.parse(value),
                          title: _edtidedProduct.title,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Provide a value';
                        }
                        if (value.length < 10) {
                          return 'Least 10 carac long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _edtidedProduct = Product(
                          description: value,
                          id: _edtidedProduct.id,
                          isFavorite: _edtidedProduct.isFavorite,
                          imgUrl: _edtidedProduct.imgUrl,
                          price: _edtidedProduct.price,
                          title: _edtidedProduct.title,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.blueGrey,
                            ),
                          ),
                          child: _imgUrlController.text.isEmpty
                              ? Text('Enter URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imgUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Img Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imgUrlController,
                            focusNode: _imgUrlFocus,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Provide a value';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _edtidedProduct = Product(
                                description: _edtidedProduct.description,
                                id: _edtidedProduct.id,
                                isFavorite: _edtidedProduct.isFavorite,
                                imgUrl: value,
                                price: _edtidedProduct.price,
                                title: _edtidedProduct.title,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
