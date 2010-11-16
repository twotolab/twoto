Ext.EventManager=function(){var Y,R,N=false;var O,X,H,T;var Q=Ext.lib.Event;var S=Ext.lib.Dom;var A="Ex"+"t";var K={};var P=function(c,E,b,a,Z){var e=Ext.id(c);if(!K[e]){K[e]={};}var d=K[e];if(!d[E]){d[E]=[];}var D=d[E];D.push({id:e,ename:E,fn:b,wrap:a,scope:Z});Q.on(c,E,a);if(E=="mousewheel"&&c.addEventListener){c.addEventListener("DOMMouseScroll",a,false);Q.on(window,"unload",function(){c.removeEventListener("DOMMouseScroll",a,false);});}if(E=="mousedown"&&c==document){Ext.EventManager.stoppedMouseDownEvent.addListener(a);}};var I=function(Z,b,f,h){Z=Ext.getDom(Z);var D=Ext.id(Z),g=K[D],E;if(g){var d=g[b],a;if(d){for(var c=0,e=d.length;c<e;c++){a=d[c];if(a.fn==f&&(!h||a.scope==h)){E=a.wrap;Q.un(Z,b,E);d.splice(c,1);break;}}}}if(b=="mousewheel"&&Z.addEventListener&&E){Z.removeEventListener("DOMMouseScroll",E,false);}if(b=="mousedown"&&Z==document&&E){Ext.EventManager.stoppedMouseDownEvent.removeListener(E);}};var F=function(b){b=Ext.getDom(b);var d=Ext.id(b),c=K[d],E;if(c){for(var a in c){if(c.hasOwnProperty(a)){E=c[a];for(var Z=0,D=E.length;Z<D;Z++){Q.un(b,a,E[Z].wrap);E[Z]=null;}}c[a]=null;}delete K[d];}};var C=function(){if(!N){N=true;Ext.isReady=true;if(R){clearInterval(R);}if(Ext.isGecko||Ext.isOpera){document.removeEventListener("DOMContentLoaded",C,false);}if(Ext.isIE){var D=document.getElementById("ie-deferred-loader");if(D){D.onreadystatechange=null;D.parentNode.removeChild(D);}}if(Y){Y.fire();Y.clearListeners();}}};var B=function(){Y=new Ext.util.Event();if(Ext.isGecko||Ext.isOpera){document.addEventListener("DOMContentLoaded",C,false);}else{if(Ext.isIE){document.write("<s"+'cript id="ie-deferred-loader" defer="defer" src="/'+'/:"></s'+"cript>");var D=document.getElementById("ie-deferred-loader");D.onreadystatechange=function(){if(this.readyState=="complete"){C();}};}else{if(Ext.isSafari){R=setInterval(function(){var E=document.readyState;if(E=="complete"){C();}},10);}}}Q.on(window,"load",C);};var W=function(E,Z){var D=new Ext.util.DelayedTask(E);return function(a){a=new Ext.EventObjectImpl(a);D.delay(Z.buffer,E,null,[a]);};};var U=function(a,Z,D,E){return function(b){Ext.EventManager.removeListener(Z,D,E);a(b);};};var G=function(D,E){return function(Z){Z=new Ext.EventObjectImpl(Z);setTimeout(function(){D(Z);},E.delay||10);};};var M=function(Z,E,D,d,c){var e=(!D||typeof D=="boolean")?{}:D;d=d||e.fn;c=c||e.scope;var b=Ext.getDom(Z);if(!b){throw'Error listening for "'+E+'". Element "'+Z+"\" doesn't exist.";}var a=function(g){g=Ext.EventObject.setEvent(g);var f;if(e.delegate){f=g.getTarget(e.delegate,b);if(!f){return ;}}else{f=g.target;}if(e.stopEvent===true){g.stopEvent();}if(e.preventDefault===true){g.preventDefault();}if(e.stopPropagation===true){g.stopPropagation();}if(e.normalized===false){g=g.browserEvent;}d.call(c||b,g,f,e);};if(e.delay){a=G(a,e);}if(e.single){a=U(a,b,E,d);}if(e.buffer){a=W(a,e);}d._handlers=d._handlers||[];d._handlers.push([Ext.id(b),E,a]);Q.on(b,E,a);if(E=="mousewheel"&&b.addEventListener){b.addEventListener("DOMMouseScroll",a,false);Q.on(window,"unload",function(){b.removeEventListener("DOMMouseScroll",a,false);});}if(E=="mousedown"&&b==document){Ext.EventManager.stoppedMouseDownEvent.addListener(a);}return a;};var J=function(E,Z,e){var D=Ext.id(E),f=e._handlers,c=e;if(f){for(var a=0,d=f.length;a<d;a++){var b=f[a];if(b[0]==D&&b[1]==Z){c=b[2];f.splice(a,1);break;}}}Q.un(E,Z,c);E=Ext.getDom(E);if(Z=="mousewheel"&&E.addEventListener){E.removeEventListener("DOMMouseScroll",c,false);}if(Z=="mousedown"&&E==document){Ext.EventManager.stoppedMouseDownEvent.removeListener(c);}};var L=/^(?:scope|delay|buffer|single|stopEvent|preventDefault|stopPropagation|normalized|args|delegate)$/;var V={addListener:function(Z,D,b,a,E){if(typeof D=="object"){var d=D;for(var c in d){if(L.test(c)){continue;}if(typeof d[c]=="function"){M(Z,c,d,d[c],d.scope);}else{M(Z,c,d[c]);}}return ;}return M(Z,D,E,b,a);},removeListener:function(E,D,Z){return J(E,D,Z);},removeAll:function(D){return F(D);},onDocumentReady:function(Z,E,D){if(N){Y.addListener(Z,E,D);Y.fire();Y.clearListeners();return ;}if(!Y){B();}D=D||{};if(!D.delay){D.delay=1;}Y.addListener(Z,E,D);},onWindowResize:function(Z,E,D){if(!O){O=new Ext.util.Event();X=new Ext.util.DelayedTask(function(){O.fire(S.getViewWidth(),S.getViewHeight());});Q.on(window,"resize",this.fireWindowResize,this);}O.addListener(Z,E,D);},fireWindowResize:function(){if(O){if((Ext.isIE||Ext.isAir)&&X){X.delay(50);}else{O.fire(S.getViewWidth(),S.getViewHeight());}}},onTextResize:function(a,Z,D){if(!H){H=new Ext.util.Event();var E=new Ext.Element(document.createElement("div"));E.dom.className="x-text-resize";E.dom.innerHTML="X";E.appendTo(document.body);T=E.dom.offsetHeight;setInterval(function(){if(E.dom.offsetHeight!=T){H.fire(T,T=E.dom.offsetHeight);}},this.textResizeInterval);}H.addListener(a,Z,D);},removeResizeListener:function(E,D){if(O){O.removeListener(E,D);}},fireResize:function(){if(O){O.fire(S.getViewWidth(),S.getViewHeight());}},ieDeferSrc:false,textResizeInterval:50};V.on=V.addListener;V.un=V.removeListener;V.stoppedMouseDownEvent=new Ext.util.Event();return V;}();Ext.onReady=Ext.EventManager.onDocumentReady;Ext.onReady(function(){var B=Ext.getBody();if(!B){return ;}var A=[Ext.isIE?"ext-ie "+(Ext.isIE6?"ext-ie6":"ext-ie7"):Ext.isGecko?"ext-gecko":Ext.isOpera?"ext-opera":Ext.isSafari?"ext-safari":""];if(Ext.isMac){A.push("ext-mac");}if(Ext.isLinux){A.push("ext-linux");}if(Ext.isBorderBox){A.push("ext-border-box");}if(Ext.isStrict){var C=B.dom.parentNode;if(C){C.className+=" ext-strict";}}B.addClass(A.join(" "));});