import 'package:flutter/material.dart';

import '../add_details_screen/add_details_screen.dart';
import '../database/database_helper.dart';
import '../edit_details_screen/edit_details_screen.dart';
import '../model/user_data.dart';

/*class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<UserData>> _userDataFuture;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final userDataList = await DatabaseHelper.instance.getUserData();
      if (userDataList.isEmpty) {
        print('No data available');
      }
      setState(() {
        _isLoading = false;
        _userDataFuture = Future.value(userDataList);
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _isLoading = false;
        _userDataFuture = Future.error(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Screen'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<UserData>>(
              future: _userDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final userData = snapshot.data![index];
                      return GestureDetector(
                        onTap: () async {
                          if (userData.id != null) {
                            UserData? userDataWithId = await DatabaseHelper
                                .instance
                                .getUserDataById(userData.id!);

                            if (userDataWithId != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditDetailsScreen(
                                    userData: userDataWithId,
                                  ),
                                ),
                              );
                            } else {
                              print('User data is null');
                            }
                          } else {
                            print('User ID is null');
                          }
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                              userData.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Age: ${userData.age}, Gender: ${userData.gender}, City: ${userData.city}, Address: ${userData.address}',
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (String choice) {
                                if (choice == 'edit') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditDetailsScreen(
                                        userData: userData,
                                      ),
                                    ),
                                  );
                                } else if (choice == 'delete') {
                                  // Handle delete logic
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'edit',
                                  child: ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit'),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'delete',
                                  child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDetailsScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<UserData>> _userDataFuture;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final userDataList = await DatabaseHelper.instance.getUserData();
      if (userDataList.isEmpty) {
        print('No data available');
      }
      setState(() {
        _isLoading = false;
        _userDataFuture = Future.value(userDataList);
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _isLoading = false;
        _userDataFuture = Future.error(error);
      });
    }
  }

  Future<void> _showDeleteConfirmationDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteUserData(id);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteUserData(int id) async {
    try {
      await DatabaseHelper.instance.deleteUserData(id);
      _fetchData(); // Fetch updated data. This will Reflect the UI and we can see Immediately changing in our App
    } catch (error) {
      print('Error deleting user data: $error');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Screen'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<UserData>>(
              future: _userDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final userData = snapshot.data![index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            userData.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Age: ${userData.age}, Gender: ${userData.gender}, City: ${userData.city}, Address: ${userData.address}',
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (String choice) {
                              if (choice == 'edit') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditDetailsScreen(
                                      userData: userData,
                                    ),
                                  ),
                                ).then((value) {
                                  if (value != null && value) {
                                    _fetchData(); // Fetch updated data after editing
                                  }
                                });
                              } else if (choice == 'delete') {
                                _showDeleteConfirmationDialog(userData.id!);
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'edit',
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDetailsScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
