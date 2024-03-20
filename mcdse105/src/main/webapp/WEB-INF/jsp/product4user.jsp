<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="US-ASCII">
    <title>Inventory</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
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
    <style>
		*{
			font-family: Arial, sans-serif;
			margin: 0;
		}
		section{
			height: 100vh;
			background-color: rgb(255, 255, 255);
		}
		footer{
			height: 50vh;
            background-color: rgba(0, 0, 0, 0.8);
		}
		.container{
			justify-content: center;
			display: flex;
            padding-top: 10px;
			background-color: rgba(0, 0, 0, 0.8);
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            max-width: 100%;
        }
		.container ul{	
			list-style-type: none;
			display: flex;
			justify-content: space-between;
			width: 50%;
		}
		.container ul li a{
			text-decoration: none;
			color: #b4b4b4;
			position: relative;
			padding: 3px 0;
			transition: color 0.3s;
		}
		.container ul li a::before{
			content: '';
			position: absolute;
			width: 100%;
			height: 1.5px;
			bottom: 0;
			left: 0;
			background-color: #f3f3f3;
			visibility: hidden;
			transform: scaleX(0);
			transition: all 0.3s ease-in-out;
		}
		.container ul li a:hover{
			color: #f3f3f3;
		}
		.container ul li a:hover::before{
			visibility: visible;
			transform: scaleX(1);
		}
		body{
            margin-top: 40px;
		}
        .overview{
            position: absolute;
            top: 80px;
            left: 0;
            width: 15%;
            height: 90vh;
            overflow-y: auto;
            padding: 0 2%;
        }
        .main-content{
            margin-left: 20%;
            margin-right: 10%;
            width: 80%;
        }
        .main-content table{
            margin-left: 5%;
            width: 90%;
            border: 0;
        }
        .main-content table tbody tr button{
            height: auto;
            margin: 0;
            padding: 0;
        }
        footer{
            position: relative;
        }
        footer a{
            color: rgb(231, 231, 231);
        }
        footer div{
            color: rgb(210, 210, 210);
            text-align: center;
            justify-content: center;
            display: flex;
            flex-direction: row;
            height: 300px;
        }
        .contact{
            display: flex;
            flex-direction: column;
            margin: 0 5%;
        }
        .bottom{
            position: absolute;
            text-align: center;
            bottom: 0;
            width: 100%;
            height: fit-content;
        }
	</style>
    <script>
        function scrollToFooter() {
            document.getElementById('footer').scrollIntoView({ behavior: 'smooth' });
        }
    </script>
</head>
<body>
    <div class="container">
        <ul>
            <li><a href="/">Home</a></li>
            <li><a href="#" onclick="scrollToFooter()">Contact</a></li>
            <li><a href="/product">Manage</a></li>
            <li><a href="/logout">Logout</a></li>
        </ul>
    </div>
    <section class="overview">
        <div>
            <h1>Overview</h1>
            <c:set var="totalCostPrice" value="0" />
            <c:forEach items="${products}" var="product">
                <c:set var="totalCostPrice" value="${totalCostPrice + (product.quantity * product.costPrice)}" />
            </c:forEach>
            <p>Remain stock: ${totalCostPrice}<i class="bi bi-currency-dollar"></i></p>
        </div>
    </section>    
    <section class="main-content">
        <div>
            <div style="display: flex;justify-content:space-between;margin: 0 5%;padding:2%">
                <h1>In stock</h1>
                <input type="text" id="searchInput" onkeyup="searchTable()" placeholder=" Search for product...">
            </div>
            <table border="1" id="productTable" class="table table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>SKU</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Cost price</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="product">
                        <tr>
                            <td>${product.sku}</td>
                            <td>${product.productName}</td>
                            <td>${product.quantity}</td>
                            <td>${product.costPrice}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <script>
            function searchTable() {
                var input, filter, table, tr, td1, td2, i, txtValue1, txtValue2;
                input = document.getElementById("searchInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("productTable");
                tr = table.getElementsByTagName("tr");

                for (i = 0; i < tr.length; i++) {
                    td1 = tr[i].getElementsByTagName("td")[0];
                    td2 = tr[i].getElementsByTagName("td")[1];
                    if (td1 && td2) {
                        txtValue1 = td1.textContent || td1.innerText;
                        txtValue2 = td2.textContent || td2.innerText;
                        if (txtValue1.toUpperCase().indexOf(filter) > -1 || txtValue2.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }
        </script>
    </section>

    <footer id="footer">
        <div>
            <div class="contact">
                <h2>Contact us</h2>
                <p><i class="bi bi-whatsapp"></i><a href="call"> (+60)10-3100827</a></p>
                <p><i class="bi bi-instagram"></i><a href="instagram.com"> IMSystem</a></p>
            </div>
        </div>
        <div class="bottom">
            <a href="/">&copy; 2024. Cj Inventory Management System.</a>
        </div>
    </footer>
</body>
</html>
