import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../database/database_helper.dart';
import '../model/user_data.dart';

class AddDetailsScreen extends StatelessWidget {
  AddDetailsScreen({super.key});
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'age':
        FormControl<int>(validators: [Validators.required, Validators.min(18)]),
    'gender': FormControl<String>(validators: [Validators.required]),
    'city': FormControl<String>(validators: [Validators.required]),
    'address': FormControl<String>(validators: [Validators.required]),
  });

  final List<String> cities = [
    'Islamabad',
    'Peshawar',
    'Multan',
    'Faisalabad',
    'Karachi'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reactive Forms'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ReactiveForm(
            formGroup: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReactiveTextField<String>(
                  formControlName: 'name',
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 10),
                ReactiveTextField<int>(
                  formControlName: 'age',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age'),
                ),
                SizedBox(height: 10),
                ReactiveTextField<String>(
                  formControlName: 'gender',
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                SizedBox(height: 10),
                ReactiveDropdownField<String>(
                  formControlName: 'city',
                  items: cities
                      .map((city) =>
                          DropdownMenuItem(value: city, child: Text(city)))
                      .toList(),
                  decoration: InputDecoration(labelText: 'City'),
                ),
                SizedBox(height: 10),
                ReactiveTextField<String>(
                  formControlName: 'address',
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                SizedBox(height: 20),
                Center(
                  child: ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          onPressed:
                              form.valid ? () => _submitForm(context) : null,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors
                                .transparent), // Make the button background transparent
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _submitForm() {
  //   if (form.valid) {
  //     print('Form values: ${form.value}');
  //     // You can perform further actions with the form values here
  //   }
  // }

  void _submitForm(BuildContext context) async {
    if (form.valid) {
      //form.value;
      //print('form.value : ${form.value}');
      final userData = UserData(
        name: form.control('name').value,
        age: form.control('age').value,
        gender: form.control('gender').value,
        city: form.control('city').value,
        address: form.control('address').value,
      );

      // Store data in the database
      await DatabaseHelper.instance.insertUserData(userData);

      // Navigate back to the home screen
      Navigator.pop(context);
    }
  }
}
