import 'package:flutter/cupertino.dart';

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({required this.width, required this.value, required this.index});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint();
    paint.color = Color(0xFFDEEDCF);
    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(index * this.width, 0), Offset(index * this.width, this.value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    //throw UnimplementedError();
    return true;
  }
  
}

void mergeInPlace(List<int> arr, int start, int mid, int end)
{
int start2 = mid + 1;

// If the direct merge is already sorted
if (arr[mid] <= arr[start2]) {
return;
}

// Two pointers to maintain start
// of both arrays to merge
while (start <= mid && start2 <= end) {

// If element 1 is in right place
if (arr[start] <= arr[start2]) {
start++;
}
else {
int value = arr[start2];
int index = start2;

// Shift all the elements between element 1
// element 2, right by 1.
while (index != start) {
arr[index] = arr[index - 1];
index--;
}
arr[start] = value;

// Update all the pointers
start++;
mid++;
start2++;
}
}
}

/* l is for left index and r is right index of the
   sub-array of arr to be sorted */
void mergeSortInPlace(List<int> arr, int l, int r)
{
if (l < r) {

// Same as (l + r) / 2, but avoids overflow
// for large l and r
double a = l + (r - l) / 2;
int m = a.toInt();

// Sort first and second halves
mergeSortInPlace(arr, l, m);
mergeSortInPlace(arr, m + 1, r);

mergeInPlace(arr, l, m, r);
}
}