import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> promotionList(List<String> promotionImageFiles) => [
      Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 15),
        child: Text(
          "Promotions",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...promotionImageFiles
                .map((promotion) => Container(
                      width: 240,
                      height: 160,
                      margin: EdgeInsets.only(
                          left:
                              promotion == promotionImageFiles.first ? 24 : 10,
                          right:
                              promotion == promotionImageFiles.last ? 24 : 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage(promotion), fit: BoxFit.cover)),
                    ))
                .toList()
          ],
        ),
      )
    ];
