import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/providers/product.dart';
import 'package:shop_provider/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _desFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product('999999', '', '', 0.0, '', false);

  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _desFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final prodId = ModalRoute.of(context)!.settings.arguments as String;

      if (prodId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(prodId);

        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };

        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    if (_editedProduct.id != '999999') {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      _editedProduct.id,
                      value!,
                      _editedProduct.description,
                      _editedProduct.price,
                      _editedProduct.imageUrl,
                      _editedProduct.isFavorite);
                },
                initialValue: _initValues['title'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_desFocusNode);
                },
                initialValue: _initValues['price'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price.';
                  }

                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }

                  if (double.tryParse(value)! <= 0) {
                    return 'Please enter a number greater than zero.';
                  }

                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      _editedProduct.id,
                      _editedProduct.title,
                      _editedProduct.description,
                      double.parse(value!),
                      _editedProduct.imageUrl,
                      _editedProduct.isFavorite);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _desFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }

                  if (value!.length < 10) {
                    return 'Should be at least 10 characters';
                  }
                  return null;
                },
                initialValue: _initValues['description'],
                onSaved: (value) {
                  _editedProduct = Product(
                      _editedProduct.id,
                      _editedProduct.title,
                      value!,
                      _editedProduct.price,
                      _editedProduct.imageUrl,
                      _editedProduct.isFavorite);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an image URL.';
                        }

                        if (!value.startsWith('http') ||
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }

                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpeg') &&
                            !value.endsWith('.jpg')) {
                          return 'Please enter a valid image URL.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            _editedProduct.id,
                            _editedProduct.title,
                            _editedProduct.description,
                            _editedProduct.price,
                            value!,
                            _editedProduct.isFavorite);
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
