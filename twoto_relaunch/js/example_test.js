$(function(){

    var $el, leftPos, newWidth,
        $mainNav2 = $("#filterNavigation");
    
    /*
        EXAMPLE TWO
    */
    $mainNav2.append("<li id='magicBox'></li>");
    
    var $magicBox = $("#magicBox");
    var $selected = $(".current_page_item_two a");
    var $basicColor =$("#000");
    var $ndColor =$("#fff");
    
    $selected.css({color:$ndColor});
    $magicBox
        .width($(".current_page_item_two").width())
        .height($mainNav2.height()-5)
        .css("left", $selected.position().left)
        .data("origLeft", $selected.position().left)
        .data("origWidth", $magicBox.width())
        .data("origColor", $basicColor);
                
    $("#filterNavigation li").find("a").hover(function() {
        $el = $(this);
       
        leftPos = $el.position().left;
        newWidth = $el.parent().width();
        $selected.stop().animate({color:"#000"});
        $magicBox.stop().animate({
            left: leftPos,
            width: newWidth
        })
        
    }, function() {
    	$selected.stop().animate({color:"#fff"});
        $magicBox.stop().animate({
            left: $magicBox.data("origLeft"),
            width: $magicBox.data("origWidth"),
        });    
    });
});