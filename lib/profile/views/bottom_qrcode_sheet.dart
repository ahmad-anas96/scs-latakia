import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanner extends StatefulWidget {
  final Function(Barcode?) onScanComplete;
  const QrCodeScanner({Key? key, required this.onScanComplete})
      : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QRCODE');
  Barcode? result;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _showScanner,
      icon: Icon(
        Icons.qr_code_scanner_rounded,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var i = MediaQuery.of(context).size.width * 0.85;
    return SizedBox(
      height: i,
      child: InkWell(
        onTap: () => controller?.resumeCamera(),
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              overlayColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).colorScheme.primary,
              borderRadius: 10,
              borderLength: 50,
              borderWidth: 10,
              cutOutSize: i - 70),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
      ),
    );
  }

  _showScanner() => showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
          child: _buildQrView(context),
        ),
      );

  _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.pauseCamera();
      Navigator.pop(context);
      widget.onScanComplete(result);
    });
  }

  _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      AppSettings.openAppSettings();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
