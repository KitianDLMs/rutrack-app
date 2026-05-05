import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:localdriver/src/presentation/pages/client/mp/aprobado.dart';
import 'package:localdriver/src/presentation/pages/client/mp/pendiente.dart';
import 'package:localdriver/src/presentation/pages/client/mp/rechazado.dart';

class PagoPage extends StatefulWidget {
  static const String routename = 'client/mp/pago';
  final String? url;
  const PagoPage({super.key, this.url});

  @override
  State<PagoPage> createState() => _PagoPageState();
}

class _PagoPageState extends State<PagoPage> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: WebUri("${widget.url}")),
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                print('pagopage url $url');
                if (url.toString().contains(
                    "https://pedidos-huertos-estado-de-pago.netlify.app/approved")) {
                  webViewController?.goBack();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AprobadoPage()),
                  );
                  return;
                } else if (url.toString().contains(
                    "https://pedidos-huertos-estado-de-pago.netlify.app/refused")) {
                  webViewController?.goBack();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RechazadoPage()),
                  );
                  return;
                } else if (url.toString().contains(
                    "https://pedidos-huertos-estado-de-pago.netlify.app/pending")) {
                  webViewController?.goBack();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PendientePage()),
                  );
                }
              })
        ],
      ),
    ));
  }
}
