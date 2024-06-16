import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:marketing_apps/data/data.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String selectedFilterLocation = "";
  String selectedFilterQuery = "";
  String searchQuery = "";
  List<Map<String, dynamic>> filteredHistory = [];
  List<Map<String, dynamic>> selectedFilter = [];
  List<Map<String, dynamic>> selectedLocation = [];

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    filteredHistory = historyData;
    selectedFilter = historyData;
  }

  // Search Logic
  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredHistory = historyData
          .where((item) =>
              item['proyek']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item['location']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  // Filter Logic Proyek
  void updateSelectedFilter(String filter) {
    setState(() {
      selectedFilterQuery = filter;
      filteredHistory = filter.isEmpty
          ? historyData
          : historyData
              .where((item) => item['proyek'].contains(filter))
              .toList();
    });
  }

  // Filter Logic Location
  void updateSelectedLocation(String filter) {
    setState(() {
      selectedFilterLocation = filter;
      filteredHistory = filter.isEmpty
          ? historyData
          : historyData
              .where((item) => item['location'].contains(filter))
              .toList();
    });
  }

  // Update Range Filter Date
  void updateDateRangeFilter() {
    setState(() {
      filteredHistory = historyData.where((item) {
        DateTime itemDate = DateFormat('dd/MM/yyyy').parse(item['date']);
        if (startDate != null && itemDate.isBefore(startDate!)) {
          return false;
        }
        if (endDate != null && itemDate.isAfter(endDate!)) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  // Filter Date
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2101);

    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
        updateDateRangeFilter();
      });
    }
  }

  // Reset Filter Logic
  void resetFilter() {
    setState(() {
      selectedFilterQuery = "";
      selectedFilterLocation = "";
      filteredHistory = historyData;
      selectedLocation = historyData;
      startDate = null;
      endDate = null;
    });
  }

  // Open Google Maps
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
              padding: const EdgeInsets.only(left: 100),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'History',
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
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 11,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Search
                Expanded(
                  child: TextField(
                    onChanged: updateSearchQuery,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),

                // Filter
                Container(
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: ((context) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.8,
                            minChildSize: 0.1,
                            maxChildSize: 1.0,
                            expand: false,
                            builder: ((context, scrollController) {
                              return Container(
                                padding: EdgeInsets.only(
                                  top: 16,
                                  left: 16,
                                  right: 16,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: ListView(
                                  controller: scrollController,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Filter',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF5F5E5E),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: resetFilter,
                                          child: Text(
                                            'Reset',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF5F5E5E),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Filter Proyek
                                    Text(
                                      'Proyek',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF5F5E5E),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  updateSelectedFilter('MRT'),
                                              child: Container(
                                                width: 70,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: selectedFilterQuery ==
                                                          'MRT'
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'MRT',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            selectedFilterQuery ==
                                                                    'MRT'
                                                                ? Colors.white
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  updateSelectedFilter('KRL'),
                                              child: Container(
                                                width: 70,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: selectedFilterQuery ==
                                                          'KRL'
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'KRL',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            selectedFilterQuery ==
                                                                    'KRL'
                                                                ? Colors.white
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  updateSelectedFilter('LRT'),
                                              child: Container(
                                                width: 70,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: selectedFilterQuery ==
                                                          'LRT'
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'LRT',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            selectedFilterQuery ==
                                                                    'LRT'
                                                                ? Colors.white
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  updateSelectedFilter('BRT'),
                                              child: Container(
                                                width: 70,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: selectedFilterQuery ==
                                                          'BRT'
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'BRT',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            selectedFilterQuery ==
                                                                    'BRT'
                                                                ? Colors.white
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Filter Lokasi
                                    Text(
                                      'Lokasi',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF5F5E5E),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),

                                    // Filter Location
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  updateSelectedLocation(
                                                      'Jakarta'),
                                              child: Container(
                                                width: 100,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color:
                                                      selectedFilterLocation ==
                                                              'Jakarta'
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                          : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Jakarta',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            selectedFilterLocation ==
                                                                    'Jakarta'
                                                                ? Colors.white
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  updateSelectedLocation(
                                                      'Jawa Barat'),
                                              child: Container(
                                                width: 100,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color:
                                                      selectedFilterLocation ==
                                                              'Jawa Barat'
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                          : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Jawa Barat',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            selectedFilterLocation ==
                                                                    'Jawa Barat'
                                                                ? Colors.white
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  updateSelectedLocation(
                                                      'Tangerang'),
                                              child: Container(
                                                width: 100,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color:
                                                      selectedFilterLocation ==
                                                              'Tangerang'
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                          : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Tangerang',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            selectedFilterLocation ==
                                                                    'Tangerang'
                                                                ? Colors.white
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  updateSelectedLocation(
                                                      'Bogor'),
                                              child: Container(
                                                width: 100,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color:
                                                      selectedFilterLocation ==
                                                              'Bogor'
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                          : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Bogor',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            selectedFilterLocation ==
                                                                    'Bogor'
                                                                ? Colors.white
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Periode',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF5F5E5E),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Periode Awal',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF5F5E5E),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Periode Akhir',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF5F5E5E),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    // Filter Periode
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  _selectDate(context, true),
                                              child: AbsorbPointer(
                                                child: TextField(
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Periode Awal',
                                                    hintText: 'dd/mm/yyyy',
                                                    prefixIcon: Icon(
                                                        Icons.calendar_today),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  controller:
                                                      TextEditingController(
                                                    text: startDate != null
                                                        ? DateFormat(
                                                                'dd/MM/yyyy')
                                                            .format(startDate!)
                                                        : '',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  _selectDate(context, false),
                                              child: AbsorbPointer(
                                                child: TextField(
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Periode Akhir',
                                                    hintText: 'dd/mm/yyyy',
                                                    prefixIcon: Icon(
                                                        Icons.calendar_today),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  controller:
                                                      TextEditingController(
                                                    text: endDate != null
                                                        ? DateFormat(
                                                                'dd/MM/yyyy')
                                                            .format(endDate!)
                                                        : '',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        }),
                      );
                    },
                    icon: Image.asset(
                      'assets/icons/filter-icon.png',
                      width: 24,
                      height: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ListView Card History
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = filteredHistory[index];
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 11),
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
                itemCount: filteredHistory.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
