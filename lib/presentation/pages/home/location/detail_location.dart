import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/domain/models/episodes.dart';
import 'package:rickmorty/domain/models/location.dart';

import '../../../../constants/constants.dart';
import '../../../../domain/models/characters.dart';

class DetailLocationPage extends StatefulWidget {
  final Location location;

  DetailLocationPage({required this.location});

  @override
  State<DetailLocationPage> createState() => _DetailLocationPageState();
}

class _DetailLocationPageState extends State<DetailLocationPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          Navigator.pushNamed(context, AppConstants.homePage);
        });
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(widget.location.name!!),
          ),
          body: Column(
            children: [
              _image(context),
              _textName(),
              _textDetail(),
            ],
          )),
    );
  }

  Widget _image(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Image.network(
          "https://rickandmortyapi.com/api/character/avatar/12.jpeg",
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.50,
          fit: BoxFit.cover,
        )
      ],
    ));
  }

  Widget _textName() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Text(
        widget.location.name!,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
      ),
    );
  }

  Widget _textDetail() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Card(
              elevation: 4, // Sombra del Card para darle profundidad
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15), // Borde redondeado del Card
              ),
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: const Icon(
                            Icons.star_border_outlined,
                            size: 50,
                            color: Color.fromARGB(255, 20, 174, 252),
                          )),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Text("Tipo: ${widget.location.type}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
