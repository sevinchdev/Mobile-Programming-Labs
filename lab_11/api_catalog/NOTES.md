# Lab 11 - Fetch, Parse, Emit

## Part 1 - Setup

**In product.json, find a number, a list of strings, a nested object and a list of objects.**

- A number: `price` (also `rating` and `stock`)
- A list of strings: `tags` (also `images`)
- A nested object: `dimensions` (also `meta`)
- A list of objects: `reviews`

**Change the address to /products/0. What status code and body come back?**

The server answers with status <200> and a short JSON body:
<Essence Mascara Lash Princess
_Map<String, dynamic>>.
The request still reaches the server and gets a normal answer, so an unknown id is not a
crash: it is an error status. In my code I must check the status code before parsing the
body, otherwise I would try to read this error message as if it were a product.

**Change the address to /products/0. What status code and body come back?**

The server answers with status 404 (not found) and a short JSON body:
{"message": "Product with id '0' not found"}.
The request still reaches the server and gets a normal answer, so an unknown id is not a
crash: it is an error status. In my code I must check the status code before parsing the
body, otherwise I would try to read this error message as if it were a product.