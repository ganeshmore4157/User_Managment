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
  // TextEditingController gendreController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String gender = 'male';

  Service service = Service();

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a name';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Please enter a valid name (only characters)';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email address';
    }
    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a mobile number';
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number should be 10 digits';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page', textAlign: TextAlign.center, style: TextStyle(fontSize: 32, color: Colors.brown)),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_formKey.currentState != null && !_formKey.currentState!.validate())
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.red,
                  child: Text(
                    'Please correct the errors above and try again.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              const Text('Name:-', textAlign: TextAlign.justify, style: TextStyle(fontSize: 20, color: Colors.black)),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
                validator: validateName,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Email:-', textAlign: TextAlign.justify, style: TextStyle(fontSize: 20, color: Colors.black)),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email',
                ),
                validator: validateEmail,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Mobile:-', textAlign: TextAlign.justify, style: TextStyle(fontSize: 20, color: Colors.black)),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: mobileController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Mobile',
                ),
                validator: validateMobile,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Address:-', textAlign: TextAlign.justify, style: TextStyle(fontSize: 20, color: Colors.black)),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Address',
                ),
                validator: validateAddress,
              ),
              const SizedBox(
                height: 10,
              ),
               const SizedBox(
                height: 5,
              ),
               SizedBox(height: 10),
      Text('Gender:', style: TextStyle(fontSize: 20, color: Colors.black)),
      Row(
        children: [
          Radio(
            value: 'Male',
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
              });
            },
          ),
          Text('Male'),
          Radio(
            value: 'Female',
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
              });
            },
          ),
          Text('Female'),
        ],
      ),
      SizedBox(height: 10),

            
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    await service.saveUser(
                      nameController.text,
                      mobileController.text,
                      emailController.text,
                      addressController.text,
                      // gendreController.text,
                      gender ?? '',
                    );
                    widget.fetchUserListCallback();
                    Navigator.of(context).pop();
                  }
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
      ),
    );
  }
}
