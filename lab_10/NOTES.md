# Lab 10: Teach It, Ship It

## Part 1: Model

### Class list (6 classes)
1. Car
2. Plane
3. Train
4. Ship
5. Motorcycle
6. Nothing (background class: scenes with no vehicle)

### Data source
- Vehicles image dataset from Kaggle (folders: Cars, Planes, Trains, Ships, Motorcycles), about 60 images used per class
- "Nothing" class: scene images with no vehicles (street, buildings, forest)
- A few of our own phone photos added per class

### Inline questions

**Q1. What does the model answer for an object that belongs to none of the classes? How does the background class change that?**
Softmax forces the output probabilities to sum to 1, so the model must
spread 100% over the classes it knows, even for an unknown object. It
returns the closest-looking class, often with high confidence. The
background class gives the model a "none of the above" option, so
scenes without a vehicle can land there instead of being forced into a
wrong vehicle class.

**Q2. Floating point vs Quantized: what differs in file size, input type, and Dart code?**
- Size: quantized is about 4x smaller (8-bit integers instead of 32-bit floats).
- Input type: floating point takes float32 values in [-1, 1]; quantized takes uint8 values in [0, 255].
- Dart code: floating point needs normalisation (value / 127.5 - 1) and a double output buffer; quantized needs no normalisation, a uint8 input and the output divided by 255.

## Part 2: Setup

**Q1. Difference between listing `assets/model/` and listing `assets/`?**
Listing `assets/model/` bundles only the files directly inside that
folder (model_unquant.tflite and labels.txt). Listing `assets/` bundles
only the files directly in `assets/`, not the files in subfolders, so the
model files would be missing and loading would fail.

**Q2. Why can `image` and `http` run in a plain Dart unit test while `tflite_flutter` and `image_picker` cannot?**
`image` and `http` are pure Dart, so they run on the Dart VM in a unit
test. `tflite_flutter` and `image_picker` call native platform code
(Android/iOS plugins through platform channels), which doesn't exist in a
plain unit test.