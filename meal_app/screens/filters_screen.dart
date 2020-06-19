import 'package:flutter/material.dart';

import 'main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String,bool> currentFilters;

  FiltersScreen(this.currentFilters,this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  initState(){
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget _builderSwitch(
    String title,
    String subtitle,
    bool state,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: state,
      onChanged: updateValue,
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FILTERS'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegetarian,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust MEAL',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _builderSwitch(
                  'Gluten-free',
                  'Only Gluten-free',
                  _glutenFree,
                  (newState) {
                    setState(
                      () {
                        _glutenFree = newState;
                      },
                    );
                  },
                ),
                _builderSwitch(
                  'Vegetarian',
                  'Only Vegetarian',
                  _vegetarian,
                  (newState) {
                    setState(
                      () {
                        _vegetarian = newState;
                      },
                    );
                  },
                ),
                _builderSwitch(
                  'Vegan',
                  'Only Vegan',
                  _vegan,
                  (newState) {
                    setState(
                      () {
                        _vegan = newState;
                      },
                    );
                  },
                ),
                _builderSwitch(
                  'Lactosen-free',
                  'Only Lactosen-free',
                  _lactoseFree,
                  (newState) {
                    setState(
                      () {
                        _lactoseFree = newState;
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
