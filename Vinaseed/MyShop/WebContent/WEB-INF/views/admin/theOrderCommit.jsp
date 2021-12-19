<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<c:set var="root" value="${pageContext.servletContext.contextPath}" />

<head>
<style>
.float-left-child {
	float: left;
}
</style>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Quản lý người dùng</title>

<!-- Custom fonts for this template-->
<link
	href="${root}/resources/admin/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Page level plugin CSS-->
<link
	href="${root}/resources/admin/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${root}/resources/admin/css/sb-admin.css" rel="stylesheet">

</head>
<body id="page-top">

	<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

		<a class="navbar-brand mr-1" href="manage.htm"> QUẢN LÝ</a> </a> -->
		<button class="btn btn-link btn-sm text-white order-1 order-sm-0"
			id="sidebarToggle" href="#">
			<i class="fas fa-bars"></i>
		</button>

		<!-- Navbar Search -->
		<form
			class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="Search for..."
					aria-label="Search" aria-describedby="basic-addon2">
				<div class="input-group-append">
					<button class="btn btn-primary" type="button">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</div>
		</form>

		<!-- Navbar -->
		<ul class="navbar-nav ml-auto ml-md-0">
			<li class="nav-item dropdown no-arrow"><a
				class="nav-link dropdown-toggle" href="#" id="userDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-user-circle fa-fw"></i>
			</a>
				<div class="dropdown-menu dropdown-menu-right"
					aria-labelledby="userDropdown">

					<a class="dropdown-item" href="../logout.htm" data-toggle="modal"
						data-target="#logoutModal">Logout</a>
				</div></li>
		</ul>

	</nav>

	<div id="wrapper">

		<!-- Sidebar -->
		<ul class="sidebar navbar-nav">
			<li class="nav-item dropdown">
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<h6 class="dropdown-header">Login Screens:</h6>
					<a class="dropdown-item" href="login.htm">Login</a> <a
						class="dropdown-item" href="register.htm">Register</a> <a
						class="dropdown-item" href="forgot.htm">Forgot Password</a>
					<div class="dropdown-divider"></div>
				</div>
			</li>
			<li class="nav-item active"><a class="nav-link"
				href="/MyShop/manageuser/edit.htm" rel="stylesheet"> <i
					class="fas fa-fw fa-table"></i> <span>Quản lý người dùng</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link"
				href="/MyShop/quanlyhatgiong/edit.htm" rel="stylesheet"> <i
					class="fas fa-fw fa-table"></i> <span>Quản lý hạt giống</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link"
				href="/MyShop/admin/theorder.htm" rel="stylesheet"> <i
					class="fas fa-fw fa-table"></i> <span>Quản lý đơn hàng</span>
			</a></li>
		</ul>

		<div class="container">
			<br>
			<h3>Đơn Hàng đã xử lý</h3>
			<h4 style="color: red;">${message}</h4>
			<c:choose>
				<c:when test="${TheOrderNew == null}">
					<div class="alert alert-danger">Bạn chưa có đơn hàng mới</div>
				</c:when>
				<c:otherwise>
					<table class="table table-striped">


						<thead class="thead-light">
							<tr>
								<th>Mã số đơn hàng</th>
								<th style="text-align: center;">Họ và tên</th>
								<th style="text-align: center;">Địa chỉ</th>
								<th style="text-align: center;">Số điện thoại</th>
								<th style="text-align: center;">Ngày giờ đặt</th>
								<th style="text-align: center;">Tổng</th>
								<th style="text-align: center;">Trạng thái đơn hàng</th>
								<th style="text-align: center;">Xem</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="o" items="${TheOrderNew}">
								<c:if test="${o.getStatusOrder().trim()=='2'}">
									<tr class="table-success">
								</c:if>
								<c:if test="${o.getStatusOrder().trim()=='0'}">
									<tr class="table-danger">
								</c:if>
								<td>${o.getIdOrder()}</td>
								<td style="text-align: center;">${o.getLastName()}
									${o.getFirstName()}</td>
								<td style="text-align: center;">${o.getAddress()}</td>
								<td style="text-align: center;">${o.getPhone()}</td>
								<td style="text-align: center;">${o.getOrderTime()}</td>
								<td style="text-align: center;">${o.getPrice()}</td>
								<c:choose>
									<c:when test="${o.getStatusOrder().trim()=='1'}">
										<td style="text-align: center;">Đơn hàng đã đặt</td>
									</c:when>
									<c:when test="${o.getStatusOrder().trim()=='0'}">
										<td class="" style="text-align: center;">Đơn hàng đã Huỷ</td>
									</c:when>

									<c:otherwise>
										<td style="text-align: center;">Đơn hàng đã được tiếp
											nhận</td>
									</c:otherwise>
								</c:choose>


								<td style="text-align: center;"><a
									href="admin/showDetail/${o.getIdOrder()}.htm">Xem</a></td>
								</tr>
							</c:forEach>
							
						</tbody>
					</table>
				</c:otherwise>
			</c:choose>


		</div>
	</div>
	<!-- /#wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="../logout.htm">Logout</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="${root}/resources/admin/vendor/jquery/jquery.min.js"></script>
	<script
		src="${root}/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="${root}/resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Page level plugin JavaScript-->
	<script
		src="${root}/resources/admin/vendor/datatables/jquery.dataTables.js"></script>
	<script
		src="${root}/resources/admin/vendor/datatables/dataTables.bootstrap4.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${root}/resources/admin/js/sb-admin.min.js"></script>

	<!-- Demo scripts for this page-->
	<script src="${root}/resources/admin/js/demo/datatables-demo.js"></script>

	<script>
		function searchValue() {
			//event.preventDefault();
			var searchProductname = $("#searchInput").val();
			alert(searchProductname)
		}
	</script>
</body>

</html>