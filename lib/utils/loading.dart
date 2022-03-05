import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scs_latakia_app/utils/const.dart';

Widget imageWithLoader(String? url, BoxFit? fit) {
  try {
    if (url == null) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(MAIN_RADIUS))),
        child:
            const Icon(Icons.image_not_supported_rounded, color: Colors.grey),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(MAIN_RADIUS),
      child: CachedNetworkImage(
        imageUrl: "$ROOT/uploads/$url",
        fit: fit,
        height: double.infinity,
        width: double.infinity,
        placeholder: (context, url) => const Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  } catch (e) {
    return const Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: Icon(Icons.error),
      ),
    );
  }
}

class Loading extends StatefulWidget {
  final void Function()? action;
  const Loading({Key? key, this.action}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.action?.call();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(MAIN_MARGIN),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: MAIN_MARGIN),
            Text("Loading...", style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }
}
