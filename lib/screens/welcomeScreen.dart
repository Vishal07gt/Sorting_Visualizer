import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sorting_visualizer/sortingTech.dart';
import 'dart:math';

class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();

}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomize();
  }

  @override
  double sliderSize = 20;
  double sliderSpeed = 250;
  int size = 500;
  bool isSorted = false;
  bool isSorting = false;
  String selectedAlgo = sortingTech[0];

  _doSort() async{
    switch(selectedAlgo){
      case 'Bubble Sort' :
        return _bubbleSort();

      case 'Selection Sort':
        return _selectionSort();

      case 'Merge Sort' :
        print('Merge Called');
        return _mergeSort(0, numbers.length - 1);

      case 'In Place Sort' :
        return mergeSortInPlace(numbers, 0, numbers.length - 1);

      case 'Shell Sort' :
        return _shellSort();

      case 'Odd Even Sort' :
        return _oddEvenSort();

      case 'Quick Sort' :
        return _quickSort(0, numbers.length - 1);
      case 'Heap Sort' :
        return _heapSort();

      case 'Insertion Sort' :
        return _insertionSort();

      case 'Cycle Sort' :
        return _cycleSort();
    }
  }


  _bubbleSort() async {
    for (int i = 0; i < numbers.length; ++i) {
      for (int j = 0; j < numbers.length - i - 1; ++j) {
        if (numbers[j] > numbers[j + 1]) {
          int temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;
        }
        await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
        setState(() {
        });
      }
    }
  }
  _selectionSort() async {
    for (int i = 0; i < numbers.length; i++) {
      for (int j = i + 1; j < numbers.length; j++) {
        if (numbers[i] > numbers[j]) {
          int temp = numbers[j];
          numbers[j] = numbers[i];
          numbers[i] = temp;
        }

        await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
        setState(() {
        });
      }
    }
  }

  _insertionSort() async {
    for (int i = 1; i < numbers.length; i++) {
      int temp = numbers[i];
      int j = i - 1;
      while (j >= 0 && temp < numbers[j]) {
        numbers[j + 1] = numbers[j];
        --j;
        await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));

        setState(() {
        });
      }
      numbers[j + 1] = temp;
      await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
      setState(() {
      });
    }
  }


  _mergeSort(int leftIndex, int rightIndex) async {
    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      List leftList =  [];
      List rightList =  [];

      for (int i = 0; i < leftSize; i++) leftList.add(numbers[leftIndex + i]);
      for (int j = 0; j < rightSize; j++) rightList.add(numbers[middleIndex + j + 1]) ;

      int i = 0, j = 0;
      int k = leftIndex;

      while (i < leftSize && j < rightSize) {
        if (leftList[i] <= rightList[j]) {
          numbers[k] = leftList[i];
          i++;
        } else {
          numbers[k] = rightList[j];
          j++;
        }

        await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
        setState(() {
        });
        k++;
      }

      while (i < leftSize) {
        numbers[k] = leftList[i];
        i++;
        k++;

        await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
        setState(() {
        });
      }

      while (j < rightSize) {
        numbers[k] = rightList[j];
        j++;
        k++;

        await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
        setState(() {
        });
      }
    }

    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      await _mergeSort(leftIndex, middleIndex);
      await _mergeSort(middleIndex + 1, rightIndex);

      await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
      setState(() {
      });

      await merge(leftIndex, middleIndex, rightIndex);
      setState(() {
      });
    }
  }

  mergeInPlace(List<int> arr, int start, int mid, int end) async
  {
    int start2 = mid + 1;

// If the direct merge is already sorted
    if (arr[mid] <= arr[start2]) {
      //await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
      // setState(() {
      // });
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
          setState(() {
          });
        }
        arr[start] = value;

// Update all the pointers
        start++;
        mid++;
        start2++;
        //await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
        setState(() {
        });
      }
      await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
      setState(() {
      });
    }
    setState(() {
    });
    //await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
  }

