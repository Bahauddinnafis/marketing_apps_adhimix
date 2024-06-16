import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketing_apps/screens/history.dart';
import 'package:marketing_apps/data/data.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketingMain extends StatefulWidget {
  const MarketingMain({super.key});

  @override
  State<MarketingMain> createState() => _MarketingMainState();
}

class _MarketingMainState extends State<MarketingMain> {
  // Open Maps
  Future<void> launchMap(String address) async {
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Tidak bisa menampilkan $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    // // Get User Location
    // Position? _currentLocatio;
    // late bool servicePermission = false;
    // late LocationPermission permission;

    // String _currentAddress = "";

    // Future<Position> _getCurrentLocation() async {
    //   servicePermission = await Geolocator.isLocationServiceEnabled();
    //   if (!servicePermission) {
    //     permission = await Geolocator.checkPermission();
    //   }

    //   return await Geolocator.getCurrentPosition();
    // }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(top: 20, left: 15),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  iconSize: 24,
                  padding: const EdgeInsets.only(left: 10),
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Marketing',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            flexibleSpace: Stack(
              children: [
                const Image(
                  image: AssetImage('assets/images/adhimix_truck.jpg'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Card User
          Center(
            heightFactor: 1.5,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: const Image(
                    image: AssetImage('assets/images/product_readymix.jpg'),
                    fit: BoxFit.cover,
                    width: 328,
                    height: 184,
                  ),
                ),
                Container(
                  width: 328,
                  height: 184,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 13, left: 8),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Informasi Pengguna',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                            Text(
                              'Nafis',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Penugasan',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                            Text(
                              'Plant Cibubur',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tanggal',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                            Text(
                              '16-05-2024',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tagging Sales
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(
                        child: Text(
                          'Form',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: const Color(0xFFEB0009),
                                hintText: 'Pelanggan',
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: const Color(0xFFEB0009),
                                hintText: 'Proyek',
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 68,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFEB0009),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Save',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(328, 30),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFFEB0009),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
              ),
              child: Text(
                'Tagging Sales',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 33, 16, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'History',
                    style: GoogleFonts.poppins(
                      textStyle:
                          const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'View All',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ListView Card History
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = historyData[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      width: 339,
                      height: 147,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['proyek'],
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    launchMap(item['location']);
                                  },
                                  icon: const Icon(
                                    FeatherIcons.map,
                                    size: 20,
                                  ),
                                  iconSize: 20,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'NAFIS',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.apartment,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'Plant Cibubur',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  item['date'],
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            child: Row(
                              children: [
                                const Icon(
                                  FeatherIcons.mapPin,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    item['location'],
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: 69,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF45B64A)
                                        .withOpacity(0.3),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      item['periode_awal'],
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 8,
                                          color: Color(0xFF45B64A),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 21,
                                ),
                                Container(
                                  width: 69,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEB0009)
                                        .withOpacity(0.3),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Center(
                                      child: Text(
                                        item['periode_akhir'],
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 8,
                                            color: Color(0xFFEB0009),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
