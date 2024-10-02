import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

  AudioPlayer audioPlayer = AudioPlayer();
  bool primeiraExecucao = true;
  double _volume = 0.5;

  _executar() async{

    audioPlayer.setVolume(_volume);
    if ( primeiraExecucao ){
      await audioPlayer.play(AssetSource("audios/musica.mp3"));
      primeiraExecucao = false;
    } else {
      audioPlayer.resume();
    }

    /*
    String source = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-15.mp3";
    await audioPlayer.play(UrlSource(source));
    */
  }

  _pausar() async{

    await audioPlayer.pause();

  }

  _parar() async{
    await audioPlayer.stop();
    primeiraExecucao = true;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Reproduzinho sons"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Slider(
              value: _volume,
              min: 0,
              max: 1,
              divisions: 10,
              onChanged: (novoVolume){
                setState(() {
                  _volume = novoVolume;
                });
                audioPlayer.setVolume(novoVolume);
              }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/executar.png"),
                  onTap: (){
                    _executar();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/pausar.png"),
                  onTap: (){
                    _pausar();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/parar.png"),
                  onTap: (){
                    _parar();
                  },
                ),
              ),
            ],
          ),
        ],
      ),


    );
  }
}
