import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'WELCOME TO MY APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isInputValid = true;
  bool _isPasswordValid = true;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  var likeNumber = <int>[];

  void like() {
    if (likeNumber.contains(_counter)) {
      likeNumber.remove(_counter);
    } else {
      likeNumber.add(_counter);
    }
  }

  bool isEmailValid(String email) {
    // Define the regex pattern for email validation
    final pattern = r'^[\w-]+(\.[\w-]+)*@([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$';

    // Create a RegExp object with the defined pattern
    final regex = RegExp(pattern);

    // Use the RegExp object to check if the email matches the pattern
    return regex.hasMatch(email);
  }

  void _validateInput(String text) {
    bool isValid = isEmailValid(text);

    // Update the state variable to control the error state
    setState(() {
      _isInputValid = isValid;
    });
  }

  void passwordInput(String text, String email) {
    bool isShort = false;
    if (text.length < 6) {
      isShort = false;
    } else {
      isShort = true;
    }
    int index = email.indexOf("@");
    if (email.contains("@")) {
      String nameEmail = email.substring(0, index);

      if (text.contains(nameEmail)) isShort = false;
    } else {
      if (text.contains(email)) isShort = false;
    }
    setState(() {
      _isPasswordValid = isShort;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final theme = Theme.of(context);
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 500,
                child: Card(
                  color: theme.colorScheme.onPrimary,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Colors.deepPurple,
                              ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildGreyText("Email address"),
                            _buildInputEmailField(emailController),
                            _buildGreyText("Password"),
                            _buildInputPasswordField(passwordController,
                                isPassword: true),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: FloatingActionButton(
                            onPressed: () {
                              _validateInput(emailController.text);
                              passwordInput(passwordController.text,
                                  emailController.text);
                            },
                            tooltip: 'hey',
                            hoverColor: Colors.white,
                            foregroundColor: Colors.deepPurple,
                            child: Text(
                              'Login',
                            ),
                          ),
                        ),
                      ])),
                ),
              )
            ],
          ),
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(text, style: const TextStyle(color: Colors.grey));
  }

  Widget _buildInputEmailField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: _isInputValid ? Icon(null) : Icon(Icons.close),
          errorText: _isInputValid ? null : 'Invalid input'),
    );
  }

  Widget _buildInputPasswordField(TextEditingController controller,
      {isPassword = false}) {
    bool _obscureText = true;
    return TextField(
      controller: controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: _obscureText
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        errorText: _isPasswordValid ? null : 'Password too short',
      ),
    );
  }
}

// class BigCard extends StatefulWidget {
//   BigCard({
//     super.key,
//   });
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _isInputValid = true;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       width: 500,
//       child: Card(
//         color: theme.colorScheme.onPrimary,
//         child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(
//                 'Welcome',
//                 style: Theme.of(context).textTheme.displayMedium!.copyWith(
//                       color: Colors.deepPurple,
//                     ),
//               ),
//               _buildGreyText("Email address"),
//               _buildInputEmailField(emailController),
//               _buildGreyText("Password"),
//               _buildInputPasswordField(passwordController, isPassword: true),
//               // FloatingActionButton(
//               //   onPressed: None,
//               //   tooltip: 'hey',
//               //   hoverColor: Colors.yellow,
//               //   foregroundColor: Colors.red,
//               //   child: const Icon(Icons.add),
//               // ), // This trailing comma makes auto-formatting nicer for build methods.
//             ])),
//       ),
//     );
//   }

//   bool isEmailValid(String email) {
//     // Define the regex pattern for email validation
//     final pattern = r'^[\w-]+(\.[\w-]+)*@([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$';

//     // Create a RegExp object with the defined pattern
//     final regex = RegExp(pattern);

//     // Use the RegExp object to check if the email matches the pattern
//     return regex.hasMatch(email);
//   }

//   void _validateInput(String text) {
//     bool isValid = isEmailValid(text);

//     // Update the state variable to control the error state
//     setState(() {
//       _isInputValid = isValid;
//     });
//   }

//   Widget _buildGreyText(String text) {
//     return Text(text, style: const TextStyle(color: Colors.grey));
//   }

//   Widget _buildInputEmailField(TextEditingController controller) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//           suffixIcon: Icon(Icons.done),
//           errorText: isEmailValid(controller.text) ? null : 'Invalid input'),
//     );
//   }

//   Widget _buildInputPasswordField(TextEditingController controller,
//       {isPassword = false}) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//           suffixIcon:
//               isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done)),
//       obscureText: isPassword,
//     );
//   }
// }
