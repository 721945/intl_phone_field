import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/helpers.dart';

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;

  CountryPickerDialog({
    Key? key,
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  }) : super(key: key);

  @override
  _CountryPickerDialogState createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select country'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              cursorColor: widget.style?.searchFieldCursorColor,
              decoration: widget.style?.searchFieldInputDecoration ??
                  InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: widget.searchText,
                  ),
              onChanged: (value) {
                _filteredCountries = isNumeric(value)
                    ? widget.countryList
                        .where((country) => country.dialCode.contains(value))
                        .toList()
                    : widget.countryList
                        .where((country) => country.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                if (this.mounted) setState(() {});
              },
            ),
          ),
          // Column(
          //   children: [
          //     Text(
          //       'Current country',
          //     ),
          //     ListTile(
          //       leading: ClipOval(
          //         child: Image.asset(
          //           'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
          //           package: 'intl_phone_field',
          //           width: 20,
          //           height: 20,
          //         ),
          //       ),
          //       contentPadding: widget.style?.listTilePadding,
          //       title: Text(
          //         _selectedCountry.name,
          //         style: widget.style?.countryNameStyle ??
          //             TextStyle(fontWeight: FontWeight.w700),
          //       ),
          //       trailing: Text(
          //         '+${_selectedCountry.dialCode}',
          //         style: widget.style?.countryCodeStyle ??
          //             TextStyle(fontWeight: FontWeight.w700),
          //       ),
          //       onTap: () {
          //         _selectedCountry = _selectedCountry;
          //         widget.onCountryChanged(_selectedCountry);
          //         Navigator.of(context).pop();
          //       },
          //     ),
          //   ],
          // ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredCountries.length,
              itemBuilder: (ctx, index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: ClipOval(
                      child: Image.asset(
                        'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
                        package: 'intl_phone_field',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    contentPadding: widget.style?.listTilePadding,
                    title: Text(
                      _filteredCountries[index].name,
                      style: widget.style?.countryNameStyle ??
                          TextStyle(fontWeight: FontWeight.w700),
                    ),
                    trailing: Text(
                      '+${_filteredCountries[index].dialCode}',
                      style: widget.style?.countryCodeStyle ??
                          TextStyle(fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      _selectedCountry = _filteredCountries[index];
                      widget.onCountryChanged(_selectedCountry);
                      Navigator.of(context).pop();
                    },
                  ),
                  widget.style?.listTileDivider ?? Divider(thickness: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  // final mediaWidth = MediaQuery.of(context).size.width;
  // final width = widget.style?.width ?? mediaWidth;
  // final defaultHorizontalPadding = 40.0;
  // final defaultVerticalPadding = 24.0;
  //   return Dialog(
  //     insetPadding: EdgeInsets.symmetric(
  //         vertical: defaultVerticalPadding,
  //         horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
  //             ? (mediaWidth - width) / 2
  //             : defaultHorizontalPadding),
  //     backgroundColor: widget.style?.backgroundColor,
  //     child: Container(
  //       padding: widget.style?.padding ?? EdgeInsets.all(10),
  //       child: Column(
  //         children: <Widget>[
  //           Padding(
  //             padding: widget.style?.searchFieldPadding ?? EdgeInsets.all(0),
  //             child: TextField(
  //               cursorColor: widget.style?.searchFieldCursorColor,
  //               decoration: widget.style?.searchFieldInputDecoration ??
  //                   InputDecoration(
  //                     suffixIcon: Icon(Icons.search),
  //                     labelText: widget.searchText,
  //                   ),
  //               onChanged: (value) {
  //                 _filteredCountries = isNumeric(value)
  //                     ? widget.countryList
  //                         .where((country) => country.dialCode.contains(value))
  //                         .toList()
  //                     : widget.countryList
  //                         .where((country) => country.name
  //                             .toLowerCase()
  //                             .contains(value.toLowerCase()))
  //                         .toList();
  //                 if (this.mounted) setState(() {});
  //               },
  //             ),
  //           ),
  //           SizedBox(height: 20),
  //           Expanded(
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: _filteredCountries.length,
  //               itemBuilder: (ctx, index) => Column(
  //                 children: <Widget>[
  //                   ListTile(
  //                     leading: Image.asset(
  //                       'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
  //                       package: 'intl_phone_field',
  //                       width: 32,
  //                     ),
  //                     contentPadding: widget.style?.listTilePadding,
  //                     title: Text(
  //                       _filteredCountries[index].name,
  //                       style: widget.style?.countryNameStyle ??
  //                           TextStyle(fontWeight: FontWeight.w700),
  //                     ),
  //                     trailing: Text(
  //                       '+${_filteredCountries[index].dialCode}',
  //                       style: widget.style?.countryCodeStyle ??
  //                           TextStyle(fontWeight: FontWeight.w700),
  //                     ),
  //                     onTap: () {
  //                       _selectedCountry = _filteredCountries[index];
  //                       widget.onCountryChanged(_selectedCountry);
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                   widget.style?.listTileDivider ?? Divider(thickness: 1),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
