import 'dart:convert';

import 'package:apipractice/export_all.dart';
import 'package:apipractice/models/user_model.dart';
import 'package:http/http.dart' as http;

// This is the example of getting simple json data form unnamed
//array using modal (with custom selection)in UI list

class GetApiThreeScreen extends StatefulWidget {
  const GetApiThreeScreen({super.key});

  @override
  State<GetApiThreeScreen> createState() => _GetApiThreeScreenState();
}

class _GetApiThreeScreenState extends State<GetApiThreeScreen> {
  List<userModal> userList = [];
  Future<List<userModal>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        var map = i as Map<String, dynamic>;
        print(map['name']);
        userList.add(userModal.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Api Practice 3'),
      ),
      body: FutureBuilder(
          future: getUserApi(),
          builder: (context, AsyncSnapshot<List<userModal>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.red, width: 2)),
                      child: Column(
                        children: [
                          ReusableRow(
                            title: 'Id',
                            value: snapshot.data![index].id.toString(),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          ReusableRow(
                            title: 'Name',
                            value: snapshot.data![index].name.toString(),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          ReusableRow(
                            title: 'Address',
                            value: snapshot.data![index].address.toString(),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          ReusableRow(
                            title: 'street',
                            value: snapshot.data![index].address!.street
                                .toString(),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          ReusableRow(
                            title: 'suite',
                            value:
                                snapshot.data![index].address!.suite.toString(),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String? title, value;
  ReusableRow({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title!), Text(value!)],
    );
  }
}
