import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code/qr_scanner_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrResultScreen extends StatefulWidget {

  const QrResultScreen({super.key, required this.qrCode, required this.closeScreen,});
  final String qrCode;
  final Function() closeScreen;

  @override
  State<QrResultScreen> createState() => _QrResultScreenState();
}

class _QrResultScreenState extends State<QrResultScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            widget.closeScreen();
            Navigator.pop(context);
          },icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title:  const Text(
          ' QR Scanner',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(data: widget.qrCode,size: 150,version: QrVersions.auto,),
            const Text(
              ' Scanned result',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              textAlign: TextAlign.center,
              widget.qrCode,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width-100,
              height: 48,
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.qrCode));
              }, child: const Text(
                ' Copy',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  letterSpacing: 1,
                ),
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
