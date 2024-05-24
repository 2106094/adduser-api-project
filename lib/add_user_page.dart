import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  Future<void> addUserData({required String username, required String job}) async {
    var url = "https://reqres.in/api/users";
    final response = await http.post(
      Uri.parse(url),
      body: {
        "name": username,
        "job": job,
      },
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User added successfully')),
      );
      Navigator.pop(context);
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                  hintText: "Masukkan nama Anda",
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _jobController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Job",
                  hintText: "Masukkan pekerjaan",
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    addUserData(
                      username: _nameController.text,
                      job: _jobController.text,
                    );
                  },
                  child: const Text("Kirim"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
