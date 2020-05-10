import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:corona_details/data/CoronaDetailsData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsListViewBuilder {



  Widget detailsList(Set<CoronaDetailsData> list) {

    return  Flexible(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Stack(
              children: <Widget>[
                Card(
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            list.elementAt(index).countryFlag.flag),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Country',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    child: Text(
                                        list
                                            .elementAt(index)
                                            .country
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20)),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Today Cases',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    child: Text(
                                        list
                                            .elementAt(index)
                                            .newCases
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20)),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Total Cases',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    child: Text(
                                        list
                                            .elementAt(index)
                                            .totalCases
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20)),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Recovered',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    child: Text(
                                        list
                                            .elementAt(index)
                                            .recovered
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20)),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Tests',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    child: Text(
                                        list.elementAt(index).tests.toString(),
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
