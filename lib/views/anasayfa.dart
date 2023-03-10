import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kisiler2_uygulamasi/entity/kisiler.dart';
import 'package:kisiler2_uygulamasi/views/kisi_detay_sayfa.dart';
import 'package:kisiler2_uygulamasi/views/kisi_kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  Future<List<Kisiler>> tumKisileriGoster() async {
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: 1, kisi_ad: "Ahmet", kisi_tel: "1111");
    var k2 = Kisiler(kisi_id: 2, kisi_ad: "Zeynep", kisi_tel: "2222");
    var k3 = Kisiler(kisi_id: 3, kisi_ad: "Beyza", kisi_tel: "3333");

    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);
    return kisilerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
                decoration: const InputDecoration(hintText: "Ara"),
                onChanged: (aramasonucu) {
                  print("Arama Sonucu");
                },
              )
            : const Text("Kişiler"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: (() {
                    setState(() {
                      aramaYapiliyorMu = false;
                    });
                  }),
                  icon: const Icon(Icons.search))
              : IconButton(
                  onPressed: (() {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  }),
                  icon: const Icon(Icons.cancel),
                ),
        ],
      ),
      body: FutureBuilder<List<Kisiler>>(
          future: tumKisileriGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var kisilerListesi = snapshot.data;
              return ListView.builder(
                itemCount: kisilerListesi!.length,
                itemBuilder: (context, index) {
                  var kisi = kisilerListesi[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      KisiDetaySayfa(kisi: kisi)))
                          .then((value) => {print("Anasayfaya Dönüldü")});
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("${kisi.kisi_ad}. -  ${kisi.kisi_tel}"),
                            const Spacer(),
                            IconButton(
                                onPressed: (() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("${kisi.kisi_ad} silinsin mi?"),
                                      action: SnackBarAction(
                                        label: "EVET",
                                        onPressed: () {
                                          print("Kişi sil : ${kisi.kisi_id}");
                                        },
                                      ),
                                    ),
                                  );
                                }),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.black54,
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KisiKayitSayfa(),
              )).then((value) => {print("Anasayfaya Dönüldü")});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
