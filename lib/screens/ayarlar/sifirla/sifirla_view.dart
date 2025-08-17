import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/kisi_provider.dart';
import '../../../providers/mesaj_listesi_provider.dart';

class SifirlaView extends StatelessWidget {
  const SifirlaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.settings_rounded,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Ayarlar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.delete_sweep, color: Colors.white),
              title: const Text('Geçmişi Sıfırla',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(
                'Tüm gönderim geçmişini sıfırlayın',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 12.6),
              ),
              trailing:
                  const Icon(Icons.radio_button_unchecked, color: Colors.white),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.blueGrey.withOpacity(0.8),
                    title: const Text(
                      'Emin misiniz?',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      'Geçmiş verileriniz kalıcı olarak silinecektir.',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'İptal',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await Provider.of<MesajListesiProvider>(context,
                                    listen: false)
                                .gecmisiSifirla();
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('Geçmiş başarıyla sıfırlandı'),
                                  backgroundColor:
                                      Colors.blueGrey.withOpacity(0.8),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Geçmiş sıfırlanırken hata oluştu'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueGrey.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Sıfırla',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Divider(color: Colors.white.withOpacity(0.3)),
            ListTile(
              leading: const Icon(Icons.contact_page, color: Colors.white),
              title: const Text('Rehberi Sıfırla',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(
                'Tüm kayıtlı kişileri sıfırlayın',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 12.6),
              ),
              trailing:
                  const Icon(Icons.radio_button_unchecked, color: Colors.white),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.blueGrey.withOpacity(0.8),
                    title: const Text(
                      'Emin misiniz?',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      'Rehber bilgileriniz kalıcı olarak silinecektir.',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'İptal',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await Provider.of<KisiProvider>(context,
                                    listen: false)
                                .rehberiSifirla();
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('Rehber başarıyla sıfırlandı'),
                                  backgroundColor:
                                      Colors.blueGrey.withOpacity(0.8),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Rehber sıfırlanırken hata oluştu'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueGrey.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Sıfırla',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Divider(color: Colors.white.withOpacity(0.3)),
            ListTile(
              leading: const Icon(Icons.restore, color: Colors.white),
              title: const Text('Uygulamayı Sıfırla',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(
                'Tüm veriler ve planlamalar sıfırlanır',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 12.6),
              ),
              trailing:
                  const Icon(Icons.radio_button_unchecked, color: Colors.white),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.blueGrey.withOpacity(0.8),
                    title: const Text(
                      'Emin misiniz?',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      'Tüm uygulama verileri kalıcı olarak silinecektir.',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'İptal',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final kisiProvider =
                              Provider.of<KisiProvider>(context, listen: false);
                          final mesajProvider =
                              Provider.of<MesajListesiProvider>(context,
                                  listen: false);

                          try {
                            await kisiProvider.rehberiSifirla();
                            await mesajProvider.gecmisiSifirla();
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Uygulama başarıyla sıfırlandı'),
                                  backgroundColor:
                                      Colors.blueGrey.withOpacity(0.8),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Uygulama sıfırlanırken hata oluştu'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueGrey.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Sıfırla',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
