<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="US-ASCII">
	<title>Homepage</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<style>
		@keyframes fadeIn{
			from {
				opacity: 0;
				transform: translateY(-20px);
			}
			to {
				opacity: 1;
				transform: translateY(0);
			}
		}
		.letter{
			opacity: 0;
			display: inline-block;
			animation: fadeIn 2s forwards;
		}
		*{
			font-family: Arial, sans-serif;
			margin: 0;
		}
		section{
			height: 100vh;
			background-color: rgb(255, 255, 255);
			color: rgb(0, 0, 0);
			text-align: center;
			padding-top: 20%;
		}
		footer{
			height: 50vh;
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
		.container ul li a:hover {
			color: #f3f3f3;
		}
		.container ul li a:hover::before{
			visibility: visible;
			transform: scaleX(1);
		}
		footer{
			height: 50vh;
            background-color: rgba(0, 0, 0, 0.8);
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
		.edit{
			color: black;
		}
	</style>
	<script>
        function scrollToFooter() {
            document.getElementById('footer').scrollIntoView({ behavior: 'smooth' });
        }
		function scrollToRole() {
            document.getElementById('role').scrollIntoView({ behavior: 'smooth' });
        }
		document.addEventListener('DOMContentLoaded', function() {
			const h2 = document.getElementById('animatedText');
			if (h2) {
				const text = h2.innerText;
				h2.innerHTML = ''; // Use innerHTML to clear the content
		
				text.split('').forEach((char, index) => {
					const span = document.createElement('span');
					if (char === ' ') {
						// If the character is a space, add a non-breaking space
						span.innerHTML = '&nbsp;';
					} else {
						span.textContent = char;
					}
					span.classList.add('letter');
					span.style.animationDelay = `${0.1 * index}s`;
					h2.appendChild(span);
				});
			}
		});
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
	<section>
		<h2 id="animatedText">Welcome to CJ Inventory Management System!</h2>
		<c:if test="${sessionScope.isAdmin}">
			<a class="edit" href="#" onclick="scrollToRole()">edit your role</a>
		</c:if>
	</section>
	<c:if test="${sessionScope.isAdmin}">
		<section id="role">
			<h2 id="animatedText">Manage your role</h2>
			<form action="${pageContext.request.contextPath}/role" method="post">
				<select class="form-select" name="account" id="account" required>
					<option value="">Select account</option>
					<c:forEach items="${nonAdminUsers}" var="user">
						<option value="${user.id}">${user.username}</option>
					</c:forEach>
				</select>
				<div class="form-check">
					<input class="form-check-input" type="checkbox" value="yes" id="defaultCheck1" name="admin">
					<label class="form-check-label" for="defaultCheck1">Admin</label>
				</div>
				<c:if test="${_csrf != null}">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</c:if>
				<button class="btn btn-outline-dark" type="submit">Update role</button>
			</form>			
		</section>
	</c:if>
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