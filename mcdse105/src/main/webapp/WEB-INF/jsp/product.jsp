<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="US-ASCII">
    <title>Inventory</title>
    <script>
        function toggleEditSave(button, productId) {
            var row = button.parentNode.parentNode;
            var quantityInput = row.querySelector("#quantity_" + productId);
            var quantity = quantityInput.value;
            var quantityField = row.querySelector("#quantity_" + productId);
            var editButton = row.querySelector("#editButton_" + productId);

            if (editButton.innerHTML === "Edit") {
                quantityField.removeAttribute("readonly");
                editButton.innerHTML = "Save";
            } else {
                quantityField.setAttribute("readonly", "true");
                editButton.innerHTML = "Edit";
                updateQuantity(productId, quantity);
            }
        }

        function updateQuantity(productId, quantity) {
            fetch('/product/' + productId + '/edit', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ productId: productId, quantity: quantity })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log('Success:', data);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
        }
    </script>
</head>
<body>
    <div class="container">
        <ul>
            <li><a href="/about">About</a></li>
            <li><a href="/contact">Contact</a></li>
            <li><a href="/product">Products</a></li>
            <li><a href="/logout">Logout</a></li>
        </ul>
    </div>
    <section>
        <div>
            <h1>ADD ITEMS HERE</h1>
            <form action="/product" method="post">
                <label for="sku">SKU:</label>
                <input type="text" id="sku" name="sku" required /><br>
                <label for="productName">Product Name:</label>
                <input type="text" id="productName" name="productName" required /><br>
                <label for="quantity">Quantity:</label>
                <input type="text" id="quantity" name="quantity" required /><br>
                <label for="costPrice">Cost Price:</label>
                <input type="text" id="costPrice" name="costPrice" required /><br>
                <button type="submit">Add Product</button>
            </form>
        </div>
        <div>
            <h1>List of Products</h1>
            <table border="1">
                <thead>
                    <tr>
                        <th>SKU</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Cost Price</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="product">
                        <tr>
                            <td>${product.sku}</td>
                            <td>${product.productName}</td>
                            <td><input type="text" value="${product.quantity}" id="quantity_${product.id}" readonly />
                                <input type="hidden" id="productId_${product.id}" value="${product.id}" /></td>
                            <td>${product.costPrice}</td>
                            <td><button id="editButton_${product.id}" onclick="toggleEditSave(this, '${product.id}')">Edit</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <footer><a href="/">CJ Inventory System</a> &copy; 2024</footer>
</body>
</html>
