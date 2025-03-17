// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

// class SongAndValume extends StatelessWidget {
//   const SongAndValume({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SfRadialGauge(
//       animationDuration: 1,
//       enableLoadingAnimation: true,
//       axes: [
//         RadialAxis(
//           useRangeColorForAxis: true,
//           startAngle: 0,
//           endAngle: 180,
//           canRotateLabels: false,
//           interval: 10,
//           isInversed: false,
//           maximum: 1,
//           minimum: 0,
//           showAxisLine: true,
//           showLabels: false,
//           showTicks: true,
//           ranges: [
//             GaugeRange(
//               startValue: 0,
//               endValue: 0,
//               // endValue: songPlayerController.volumLavel.value,
//               color: Theme.of(context).colorScheme.primary,
//             ),
//           ],
//           pointers: [
//             MarkerPointer(
//               color: Theme.of(context).colorScheme.primary,
//               value: 0,
//               // value: songPlayerController.volumLavel.value,
//               onValueChanged: (value) {
//                 // songPlayerController.chnageVolum(value);
//               },
//               enableAnimation: true,
//               enableDragging: true,
//               markerType: MarkerType.circle,
//               markerWidth: 20,
//               markerHeight: 20,
//             ),
//           ],
//           annotations: [
//             GaugeAnnotation(
//               // horizontalAlignment: GaugeAlignment.center,
//               widget:
//                   Image.asset("") == ""
//                       // songPlayerController.isCouldSoundPlaying.value
//                       ? Container(
//                         width: 270,
//                         height: 270,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(1000),
//                           image: DecorationImage(
//                             image: NetworkImage(" albumUrl.value"),
//                             fit: BoxFit.cover,
//                           ),

//                           color:
//                               Theme.of(context).colorScheme.secondaryContainer,
//                         ),
//                       )
//                       : Container(
//                         width: 270,
//                         height: 270,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(1000),
//                           image: DecorationImage(
//                             image: AssetImage("assets/images/cover.jpg"),
//                             fit: BoxFit.cover,
//                           ),
//                           color:
//                               Theme.of(context).colorScheme.secondaryContainer,
//                         ),
//                       ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
