import 'package:check_bird/screens/groups/models/groups_controller.dart';
import 'package:check_bird/screens/groups/widgets/create_group/create_group_screen.dart';
import 'package:check_bird/screens/groups/widgets/group_item.dart';
import 'package:check_bird/screens/groups/widgets/search_group/search_group_screen.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:check_bird/widgets/focus/focus_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  static const routeName = '/groups-screen';

  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.cyanAccent.withOpacity(0.1),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Group"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateGroupScreen()));
              },
              icon: const Icon(Icons.group_add)),
          const FocusButton(),
        ],
      ),
      body: Center(
        child: Authentication.user == null
            ? const Text("You need to login to use this feature")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchGroupScreen()));
                      },
                      title:  TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          icon: Icon(Icons.search, color: Theme.of(context).primaryColor,),
                          hintText: "Search for more groups...",
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: StreamBuilder(
                      stream: GroupsController().usersGroupsStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final data = snapshot.data!.docs;
                        if (data.isEmpty) {
                          return const Center(
                            child: Text(
                                "Join some groups first! Or create one..."),
                          );
                        }
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return GroupItem(
                              groupId: data[index].id,
                              size: size,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
