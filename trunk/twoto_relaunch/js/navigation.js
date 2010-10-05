
// onload action
	
$(window).load(function(){

	 // The DOM (document object model) is constructed
    // We will initialize and run our plugin here
	$('#profile a').click(function(){	
		contentHandler("profile");
	});
	$('#service a').click(function(){	
		contentHandler("service");
	});
	$('#contact a').click(function(){	
		contentHandler("contact");
	});
	
	//content Handler
	var caseHandler ="close";
	var selected="";;
	var lastSelected="";
	contentHandler = function (selected){

		if ($(".contentStage").is('.close')) {
			caseHandler= "close";
		} else{
			caseHandler ="open";
		}

		if (caseHandler == "close" && selected != lastSelected) {
			lastSelected = selected;
				 $(".contentStage").removeClass('close').addClass('open');
				 $(".contentStage").css('visibility','visible');
				 $(".contentStage").css('display','block');
					$(".contentStage").stop().animate({
						height: "130"
					
					});
					$("#stage").stop().animate({
						height: "1",
						opacity: "0"
					});
					
					
					$(".contentStage .service").hide();	
					$(".contentStage .profile").hide();
					$(".contentStage .contact").hide();
					$(".contentStage "+"."+selected).stop().slideToggle('slow');		
					
		 	} else if (caseHandler == "open"  && selected == lastSelected) {
		 		
				 $(".contentStage").removeClass('open').addClass('close');
				 
			  	$(".contentStage").stop().animate({
						height: "0"
					
					},function(){
							$(".contentStage").css('visibility','hidden');
							$(".contentStage").css('display','none');
					});
				 	$("#stage").stop().animate({
						height: "130px",
						opacity: "1"
					});
					 lastSelected = "";
						
						$(".contentStage .service").hide();	
						$(".contentStage .profile").hide();
						$(".contentStage .contact").hide();
			}	
		 	else if (caseHandler == "open"  && selected != lastSelected) {
		 		lastSelected = selected;
		 		$(".contentStage .service").hide();	
				$(".contentStage .profile").hide();
				$(".contentStage .contact").hide();
				$(".contentStage "+"."+selected).stop().slideToggle('slow');	
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

//});
	});