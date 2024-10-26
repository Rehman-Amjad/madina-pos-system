
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controller/MenuAppController.dart';
import '../../../provider/text_color_provider.dart';
import '../../../responsive.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.index,
    required this.screenIndex,
    required this.title,
    required this.svgSrc,
  //  required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final int index,screenIndex;
 // final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final textColorProvider = Provider.of<TextColorProvider>(context,listen: false);
    print("Tiles Builder");
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20),
      child: Consumer<TextColorProvider>(
          builder: (context,value,child){
            return MouseRegion(
              onHover: (_) {
                textColorProvider.setHoveredIndex(index);
                // textColorProvider.changeTextColor(hoverColor); // Change color on hover
              },
              onExit: (_) {
                textColorProvider.setHoveredIndex(-1); // Change color when not hovering
                //  textColorProvider.changeTextColor(Colors.black); // Change color when not hovering
              },
              child: InkWell(
                  onTap: (){
                    textColorProvider.setActiveIndex(index);
                    Provider.of<MenuAppController>(context, listen: false)
                        .changeScreen(screenIndex);
                    if(Responsive.isMobile(context)){
                      Navigator.pop(context);
                    }
                  },
                  // hoverColor: Colors.redAccent.shade100,
                  child: ListTile(
                      horizontalTitleGap: 0.0,
                      leading: SvgPicture.asset(
                        svgSrc,
                        colorFilter: ColorFilter.mode(textColorProvider.activeIndex == index ? hoverColor :
                        textColorProvider.hoveredIndex == index ? hoverColor : Colors.white
                            , BlendMode.srcIn),
                        height: 16,
                      ),
                      title: Text(
                        title,
                        style: TextStyle(color:
                        textColorProvider.activeIndex == index
                            ? hoverColor // Change color when actively selected
                            : (textColorProvider.hoveredIndex == index
                            ? hoverColor // Change color on hover
                            : Colors.white),fontWeight: FontWeight.bold,fontSize: 15
                        ),
                      )
                  )
              ),
            );
          }
      )
    );
  }
}