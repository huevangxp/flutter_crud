import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String Gender = "";

  final userType = ['Admin', 'User'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Center(child: Text("Add User")),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Padding(padding: EdgeInsets.only(top: 20)),
              const SizedBox(
                height: 50,
              ),
              textFieldFname(context),
              const SizedBox(
                height: 20,
              ),
              textFieldLname(context),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    Text(
                      "Gender",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              radioMaleAndFemal(context),
              const SizedBox(
                height: 20,
              ),
              textFormFieldBirthday(context),
              const SizedBox(
                height: 20,
              ),
              textFormFieldPhone(context),
              const SizedBox(
                height: 20,
              ),
              selectWidget(context),
              const SizedBox(
                height: 100,
              ),
              buttonAddUser(context)
            ],
          ),
        ),
      ),
    );
  }

  Container buttonAddUser(BuildContext context) {
    return Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 40,
              child: ElevatedButton(onPressed: (){}, child: Text('Add User', style:TextStyle(fontSize: 20))));
  }

  Container selectWidget(BuildContext context) {
    return Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: DropdownButton(
                  isExpanded: true,
                  hint: Text("Select"),
                  items: userType
                      .map((e) => DropdownMenuItem(
                            child: Text(
                              e,
                              style: TextStyle(fontSize: 16),
                            ),
                            value:e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      value = value;
                    });
                  }),
            );
  }

  Container textFormFieldPhone(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Phone",
            border: OutlineInputBorder(),
            prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.phone))),
      ),
    );
  }

  Container textFormFieldBirthday(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Birthday",
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.date_range),
          ),
        ),
      ),
    );
  }

  Container radioMaleAndFemal(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Radio(
                  value: "Male",
                  groupValue: Gender,
                  onChanged: (value) {
                    setState(() {
                      Gender = value.toString();
                      print(value);
                    });
                  }),
              Text("Male"),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: "Female",
                  groupValue: Gender,
                  onChanged: (value) {
                    setState(() {
                      Gender = value.toString();
                      print(value);
                    });
                  }),
              Text("Female")
            ],
          )
        ],
      ),
    );
  }

  Container textFieldLname(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Last Name",
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container textFieldFname(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "First Name",
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
