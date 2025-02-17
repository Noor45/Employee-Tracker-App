import 'package:flutter/material.dart';

   class NotificationCard extends StatefulWidget{
    final String? title;
      final String? subtitle;
      final String? trailing;
      final Image? image;

  const NotificationCard({
  Key?key,
      this.title,  this.subtitle,  this.trailing, this.image
    }): super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
     @override
     Widget build(BuildContext context) {
      
       return  Card(
                    color: Colors.white,
                    child: ListTile( 
                     leading:widget.image!,
                     title: Text(widget.title!),
                     subtitle: Text(widget.subtitle!),
                     trailing: Text(widget.trailing!),
                     
                    ),
                    
                    
                  ); 
            
       
     }
}