var agt = navigator.userAgent.toLowerCase();
var apName = navigator.appName.toLowerCase();
var is_nav4 = ((apName == "netscape") && (parseInt(navigator.appVersion) < 5))? 1:0; 
var is_ie4 = ((apName == "msie") && (parseInt(navigator.appVersion) < 5))? 1:0;
var is_dom = document.getElementById? 1:0;
var is_gecko = (agt.indexOf('gecko') != -1)? 1:0;
var is_ie = (agt.indexOf("msie") != -1)? 1:0;
var is_nav = (agt.indexOf('mozilla')!=-1) && (agt.indexOf('opera')==-1)? 1:0;
var is_ie5up = (is_dom && is_ie)? 1:0;
var is_nav6up = (is_dom && (is_gecko || is_nav))? 1:0;


var docObj = is_nav4? "document.": is_ie4? "document.all.": is_dom? "document.getElementById('": 0;
var styleObj = is_nav4? "": is_ie4? "": is_dom? "')":0; 

var current_popup_id = '';
var pupup_timer_id = '';

//----------------------------------------------
function on_eo(event,id,status){
		if(current_popup_id && current_popup_id!=id){
			var el = eval(docObj + current_popup_id + styleObj);
			el.style.display = 'none';		
		}		
		var el = eval(docObj + id + styleObj);							
		if(status == 'show'){
			if(current_popup_id==id) return;
			if (is_dom && window.event) { 
				leftVal = window.event.clientX + 20 + document.documentElement.scrollLeft + document.body.scrollLeft; 
				topVal = window.event.clientY + 10 + document.documentElement.scrollTop + document.body.scrollTop;
			} else if (is_ie4) { 
				topVal = eval(event.y + 10 + document.body.scrollTop);
				leftVal = eval(event.x+ 20 );
			} else if (is_nav4) {
				topVal = eval(event.pageY + 10);
				leftVal = eval(event.pageX + 20);
			} else {				
				leftVal = event.clientX + 20 + window.scrollX;
				topVal = event.clientY + 10 + window.scrollY; 
			} 
			if (leftVal < 2) { leftVal = 2; } 		
			el.style.left = leftVal;
			el.style.top = topVal;				
			el.style.display = 'block';
			current_popup_id = id;
			//el.style.zIndex = 100;
			window.clearTimeout(pupup_timer_id);
			return;
		}
		if(status == 'pause'){
			window.clearTimeout(pupup_timer_id);
			return;
		}
		if(status == 'fade_hide'){
			pupup_timer_id = window.setTimeout("on_eo('','"+id+"','hide')",500);		
			return;
		}
		if(status == 'hide'){
			el.style.display = 'none';
			current_popup_id = '';
			return;
		}		
}