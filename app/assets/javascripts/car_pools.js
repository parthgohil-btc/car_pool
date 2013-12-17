$(document).ready(function(){
	
	$('#dialog').on('change', '#car_pool_school_id', function(){
		school_id = $("#car_pool_school_id").val()
		$(".students_check_box").attr('disabled', true).prop('checked', false);
		$("." + school_id+".students_check_box").attr('disabled', false);
	});

});