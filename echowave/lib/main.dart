import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:echowave/src/screens/Home.dart';
import 'package:echowave/src/screens/Search.dart';
import 'package:echowave/src/screens/Library.dart';
import 'package:echowave/src/screens/Listning.dart';
import 'package:echowave/src/screens/Login_Screen.dart'; // Add LoginScreen import

const Color backgroundColor = Colors.black;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing App...");

  try {
    await _initializeFirebase();
    print("Firebase initialized successfully.");
    runApp(const MyApp());
  } catch (e) {
    print("Error initializing Firebase: $e");
    runApp(ErrorApp(error: e.toString()));
  }
}

Future<void> _initializeFirebase() async {
  print("Initializing Firebase...");
  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: "AIzaSyCVN9aQEsMOmDdKzhUeT1FSEA9vak1JONM",
            authDomain: "echowave-3b5c3.firebaseapp.com",
            projectId: "echowave-3b5c3",
            storageBucket: "echowave-3b5c3.appspot.com",
            messagingSenderId: "1013422993345",
            appId: "1:1013422993345:web:7dbc1e1f3fa08b7585c940",
            measurementId: "G-6RMPEMRF9M",
          )
        : null,
  );

  // Enable Firebase Authentication persistence
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("Building MyApp...");
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => CounterBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF36B6FF)),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const RadioScreen(),
    const LibraryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Future<void> _requestPermissions() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission required!')),
        );
      }
    } else {
      print("Web does not support microphone permissions natively.");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Building MainScreen with index: $_selectedIndex");

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          // User is authenticated
          return Scaffold(
            body: _screens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.black,
              selectedItemColor: const Color(0xFF36B6FF),
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home, size: 32), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.search, size: 32), label: "Search"),
                BottomNavigationBarItem(icon: Icon(Icons.podcasts, size: 32), label: "Listening"),
                BottomNavigationBarItem(icon: Icon(Icons.library_music, size: 32), label: "Library"),
              ],
            ),
          );
        } else {
          // User is not authenticated
          return const LoginScreen();  // Redirect to login screen
        }
      },
    );
  }
}

// Bloc Implementation
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial()) {
    on<IncrementCounter>((event, emit) => emit(CounterUpdated(state.counter + 1)));
  }
}

// Events
abstract class CounterEvent {}
class IncrementCounter extends CounterEvent {}

// States
abstract class CounterState {
  final int counter;
  const CounterState(this.counter);
}

class CounterInitial extends CounterState {
  const CounterInitial() : super(0);
}

class CounterUpdated extends CounterState {
  const CounterUpdated(super.counter);
}

// ErrorApp to display Firebase initialization errors.
class ErrorApp extends StatelessWidget {
  final String error;
  const ErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(
            'Error initializing Firebase: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
