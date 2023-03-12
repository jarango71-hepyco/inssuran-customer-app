import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../../components/drawer.dart';
import '../../res/i_font_res.dart';
import '../../utils/constants.dart';


class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateCollectionPage();
}

class _StateCollectionPage extends State<CollectionPage> {
  TextEditingController? _searchQuery;
  bool _isSearching = false;
  bool _loaded = false;

  List<String> _items = [];
  List<String> _duplicateItems = [];

  @override
  void initState() {
    super.initState();
    _searchQuery = TextEditingController();
    _items.add("Item 1");
    _items.add("Item 2");
  }

  @override
  void dispose() {
    _searchQuery!.dispose();
    super.dispose();
  }

  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery!.clear();
      updateSearchQuery("");
    });
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQuery,
      cursorColor: Colors.white,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: Consts.S_SEARCH,
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white60),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(_duplicateItems);
    if(newQuery.isNotEmpty) {
      List<String> dummyList = [];
      for (var item in dummySearchList) {
        /*if(
        item.type.toUpperCase().contains(newQuery.toUpperCase()) ||
            item.clinic.toUpperCase().contains(newQuery.toUpperCase()) ||
            item.description.toUpperCase().contains(newQuery.toUpperCase())
        )
        {
          dummyList.add(item);
        }*/
      }
      setState(() {
        _items.clear();
        _items.addAll(dummyList);
      });
      return;
    } else {
      setState(() {
        _items.clear();
        _items.addAll(_duplicateItems);
      });
    }
  }

  Widget _buildTitle(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(Consts.S_PAGE_COLLECTION_TITLE, textAlign: TextAlign.center,
          style: TextStyle(fontFamily: FontRes.GILROYLIGHT,
              fontSize: 20,
              fontWeight: FontWeight.bold
          )
      ),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(FlutterRemix.close_line, color: Colors.white,),
          onPressed: () {
            if (_searchQuery == null || _searchQuery!.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(
          FlutterRemix.search_line,
          semanticLabel: Consts.S_SEARCH,
          color: Colors.white,
        ),
        onPressed: _startSearch,
      ),
      IconButton(
        icon: const Icon(
          FlutterRemix.notification_2_line,
          semanticLabel: Consts.S_SEARCH,
          color: Colors.white,
        ),
        onPressed: _startSearch,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(Consts.C_PRIMARYCOLOR),
          leading: IconButton(
            icon: const Icon(FlutterRemix.menu_line),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),
        ),
        drawer: buildDrawer(context),
        body:  _loaded?
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    //return drawCard(items[index]);
                    return Container();
                  },
                ),
              ),
            ],
          ),
        )
            : Container()
      // : const Center(child: CircularProgressIndicator(backgroundColor: Color(Consts.C_ORANGECOLOR), valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)),
    );
  }
}