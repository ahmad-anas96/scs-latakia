import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scs_latakia_app/home/models/course_model.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DownloadCertificateWidget extends StatefulWidget {
  final String certificate;
  final CourseModel course;
  const DownloadCertificateWidget(
      {Key? key, required this.certificate, required this.course})
      : super(key: key);

  @override
  State<DownloadCertificateWidget> createState() =>
      _DownloadCertificateWidgetState();
}

class _DownloadCertificateWidgetState extends State<DownloadCertificateWidget> {
  @override
  void initState() {
    super.initState();
    FlutterDownloader.registerCallback(_downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void _downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  Future<bool> _checkPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: MAIN_MARGIN),
      child: ElevatedButton.icon(
        onPressed: () async {
          if (await _checkPermission()) {
            final dir = await getApplicationDocumentsDirectory();
            await FlutterDownloader.enqueue(
              url:
                  "$ROOT/certificates/${widget.course.id}/${widget.certificate}",
              fileName: "${widget.course.title} ${widget.certificate}",
              savedDir: dir.path,
              showNotification: true,
              saveInPublicStorage: true,
              openFileFromNotification: true,
            );
          }
        },
        icon: const Icon(Icons.download_rounded),
        label: Text("${AppLocalizations.of(context)?.downloadCertificate}"),
      ),
    );
  }
}