/* l is for left index and r is right index of the
   sub-array of arr to be sorted */
   mergeSortInPlace(List<int> arr, int l, int r) async
  {
    if (l < r) {

// Same as (l + r) / 2, but avoids overflow
// for large l and r
      double a = l + (r - l) / 2;
      int m = a.toInt();

// Sort first and second halves
      await mergeSortInPlace(arr, l, m);
      await mergeSortInPlace(arr, m + 1, r);

      await mergeInPlace(arr, l, m, r);
    }
  }

  _shellSort() async {
    for (int gap = numbers.length ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < numbers.length; i += 1) {
        int temp = numbers[i];
        int j;
        for (j = i; j >= gap && numbers[j - gap] > temp; j -= gap) numbers[j] = numbers[j - gap];
        numbers[j] = temp;
        await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
        setState(() {
        });
      }
    }
  }

  int getNextGap(int gap) {
    gap = (gap * 10) ~/ 13;

    if (gap < 1) return 1;
    return gap;
  }

  _oddEvenSort() async {
    bool isSorted = false;

    while (!isSorted) {
      isSorted = true;

      for (int i = 1; i <= numbers.length - 2; i = i + 2) {
        if (numbers[i] > numbers[i + 1]) {
          int temp = numbers[i];
          numbers[i] = numbers[i + 1];
          numbers[i + 1] = temp;
          isSorted = false;
          await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
          setState(() {
          });
        }
      }

      for (int i = 0; i <= numbers.length - 2; i = i + 2) {
        if (numbers[i] > numbers[i + 1]) {
          int temp = numbers[i];
          numbers[i] = numbers[i + 1];
          numbers[i + 1] = temp;
          isSorted = false;
          await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
          setState(() {
          });
        }
      }
    }

    return;
  }

  cf(int a, int b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

  _quickSort(int leftIndex, int rightIndex) async {
    Future<int> _partition(int left, int right) async {
      int p = (left + (right - left) / 2).toInt();

      var temp = numbers[p];
      numbers[p] = numbers[right];
      numbers[right] = temp;
      await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
      setState(() {
      });

      int cursor = left;

      for (int i = left; i < right; i++) {
        if (cf(numbers[i], numbers[right]) <= 0) {
          var temp = numbers[i];
          numbers[i] = numbers[cursor];
          numbers[cursor] = temp;
          cursor++;

          await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
          setState(() {
          });

        }
      }

      temp = numbers[right];
      numbers[right] = numbers[cursor];
      numbers[cursor] = temp;

      await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
      setState(() {
      });


      return cursor;
    }

    if (leftIndex < rightIndex) {
      int p = await _partition(leftIndex, rightIndex);

      await _quickSort(leftIndex, p - 1);

      await _quickSort(p + 1, rightIndex);
    }
  }

  _heapSort() async {
    for (int i = numbers.length ~/ 2; i >= 0; i--) {
      await heapify(numbers, numbers.length, i);
      setState(() {
      });
    }
    for (int i = numbers.length - 1; i >= 0; i--) {
      int temp = numbers[0];
      numbers[0] = numbers[i];
      numbers[i] = temp;
      await heapify(numbers, i, 0);
      setState(() {
      });
    }
  }

  heapify(List<int> arr, int n, int i) async {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && arr[l] > arr[largest]) largest = l;

    if (r < n && arr[r] > arr[largest]) largest = r;

    if (largest != i) {
      int temp = numbers[i];
      numbers[i] = numbers[largest];
      numbers[largest] = temp;
      heapify(arr, n, largest);
    }
    await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
  }

  _cycleSort() async {
    int writes = 0;
    for (int cycleStart = 0; cycleStart <= numbers.length - 2; cycleStart++) {
      int item = numbers[cycleStart];
      int pos = cycleStart;
      for (int i = cycleStart + 1; i < numbers.length; i++) {
        if (numbers[i] < item) pos++;
      }

      if (pos == cycleStart) {
        continue;
      }

      while (item == numbers[pos]) {
        pos += 1;
      }
      if (pos != cycleStart) {
        int temp = item;
        item = numbers[pos];
        numbers[pos] = temp;
        writes++;
        setState(() {
        });
      }


      while (pos != cycleStart) {
        pos = cycleStart;
        for (int i = cycleStart + 1; i < numbers.length; i++) {
          if (numbers[i] < item) pos += 1;
          setState(() {
          });
        }

        while (item == numbers[pos]) {
          pos += 1;
        }

        if (item != numbers[pos]) {
          int temp = item;
          item = numbers[pos];
          numbers[pos] = temp;
          writes++;
          setState(() {
          });
        }
        await Future.delayed(Duration(microseconds: sliderSpeed.toInt()));
        setState(() {
        });
      }
    }
  }


  List<int> numbers = [];


  randomize(){
    numbers = [];
    for(int i = 0 ; i < size ;i++){
      numbers.add(Random().nextInt(500));
    }
    setState(() {
    });
    // for(int i = 0 ; i < sliderSize ;i++){
    //   print(numbers[i]);
    // }
  }

  reset(){
    numbers = [];
    for(int i = 0 ; i < size ;i++){
      numbers.add(Random().nextInt(500));
    }
    setState(() {
    });
  }

  List<DropdownMenuItem<String>> getAlgo(){
    List<DropdownMenuItem<String>> algoList = [];
    for(String algo in sortingTech){
      var newItem = DropdownMenuItem(
          child: Text(algo),
          value: algo,
      );
      algoList.add(newItem);
    }
    return algoList;
  }

  Widget build(BuildContext context) {
    int counter = 0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: Icon(
                    Icons.sort
                  ),
                  value: selectedAlgo,
                  items: getAlgo(),
                  onChanged: (String? newValue) {
                    print(newValue);
                    setState(() {
                      selectedAlgo = newValue.toString();
                    });
                  },
                ),
              ),
            )
          ],
          title: Text('Sorting Visualizer',style: TextStyle(
          ),),
        ),
        body: Container(
          child: Row(
            children: numbers.map((int number){
              counter++;
              return CustomPaint(
                painter: BarPainter(
                  width: MediaQuery.of(context).size.width / (size + 1),
                  value: number,
                  index: counter
                )
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextButton(onPressed: (){},
                      child: Text('Size')),
                ),
                Expanded(
                  child: TextButton(onPressed: (){},
                      child: Text('Delay')),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                // Slider(
                //   // n = num.parse(n.toStringAsFixed(2));
                //   value: sliderSize,
                //   onChanged: (value){
                //     setState(() {
                //       sliderSize = value;
                //       sliderSize = double.parse(value.toStringAsFixed(0));
                //       print(sliderSize);
                //     });
                //   },
                //   min: 2,
                //   max: 200,
                // ),
                Slider(
                  // n = num.parse(n.toStringAsFixed(2));
                  value: sliderSpeed,
                  divisions: 6,
                  onChanged: (value){
                    setState(() {
                      sliderSpeed = value;
                      sliderSpeed = double.parse(value.toStringAsFixed(0));
                      print(sliderSpeed);
                    });
                  },
                  min: 0,
                  max: 1000,
                ),
              ],
            ),
            SizedBox(
              child: Container(
                //color: Colors.white,
              ),
              height: 10,
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(onPressed: (){
                    reset();
                  },
                    child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(child: Text('Reset'))),
                    style: ButtonStyle(
                    ),
                  ),
                ),
                // Expanded(
                //   child: TextButton(onPressed: (){
                //     randomize();
                //   },
                //       child: Container(
                //         width: double.infinity,
                //         height: 50,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Colors.white,
                //         ),
                //           child: Center(child: Text('Randomize'))),
                //     style: ButtonStyle(
                //     ),
                //   ),
                // ),
                Expanded(
                  child: TextButton(onPressed: (){
                    _doSort();
                  },
                    child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(child: Text('Sort'))),
                    style: ButtonStyle(
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({required this.width, required this.value, required this.index});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (this.value < 500 * .10) {
      paint.color = Color(0xFF003a6d);
    } else if (this.value < 500 * .20) {
      paint.color = Color(0xFF0072c3);
    } else if (this.value < 500 * .30) {
      paint.color = Color(0xFF33b1ff);
    } else if (this.value < 500 * .40) {
      paint.color = Color(0xFFbae6ff);
    } else if (this.value < 500 * .50) {
      paint.color = Color(0xFFfff1f1);
    } else if (this.value < 500 * .60) {
      paint.color = Color(0xFFffb3b8);
    } else if (this.value < 500 * .70) {
      paint.color = Color(0xFFff8389);
    } else if (this.value < 500 * .80) {
      paint.color = Color(0xFFda1e28);
    } else if (this.value < 500 * .90) {
      paint.color = Color(0xFFa2191f);
    } else {
      paint.color = Color(0xFF750e13);
    }

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(index * this.width, 0), Offset(index * this.width, this.value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}