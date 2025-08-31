import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({Key? key}) : super(key: key);

  @override
  _ItineraryScreenState createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  final List<Map<String, String>> _itinerary = [];
  final _placeController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  void _addItinerary() {
    if (_placeController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _timeController.text.isNotEmpty) {
      setState(() {
        _itinerary.add({
          "place": _placeController.text,
          "date": _dateController.text,
          "time": _timeController.text,
        });
      });
      _placeController.clear();
      _dateController.clear();
      _timeController.clear();
    }
  }

  Future<void> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Jharkhand Tourism Itinerary",
                style: pw.TextStyle(
                    fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            ..._itinerary.map((item) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Text(
                    "📍 ${item['place']} | 📅 ${item['date']} | ⏰ ${item['time']}",
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                )),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Itinerary Generator"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00c6ff), Color(0xFF0072ff)],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _placeController,
              decoration: const InputDecoration(
                labelText: "Place",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: "Date (DD/MM/YYYY)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: "Time",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _addItinerary,
              icon: const Icon(Icons.add),
              label: const Text("Add Itinerary"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _itinerary.length,
                itemBuilder: (context, index) {
                  final item = _itinerary[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.blue),
                      title: Text(item['place'] ?? ''),
                      subtitle: Text("${item['date']} - ${item['time']}"),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: _generatePDF,
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("Generate PDF"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
