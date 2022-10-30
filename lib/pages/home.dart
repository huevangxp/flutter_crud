import 'package:flutter/material.dart';
import 'package:flutter_crud/pages/add_user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/male.jpeg",
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
                          Text(
                            "Mr Huevang XiongPor",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontFamily: "NotoSerifLao",fontWeight: FontWeight.w800,fontSize: 20),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("020 23456543", style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
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
                  content: const Text("Do you want to delete this account?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        // color: Colors.red,
                        // padding: const EdgeInsets.all(14),
                        // child: const Text("Delete", style: TextStyle(color: Colors.white),),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(onPressed: () {
                            Navigator.of(ctx).pop();
                            }, child:Text("Cancel"),
                           ),
                           SizedBox(width: 10,),
                            ElevatedButton(onPressed: () {
                            Navigator.of(ctx).pop();
                            }, child:Text("Delete"),
                            style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
    ),),
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
      ),),
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
}