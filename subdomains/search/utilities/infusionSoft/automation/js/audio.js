// JavaScript Document
$(document).ready(function() {
	
	
 	 $( ".datepicker" ).datepicker();
   
	 $('input[id^="edit_"]').click(function() {
	 	var id =  $(this).attr('id');
		var element_id = id.split("_");
		element_id = element_id[1];
		$('#show_row_'+element_id).hide();
		$('#edit_row_'+element_id).show();
		$('#add_row_'+element_id).show();
	 });
	 
	 $('input[id^="save_"]').click(function() {
		
	 	var id =  $(this).attr('id');
		var errors = 0;
		var element_id = id.split("_");
		element_id = element_id[1];
		
		var category = $('#category_'+element_id).val();
		var cceh = $('#cceh_'+element_id).val();
		var classTitle = $('#classTitle_'+element_id).val();
		var ce_requirements = $('#ce_requirements_'+element_id).val();
		var downLoadLink = $('#downloadLink_'+element_id).val();
		var facilitator = $('#facilitator_'+element_id).val();
		var handoutLink = $('#handoutLink_'+element_id).val();
//		var listenLink = $('#listenLink_'+element_id).val();
		var classDate = $('#classDate_'+element_id).val();
		
		if($('#cip_'+element_id).attr('checked')){
			var cip = 1;
		}else{
			var cip = 0;
		}
		if($('#wcm_'+element_id).attr('checked')){
			var wcm =1;
		}else{
			var wcm=0;
		}
		if($('#nchec_'+element_id).attr('checked')){
			var nchec =1;
		}else{
			var nchec=0;
		}
		if($('#ace_'+element_id).attr('checked')){
			var ace =1;
		}else{
			var ace=0;
		}
		if($('#acsm_'+element_id).attr('checked')){
			var acsm =1;
		}else{
			var acsm=0;
		}
		if($('#boc_'+element_id).attr('checked')){
			var boc =1;
		}else{
			var boc=0;
		}
		if($('#cdr_'+element_id).attr('checked')){
			var cdr =1;
		}else{
			var cdr=0;
		}

		if($('#ichwc_'+element_id).attr('checked')){
			var ichwc =1;
		}else{
			var ichwc=0;
		}
		
		if($.trim($('#category_'+element_id).val())==""){
			errors = 1;
		}
		
		if(!errors){
		
			$('#show_row_'+element_id).show();
			$('#edit_row_'+element_id).hide();
		
		//	var instance = new myForm();
		//    instance.updateMemberClasses(element_id,category,cceh,classTitle,ce_requirements,downLoadLink,facilitator,handoutLink,listenLink,classDate,cip,wcm);
		
		  $.ajax({
                type: "POST",
                url: "/utilities/infusionsoft/automation/audioFileSubmit.cfc?method=updateMemberClasses",
                data: {
					element_id : element_id,
					category : category,
					cceh : cceh,
					classTitle : classTitle,
					ce_requirements : ce_requirements,
					downLoadLink : downLoadLink,
					facilitator : facilitator,
					handoutLink : handoutLink,
					classDate : classDate,
					cip : cip,
					wcm :wcm,
					nchec:nchec,
					ace:ace,
					acsm:acsm,
					boc:boc,
					cdr:cdr,
					ichwc:ichwc
			},
			success: function(data) {
				location.reload(); 
			}
               
            });
		
		 	$('#show_category_'+element_id).html(category);
            $('#show_class_title_'+element_id).html(classTitle);
            $('#show_facilitator_'+element_id).html(facilitator);
            $('#show_handout_link_'+element_id).html(handoutLink);
            $('#show_listen_link_'+element_id).html(listenLink);
			$('#show_class_date_'+element_id).html(classDate);
            $('#show_download_link'+element_id).html(downLoadLink);
            $('#show_cceh_'+element_id).html(cceh);
		
//			
		}else{
			$('#edit_category_'+element_id).html('Please enter a category name')
			return false;
		}
		
	 });
	 
	 $('#AddNew').click(function() {
		 var errors = 0;
		 
		 if($.trim($('#add_category').val())==""){
			$('#add_category_error').html('<font color="red">Please enter a category name');
			errors = 1;
		}
		 
		 if($.trim($('#add_class_title').val())==""){
			$('#add_class_title_error').html('<font color="red">Please enter a Class Title');
			errors = 1;
		 }
		
		if(!errors){
			return true;
		}else{
			
			return false;
		}
		
	 });
	 
	 $('input[id^="delete_"]').click(function() {
		var id =  $(this).attr('id');
		var element_id = id.split("_");
		element_id = element_id[1];
		
		//var instance = new myForm();
		//instance.deleteMemberClasses(element_id);
		 $.ajax({
                type: "POST",
                url: "/utilities/infusionsoft/automation/audioFileSubmit.cfc?method=deleteMemberClasses",
                data: {
				element_id : element_id
				
			},
                dataType: "text",
               
            });
		
		$('#show_row_'+element_id).remove();
		
	 });
	 
	 $('input[id^="cancel_"]').click(function() {
		var id =  $(this).attr('id');
		var element_id = id.split("_");
		element_id = element_id[1];
		$('#show_row_'+element_id).show();
		$('#edit_row_'+element_id).hide();
	 
	 });
	 
	

});