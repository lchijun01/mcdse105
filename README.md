Inventory Management System Documentation

Introduction
The Inventory Management System is a web-based application designed to help businesses manage their inventory effectively. It allows users to add, edit, and delete products, as well as search for products by SKU or product name.

Features
Add new products with SKU, product name, quantity, and cost price
Edit existing product details
Delete products from the inventory
Search for products by SKU or product name

Technologies Used
Java, Spring Framework, JSP (JavaServer Pages), HTML, CSS, JavaScript, MySQL (or any other relational database management system)

Setup Instructions
Clone the project repository from GitHub: https://github.com/lchijun01/mcdse105
Set up your development environment with Java, Spring, and a relational database management system (e.g., MySQL).
Import the project into your preferred IDE (e.g., IntelliJ IDEA, Eclipse).
Configure the database connection properties in the application.properties file.
Run the application.

Usage Guidelines
Add Product:
Click on the "ADD ITEMS HERE" section.
Fill in the SKU, product name, quantity, and cost price fields.
Click the "Add Product" button to add the product to the inventory.

Edit Product:
Locate the product you want to edit in the "List of Products" section.
Click the "Edit" button next to the product.
Update the quantity field as needed.
Click the "Save" button to save the changes.

Delete Product:
Locate the product you want to delete in the "List of Products" section.
Click the "Delete" button next to the product.
Confirm the deletion in the prompt.

Search for Product:
Use the search bar located above the "List of Products" section.
Enter the SKU or product name you want to search for.
The table will dynamically update to display matching products.

Additional Information
This application uses AJAX for asynchronous communication between the client-side and server-side.
The front-end is built using JSP and JavaScript, while the back-end is developed with Java and the Spring Framework.
Database interactions are handled through Spring Data JPA.
