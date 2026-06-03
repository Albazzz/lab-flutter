import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSF0d5_qEHcfoEqktSqJIcPUUJaGjZyDcz9A&s', // Ảnh mẫu đẹp
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            // Tên và Chức danh
            const Text(
              'Phan Công Huy',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                letterSpacing: 1.5,
              ),
            ),
            const Text(
              'Flutter Developer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Divider(thickness: 0.8),
            ),
            _buildInfoCard(
              context,
              icon: Icons.person_outline,
              title: 'Tuổi',
              content: '22 tuổi',
            ),
            _buildInfoCard(
              context,
              icon: Icons.cake_outlined,
              title: 'Ngày sinh',
              content: '03 tháng 11, 2004',
            ),
            _buildInfoCard(
              context,
              icon: Icons.email_outlined,
              title: 'Email',
              content: 'huyphw2@gmail.com',
            ),
            _buildInfoCard(
              context,
              icon: Icons.phone_android_outlined,
              title: 'Số điện thoại',
              content: '+84 123 456 789',
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Liên hệ với tôi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget _buildInfoCard(BuildContext context,
      {required IconData icon, required String title, required String content}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo, size: 28),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
