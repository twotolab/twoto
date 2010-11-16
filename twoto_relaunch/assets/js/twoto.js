
// onload action
	
$(document).ready(function() {
	// The DOM (document object model) is constructed
	/*
	if ($.browser.webkit) {
	    //alert(&quot;this is webkit!&quot;);
	    $(&quot;#magicBox&quot;).addClass('moveWebKitUp');
	    $(&quot;.moveWebKitUp&quot;).css('margin-top','4px');
	    
	    
	 }
	*/
	// case searchResult missing
	if($('#searchResult').length == 0){
	//alert("nor results")
	$('#caseResults').html("");
	$('<div id="searchResult" class="grid_4 naviElt lineBottom"><h5>no results</h5></div><div id="searchResult" class="grid_4 naviElt lineBottom"><h5>enter new search</h5></div><div id="searchResult" class="grid_4 naviElt lineBottom"> <h5>&mdash; </h5></div></div><!-- End SEARCH HEADLINES EXTENDED --><!-- SEARCH EXTENDED CONTENT--><div id="searchContents_extended" class="container_16"><div id="" class="grid_16 news alpha omega"><div id="mansonry_search" class="wrap"> </div></div></div>').appendTo('#caseResults');

	}

	// check Browser
	
	$browserTypeWebkit = false;
	if ($.browser.webkit) {
	    //alert("this is webkit!");
	    $browserTypeWebkit = true;
	    // init css modification
	    $(".moreButton").css("padding","0 0 3px 20px");
	    $(".arrowTopElt").css("margin","6px 0 0 0");
	    $(".filter").css("padding","0 0 4px 0");
	    $(".feeds").css("padding","0 0 13px 0");
	    $(".search").css("padding","0 0 13px 0");
		// example:  $('#feeds').removeClass('naviElt').addClass('naviEltWebKit');
	}

if(navigator.platform === "Win32"){
if ($.browser.webkit) {
$(".moreButton").css("padding","0 0 1px 20px");

           //alert("hello :"+moveWebKitUp);
}

}

	$("a .thumbnail").each(function(){
		
	
	var images_URL =  $(this).attr("src");
	var image_height = $(this).height();
    var image_width = $(this).width();
	$(this).parent().css('background-image','url('+images_URL+')');
	$(this).parent().css('background-repeat','none');
	$(this).parent().css('width',image_width);
	$(this).parent().css('height',image_height);
	$(this).parent().css('display','block');
	$(this).hide();
		//alert("images_URL : "+images_URL);
	});
	

	
	$(".thumbnailLinkElt").hover(
		function(){
			//alert("hover");
        	var image_width = $(this).find('img').width();
        	$(this).css('backgroundPosition',-(image_width));
        	$(this).fadeOut(200);
        	$(this).fadeIn(100);
			//$(this).animate( {backgroundPosition:-(image_width)} , 500 );
		},
  		function () {
  		$(this).css('backgroundPosition',0);

	});
		/*
		function(){	
			$(this).animate( {backgroundPosition: -100px } , 1000 );
			$(this).parent().children('img').hide();
			$(this).hide();
		}*/
	
	
	// We will initialize and run our plugin here
	//
	/*
	if (window.projectPage === undefined){
		//alert("window.projectPage is undefined/undeclared"); 
	} 
	*/
	// turm on validation in form
	$("#contactForm").validate({
	
	errorLabelContainer: ".infoForm",
	showErrors: function(errorMap, errorList) {
		$(".infoForm").html("&rarr; " + this.numberOfInvalids() + " errors. ");
		this.defaultShowErrors();
	},
   rules: {
     // simple rules
     name: {
       required: true,
       minlength: 2
     },
     from: {
       required: true
     },
     comment1: {
       required: true
     },
     // compound rule
     email: {
       required: true,
       email: true
     }
    }
})
		$("#contactForm").submit(function(){
	
	// 'this' refers to the current submitted form
	var str = $(this).serialize();
	
	   $.ajax({
	   type: "POST",
	   url: "assets/contactForm/contact.php",
	   data: str,
	   success: function(msg){
		
	$(".infoForm").ajaxComplete(function(event, request, settings){
	
	$(".infoForm").css("display","inline");
	if(msg == 'OK') // Message Sent? Show the 'Thank You' message and hide the form
	{
		
	result = '<div class="notification_ok" style ="display:inline">&rarr;  Your message has been sent. Thank you!</div>';
	$(".sendElt").hide();
	$("form .expendedElt").css("background-image","none");
	}
	else
	{
	result = msg;
	}
		
	$(this).html(result);
	
	});
	
	}
	
	 });
	
	return false;
	
	});

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
	    	/*
	        if ($.trim(this.value == '')){
	        	this.value = (this.defaultValue ? this.defaultValue : '');
	    	}
	    	*/
	    	
	    	
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

	$.extend({
	  getUrlVars: function(){
	    var vars = [], hash;
	    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	    for(var i = 0; i < hashes.length; i++)
	    {
	      hash = hashes[i].split('=');
	      vars.push(hash[0]);
	      vars[hash[0]] = hash[1];
	    }
	    return vars;
	  },
	  getUrlVar: function(name){
	    return $.getUrlVars()[name];
	  }
	});
	// Get object of URL parameters
	var allVars = $.getUrlVars();
	
	// Getting URL var by its nam
	var bySearch = $.getUrlVar('search');

	// search expender
	$heightSearch = $(".searchExpendedElt").height();
//	$(".searchExpendedElt").height(1);
	var caseSearchHandler ="close";

	if (bySearch){
		//alert("....starting with: "+allVars+"::::"+bySearch);
		// starting with searching
		$(".searchExpendedElt").height($heightSearch);
		$(".searchExpendedElt").css('display','block');
		$(".searchExpendedElt").css('visibility','visible');
		
		$('#search a').removeClass('moreButton').addClass('closeButton');
		$('#search a').html("close search");
		
		caseSearchHandler= "open";
				
	} else{
		//alert("....starting with: "+allVars+"::::"+bySearch);
		// starting with no searching
		$(".searchExpendedElt").height(1); 
		$(".searchExpendedElt").css('display','none');
		$(".searchExpendedElt").css('visibility','hidden');

	
		$('#search a').removeClass('closeButton').addClass('moreButton');
		$('#search a').html("search");
		caseSearchHandler ="close";
	}

	
	$('.searchReset').click(function(){

 		$(':text', '#searchform').val('');  

	});

    
    	$('.searchReset').click(function(){
		$('.searchInput').val('');
	});
	
	
	$('#search a').click(function(){	
		//alert("search");
		if(caseSearchHandler == "close"){
			//alert("search open $heightSearch"+$heightSearch);
			caseSearchHandler= "open";
			$(".searchExpendedElt").css('display','block');
			$(".searchExpendedElt").css('visibility','visible');
			
			$(".searchExpendedElt").stop().animate({
				height: $heightSearch,duration: 'slow'
				});
			
			$(this).removeClass('moreButton').addClass('closeButton');
			$(this).html("close search");	

		} else {
			//alert("search close");
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
	$('#imprint a').click(function(){	
		contentInfoHandler("contact");
	});
	
	var caseHandler ="close";
	var selected="";;
	var $lastSelected="";
	
	var pos_profile="237px";
	var pos_service="477px";
	var pos_contact="717px";

	function MoveItArrow(selected){
	
	
		if(selected=="profile"){
			$(".arrowTopElt").css("opacity", "0");
			$(".arrowTopElt").stop().animate({
			 	"left": pos_profile,
			 	opacity: 1,
				duration: 'slow'
			});
			$(".arrowTopElt").css("background-position", "0px 0px");
			}
		else if(selected=="service"){
			$(".arrowTopElt").css("opacity", "0");
			$(".arrowTopElt").stop().animate({
			 	"left": pos_service,
			 	opacity: 1,
				duration: 'slow'
			});
			$(".arrowTopElt").css("background-position", "-20px 0px");
			}
		else if(selected=="contact"){
			$(".arrowTopElt").css("opacity", "0");
			$(".arrowTopElt").stop().animate({
			 	"left": pos_contact,
			 	opacity: 1,
				duration: 'slow'
			});
			$(".arrowTopElt").css("background-position", "-40px 0px");
			
			}
		else if(selected="CLOSE"){
			$(".arrowTopElt").css("opacity", "0");
			$(".arrowTopElt").css("left", pos_profile);
			$(".arrowTopElt").css('visibility','hidden');
			}
			
		
		}
	function contentInfoHandler(selected){

		if ($(".contentInfo").is('.close')) {
			caseHandler= "close";
		} else{
			caseHandler ="open";
		}
		
		if (caseHandler == "close" && selected != $lastSelected) {
		
			if(window.projectPage === "true" || window.newsPage === "true"){
			 closeProject(selected);
			// alert("here we are");
			} else{
			 //alert("alternative we are");
			// start case
			$lastSelected = selected;
			$(".contentInfo").removeClass('close').addClass('open');
			$("#"+selected+" a").removeClass('moreButton').addClass('closeButton');
			$("#"+selected+" a").html("close");	
			
			$(".contentInfo").css('visibility','visible');
			$(".contentInfo").css('display','block');
			$(".contentInfo").css("margin-bottom","20px");
			$(".contentInfo").stop().animate({
			 height: "225",duration: 'slow'
			},function(){
			 $(".arrowTopElt").css('display','block');
			 $(".arrowTopElt").css('visibility','visible');
			 
			MoveItArrow(selected);
			});
			$(".stageIntro").data("originalHeight",$(".stageIntro").height());
			$stageHeight = $(".stageIntro").data("originalHeight");
			$(".stageIntro").stop().animate({
			 height: "1",
			 opacity: "0"},function(){
			 $(".stageIntro").css('visibility','hidden');
			$(".stageIntro").css('display','none');
			});
			
			$(".contentInfo .service").hide();	
			$(".contentInfo .profile").hide();
			$(".contentInfo .contact").hide();
			
			$(".contentInfo "+"."+selected).stop().slideToggle('slow');
			// end case
			}
			$("#menu").stop().animate({
			 opacity: "0.2"}
			);
			$("#contents").stop().animate({
			 opacity: "0.2"}
			);		
		
		 } else if (caseHandler == "open"  && selected == $lastSelected) {
		 		
		 		
				$(".contentInfo").removeClass('open').addClass('close');
				$("#"+$lastSelected+" a").removeClass('closeButton').addClass('moreButton');
				$("#"+$lastSelected+" a").html("more");		 
				 MoveItArrow("CLOSE");
				 
				 						
				$(".stageIntro").css('visibility','visible');
				$(".stageIntro").css('display','block');
				if(window.projectPage === "true" || window.newsPage === "true"){
					$("#menu").css("margin-top","80px");
				};
				 
		$(".stageIntro").stop().animate({
			 height: $stageHeight,
			 opacity: "1"
			});
			  	$(".contentInfo").stop().animate({
						height: "0",duration: 'slow'
					
					},function(){
						$(".contentInfo").css('visibility','hidden');
						$(".contentInfo").css('display','none');

						
						if(window.projectPage === "true" || window.newsPage === "true"){
							$("#menu").css("margin-top","0px");
			 				openProject();
						};		
		
					});
					
			
				$lastSelected = "";
				    
				$(".contentInfo .service").hide();	
			 	$(".contentInfo .profile").hide();
				$(".contentInfo .contact").hide();
				
			$("#menu").stop().animate({
			 opacity: "1"}
			);
			$("#contents").stop().animate({
			 opacity: "1"}
			);	
				
			}	
		 	else if (caseHandler == "open"  && selected != $lastSelected) {
		 	
		 		$("#"+$lastSelected+" a").removeClass('closeButton').addClass('moreButton');
		 		$("#"+$lastSelected+" a").html("more");		
		 		$("#"+selected+" a").removeClass('moreButton').addClass('closeButton');
		 		$("#"+selected+" a").html("close");
		 	
		 		$lastSelected = selected;
		 		$(".contentInfo .service").hide();	
				$(".contentInfo .profile").hide();
				$(".contentInfo .contact").hide();
				$(".contentInfo "+"."+selected).stop().slideToggle('slow');	
				$(".arrowTopElt").css('opacity','1');
				MoveItArrow(selected);
		 	}
		}
	// project
	
	function closeProject(selected){
			
			$("#menu").css("margin-top","80px");

			$('#slideshow').cycle('pause');
			
			$(".stageProject").stop().animate({
					height: "1",duration: 'slow'				
					},function(){		
						// end action
			
			$(".stageProject").css('visibility','hidden');
			$(".stageProject").css('display','none');

	
				// start case
			//alert("selected we are: "+selected);
			
			$lastSelected = selected;
			$(".contentInfo").removeClass('close').addClass('open');
			$("#"+selected+" a").removeClass('moreButton').addClass('closeButton');
			$("#"+selected+" a").html("close");	
			
			$(".contentInfo").css('visibility','visible');
			$(".contentInfo").css('display','block');
			$(".contentInfo").stop().animate({
			 height: "225",duration: 'slow'
			},function(){
			 $(".arrowTopElt").css('display','block');
			 $(".arrowTopElt").css('visibility','visible');
			 			$("#menu").css("margin-top","0px");
			MoveItArrow(selected);
			});
			$(".stageProject").data("originalHeight",$(".stageProject").height());
			$stageHeight = $(".stageProject").data("originalHeight");

			
			$(".contentInfo .service").hide();	
			$(".contentInfo .profile").hide();
			$(".contentInfo .contact").hide();
			
			$(".contentInfo "+"."+selected).stop().slideToggle('slow');
			
			// end case
			
										
			});
			$projectInfoHeight = $(".projectInfo").height();
			
			$(".logoProject").css('visibility','hidden');
			$(".projectInfo").css('visibility','hidden');
			$(".projectInfo").css('display','none');
			$(".projectInfo").css('height','0');
			$(".contentInfo").css("margin-bottom","20px");
			

			
	};


	function openProject(){

			$(".stageProject").css("margin-top","100px");	
			$(".stageProject").css('visibility','visible');
			$(".stageProject").css('display','block');
			$(".logoProject").css('visibility','visible');
						
			$(".stageProject").stop().animate({
					height: "420px",
					opacity:"1",
					duration: 'slow'	
					},function(){
						// end action
					$(".projectInfo").css('visibility','visible');
					$('#slideshow').cycle('resume');
					});
			

			$(".projectInfo").css('display','block');
			$(".projectInfo").css('height',$projectInfoHeight);
			$(".contentInfo").css("margin-bottom","0px");
	
	
	};
	function introProject(){
	
			//$(".stageProject").css('height','1px');
			$(".stageProject").css('visibility','visible');
			$(".stageProject").css('display','block');
			//$(".projectInfo").css('visibility','hidden');
			$(".projectInfo").css('visibility','visible');	

				/*		
			$(".stageProject").stop().animate({
					height: "420px",duration: 'fast'	
					},function(){
						// end action
						$(".projectInfo").css('visibility','visible');
					});
				*/	
			$(".logoProject").css('visibility','visible');
			$(".projectInfo").css('display','block');
			$(".contentInfo").css("margin-bottom","0px");
	
	};

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
    	if(navigator.platform === "Win32"){
    		var moveWebKitUp = parseInt($magicBox.css("margin-top"));
        }else{
        	var moveWebKitUp = parseInt($magicBox.css("margin-top"));
		}   
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
    		if(window.projectPage === "true" || window.newsPage === "true"){
		introProject();
	}
});