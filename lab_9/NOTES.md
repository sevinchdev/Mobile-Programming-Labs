# Lab 9 - One Cart, Four Ways

## Part 1 - Shared code

**Why is CartLine immutable with a copyWith instead of a mutable qty field? Which of the
four styles would still "work" with mutation, and why is that a trap?**

Immutable means a line never changes. When the quantity changes, we make a new line with
copyWith. Then the app can see that something changed by comparing the old state with the
new one, and the old states are still there for undo.
Only setState would still "work" with mutation, because setState does not compare
anything, it just redraws the screen. That is a trap: the same code would silently fail in
Riverpod, Cubit and Bloc, because they skip the update when the new state is the same
object as the old one.

**Why does CartBody take callbacks rather than importing a provider or a bloc directly?**

So the same screen can be used in all four styles. CartBody only gets data and callbacks,
and it does not know how the state is managed. If it imported a provider, it could only
work with Riverpod.

## Part 2 - setState

**T3: why would storing total as a field be a bug waiting to happen?**

The total can always be calculated from the lines and the coupon. If we store it too, we
have two copies of the same information, and every place that changes the cart must
remember to update the total. If one place forgets, the screen shows a wrong total with no
error. A getter calculates the total again every time, so it is always correct.

**T4: what happens without `if (!mounted) return;` after the await?**

Checkout takes 1.5 seconds. If the user leaves the page during that time, the State is
removed. Without the check, the code after the await calls setState on a removed State
and crashes with "setState() called after dispose()".

**T6: how much of the test is about finding widgets?**

Almost all of it: building the page, finding the button, tapping, typing. The cart logic is
only one line, the final expect. With setState the logic is inside the widget, so we
cannot test it without drawing the widgets.

**After T4, how would a second page (order history) read the cart? What would you change?**

It could not, because the cart belongs to one page's State and is deleted when the page
closes. I would have to move the cart up above both pages and pass it down through
constructors, or move it out of the widgets into something shared like a provider.

**After T5, where does _history live? What happens on hot reload and hot restart?**

_history is a field in the same State as the cart. Hot reload keeps it. Hot restart creates
everything again, so the history and the cart are lost. They are also lost when the page
is closed.