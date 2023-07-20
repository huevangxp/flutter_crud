import 'package:flutter/material.dart';
import 'package:flutter_crud/pages/home.dart';
import 'package:flutter_crud/services/user_service.dart';
import 'package:intl/intl.dart';

class EdittUser extends StatefulWidget {
  String? id;
  String? fname;
  String? lname;
  String? gender;
  String? role;
  String? birthday;
  String? phone;
  EdittUser(
      {super.key,
      this.id,
      this.fname,
      this.lname,
      this.birthday,
      this.gender,
      this.phone,
      this.role});

  @override
  State<EdittUser> createState() => _EdittUserState();
}

class _EdittUserState extends State<EdittUser> {
  String gender = "MALE";
  String selectUser = 'Select Type';
  DateTime selected = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  TextEditingController BirthdayController = TextEditingController();
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _phone = TextEditingController();

  bool firstNameValidate = false;
  bool lastNameValidate = false;

  String? get _errorText {
    final text = _phone.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 8) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  final userType = ['ADMIN', 'USER'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selected,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != selected) {
      setState(() {
        selected = picked;
        BirthdayController.text = formatter.format(selected);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // id = widget.id;
    gender = widget.gender!;
    selectUser = widget.role!;
    BirthdayController.text = formatter.format(DateTime.parse(widget.birthday!));
    _fname.text = widget.fname!;
    _lname.text = widget.lname!;
    _phone.text = widget.phone!;
  }

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
                      "Birthday",
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
        child: ElevatedButton(
            onPressed: () async {
              // print("first name: ${_fname.text}");
              // print("last name: ${_lname.text}");
              // print("Gender: ${gender}");
              // print("brithday: ${BirthdayController.text}");
              // print("phone: ${_phone.text}");
              // print("select: ${selectUser}");

              if (_fname.text.isEmpty && _lname.text.isEmpty) {
                setState(() {
                  firstNameValidate = true;
                  lastNameValidate = true;
                });
              } else {
                setState(() {
                  firstNameValidate = false;
                  lastNameValidate = false;
                });
              }
              var update = await UserServices().updateUser(widget.id!, {
                "fname": _fname.text,
                "lname": _lname.text,
                "gender": gender,
                "birthday": BirthdayController.text,
                "role": selectUser,
                "phone": _phone.text
              });
              if (update == 200) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                    (route) => false);
              }
            },
            child: Text('Add User', style: TextStyle(fontSize: 20))));
  }

  Container selectWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: DropdownButton(
          isExpanded: true,
          hint: selectUser == null ? Text(selectUser) : Text(selectUser),
          // value: selectUser,
          items: userType
              .map((e) => DropdownMenuItem(
                    child: Text(
                      e,
                      style: TextStyle(fontSize: 16),
                    ),
                    value: e,
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectUser = value!;
              // print(value);
            });
          }),
    );
  }

  Widget textFormFieldPhone(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            controller: _phone,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                errorText: _errorText,
                labelText: "Phone",
                border: OutlineInputBorder(),
                prefixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.phone))),
          ),
        ),
      ],
    );
  }

  Widget textFormFieldBirthday(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        child: IgnorePointer(
          child: TextFormField(
            controller: BirthdayController,
            decoration: InputDecoration(
              labelText: "Birthday",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  // _selectDate(context);
                },
                icon: Icon(Icons.date_range),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget radioMaleAndFemal(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Radio(
                      value: "MALE",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                          print(value);
                        });
                      }),
                  Text("Male"),
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: "FEMALE",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                          print(value);
                        });
                      }),
                  Text("Female")
                ],
              )
            ],
          ),
        ),
        gender == ""
            ? Container(
                padding: EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    Container(
                        child: Text(
                      "please select gender",
                      style: TextStyle(color: Colors.red),
                    )),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  Container textFieldLname(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: TextFormField(
        controller: _lname,
        decoration: InputDecoration(
          errorText: lastNameValidate ? "Please enter last name" : null,
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

  Widget textFieldFname(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: TextFormField(
            controller: _fname,
            decoration: InputDecoration(
              errorText: firstNameValidate ? 'Value Can\'t Be Empty' : null,
              labelText: "First Name",
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        // _fname.text.isEmpty ? Text("Please enter your first name", style: TextStyle(color: Colors.red),) : Container(),
      ],
    );
  }
}
