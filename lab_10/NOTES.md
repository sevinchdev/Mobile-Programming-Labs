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

### Training
- Teachable Machine, Image Project, Standard image model
- Samples per class: Car 60, Plane 68, Train 64, Ship __, Motorcycle __, Nothing __
- Trained once with default settings (no retraining needed)

### Preview test (fresh images, not used in training)
| Class | Test image | Result in preview |
|---|---|---|
| Car | unused dataset image | 100% |
| Plane | unused dataset image | 100% |
| Train | unused dataset image | 100% |
| Ship | unused dataset image | 100% |
| Motorcycle | unused dataset image | 100% |
| Nothing | unused scene image | 100% |

All six classes reached 80% or more. Screenshots: `docs/preview.png`.

**Caveat:** the test images come from the same datasets as the training
images, so they look very similar. 100% here is likely optimistic.
Photos from the phone camera will be harder, so the evaluation table in
Part 5 is the honest accuracy measure.

### Export
- Exported as TensorFlow Lite, Floating point
- `converted_tflite.zip` contains `model_unquant.tflite` and `labels.txt`
- `labels.txt` has 6 lines, one per class
- Both files are in `assets/model/`
- Project backup downloaded from the Teachable Machine menu

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

## Part 3: Questions

### 1. What happens with `value / 255`, and why does nothing crash?

The model was trained on inputs from -1 to 1. With `/ 255` the values fall in 0 to 1, so the model sees a distorted, brighter image. The percentages still add up to 1 (softmax), but they become unreliable: the top label can change or the confidence drops. (My result: <write your numbers here>.)

Nothing crashes because the tensor shape ([1, 224, 224, 3]) and type (float32) are still correct. The interpreter checks only shape and type, not whether the values make sense, so it is a silent bug.

### 2. Where is the number of classes written down?

Nowhere in the Dart code. It comes from `labels.txt`, and everything uses `labels.length`. After retraining with a seventh class, I only replace `model_unquant.tflite` and `labels.txt` in `assets/model/` with the new export. Any UI that lists classes (like the Welcome chips) must be built from `classifier.labels`.