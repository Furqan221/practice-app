import 'package:apipractice/export_all.dart';
import 'package:http/http.dart';
import 'dart:convert';

class PostApiOneScreen extends StatefulWidget {
  const PostApiOneScreen({super.key});

  @override
  State<PostApiOneScreen> createState() => _PostApiOneScreenState();
}

class _PostApiOneScreenState extends State<PostApiOneScreen> {
  void SignUp(String email, password) async {
    try {
      Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['id']);
        print('account created');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void Login(String email, password) async {
    try {
      Response response = await post(Uri.parse('https://reqres.in/api/login'),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('log in successful');
      } else {
        print('log in failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Sign Up Api'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'Email is : eve.holt@reqres.in',
            style: TextStyle(color: Colors.white),
          ),
          Text('Password is : pistol', style: TextStyle(color: Colors.white)),
          SizedBox(
            height: 100,
          ),
          LoginTextField(
              // hintText: 'Email',
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: emailController),
          SizedBox(
            height: 50,
          ),
          LoginTextField(
              // hintText: 'Password',
              labelText: 'Password',
              keyboardType: TextInputType.emailAddress,
              controller: passwordController),
          SizedBox(
            height: 50,
          ),
          ButtonWidget1(
              text: 'Sign Up',
              color: Colors.amber,
              onTap: () {
                SignUp(
                  emailController.text.toString(),
                  passwordController.text.toString(),
                );
              }),
          ButtonWidget1(
              text: 'Login',
              color: Colors.orange,
              onTap: () {
                Login(
                  emailController.text.toString(),
                  passwordController.text.toString(),
                );
              }),
        ],
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  String? hintText;
  TextInputType? keyboardType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? labelText;
  final TextEditingController? controller;

  LoginTextField(
      {super.key,
      this.hintText,
      required this.controller,
      this.prefixIcon,
      this.keyboardType,
      this.labelText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              labelText!,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.amber,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: controller,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
              prefixIconColor: Colors.white,
              suffixIconColor: Color(0xffBCC5D4),
              filled: true,
              fillColor: Color.fromARGB(137, 125, 126, 82),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
                borderRadius: BorderRadius.circular(28),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
                borderRadius: BorderRadius.circular(28),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
