import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code/qr_result_screen.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

const bgColor = Color(0xfffafafa);

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();
  void closeScreen() {
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            setState(() {
              isFlashOn = !isFlashOn;
            });
            controller.toggleTorch();
          }, icon: Icon(Icons.flash_on,color:isFlashOn? Colors.blue: Colors.grey,)),
          IconButton(onPressed: () {
            setState(() {
              isFrontCamera = !isFrontCamera;
            });
            controller.switchCamera();
          }, icon: Icon(Icons.camera_front,color:isFrontCamera? Colors.blue: Colors.grey,))
        ],
        centerTitle: true,
        title: const Text(
          ' QR Scanner',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Place the QR Code in the area',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Scanning will be started automatically',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: controller,

                      onDetect: (barcodes) {
                        String code = barcodes.barcodes.first.rawValue ?? '___';
                       setState(() {
                         isScanCompleted = true;
                       });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QrResultScreen(
                              qrCode: code,closeScreen: closeScreen,
                            ),
                          ),
                        ).then((_) => closeScreen());
                      },
                    ),
                    QRScannerOverlay(
                      overlayColor: bgColor,
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Developed by Mita Paju',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
