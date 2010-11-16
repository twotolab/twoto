Ext.namespace("MODx");Ext.apply(Ext,{isFirebug:(window.console&&window.console.firebug)});MODx=function(A){A=A||{};MODx.superclass.constructor.call(this,A);this.config=A;this.startup();};Ext.extend(MODx,Ext.Component,{config:{},util:{},window:{},panel:{},tree:{},form:{},grid:{},combo:{},toolbar:{},page:{},msg:{},startup:function(){this.initQuickTips();this.request=this.getURLParameters();this.Ajax=this.load({xtype:"modx-ajax"});Ext.override(Ext.form.Field,{defaultAutoCreate:{tag:"input",type:"text",size:"20",autocomplete:"on"}});Ext.menu.Menu.prototype.enableScrolling=false;this.addEvents({beforeClearCache:true,beforeLogout:true,beforeReleaseLocks:true,afterClearCache:true,afterLogout:true,afterReleaseLocks:true,ready:true});Ext.state.Manager.setProvider(new Ext.state.CookieProvider({expires:new Date(new Date().getTime()+(1000*60*60*24))}));},load:function(){var B=arguments,A=B.length;var D=[];for(var C=0;C<A;C=C+1){if(!B[C].xtype||B[C].xtype===""){return false;}D.push(Ext.ComponentMgr.create(B[C]));}return(D.length===1)?D[0]:D;},initQuickTips:function(){Ext.QuickTips.init();Ext.apply(Ext.QuickTips.getQuickTip(),{dismissDelay:2300,interceptTitles:true});},getURLParameters:function(){var A={};var B=document.location.href;if(B.indexOf("?")!==-1){var E=B.split("?")[1];var D=E.split("&");for(var C=0;C<D.length;C=C+1){A[D[C].split("=")[0]]=D[C].split("=")[1];}}return A;},loadAccordionPanels:function(){return[];},clearCache:function(){if(!this.fireEvent("beforeClearCache")){return false;}var A="/clearcache/";if(this.console==null||this.console==undefined){this.console=MODx.load({xtype:"modx-console",register:"mgr",topic:A,show_filename:0,listeners:{"shutdown":{fn:function(){if(this.fireEvent("afterClearCache")){Ext.getCmp("modx-layout").refreshTrees();}},scope:this}}});}else{this.console.setRegister("mgr",A);}this.console.show(Ext.getBody());MODx.Ajax.request({url:MODx.config.connectors_url+"system/index.php",params:{action:"clearCache",register:"mgr",topic:A},listeners:{"success":{fn:function(){this.console.fireEvent("complete");},scope:this}}});return true;},releaseLock:function(A){if(this.fireEvent("beforeReleaseLocks")){MODx.Ajax.request({url:MODx.config.connectors_url+"resource/locks.php",params:{action:"release",id:A},listeners:{"success":{fn:function(B){this.fireEvent("afterReleaseLocks",B);},scope:this}}});}},sleep:function(A){var C=new Date().getTime();for(var B=0;B<10000000;B++){if((new Date().getTime()-C)>A){break;}}},logout:function(){if(this.fireEvent("beforeLogout")){MODx.msg.confirm({title:_("logout"),text:_("logout_confirm"),url:MODx.config.connectors_url+"security/logout.php",params:{action:"logout",login_context:"mgr"},listeners:{"success":{fn:function(A){if(this.fireEvent("afterLogout",A)){location.href="./";}},scope:this}}});}},getPageStructure:function(A,B){B=B||{};if(MODx.config.manager_use_tabs){Ext.applyIf(B,{xtype:"modx-tabs",itemId:"tabs",style:"margin-top: .5em;",items:A});}else{Ext.applyIf(B,{xtype:"portal",itemId:"tabs",items:[{columnWidth:1,items:A,forceLayout:true}]});}return B;},loadHelpPane:function(A){var B=MODx.config.help_url;if(!B){return false;}MODx.helpWindow=new Ext.Window({title:_("help"),width:850,height:500,modal:true,layout:"fit",html:'<iframe onload="parent.MODx.helpWindow.getEl().unmask();" src="'+B+'" width="100%" height="100%" frameborder="0"></iframe>',listeners:{show:function(C){C.getEl().mask(_("help_loading"));}}});MODx.helpWindow.show(A);return true;},addTab:function(C,B){var A=Ext.getCmp(C);Ext.applyIf(B,{id:"modx-"+Ext.id()+"-tab",layout:"form",cls:"modx-resource-tab",bodyStyle:"padding: 15px;",autoHeight:true,defaults:{border:false,msgTarget:"side",width:400}});A.add(B);A.doLayout();A.setActiveTab(0);},hiddenTabs:[],hideTab:function(B,C){var D=Ext.getCmp(B);D.hideTabStripItem(C);MODx.hiddenTabs.push(C);var A=this._getNextActiveTab(D,C);D.setActiveTab(A);},_getNextActiveTab:function(C,B){if(MODx.hiddenTabs.indexOf(B)!=-1){var D;for(var A=0;A<C.items.items.length;A++){D=C.items.items[A].id;if(MODx.hiddenTabs.indexOf(D)==-1){break;}}}else{D=B;}return D;},moveTV:function(F,D){if(!Ext.isArray(F)){F=[F];}var A=Ext.getCmp("modx-panel-resource-tv");if(!A){return ;}for(var C=0;C<F.length;C++){var E=Ext.get(F[C]+"-tr");if(!E){return ;}var B=Ext.getCmp(D);if(!B){return ;}B.add({html:"",width:"100%",id:"tv-tr-out-"+F[C],cls:"modx-tv-out"});B.doLayout();var G=Ext.get("tv-tr-out-"+F[C]);G.replaceWith(E);}},hideTV:function(A){if(!Ext.isArray(A)){A=[A];}MODx.on("ready",function(){this.hideTVs(A);},this);},hideTVs:function(C){if(!Ext.isArray(C)){C=[C];}var B;for(var A=0;A<C.length;A++){B=Ext.get(C[A]+"-tr");B.setVisibilityMode(Ext.Element.DISPLAY);B.hide();}},preview:function(){window.open(MODx.config.site_url);}});Ext.reg("modx",MODx);MODx.Ajax=function(A){A=A||{};MODx.Ajax.superclass.constructor.call(this,A);this.addEvents({"success":true,"failure":true});};Ext.extend(MODx.Ajax,Ext.Component,{request:function(B){this.purgeListeners();if(B.listeners){for(var C in B.listeners){if(B.listeners.hasOwnProperty(C)){var A=B.listeners[C];this.on(C,A.fn,A.scope||this,A.options||{});}}}Ext.apply(B,{success:function(D,E){D=Ext.decode(D.responseText);if(!D){return false;}D.options=E;if(D.success){this.fireEvent("success",D);}else{if(this.fireEvent("failure",D)){MODx.form.Handler.errorJSON(D);}}return true;},failure:function(D,E){D=Ext.decode(D.responseText);if(!D){return false;}D.options=E;if(this.fireEvent("failure",D)){MODx.form.Handler.errorJSON(D);}return true;},scope:this,headers:{"Powered-By":"MODx","modAuth":B.auth}});Ext.Ajax.request(B);}});Ext.reg("modx-ajax",MODx.Ajax);MODx=new MODx();MODx.form.Handler=function(A){A=A||{};MODx.form.Handler.superclass.constructor.call(this,A);};Ext.extend(MODx.form.Handler,Ext.Component,{fields:[],handle:function(C,A,B){B=Ext.decode(B.responseText);if(!B.success){this.showError(B.message);return false;}return true;},highlightField:function(B){if(B.id!==undefined&&B.id!=="forEach"&&B.id!==""){Ext.get(B.id).dom.style.border="1px solid red";var A=Ext.get(B.id+"_error");if(A){A.innerHTML=B.msg;}this.fields.push(B.id);}},unhighlightFields:function(){for(var B=0;B<this.fields.length;B=B+1){Ext.get(this.fields[B]).dom.style.border="";var A=Ext.get(this.fields[B]+"_error");if(A){A.innerHTML="";}}this.fields=[];},errorJSON:function(B){if(B===""){return this.showError(B);}if(B.data&&B.data!==null){for(var A=0;A<B.data.length;A=A+1){this.highlightField(B.data[A]);}}this.showError(B.message);return false;},errorExt:function(A,B){this.unhighlightFields();if(A.errors!==null&&B){B.markInvalid(A.errors);}if(A.message!==undefined&&A.message!==""){this.showError(A.message);}else{MODx.msg.hide();}return false;},showError:function(A){if(A===""){MODx.msg.hide();}else{MODx.msg.alert(_("error"),A,Ext.emptyFn);}},closeError:function(){MODx.msg.hide();}});Ext.reg("modx-form-handler",MODx.form.Handler);MODx.Msg=function(A){A=A||{};MODx.Msg.superclass.constructor.call(this,A);this.addEvents({"success":true,"failure":true,"cancel":true});Ext.MessageBox.minWidth=200;};Ext.extend(MODx.Msg,Ext.Component,{confirm:function(B){this.purgeListeners();if(B.listeners){for(var C in B.listeners){var A=B.listeners[C];this.addListener(C,A.fn,A.scope||this,A.options||{});}}Ext.Msg.confirm(B.title||_("warning"),B.text,function(D){if(D=="yes"){MODx.Ajax.request({url:B.url,params:B.params||{},method:"post",scope:this,listeners:{"success":{fn:function(E){this.fireEvent("success",E);},scope:this},"failure":{fn:function(E){return this.fireEvent("failure",E);},scope:this}}});}else{this.fireEvent("cancel",B);}},this);},getWindow:function(){return Ext.Msg.getDialog();},alert:function(D,C,B,A){B=B||Ext.emptyFn;A=A||this;Ext.Msg.alert(D,C,B,A);},status:function(C){if(!MODx.stMsgCt){MODx.stMsgCt=Ext.DomHelper.insertFirst(document.body,{id:"modx-status-message-ct"},true);}MODx.stMsgCt.alignTo(document,"t-t");var B=this.getStatusMarkup(C);var A=Ext.DomHelper.overwrite(MODx.stMsgCt,{html:B},true);A.slideIn("t");var D={remove:true,useDisplay:true};if(!C.dontHide){A.pause(C.delay||1.5).ghost("t",D);}else{A.on("click",function(){A.ghost("t",D);});}},getStatusMarkup:function(B){var A='<div class="modx-status-msg">';if(B.title){A+="<h3>"+B.title+"</h3>";}if(B.message){A+='<span class="modx-smsg-message">'+B.message+"</span>";}return A+"</div>";}});Ext.reg("modx-msg",MODx.Msg);