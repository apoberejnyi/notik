import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ListSearch<T extends StatefulWidget> implements State<T> {
  TextEditingController _searchQueryController = TextEditingController();
  var isSearching = false;
  var searchQuery = "";

  List<Widget> buildSearchActions() {
    if (isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: _clearSearch,
        ),
      ];
    }

    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  Widget buildSearchField({required String searchHint}) {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      cursorColor: Theme.of(context).primaryTextTheme.bodyText1!.color,
      decoration: InputDecoration(
        hintText: searchHint,
        border: InputBorder.none,
      ),
      onChanged: _changeSearchQuery,
    );
  }

  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: _stopSearch),
    );

    setState(() {
      isSearching = true;
    });
  }

  void _changeSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void _clearSearch() {
    if (_searchQueryController.text.isEmpty) {
      Navigator.pop(context);
    } else {
      _searchQueryController.clear();
      setState(() {
        searchQuery = "";
      });
    }
  }

  void _stopSearch() {
    setState(() {
      isSearching = false;
      searchQuery = "";
    });
  }
}
