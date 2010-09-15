/**
 * @author decaix
 */

$(function() {
	
	 var $el, leftPos, newWidth,
     $mainNav2 = $("#filteringNav");

$mainNav2.append("<li id='magic-line'></li>");

var $magicLineTwo = $("#magic-line");

$magicLineTwo
.width($(".current_page_item").width())
/*.height(/$mainNav2.height())*/
.height(30)
.css("left", $(".current_page_item a").position().left)
.data("origLeft", $(".current_page_item a").position().left)
.data("origWidth", $magicLineTwo.width())
.data("origColor", $(".current_page_item a").attr("rel"));
        
$("#filteringNav li").find("a").hover(function() {
$el = $(this);
leftPos = $el.position().left;
newWidth = $el.parent().width();
$magicLineTwo.stop().animate({
    left: leftPos,
    width: newWidth,
    backgroundColor: $el.attr("rel")
})
}, function() {
$magicLineTwo.stop().animate({
    left: $magicLineTwo.data("origLeft"),
    width: $magicLineTwo.data("origWidth"),
    backgroundColor: $magicLineTwo.data("origColor")
});    
});
});