![image](https://github.com/nkl04/BookStore_PRJ301/assets/131468660/2b390a72-70ae-4e6c-96c2-5d2e02733c75)# BookStore Website
## Introduction to the Bookstore Web Application 
The bookstore web application project focuses on creating an efficient and user-friendly platform for purchasing books online. Targeting book enthusiasts, the application aims to provide a seamless browsing and buying experience, offering a diverse range of books across various genres and categories. 

## Current Assessment  
  ### Strengths: 
  - Accessibility: The online bookstore provides easy access to a wide range of books for customers, regardless of their location.  
  - Convenience: Customers can browse and purchase books from the comfort of their homes, saving time and effort. 
  - Diverse Selection: The application offers a diverse selection of books across various genres and categories, catering to different preferences. 
  - Product Enhancement and Customer Acquisition: Feedback from online customers aids in product refinement, attracting new customers and retaining existing ones. 
  - Flexibility: The online platform allows for flexible browsing and purchasing options, accommodating varying customer preferences. 
  - Time-Saving for Buyers: Online shopping eliminates the need for physical visits to stores, saving customers valuable time.
    
  ### Weaknesses:
  - Security Concerns: Internet security risks pose threats to the integrity of the web application and customer data.  
  - Customer Trust Issues: Trust in product quality may be undermined by discrepancies between online descriptions and actual products.
    
## Purpose of website 
The purpose of the bookstore project is to create an online platform that provides a convenient and accessible way for customers to browse, purchase, and interact with a wide range of books. The project aims to leverage the power of technology to overcome geographical barriers and offer book enthusiasts a diverse selection of reading materials from various genres and authors. 

## Requirement 
### Functional Requirements 
  - User registration, login and profile view. 
  - Book browsing and searching. 
  - Shopping cart management. 
  - User’s orders browsing  
  - Checkout  
  - Admin functionalities for managing inventory and orders.
    
### Non-functional Requirements 
  - User-friendly UI. 
  - Fast loading times. 
  - Secure data storage and transmission. 
  - Compatibility with major web browsers. 
  - Regular updates with the latest products 
  - Quick and efficient product search and retrieval  

# Analysis and System Design 

## Detailed Requirements for the Website 
- Display product categories 
- Display detailed information about each product 
- Display best-selling, trending, popular products
  
### For Users: 
- Allow viewing product information 
- Search for product information 
- User registration, login 
- Checkout 
- Allow viewing history of user’s orders 
- Can view or update profile of users 
- Can store the favourites products 
- Using cart to store the book wanted to checkout
  
### For Admin: 
- Member management: Delete members 
- Book management: Add, Edit, Delete books 
- Order management: View orders 
- Genre management: Add, Edit, Delete genre 
- View the admin dashboard  

2.2.2. Diagram 

* Usecase Diagram 

![image](https://github.com/nkl04/BookStore_PRJ301/assets/131468660/a855c0e1-0c73-40ba-9819-3e89a36b1470)
Figure 2.1. General Use Case Diagram 

Description: Users can register, log in, update their information, search for products, make purchases, and view their purchase history. Meanwhile, administrators will have all the functionalities of a regular user, along with additional features for managing the website and accessing sales data. 

 
![image](https://github.com/nkl04/BookStore_PRJ301/assets/131468660/2b657479-c863-48aa-a094-d62c422fb1ce)
Figure 2.2. Specific Use Case Diagram 

Description: In the chart above, we gain an overview of how the website operates through the user and administrator interaction steps. 


![image](https://github.com/DungNVHE182057/PRJ301_Assignment_HE182057/assets/131468660/6184d5d2-c248-480f-aa93-26ec0d374021)
Figure 2.3. Login Sequence Diagram 

Description: When customers request to log in, they will be redirected to the login page. The system will validate whether the username and password are valid input so that to check in database. If account has in database, it will display a login successful message; otherwise, it will display a login failed message and return to the login interface. 


![image](https://github.com/DungNVHE182057/PRJ301_Assignment_HE182057/assets/131468660/3575c592-f6c8-48c3-8eca-2e9f36403f1a)
Figure 2.4. Signup Sequence Diagram 

Description: When users request to register as members, they will be directed to the registration page. The system will validate the entered information. If the information is valid, it will display a registration successful message. If the entered information is invalid, it will display a registration failed message. 

 
![image](https://github.com/DungNVHE182057/PRJ301_Assignment_HE182057/assets/131468660/2c2bce56-7f2e-4d9d-957a-d3b0ad246a14)
Figure 2.5. Buy Product Sequence Diagram 


Description: Customers add items they want to purchase to their shopping cart and it save in database as well. When user want to to buy products in cart, they require checkout. The system processes the payment and notifies the user of a successful transaction. 

 
![image](https://github.com/DungNVHE182057/PRJ301_Assignment_HE182057/assets/131468660/1970db8c-26f4-4f16-b888-4001a5c96157)
Figure 2.6. State Diagram for main page 

 
Description: when accessing the web, the user is in home page. If user redirect to profile page or order history page, the system check if the user is not login then redirect to login page else can access user page. According to accessing admin page, the user have to login first, if user is admin then this user can use functionality of admin page, else not. 
