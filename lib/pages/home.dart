import 'package:flutter/material.dart';
import 'package:flutter_crud/pages/add_user.dart';
import 'package:flutter_crud/pages/edit_user.dart';
import 'package:flutter_crud/services/user_service.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  // DateTime selected = DateTime.now();
  DateFormat formatter = DateFormat('dd-MM-yyyy');

  final screens = [
    const Center(child: AddUser()),
    const Center(
      child: Text("huevang"),
    ),
    const Center(
      child: Text("huevang"),
    ),
    const Center(
      child: Text("huevang"),
    ),
    const Center(
      child: Text("huevang"),
    ),
  ];

  var userData;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    var data = await UserServices().getAllUser();
    setState(() {
      userData = data["users"];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      // bottomNavigationBar: GNav(
      //   backgroundColor: Colors.blue,
      //   color: Colors.white,
      //   activeColor: Colors.white,
      //   gap: 8,
      //   selectedIndex: _currentIndex,
      //   onTabChange: (index) => {setState(() => _currentIndex = index)},
      //   tabs: const [
      //     GButton(
      //       icon: Icons.home,
      //       text: 'Home',
      //     ),
      //     GButton(
      //       icon: Icons.link,
      //       text: 'Link',
      //     ),
      //     GButton(
      //       icon: Icons.search,
      //       text: 'Search',
      //     ),
      //     GButton(
      //       icon: Icons.heart_broken,
      //       text: 'Heart',
      //     )
      //   ],
      // ),
      // body: screens[_currentIndex],
      body: userData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : listView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddUser()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView listView() {
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (context, index) => Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    userData[index]["gender"] == "MALE"
                        ? Image.asset(
                            "assets/images/male.jpeg",
                            width: 60,
                            height: 60,
                          )
                        : Image.asset(
                            "assets/images/female.jpeg",
                            width: 60,
                            height: 60,
                          ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userData[index]['gender'] == "MALE" ? Text(
                           "Mr " + userData[index]["fname"] +
                                " " +
                                userData[index]["lname"],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "NotoSerifLao",
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ) : Text(
                           "Ms " + userData[index]["fname"] +
                                " " +
                                userData[index]["lname"],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "NotoSerifLao",
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            userData[index]["phone"],
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            formatter.format(
                                DateTime.parse(userData[index]["birthday"])) + " ( " + userData[index]['role'] + " )",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EdittUser()));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        )),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Delete This Account"),
                              content: const Text(
                                  "Do you want to delete this account?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text("Delete"),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.delete, color: Colors.red)),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            // color: Color.fromARGB(255, 5, 5, 5),
          )
        ],
      ),
    );
  }
}
