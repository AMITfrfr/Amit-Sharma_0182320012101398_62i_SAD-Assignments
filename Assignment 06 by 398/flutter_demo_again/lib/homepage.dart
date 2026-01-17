import 'package:flutter/material.dart';
import 'profilepage.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage"), backgroundColor: Colors.blueGrey),
      endDrawer: NavigationDrawer(
        children: [
          DrawerHeader(
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              accountName: Text("Name"),
              accountEmail: Text("Email"),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.home),
            title: Text("Homepage"),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Image.asset("assets/images/flutter.png", height: 200, width: 200),
          Text(
            "Flutter Project",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: Colors.blueGrey,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfilePage();
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    fixedSize: Size(150, 40),
                  ),
                  child: Text("Profile Page"),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text("About")),
              SizedBox(width: 20),
              OutlinedButton(onPressed: () {}, child: Text("More Options")),
              TextButton(onPressed: () {}, child: Text("Exit")),
            ],
          ),
        ],
      ),
    );
  }
}