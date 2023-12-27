import 'package:flutter/material.dart';
import 'package:flutter_form/registration_page.dart';
import 'package:flutter_form/user_detail_page.dart';

import './service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(refreshCallback: null),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required refreshCallback});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  Service service = Service();

  List<User> userList = [];

  @override
  void initState() {
    super.initState();
    fetchUserList();
  }

  void fetchUserList() async {
    try {
      List<User> users = await service.getUsers();
      setState(() {
        userList = users;
      });
    } catch (e) {
      print("Error fetching user list: $e");
    }
  }

  Future<void> showEditDialog(User user) async {
    nameController.text = user.name;
    emailController.text = user.email;
    mobileController.text = user.mobile;
    addressController.text = user.address;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit User'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: mobileController,
                  decoration: const InputDecoration(labelText: 'Mobile'),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await service.updateUser(
                  user.id,
                  nameController.text,
                  mobileController.text,
                  emailController.text,
                  addressController.text,
                );
                Navigator.of(context).pop();
                fetchUserList();
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showDeleteDialog(User user) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await service.deleteUser(user.id);
                Navigator.of(context).pop();
                fetchUserList();
              },
              child: const Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  ElevatedButton buildActionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Management',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 34, color: Colors.brown),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text('User List',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: Colors.red)),
            userList.isEmpty
                ? Text('No users available')
                : DataTable(
                    columns: [
                      DataColumn(
                          label: Text(
                        'Name',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      )),
                      DataColumn(
                          label: Text(
                        'Email',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      )),
                      DataColumn(
                          label: Text(
                        'Address',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      )),
                      DataColumn(
                          label: Text(
                        'Actions',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ))
                    ],
                    rows: userList
                        .map((user) => DataRow(
                              cells: [
                                DataCell(Text(user.name)),
                                DataCell(Text(user.email)),
                                DataCell(Text(user.address)),
                                DataCell(Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        showEditDialog(user);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        showDeleteDialog(user);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.remove_red_eye),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserDetailPage(user: user),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )),
                              ],
                            ))
                        .toList(),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationPage(
                          fetchUserListCallback: fetchUserList)),
                );
              },
              child: Text(
                'Add New User',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
