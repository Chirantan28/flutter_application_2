import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class CartItem {
  final String name;
  final int price;
  int quantity;

  CartItem({required this.name, required this.price, this.quantity = 1});
}

class CartState {
  List<CartItem> items = [];
  int studCharge = 5;

  int get subtotal =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get total => subtotal + studCharge;

  void addItem(CartItem item) {
    final existingItem = items.firstWhere((i) => i.name == item.name,
        orElse: () => CartItem(name: '', price: 0));
    if (existingItem.name.isEmpty) {
      items.add(item);
    } else {
      existingItem.quantity += item.quantity;
    }
  }

  void removeItem(String name) {
    items.removeWhere((item) => item.name == name);
  }

  void clearCart() {
    items.clear();
  }
}

final cartState = CartState(); // Global instance

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudVery',
      theme: ThemeData(primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Text(
            "StudVery",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Login Page
class LoginPage extends StatelessWidget {
  final TextEditingController usnController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usnController,
                decoration: InputDecoration(labelText: 'USN'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainAppPage()),
                  );
                },
                child: Text('Login'),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()),
                    );
                  },
                  child: Text('Register Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  final TextEditingController usnController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  String selectedGender = 'Male';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Registration Form',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: usnController,
                    decoration: InputDecoration(
                      labelText: 'USN',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: branchController,
                    decoration: InputDecoration(
                      labelText: 'Branch',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: mobileController,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                      // keyboardType: TextInputType.phone,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: ['Male', 'Female', 'Other']
                        .map((gender) => DropdownMenuItem(
                              child: Text(gender),
                              value: gender,
                            ))
                        .toList(),
                    onChanged: (value) {
                      selectedGender = value!;
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Date of Birth',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '${selectedDate.toLocal()}'.split(' ')[0],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            selectedDate = pickedDate;
                          }
                        },
                        child: Text('Select Date'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Logic for registering the user
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Main Application Page with Toggle Feature
class MainAppPage extends StatefulWidget {
  @override
  _MainAppPageState createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  bool isOrderer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StudVery'),
        actions: [
          Switch(
            value: isOrderer,
            onChanged: (value) {
              setState(() {
                isOrderer = value;
              });
            },
          ),
        ],
      ),
      body: isOrderer ? OrdererPage() : DelivererPage(),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: cartState.items.isEmpty
          ? Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartState.items.length,
                    itemBuilder: (context, index) {
                      final item = cartState.items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('₹${item.price} x ${item.quantity}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            cartState.removeItem(item.name);
                            (context as Element).markNeedsBuild();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Subtotal'),
                  trailing: Text('₹${cartState.subtotal}'),
                ),
                ListTile(
                  title: Text('Stud Charge'),
                  trailing: Text('₹${cartState.studCharge}'),
                ),
                ListTile(
                  title: Text('Total'),
                  trailing: Text('₹${cartState.total}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Proceed to payment or checkout
                    },
                    child: Text('Proceed to Payment'),
                  ),
                ),
              ],
            ),
    );
  }
}

// Orderer Page

