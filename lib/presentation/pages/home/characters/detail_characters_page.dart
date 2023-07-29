import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/constants.dart';
import '../../../../domain/models/characters.dart';

class DetailCharactersPage extends StatefulWidget {
  final Character characterModel;

  DetailCharactersPage({required this.characterModel});

  @override
  State<DetailCharactersPage> createState() => _DetailCharactersPageState();
}

class _DetailCharactersPageState extends State<DetailCharactersPage> {
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
            title: Text(widget.characterModel.name),
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
        Container(
            child: Image.network(
          widget.characterModel.image,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.50,
          fit: BoxFit.cover,
        ))
      ],
    ));
  }

  Widget _textName() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Text(
        widget.characterModel.name.toString() +
            '  -  ' +
            widget.characterModel.species,
        style: TextStyle(
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
        borderRadius: BorderRadius.circular(15), // Borde redondeado del Card
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
                    child: widget.characterModel.gender == AppConstants.Male
                        ? const Icon(
                            Icons.male,
                            size: 50,
                            color: Color.fromARGB(255, 20, 174, 252),
                          )
                        : Icon(
                            Icons.female,
                            size: 50,
                            color: Colors.pink[200],
                          ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Genero',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ),
           Card(
      elevation: 4, // Sombra del Card para darle profundidad
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Borde redondeado del Card
      ),
      child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 253, 253, 253),
                      ),
                      child: Icon(
                        widget.characterModel.status == AppConstants.Alive
                            ? Icons.favorite
                            : widget.characterModel.status == AppConstants.Dead
                                ? Icons.cancel
                                : Icons.help,
                        color: widget.characterModel.status == AppConstants.Alive
                            ? Colors.green
                            : widget.characterModel.status == AppConstants.Dead
                                ? Colors.red
                                : Colors.grey,
                        size: 50,
                      )),
                  const SizedBox(width: 16),
                  const Text(
                    'Estado',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
