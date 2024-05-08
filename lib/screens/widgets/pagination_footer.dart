import 'package:flutter/material.dart';
import 'package:monipleapp/constants.dart';

const List<String> perPageList = <String>['10', '25', '50', '100'];

class PaginationFooter extends StatelessWidget {
  const PaginationFooter(
      {Key? key,
      required this.list,
      required this.currentPage,
      required this.currentPerPage,
      required this.onPageSize,
      required this.onNext,
      required this.onPrevious})
      : super(key: key);

  final List<dynamic>? list;
  final int currentPage;
  final int currentPerPage;
  final Function onNext;
  final Function onPrevious;
  final Function onPageSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            /* PAGINATION CONTROLS */
            Row(
              children: [
                /* ROWS PER PAGE */
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 64),
                      child: DropdownButtonFormField<String>(
                        value: currentPerPage.toString(),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1),
                          ),
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        style: const TextStyle(fontSize: 14),
                        onChanged: (String? value) {
                          onPageSize(value);
                        },
                        items: perPageList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ],
            ),

            /* CURRENT PAGE ELEMENTS */
            Text(
                "$currentPage / ${list!.length > currentPerPage ? (list!.length / currentPerPage).ceil() : 1}"),
            /* PAGE BUTTONS */
            SizedBox(
                child: Row(
              children: [
                IconButton(
                    tooltip: "Previous",
                    splashRadius: 20,
                    icon: const Icon(Icons.keyboard_arrow_left_rounded,
                        color: primaryColor),
                    onPressed: () => onPrevious()),
                const SizedBox(width: 16),
                IconButton(
                    tooltip: "Next",
                    splashRadius: 20,
                    icon: const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: primaryColor,
                    ),
                    onPressed: () => onNext())
              ],
            )),
          ])),
    );
  }
}
