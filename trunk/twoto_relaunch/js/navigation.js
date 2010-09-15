$(function(){

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
	    
	    $actualSelected = $('#filterNavigation').find('.current_page_item_two');
	    $actualSelected.css('color',$basicColor);
	    $actualSelected.removeClass('current_page_item_two');
	    $actualSelected.css('color',$basicColor);
	   $(this).parent().addClass('current_page_item_two');
	    var $selected  = $(".current_page_item_two");
	    
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
    var $selected = $(".current_page_item_two");
    
    var basicColor =$('#filterNavigation li').css('color');
    var hightLightColor=$('.current_page_item_two a').css('color');

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
        if( $el.parent().hasClass("current_page_item_two")){
        	$(".current_page_item_two").find("a").css('color',$hightLightColor)
        } else{
        	$(".current_page_item_two").find("a").stop().animate({color:basicColor}); 
        }
       
        $magicBox.stop().animate({
            left: leftPos,
            width: newWidth
        })
        
    }, function() {
    	// rollOut
    	$el.stop().animate({color:basicColor}); 
    	$(".current_page_item_two").find("a").stop().animate({color:hightLightColor});
        $magicBox.stop().animate({
            left: $magicBox.data("origLeft"),
            width: $magicBox.data("origWidth"),
            
        });    
    });
});