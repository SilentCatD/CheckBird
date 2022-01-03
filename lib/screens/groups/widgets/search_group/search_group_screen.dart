import 'package:check_bird/screens/groups/models/groups_controller.dart';
import 'package:check_bird/screens/groups/widgets/group_item.dart';
import 'package:flutter/material.dart';

class SearchGroupScreen extends StatefulWidget {
  const SearchGroupScreen({Key? key}) : super(key: key);

  @override
  _SearchGroupScreenState createState() => _SearchGroupScreenState();
}

class _SearchGroupScreenState extends State<SearchGroupScreen> {
  final _textFieldFocus = FocusNode();
  final _textFieldController = TextEditingController();
  String _searchQuery = "";
  final _groupController = GroupsController();
  bool _isSearching = false;
  final List<Group> _searchResults = [];

  void _search() async {
    if (_searchQuery.trim().isEmpty) return;
    setState(() {
      _isSearching = true;
    });
    _searchResults.clear();
    final results = await _groupController.searchGroups(query: _searchQuery);
    _searchResults.addAll(results);
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search a group"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  autofocus: true,
                  focusNode: _textFieldFocus,
                  controller: _textFieldController,
                  onChanged: (value) {
                    _searchQuery = value;
                  },
                  onSubmitted: (value) {
                    _search();
                  },
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: _isSearching
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          CircularProgressIndicator(),
                          Text("Searching..."),
                        ],
                      ),
                    )
                  : _searchResults.isEmpty
                      ? const Center(
                          child: Text("No groups found... try again"),
                        )
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GroupItem(
                              groupId: _searchResults[index].groupId,
                              size: size,
                            );
                          },
                        ),
              flex: 9,
            ),
          ],
        ),
      ),
    );
  }
}
