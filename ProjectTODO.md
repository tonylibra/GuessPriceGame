#iOS Coding Sample Project 1 - Guess the correct price game 

The Wayfair iOS apps use JSON endpoints to obtain data. One of the most common data requests that the app makes is for a "Browse page" that returns a collection of products. Each product in the collection contains a "sale_price" and an "image_url" among other data points. The goal of this assignment is to create a small, fun game app where users can guess the price of real Wayfair products and score points for each correct guess. It should take you 4 to 8 hours of focused effort to write. 

#Mandatory Elements

- [x] Make an iOS app for iPhone 
- [x] Use this request http://www.wayfair.com/v/category/display?category_id=419247&_format=json that returns a product_collection of kitchen blenders as the data source for your game. 
- [x] For each product in the product_collection, sale_price is the correct sale price and image_url is the URL for the product image you should display. 
- [x] If you'd like to you can see the full web page for this category by changing the "_format" tag to request HTML like this http://www.wayfair.com/v/category/display?category_id=419247&_format=html 
- [x] The primary screen should be a "Guess the correct price" screen for a single product. 
- [x] It should show a product image and 4 different product prices. 
- [x] One of the prices is the correct "sale_price" from the data feed and 3 prices are incorrect. Randomly generate the incorrect prices within a range of +/- 100% of the correct sale price. 
- [x] The user taps on the price to make his guess. If he is correct, he earns points. If incorrect he doesn't earn points. 
- [x] After the user makes his guess he sees the "Guess the correct price" screen again for another product. 
- [x]  Include a simple startup screen explaining the game 
- [x] Allow users to stop the guessing at any point during the game 
- [x] After a user has stopped guessing show them their score 

#Extra credit 
- [x] A universal app that runs on both iPad and iPhone 
- [x] Give the user choices of different product categories to play the game on.
- [x] Here are a few, but you can explore the Wayfair website for more. 
- [x] Make the game randomly select products from several different categories so that the user will be surprised by the product he sees next after guessing a prices. He may see a blender, then a grill, then a sofa, etc. 
- [x] Delightful / fun transitions and animations 
- [x] Display other helpful data from the JSON data response you get 
- [x] Other creative ideas that you think add value to the game 
