import 'package:flutter/material.dart';

void main() => runApp(MealsApp());

class MealsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _favoriteFoods = [];

  void _toggleFavorite(Map<String, dynamic> foodItem) {
    setState(() {
      if (_favoriteFoods.contains(foodItem)) {
        _favoriteFoods.remove(foodItem);
      } else {
        _favoriteFoods.add(foodItem);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? HomeScreen(
              favoriteFoods: _favoriteFoods,
              toggleFavorite: _toggleFavorite,
            )
          : FavoriteScreen(
              favoriteFoods: _favoriteFoods,
              toggleFavorite: _toggleFavorite,
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteFoods;
  final Function(Map<String, dynamic>) toggleFavorite;

  HomeScreen({required this.favoriteFoods, required this.toggleFavorite});

  final List<Map<String, dynamic>> foodTypes = [
    {
      'type': 'Asian',
      'image':
          'https://images.pexels.com/photos/3204950/pexels-photo-3204950.jpeg?auto=compress&cs=tinysrgb&w=600',
    },
    {
      'type': 'American',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgLjJ5cctDMZQ2GpctPTZTEPVkEPEhU0Tx_g&s',
    },
    {
      'type': 'Italian',
      'image':
          'https://images.pexels.com/photos/326709/pexels-photo-326709.jpeg?auto=compress&cs=tinysrgb&w=600',
    },
    {
      'type': 'Mexican',
      'image':
          'https://images.pexels.com/photos/12312075/pexels-photo-12312075.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
    {
      'type': 'Indian',
      'image':
          'https://images.pexels.com/photos/789750/pexels-photo-789750.jpeg?auto=compress&cs=tinysrgb&w=600',
    },
    {
      'type': 'French',
      'image':
          'https://images.pexels.com/photos/3721426/pexels-photo-3721426.jpeg?auto=compress&cs=tinysrgb&w=600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals App'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: foodTypes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodMenuScreen(
                    foodType: foodTypes[index]['type'],
                    favoriteFoods: favoriteFoods,
                    toggleFavorite: toggleFavorite,
                  ),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: foodTypes[index]['color'],
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(foodTypes[index]['image']),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Text(
                foodTypes[index]['type'],
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FoodMenuScreen extends StatelessWidget {
  final String foodType;
  final List<Map<String, dynamic>> favoriteFoods;
  final Function(Map<String, dynamic>) toggleFavorite;

  FoodMenuScreen({
    required this.foodType,
    required this.favoriteFoods,
    required this.toggleFavorite,
  });

  final Map<String, List<Map<String, dynamic>>> foodMenu = {
    'Asian': [
      {
        'name': 'Sushi',
        'description': 'Delicious sushi rolls',
        'calories': 200,
        'price': 12.99,
        'image':
            'https://images.pexels.com/photos/357756/pexels-photo-357756.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Ramen',
        'description': 'Warm and tasty ramen',
        'calories': 400,
        'price': 9.99,
        'image':
            'https://images.pexels.com/photos/2664216/pexels-photo-2664216.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Dumplings',
        'description': 'Steamed or fried dumplings',
        'calories': 300,
        'price': 7.99,
        'image':
            'https://images.pexels.com/photos/18803177/pexels-photo-18803177/free-photo-of-plate-with-greasy-momos-dumplings.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      }
    ],
    'American': [
      {
        'name': 'Burger',
        'description': 'Juicy grilled burger',
        'calories': 800,
        'price': 11.99,
        'image':
            'https://images.pexels.com/photos/1639565/pexels-photo-1639565.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Hotdog',
        'description': 'Classic hotdog with toppings',
        'calories': 350,
        'price': 5.99,
        'image':
            'https://images.pexels.com/photos/4676409/pexels-photo-4676409.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Steak',
        'description': 'Tender and flavorful steak',
        'calories': 700,
        'price': 19.99,
        'image':
            'https://images.pexels.com/photos/65175/pexels-photo-65175.jpeg?auto=compress&cs=tinysrgb&w=600',
      }
    ],
    'Italian': [
      {
        'name': 'Pizza',
        'description': 'Wood-fired pizza',
        'calories': 600,
        'price': 14.99,
        'image':
            'https://images.pexels.com/photos/1653877/pexels-photo-1653877.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Pasta',
        'description': 'Italian pasta with sauce',
        'calories': 450,
        'price': 12.99,
        'image':
            'https://images.pexels.com/photos/1437267/pexels-photo-1437267.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Lasagna',
        'description': 'Layered lasagna with cheese',
        'calories': 550,
        'price': 13.99,
        'image':
            'https://images.pexels.com/photos/4079522/pexels-photo-4079522.jpeg?auto=compress&cs=tinysrgb&w=600',
      }
    ],
    'Mexican': [
      {
        'name': 'Tacos',
        'description': 'Tasty tacos with fillings',
        'calories': 300,
        'price': 8.99,
        'image':
            'https://images.pexels.com/photos/2338015/pexels-photo-2338015.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Burrito',
        'description': 'Hearty burrito with beans',
        'calories': 500,
        'price': 9.99,
        'image':
            'https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Quesadilla',
        'description': 'Cheesy quesadilla with salsa',
        'calories': 400,
        'price': 7.99,
        'image':
            'https://images.pexels.com/photos/4676645/pexels-photo-4676645.jpeg?auto=compress&cs=tinysrgb&w=600',
      }
    ],
    'Indian': [
      {
        'name': 'Curry',
        'description': 'Spicy curry with naan',
        'calories': 600,
        'price': 10.99,
        'image':
            'https://images.pexels.com/photos/914873/pexels-photo-914873.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Biryani',
        'description': 'Fragrant rice with spices',
        'calories': 700,
        'price': 12.99,
        'image':
            'https://images.pexels.com/photos/2238010/pexels-photo-2238010.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Samosa',
        'description': 'Crunchy samosa with chutney',
        'calories': 250,
        'price': 5.99,
        'image':
            'https://images.pexels.com/photos/6063613/pexels-photo-6063613.jpeg?auto=compress&cs=tinysrgb&w=600',
      }
    ],
    'French': [
      {
        'name': 'Croissant',
        'description': 'Buttery croissant',
        'calories': 300,
        'price': 4.99,
        'image':
            'https://images.pexels.com/photos/135452/pexels-photo-135452.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Ratatouille',
        'description': 'Vegetable dish',
        'calories': 300,
        'price': 9.99,
        'image':
            'https://images.pexels.com/photos/850472/pexels-photo-850472.jpeg?auto=compress&cs=tinysrgb&w=600',
      },
      {
        'name': 'Crepes',
        'description': 'Sweet or savory crepes',
        'calories': 350,
        'price': 6.99,
        'image':
            'https://images.pexels.com/photos/3993595/pexels-photo-3993595.jpeg?auto=compress&cs=tinysrgb&w=600',
      }
    ],
  };

  @override
  Widget build(BuildContext context) {
    final foods = foodMenu[foodType] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$foodType Menu'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 1.2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final foodItem = foods[index];
          final isFavorite = favoriteFoods.contains(foodItem);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailScreen(foodItem: foodItem),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          foodItem['image'],
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => toggleFavorite(foodItem),
                        child: Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.white : Colors.red,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      foodItem['name'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteFoods;
  final Function(Map<String, dynamic>) toggleFavorite;

  FavoriteScreen({required this.favoriteFoods, required this.toggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteFoods.length,
        itemBuilder: (context, index) {
          final foodItem = favoriteFoods[index];
          return ListTile(
            leading: Image.network(foodItem['image'],
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text(foodItem['name']),
            subtitle: Text(foodItem['description']),
            trailing: GestureDetector(
              onTap: () => toggleFavorite(foodItem),
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailScreen(foodItem: foodItem),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FoodDetailScreen extends StatelessWidget {
  final Map<String, dynamic> foodItem;

  FoodDetailScreen({required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodItem['name']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(foodItem['image'], height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              foodItem['name'],
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              foodItem['description'],
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              'Calories: ${foodItem['calories']}',
              style: TextStyle(fontSize: 16, color: Colors.redAccent),
            ),
            SizedBox(height: 16),
            Text(
              '\$${foodItem['price']}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ordered ${foodItem['name']}!')),
                );
              },
              child: Text('Order'),
            ),
          ],
        ),
      ),
    );
  }
}
