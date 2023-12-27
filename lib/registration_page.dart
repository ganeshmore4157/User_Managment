import 'package:flutter/material.dart';

import 'service.dart'; 

class RegistrationPage extends StatefulWidget {
   final VoidCallback fetchUserListCallback;

  const RegistrationPage({Key? key, required this.fetchUserListCallback}) : super(key: key);
  
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page',textAlign: TextAlign.center,style: TextStyle(fontSize: 32,color: Colors.brown)),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text('Name:-',textAlign: TextAlign.justify,style: TextStyle(fontSize: 20,color: Colors.black)),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Email:-',textAlign: TextAlign.justify,style: TextStyle(fontSize: 20,color: Colors.black)),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Mobile:-',textAlign: TextAlign.justify,style: TextStyle(fontSize: 20,color: Colors.black)),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Mobile',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Address:-',textAlign: TextAlign.justify,style: TextStyle(fontSize: 20,color: Colors.black)),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Address',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await service.saveUser(
                  nameController.text,
                  mobileController.text,
                  emailController.text,
                  addressController.text,
                );
                widget.fetchUserListCallback();
                Navigator.of(context).pop(); 
              },
              child: const Text(
                'Register',
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
