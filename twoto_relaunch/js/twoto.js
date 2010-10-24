
// onload action
	
$(window).load(function(){
	// The DOM (document object model) is constructed
	/*
	if ($.browser.webkit) {
	    //alert(&quot;this is webkit!&quot;);
	    $(&quot;#magicBox&quot;).addClass('moveWebKitUp');
	    $(&quot;.moveWebKitUp&quot;).css('margin-top','4px');
	    
	    
	 }
	*/
	// check Browser
	
	$browserTypeWebkit = false;
	if ($.browser.webkit) {
	    //alert("this is webkit!");
	    $browserTypeWebkit = true;
	}
	
	// We will initialize and run our plugin here
	//
	
	// form tuning
	
	$('.service input[type="text"]').addClass("idleField");
	    $('.service input[type="text"]').focus(function() {
	    	$(this).removeClass("idleField").addClass("focusField");
	        if (this.value == this.defaultValue){
	        	this.value = '';
	    	}
	        if(this.value != this.defaultValue){
	        	this.select();
	        }
	    });
	    $('.service input[type="text"]').blur(function() {
	    	if(this.value != this.defaultValue){
	    		$(this).removeClass("focusField").addClass("filledField");
	        } else{
	        $(this).removeClass("focusField").addClass("idleField");
	        }
	    	
	        if ($.trim(this.value == '')){
	        	this.value = (this.defaultValue ? this.defaultValue : '');
	    	}
	    	
	    });
	  
	$('.service textarea').addClass("idleField");
	    $('.service textarea').focus(function() {
	    	$(this).removeClass("idleField").addClass("focusField");
	        if (this.value == this.defaultValue){
	        	this.value = '';
	    	}
	        if(this.value != this.defaultValue){
	        	this.select();
	        }
	    });
	    $('.service textarea').blur(function() {
	    	if(this.value != this.defaultValue){
	    		$(this).removeClass("focusField").addClass("filledField");
	        } else{
	        $(this).removeClass("focusField").addClass("idleField");
	        }
	    	
	        if ($.trim(this.value == '')){
	        	this.value = (this.defaultValue ? this.defaultValue : '');
	    	}
	    	
	    });
	

	// search form tuning
	//
	$('form fieldset input[type="text"]').focus(function() {
	        if (this.value == this.defaultValue){
	        	this.value = '';
	    	}
	        if(this.value != this.defaultValue){
	        	this.select();
	        }
	   });
	
	// search expender
	$heightSearch = $("#search_extended").height(); 

	$(".searchExpendedElt").height(1); 
	
	var caseSearchHandler ="close";
	
	$('#search a').click(function(){	
		//alert("search");
		if(caseSearchHandler == "close"){
			caseSearchHandler= "open";
				
			$(".searchExpendedElt").css('display','block');
			$(".searchExpendedElt").css('visibility','visible');
			
			$(".searchExpendedElt").stop().animate({
				height: $heightSearch+'px',duration: 'slow'
				});
			
			$(this).removeClass('moreButton').addClass('closeButton');
			$(this).html("close");	

		} else if(caseSearchHandler != "close"){
			caseSearchHandler ="close";
			
			
			$(".searchExpendedElt").stop().animate({
			height: '1px',duration: 'slow',
				},function(){
				$(this).css('display','none');
				$(this).css('visibility','hidden');
				
				$('#search a').removeClass('closeButton').addClass('moreButton');
				$('#search a').html("search");
				
				});
		}
	});	
	//contentInfo Handler
	
	$('#profile a').click(function(){
		contentInfoHandler("profile");
	});
	$('#service a').click(function(){	
		contentInfoHandler("service");
	});
	$('#contact a').click(function(){	
		contentInfoHandler("contact");
	});
	
	var caseHandler ="close";
	var selected="";;
	var lastSelected="";
	
	var pos_profile="236px";
	var pos_service="476px";
	var pos_contact="716px";

	function MoveItArrow(selected){
	
	
		if(selected=="profile"){
			$(".arrowTopElt").animate({"left": pos_profile,opacity: 1}, "slow");
			}
		else if(selected=="service"){
			$(".arrowTopElt").animate({"left": pos_service,opacity: 1}, "slow");
			}
		else if(selected=="contact"){
			$(".arrowTopElt").animate({"left": pos_contact,opacity: 1}, "slow");
			
			}
		else if(selected="CLOSE"){
			$(".arrowTopElt").animate({"left": pos_contact,opacity: 0} ,"slow",function(){
				$(".arrowTopElt").css('visibility','hidden');
			});
			
				
			}
		
		}
	function contentInfoHandler(selected){

		if ($(".contentInfo").is('.close')) {
			caseHandler= "close";
		} else{
			caseHandler ="open";
		}
		
		if (caseHandler == "close" && selected != lastSelected) {
			lastSelected = selected;
				 $(".contentInfo").removeClass('close').addClass('open');
				 $("#"+selected+" a").removeClass('moreButton').addClass('closeButton');
				 $("#"+selected+" a").html("close");	
				 
				 $(".contentInfo").css('visibility','visible');
				 $(".contentInfo").css('display','block');
					$(".contentInfo").stop().animate({
						height: "225"
					},function(){
						$(".arrowTopElt").css('display','block');
						$(".arrowTopElt").css('visibility','visible');
						
					 	MoveItArrow(selected);
					});
					$("#stage").stop().animate({
						height: "1",
						opacity: "0"
					});
					
					$(".contentInfo .service").hide();	
					$(".contentInfo .profile").hide();
					$(".contentInfo .contact").hide();
					$(".contentInfo "+"."+selected).stop().slideToggle('slow');
					
					
					
					
		 	} else if (caseHandler == "open"  && selected == lastSelected) {
		 		
				$(".contentInfo").removeClass('open').addClass('close');
				$("#"+lastSelected+" a").removeClass('closeButton').addClass('moreButton');
				$("#"+lastSelected+" a").html("more");		 
				 MoveItArrow("CLOSE");
				 
			  	$(".contentInfo").stop().animate({
						height: "0"
					
					},function(){
							$(".contentInfo").css('visibility','hidden');
							$(".contentInfo").css('display','none');
					});
				 	$("#stage").stop().animate({
						height: "130px",
						opacity: "1"
					});
					 lastSelected = "";
						
						$(".contentInfo .service").hide();	
						$(".contentInfo .profile").hide();
						$(".contentInfo .contact").hide();
			}	
		 	else if (caseHandler == "open"  && selected != lastSelected) {
		 	
		 		$("#"+lastSelected+" a").removeClass('closeButton').addClass('moreButton');
		 		$("#"+lastSelected+" a").html("more");		
		 		$("#"+selected+" a").removeClass('moreButton').addClass('closeButton');
		 		$("#"+selected+" a").html("close");
		 	
		 		lastSelected = selected;
		 		$(".contentInfo .service").hide();	
				$(".contentInfo .profile").hide();
				$(".contentInfo .contact").hide();
				$(".contentInfo "+"."+selected).stop().slideToggle('slow');	
				$(".arrowTopElt").css('opacity','0.8');
				MoveItArrow(selected);
		 	}
		}
	
	// mansonry
	
	var speed = 1000,  // animation speed
    $wall = $('#mansonry');

	$('#mansonry').masonry({
		 singleMode: true, 
	    // only apply masonry layout to visible elements
	    itemSelector: '.box:not(.invis)',
	    animate: true,
	    animationOptions: {
	        duration: speed,
	        queue: false
	    }
	});

	$('#filterNavigation a').click(function(){
		
	    var colorClass = '.' + $(this).attr('class');
	    
	    $actualSelected = $('#filterNavigation').find('.selected_filter');
	    $actualSelected.css('color',$basicColor);
	    $actualSelected.removeClass('selected_filter');
	    $actualSelected.css('color',$basicColor);
	   $(this).parent().addClass('selected_filter');
	    var $selected  = $(".selected_filter");
	    
	    $magicBox
	    .width($selected.width())
	    .css("left", $selected.find("a").position().left)
	    .data("origLeft", $selected.find("a").position().left)
	    .data("origWidth", $magicBox.width())
	    .data("origColor", $basicColor);
	    

	     
	    
	    $selected.find("a").stop().animate({color:hightLightColor});
        $magicBox.stop().animate({
            left: $magicBox.data("origLeft"),
            width: $magicBox.data("origWidth"),
            
        });    
	    
	    if(colorClass=='.all') {
	        // show all hidden boxes
	        $wall.children('.invis')
	            .toggleClass('invis').fadeIn(speed);
	    } else {    
	        // hide visible boxes 
	        $wall.children().not(colorClass).not('.invis')
	            .toggleClass('invis').fadeOut(speed);
	        // show hidden boxes
	        $wall.children(colorClass+'.invis')
	            .toggleClass('invis').fadeIn(speed);
	    }
	    $wall.masonry();

	    return false;
	});
	
	// menu Effects: magicBox,rollOver,rollOut
	
    var $el, leftPos, newWidth;
    var $mainNav = $("#filterNavigation");

    	
    $mainNav.append("<li id='magicBox'></li>");
    var $magicBox = $("#magicBox");
    var $selected = $(".selected_filter");
    
    var basicColor =$('#filterNavigation li').css('color');
    var hightLightColor=$('.selected_filter a').css('color');

    var $basicColor =$(basicColor);
    var $hightLightColor =$(hightLightColor);
    
    $magicBox
    .width($selected.width())
    .css("left", $selected.find("a").position().left)
    .data("origLeft", $selected.find("a").position().left)
    .data("origWidth", $magicBox.width())
    .data("origColor", $basicColor);
    
    
    // fix for webkit
    if ($browserTypeWebkit == true) {
       var moveWebKitUp = parseInt($magicBox.css("margin-top"))-1;
            //alert("hello :"+moveWebKitUp);
            $magicBox.css("margin-top",moveWebKitUp);
       
    }
    
    $("#filterNavigation li").find("a").hover(function() {
        $el = $(this);
        
        leftPos = $el.position().left;
        newWidth = $el.parent().width();
        
        $el.stop().animate({color:hightLightColor}); 
        // rollOn
        if( $el.parent().hasClass("selected_filter")){
        	$(".selected_filter").find("a").css('color',$hightLightColor)
        } else{
        	$(".selected_filter").find("a").stop().animate({color:basicColor}); 
        }
       
        $magicBox.stop().animate({
            left: leftPos,
            width: newWidth
        })
        
    }, function() {
    	// rollOut
    	$el.stop().animate({color:basicColor}); 
    	$(".selected_filter").find("a").stop().animate({color:hightLightColor});
        $magicBox.stop().animate({
            left: $magicBox.data("origLeft"),
            width: $magicBox.data("origWidth"),
            
        });    
    });
    
});