import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../model/user_data.dart';

class EditDetailsScreen extends StatefulWidget {
  final UserData userData;

  const EditDetailsScreen({super.key, required this.userData});

  @override
  _EditDetailsScreenState createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _genderController;
  late TextEditingController _cityController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData.name);
    _ageController =
        TextEditingController(text: widget.userData.age.toString());
    _genderController = TextEditingController(text: widget.userData.gender);
    _cityController = TextEditingController(text: widget.userData.city);
    _addressController = TextEditingController(text: widget.userData.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors
                          .transparent), // Make the button background transparent
                    ),
                    onPressed: _updateUserData,
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateUserData() async {
    final updatedUserData = UserData(
      id: widget.userData.id,
      name: _nameController.text,
      age: int.parse(_ageController.text),
      gender: _genderController.text,
      city: _cityController.text,
      address: _addressController.text,
    );
    //print(' widget.userData.id, :${widget.userData.id}');
    await DatabaseHelper.instance.updateUserData(updatedUserData);

    // Pop the screen and notify the previous screen about the update
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
