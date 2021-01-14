# Overview

**FarGoTraders** - is my first iOS app mainly done for research and proof of concept purposes.

The app is a dummy store for things from the first Fallout game. You can list the products, add them to and manage in a cart, and look at how your order will look like as a JSON request to a server (a real "buy" submit wasn't implemented).

In this project, I used `SwiftUI` and `Combine` frameworks without any additional dependencies (it was a challenge due to some reasons).

There is a small complete demo (recorder on iphone 12 mini):

> **IMPORTANT:** the GIF below loads slowly because of its size, but I anyway leave it *as is* for better on-device demonstration.

<p align="center">
  <img src="https://github.com/xxlabaza/far-go-traders/blob/main/readme/gifs/demo.gif?raw=true" alt="Demo" />
</p>

## Contents

- [Requirements](#requirements)
- [Features](#features)
  - [Products list from Firebase](#products-list-from-firebase)
  - [Async images load](#async-images-load)
  - [Cart icon badge count](#cart-icon-badge-count)
  - [Swipe to delete from cart](#swipe-to-delete-from-cart)
  - [Persist cart between launches](#persist-cart-between-launches)
  - [JSON cart format](#json-cart-format)
- [Authors](#authors)
- [License](#license)

## Requirements

* iOS 14.3
* Swift 5.3

## Features

The most valuable features in the project are listed below.

### Products list from Firebase

Just for curious, I would like to try the Firebase platform for data storing. I used a free (with a 30 days trial period) **Realtime Database** service and added there all my product items:

<p align="center">
  <img src="https://github.com/xxlabaza/far-go-traders/blob/main/readme/images/firebase_dashboard.png?raw=true" alt="Firebase dashboard" />
</p>

The **Realtime Database** has a convenient API, so all my data can be retrieved via simple cURL command:

```bash
$> curl https://xxlabaza-products-default-rtdb.europe-west1.firebasedatabase.app/products.json

{
  "1001": {
    "picture_path": "/9/92/Fo1_brass_knuckles.png",
    "price": 4000,
    "title": "Brass knuckles"
  },
  "10010": {
    "picture_path": "/a/a1/Fo1_Ripper.png",
    "price": 90000,
    "title": "Ripper"
  },
  ...
}
```

When the app launches - it requests the Firebase's database, and a user sees a "Loading..." message during this load:

<p align="center">
  <img src="https://github.com/xxlabaza/far-go-traders/blob/main/readme/images/products_loading.png?raw=true" alt="Products loading message" />
</p>

### Async images load

All images (in the products list or the cart screens) load asynchronously, and during this, a user sees a spinner:

<p align="center">
  <img src="https://github.com/xxlabaza/far-go-traders/blob/main/readme/images/products_images_spinner.png?raw=true" alt="Products images spinner" />
</p>

An image is put in the cache after a first download.

### Cart icon badge count

For better user experience, the cart's icon is dynamic - it disables (doesn't allow to go to a cart) when the cart is empty and shows the number of items in it (not by SKU, but the whole amount of the products):

<p align="center">
  <img src="https://github.com/xxlabaza/far-go-traders/blob/main/readme/gifs/cart_icon_badge_count.gif?raw=true" alt="Cart icon badge count" />
</p>

### Swipe to delete from cart

To remove a product from a cart - just swipe it out:

<p align="center">
  <img src="https://github.com/xxlabaza/far-go-traders/blob/main/readme/gifs/swipe_to_delete.gif?raw=true" alt="Swipe to delete" />
</p>

### Persist cart between launches

I use the UserDefaults for storing a user's selected products with their amount in format Product->Amount dictionary.

At first, I would like to use SQLite for that, but the UserDefaults solution (for this app) turned out to be better and much more cleaner.

<p align="center">
  <img src="https://github.com/xxlabaza/far-go-traders/blob/main/readme/gifs/persist_user_input.gif?raw=true" alt="Persist user's input" />
</p>

### JSON cart format

When a user presses a button, a modal view shows. It contains a transformed cart state in the JSON format:

<p align="center">
  <img src="https://github.com/xxlabaza/far-go-traders/blob/main/readme/images/json_cart_format.png?raw=true" alt="JSON cart format" />
</p>

## Authors

* **[Artem Labazin](https://github.com/xxlabaza)** - creator and the main developer

## License

This project is licensed under the Public Domain License - see the [license](./LICENSE) file for details.
