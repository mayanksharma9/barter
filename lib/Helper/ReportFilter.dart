import 'package:flutter/cupertino.dart';

class ReportFilter extends StatefulWidget {
  @override
  _ReportFilterState createState() => _ReportFilterState();
}

class _ReportFilterState extends State<ReportFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 24, left: 24, top: 32, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Filter",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "your search",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),

              ],
            ),


            SizedBox(
              height: 16,
            ),
            Text(
              "Report",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Hide",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),

          ],
        ),
    );
  }
}
