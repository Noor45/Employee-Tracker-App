import 'package:office_orbit/cards/appbar_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import '../../utils/colors.dart';
import 'apply_leave.dart';

class LeaveDetail extends StatefulWidget {
  const LeaveDetail({super.key});

  @override
  State<LeaveDetail> createState() => _LeaveDetailState();
}

class _LeaveDetailState extends State<LeaveDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRefer.kBackgroundColor,
      appBar: appBar(
        title: 'Apply For Leave',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LeavesDashboard(),
              SizedBox(height: 20),
              LeaveRequests(),
            ],
          ),
        ),
      ),

    );
  }
}

class LeavesDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dashboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Center(
            child: CircularProgressIndicator(
              value: 0.3,
              strokeWidth: 10,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Used', style: TextStyle(color: Colors.blue)),
              Text('Balance', style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              LeaveTypeRow(type: 'Casual', used: 2, total: 5, color: Colors.green),
              SizedBox(height: 8),
              LeaveTypeRow(type: 'Sick', used: 1, total: 5, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}

class LeaveTypeRow extends StatelessWidget {
  final String type;
  final int used;
  final int total;
  final Color color;

  LeaveTypeRow({required this.type, required this.used, required this.total, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(type),
        SizedBox(width: 16),
        Expanded(
          child: LinearProgressIndicator(
            value: used / total,
            backgroundColor: color.withOpacity(0.2),
            color: color,
          ),
        ),
        SizedBox(width: 16),
        Text('$used/$total'),
      ],
    );
  }
}

class LeaveRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Leave Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          LeaveRequestItem(
              date: 'Dec 30, 2023',
              status: 'Pending',
              type: 'Sick',
              statusColor:
              Colors.orange,
              typeColor: Colors.orange,
              description: 'Yorem ipsum dolor sit amet, consectetur adipiscing elit.',
          ),
          SizedBox(height: 16),
          LeaveRequestItem(
              date: 'Dec 30, 2023',
              status: 'Rejected',
              type: 'Casual',
              statusColor: Colors.red,
              typeColor: Colors.green,
              description: 'Yorem ipsum dolor sit amet, consectetur adipiscing elit.',
          ),
          SizedBox(height: 16),
          LeaveRequestItem(
            date: 'Dec 30, 2023',
            status: 'Accpeted',
            type: 'Sick',
            statusColor:
            Colors.green,
            typeColor: Colors.orange,
            description: 'Yorem ipsum dolor sit amet, consectetur adipiscing elit.',
          ),
          // LeaveRequestItem(date: 'Dec 30, 2023', status: 'Approved', type: 'Casual', statusColor: Colors.green, typeColor: Colors.red),
          // LeaveRequestItem(date: 'Dec 30, 2023', status: 'Approved', type: 'Casual', statusColor: Colors.green, typeColor: Colors.red),
        ],
      ),
    );
  }
}



class LeaveRequestItem extends StatelessWidget {
  final String date;
  final String status;
  final String type;
  final String description;
  final Color statusColor;
  final Color typeColor;

  LeaveRequestItem({
    required this.date,
    required this.status,
    required this.type,
    required this.description,
    required this.statusColor,
    required this.typeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      // margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(description),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.circle, color: typeColor, size: 12),
              SizedBox(width: 4),
              Text(type, style: TextStyle(color: typeColor, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}


// class LeaveRequestItem extends StatelessWidget {
//   final String date;
//   final String status;
//   final String type;
//   final Color color;
//
//   LeaveRequestItem({required this.date, required this.status, required this.type, required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(type, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text('Yorem ipsum dolor sit amet, consectetur adipiscing elit.'),
//               ],
//             ),
//           ),
//           Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }