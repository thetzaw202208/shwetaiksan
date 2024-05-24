import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/provider/two_d_provider.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

class ReadyMade2D extends StatelessWidget {
  const ReadyMade2D({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                size: 30,
              ))
        ],
      ),
      body: Consumer<TwoDProvider>(
        builder: (context, data, _) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SizedBox(
                  height: 150,
                  child: GridView.builder(
                      itemCount: data.readyMadeTitle.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2.5),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            data.selectReadyMade(index);


                          },
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 70,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: data.selectedReadyMade==index ?yellowColor:whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                //border: Border.all(color: Colors.black)
                              ),
                              child: Center(
                                  child: Text(data.readyMadeTitle[index])),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 50,
                ),
                if (data.selectedReadyMade==1||data.selectedReadyMade==2||data.selectedReadyMade==5)
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                        itemCount: data.numbers.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              data.selectedReadyMade==1?
                              data.selectPrefix(index):data.selectedReadyMade==2?
                              data.selectSuffix(index):data.selectPT(index);
                            },
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 70,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 3,
                                        color:
                                        data.selectedReadyMade==1? ((data.selectedPrefixNumber == index)
                                            ? yellowColor
                                            : Colors.white): data.selectedReadyMade==2? ((data.selectedSuffixNumber== index)
                                            ? yellowColor
                                            : Colors.white): ((data.selectedPTNumber == index)
                                                ? yellowColor
                                                : Colors.white))),
                                child: Center(child: Text("$index")),
                              ),
                            ),
                          );
                        }),
                  )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Consumer<TwoDProvider>(
        builder: (context,data,_)=>
         Padding(
          padding: EdgeInsets.all(10),
          child:  GestureDetector(
            onTap: (){
              if(data.selectedReadyMade!=null) {
                Navigator.pop(context);
              }else{
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: 'ဝမ်းနည်းပါတယ်',
                  desc: 'အနည်းဆုံးတစ်ခုရွေးချယ် ရပါမည်',

                  btnOkText: "ဝင်မည်",

                  btnOkOnPress: () {

                  },
                ).show();
              }
            },
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 10,
              child: Container(

                height: 40,
                width: MediaQuery.of(context).size.width*.2,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 196, 64),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                      "သေချာပါသည်",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
