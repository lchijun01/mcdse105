<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="US-ASCII">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style>
        html,body{
            height: 100vh;
        }
        body{
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }
        body h2{
            text-align: center;
        }
        footer{
            display: block;
            bottom: 0;
            position: fixed;
        }
        .form-control-plaintext{
            width: 200px;
            border: 1px solid black;
            border-radius: 5px;
        }
        button{
            background-color: transparent;
            color: blue;
            padding: 10px 20px;
            text-decoration: none;
            cursor: pointer;
            display: inline-block;
            border: 0px;
        }
        button:hover{
            text-decoration: underline;
        }
        form div{
            display: flex;
            justify-content: space-between;
            margin: 3% 0;
        }
        form{
			justify-content: center;
			display: flex;
			flex-direction: column;
		}
        form .btn{
			margin: 0 30%;
		}
        h2{
            padding-bottom: 6%;
        }
    </style>
</head>
<body>
    <div class="main">
        <h2>Login</h2>
        <form action="/login" method="post">
            <div>
                <label class="col-sm-2 col-form-label" for="username">Email/Username</label>
                <input class="form-control-plaintext" type="text" id="username" name="username" required />
            </div>
            <div>
                <label class="col-sm-2 col-form-label" for="password">Password</label>
                <input class="form-control-plaintext" type="password" id="password" name="password" required />
            </div>
            <button class="btn btn-primary" type="submit">Login</button>
            <p>Don't have an account?<button class="button" type="button" onclick="location.href='/register'">Sign up</button>for free!
            
            <c:if test="${not empty errmsg}">
                <p style="color: red;">${errmsg} Please try again.</p>
            </c:if>
        </form>
    </div>
    
    <footer>&copy; 2024. Cj Inventory Management System.</footer>
</body>
</html>