class OrdererPage extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {'title': 'ESB Canteen', 'icon': Icons.fastfood, 'page': ESBCanteenPage()},
    {
      'title': 'Multipurpose Canteen',
      'icon': Icons.restaurant,
      'page': MultipurposeCanteenPage()
    },
    {
      'title': 'Law Canteen',
      'icon': Icons.lunch_dining,
      'page': LawCanteenPage()
    },
    {'title': 'Stationery', 'icon': Icons.edit_note, 'page': StationaryPage()},
    {'title': 'Xerox', 'icon': Icons.print, 'page': XeroxPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Order Mode', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to the respective page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => options[index]['page'],
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                color: Colors.purple[50],
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(
                        options[index]['icon'],
                        size: 40,
                        color: Colors.purple,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          options[index]['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

// Separate pages for each entity

class ESBCanteenPage extends StatefulWidget {
  @override
  _ESBCanteenPageState createState() => _ESBCanteenPageState();
}

class _ESBCanteenPageState extends State<ESBCanteenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<Map<String, dynamic>> items = [
    {'name': 'Idli Vada', 'price': 45, 'image': 'assets/idli_vada.jpg'},
    {'name': 'Vada', 'price': 20, 'image': 'assets/vada.jpg'},
    {'name': 'Masala Dosa', 'price': 45, 'image': 'assets/masala_dosa.jpg'},
    {'name': 'Set Dosa', 'price': 45, 'image': 'assets/set_dosa.jpg'},
    {
      'name': 'Chapathi Meals',
      'price': 50,
      'image': 'assets/chapathi_meals.jpg'
    },
    {'name': 'Orange Juice', 'price': 30, 'image': 'assets/orange_juice.jpg'},
    {
      'name': 'Moosambi Juice',
      'price': 30,
      'image': 'assets/moosambi_juice.jpg'
    },
    {
      'name': 'Oreo Milkshake',
      'price': 50,
      'image': 'assets/oreo_milkshake.jpg'
    },
    {'name': 'Water Bottle', 'price': 20, 'image': 'assets/water_bottle.jpg'},
    {
      'name': 'Watermelon Juice',
      'price': 40,
      'image': 'assets/watermelon_juice.jpg'
    },
  ];

  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESB Canteen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to ESB Canteen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              items[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            items[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${items[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  quantities[index] =
                                      (quantities[index] ?? 1) - 1;
                                  if (quantities[index]! <= 0) {
                                    quantities[index] = 0;
                                  }
                                });
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  quantities[index] =
                                      (quantities[index] ?? 0) + 1;

                                  // Add item to cart
                                  final item = CartItem(
                                    name: items[index]['name'],
                                    price: items[index]['price'],
                                    quantity: 1,
                                  );
                                  cartState.addItem(item);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('${item.name} added to cart'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class MultipurposeCanteenPage extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {'title': 'South Mess', 'icon': Icons.local_dining},
    {'title': 'North Mess', 'icon': Icons.local_dining},
    {'title': 'Bakery', 'icon': Icons.cake},
    {'title': 'Cafe De Costa', 'icon': Icons.local_cafe},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multipurpose Canteen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to the respective page
                if (options[index]['title'] == 'South Mess') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SouthMessPage()),
                  );
                } else if (options[index]['title'] == 'North Mess') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NorthMessPage()),
                  );
                } else if (options[index]['title'] == 'Bakery') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BakeryPage()),
                  );
                } else if (options[index]['title'] == 'Cafe De Costa') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CafeDeCostaPage()),
                  );
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                color: Colors.purple[50],
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        options[index]['icon'],
                        size: 40,
                        color: Colors.purple,
                      ),
                      SizedBox(height: 10),
                      Text(
                        options[index]['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[900],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//Pages for locations

class SouthMessPage extends StatefulWidget {
  @override
  _SouthMessPageState createState() => _SouthMessPageState();
}

class _SouthMessPageState extends State<SouthMessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Idli Vada', 'price': 45, 'image': 'assets/idli_vada.jpg'},
    {'name': 'Vada', 'price': 20, 'image': 'assets/vada.jpg'},
    {'name': 'Masala Dosa', 'price': 45, 'image': 'assets/masala_dosa.jpg'},
    {'name': 'Set Dosa', 'price': 45, 'image': 'assets/set_dosa.jpg'},
    {
      'name': 'Chapathi Meals',
      'price': 50,
      'image': 'assets/chapathi_meals.jpg'
    },
    {'name': 'Coffee', 'price': 12, 'image': 'assets/coffee.jpg'},
    {'name': 'Tea', 'price': 12, 'image': 'assets/tea.jpg'},
    {'name': 'Limca', 'price': 50, 'image': 'assets/limca.jpg'},
    {'name': 'Water Bottle', 'price': 20, 'image': 'assets/water_bottle.jpg'},
    {'name': 'Munch', 'price': 20, 'image': 'assets/munch.jpg'},
  ];

  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('South Mess'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to South Mess',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(index, false);
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(index, true);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

//North Mess page
class NorthMessPage extends StatefulWidget {
  @override
  _NorthMessPageState createState() => _NorthMessPageState();
}

class _NorthMessPageState extends State<NorthMessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  // List of items with images, names, and prices
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Kulcha Curry', 'price': 75, 'image': 'assets/kulcha_curry.jpg'},
    {'name': 'Roti Curry', 'price': 70, 'image': 'assets/roti_curry.jpg'},
    {'name': 'Gobi Paratha', 'price': 80, 'image': 'assets/gobi_parata.jpg'},
    {'name': 'Noodles', 'price': 80, 'image': 'assets/noodles.jpg'},
    {'name': 'Gobi Noodles', 'price': 80, 'image': 'assets/gobi_noodles.jpg'},
    {'name': 'North Meals', 'price': 90, 'image': 'assets/north_meals.jpg'},
    {'name': 'Soya Roll', 'price': 50, 'image': 'assets/soya_roll.jpg'},
    {'name': 'Paneer Roll', 'price': 60, 'image': 'assets/paneer_roll.jpg'},
  ];

  // Quantity tracker
  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to update quantity of the item
  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('North Mess'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Welcome text with slide animation
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to North Mess',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, false); // Decrease quantity
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, true); // Increase quantity
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class BakeryPage extends StatefulWidget {
  @override
  _BakeryPageState createState() => _BakeryPageState();
}

class _BakeryPageState extends State<BakeryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  // List of items with images, names, and prices
  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Paneer Sandwich',
      'price': 40,
      'image': 'assets/paneer_sandwich.jpg'
    },
    {'name': 'Samosa', 'price': 30, 'image': 'assets/samosa.jpg'},
    {'name': 'Cold coffee', 'price': 35, 'image': 'assets/cold_coffee.jpg'},
    {'name': 'Donut', 'price': 25, 'image': 'assets/donut.jpg'},
    {'name': 'Snickers', 'price': 20, 'image': 'assets/snickers.jpg'},
    {'name': 'Five Star', 'price': 60, 'image': 'assets/five_star.jpg'},
  ];

  // Quantity tracker
  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to update quantity of the item
  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bakery'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Welcome text with slide animation
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Bakery',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, false); // Decrease quantity
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, true); // Increase quantity
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class CafeDeCostaPage extends StatefulWidget {
  @override
  _CafeDeCostaPageState createState() => _CafeDeCostaPageState();
}

