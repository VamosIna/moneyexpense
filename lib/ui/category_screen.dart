import 'package:flutter/material.dart';

class CategoryBottomSheet extends StatelessWidget {
  final void Function(String) onCategorySelected;

  CategoryBottomSheet({required this.onCategorySelected});

  final List<String> categories = [
    'Makanan',
    'Internet',
    'Transport',
    'Edukasi',
    'Belanja',
    'Hiburan',
    'Alat Rumah',
    'Olahraga',
    'Hadiah'
  ];

  Widget _getIconForCategory(String category) {
    switch (category) {
      case 'Makanan':
        return Image.asset('assets/icons/ic_makanan.png', scale: 1.5);
      case 'Internet':
        return Image.asset('assets/icons/ic_internet.png', scale: 1.5);
      case 'Transport':
        return Image.asset('assets/icons/ic_transport.png', scale: 1.5);
      case 'Edukasi':
        return Image.asset('assets/icons/ic_edukasi.png', scale: 1.5);
      case 'Belanja':
        return Image.asset('assets/icons/ic_belanja.png', scale: 1.5);
      case 'Hiburan':
        return Image.asset('assets/icons/ic_hiburan.png', scale: 1.5);
      case 'Alat Rumah':
        return Image.asset('assets/icons/ic_alatrumah.png', scale: 1.5);
      case 'Olahraga':
        return Image.asset('assets/icons/ic_olahraga.png', scale: 1.5);
      case 'Hadiah':
        return Image.asset('assets/icons/ic_hadiah.png', scale: 1.5);
      default:
        return Image.asset('assets/icons/ic_default.png', scale: 1.5); // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         Align(
           alignment: Alignment.centerLeft,
           child:  Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(
                 'Pilih Kategori',
                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
               ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close)
              )
             ],
           ),
         ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Jumlah kolom dalam grid
                crossAxisSpacing: 8.0, // Jarak antar kolom
                mainAxisSpacing: 8.0, // Jarak antar baris
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onCategorySelected(categories[index]);
                    Navigator.pop(context);
                  },
                  child: GridTile(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _getIconForCategory(categories[index]),
                          SizedBox(height: 2.0),
                          Text(
                            categories[index],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
