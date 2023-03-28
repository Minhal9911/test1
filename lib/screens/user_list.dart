import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key, required this.users}) : super(key: key);
  final List<Map<String, String>> users;

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  TextEditingController searchController = TextEditingController();
  final List<String> source = [
    "Facebook",
    "Instagram",
    "Organic",
    "Friend",
    "Google"
  ];
  String selectedSource = "Search by Source";
  List<Map<String, String>> showList = [];

  bool searchBoolean = false;

  @override
  void initState() {
    showList.addAll(widget.users);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: !searchBoolean ? const Text("Users") : searchTextField(),
        centerTitle: true,
        actions: !searchBoolean
            ? [
                IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        searchBoolean = true;
                      });
                    })
              ]
            : [
                IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        searchBoolean = false;
                      });
                    })
              ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
            child: DropdownButton(
              hint: Text(selectedSource),
              alignment: AlignmentDirectional.centerStart,
              borderRadius: BorderRadius.circular(10.0),
              style: const TextStyle(color: Colors.black, fontSize: 15),
              iconEnabledColor: Colors.blue,
              icon: const Icon(Icons.arrow_drop_down),
              items: source.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                selectedSource = newValue!;
                showList.clear();
                showList = widget.users
                    .where((e) => e['source']!
                        .toLowerCase()
                        .contains(newValue.toLowerCase()))
                    .toList();
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: showList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.blue,
                    ),
                    title: Text(
                      showList[index]['name']!,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      showList[index]['email']!,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      showList[index]['source']!,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget searchTextField() {
    return TextField(
      controller: searchController,
      enableSuggestions: true,
      autofocus: false,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.white54),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      keyboardType: TextInputType.name,
      onChanged: (value) {
        showList.clear();
        showList = widget.users
            .where((e) =>
                (e['email']!.toLowerCase().contains(value.toLowerCase())) ||
                (e['name']!.toLowerCase().contains(value.toLowerCase())))
            .toList();
        setState(() {});
      },
    );
  }
}