class _CafeDeCostaPageState extends State<CafeDeCostaPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  // List of items with images, names, and prices
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Espresso', 'price': 60, 'image': 'assets/espresso.jpg'},
    {'name': 'Cappuccino', 'price': 70, 'image': 'assets/cappuccino.jpg'},
    {'name': 'Latte', 'price': 80, 'image': 'assets/latte.jpg'},
    {'name': 'Mocha', 'price': 90, 'image': 'assets/mocha.jpg'},
    {'name': 'Cold Brew', 'price': 100, 'image': 'assets/cold_brew.jpg'},
    {'name': 'Iced Coffee', 'price': 80, 'image': 'assets/iced_coffee.jpg'},
  ];

  // Quantity tracker
  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to update quantity of the item
  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cafe de Costa'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Welcome text with slide animation
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Cafe de Costa',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, false); // Decrease quantity
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, true); // Increase quantity
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class LawCanteenPage extends StatefulWidget {
  @override
  _LawCanteenPageState createState() => _LawCanteenPageState();
}

class _LawCanteenPageState extends State<LawCanteenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Fruit Bowl', 'price': 50, 'image': 'assets/fruit_bowl.jpg'},
    {'name': 'Burger', 'price': 30, 'image': 'assets/burger.jpg'},
  ];

  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Law Canteen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Law Canteen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(index, false);
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(index, true);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class StationaryPage extends StatefulWidget {
  @override
  _StationaryPageState createState() => _StationaryPageState();
}

class _StationaryPageState extends State<StationaryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Pen', 'price': 10, 'image': 'assets/pen.jpg'},
    {'name': 'Notebook', 'price': 40, 'image': 'assets/notebook.jpg'},
    {'name': 'Eraser', 'price': 5, 'image': 'assets/eraser.jpg'},
    {'name': 'Pencil', 'price': 5, 'image': 'assets/pencil.jpg'},
    {'name': 'Record', 'price': 70, 'image': 'assets/record.jpg'},
    {'name': 'Bluebook', 'price': 20, 'image': 'assets/bluebook.jpg'},
    {'name': 'Data Sheets', 'price': 2, 'image': 'assets/datasheet.jpg'},
  ];

  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stationary'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Stationary',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(index, false);
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(index, true);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class XeroxPage extends StatefulWidget {
  @override
  _XeroxPageState createState() => _XeroxPageState();
}

class _XeroxPageState extends State<XeroxPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Single Page Xerox', 'price': 2},
    {'name': 'Double Page Xerox', 'price': 3},
    {'name': 'Lamination', 'price': 20},
    {'name': 'Binding', 'price': 30},
  ];

  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xerox'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Xerox',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuItems[index]['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Price: ₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    updateQuantity(index, false);
                                  },
                                ),
                                Text(
                                  '${quantities[index] ?? 0}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    updateQuantity(index, true);
                                  },
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Add functionality for order or cart here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

// Deliverer Page
class DelivererPage extends StatefulWidget {
  @override
  _DelivererPageState createState() => _DelivererPageState();
}

class _DelivererPageState extends State<DelivererPage> {
  final List<Map<String, dynamic>> orders = List.generate(
    5,
    (index) => {
      'orderId': index + 1,
      'name': 'Order ${index + 1}',
      'isDelivered': false,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(
                  orders[index]['isDelivered']
                      ? Icons.check_circle
                      : Icons.pending,
                  color: orders[index]['isDelivered']
                      ? Colors.green
                      : Colors.orange,
                ),
                title: Text(orders[index]['name']),
                trailing: Checkbox(
                  value: orders[index]['isDelivered'],
                  onChanged: (value) {
                    setState(() {
                      orders[index]['isDelivered'] = value!;
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
