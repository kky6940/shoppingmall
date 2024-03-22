<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"  href="resources/css/test.css">
</head>
<body>
 	<div class="img_parentsdiv">
    	<div class="img_childdiv"><a href="#"><img src="resources/img/cat2.jpg"></a></div>
    	<div class="img_childdiv"><a href="#"><img src="resources/img/cat2.jpg"></a></div>
    	<div class="img_childdiv"><a href="#"><img src="resources/img/cat2.jpg"></a></div>
    </div>
   
<script type="text/javascript">
	window.addEventListener('wheel', function(e){
		e.preventDefault();
	},{passive : false});
	
	var $html = $('html');
	var page = 0;
	var lastPage = $('.img_childdiv').length;

	$html.animate({scrollTop:0},500);
	
	$(window).on('wheel', function(e){
		if($html.is(':animated')) return;
		if(e.originalEvent.deltaY > 0){
			if(page == lastPage) page = 0;
			else page++;
		}else if(e.originalEvent.deltaY < 0){
			if(page == 0) page = lastPage;
			else page--;
		}
		
		var posTop = page * $('.img_childdiv').height();
		$html.animate({scrollTop : posTop},700);
	 
	});
</script>
    
</body>
</html>