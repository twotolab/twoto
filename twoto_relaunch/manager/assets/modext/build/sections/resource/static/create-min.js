MODx.page.CreateStatic=function(A){A=A||{};Ext.applyIf(A,{url:MODx.config.connectors_url+"resource/index.php",formpanel:"modx-panel-resource",id:"modx-page-update-resource",which_editor:"none",actions:{"new":MODx.action["resource/create"],edit:MODx.action["resource/update"],cancel:MODx.action["welcome"]},buttons:this.getButtons(A),loadStay:true,components:[{xtype:"modx-panel-static",renderTo:"modx-panel-static-div",resource:0,record:A.record||{},publish_document:A.publish_document,access_permissions:A.access_permissions}]});MODx.page.CreateStatic.superclass.constructor.call(this,A);};Ext.extend(MODx.page.CreateStatic,MODx.Component,{getButtons:function(A){var B=[];if(A.canSave==1){B.push({process:"create",text:_("save"),method:"remote",checkDirty:true,keys:[{key:MODx.config.keymap_save||"s",alt:true,ctrl:true}]});B.push("-");}B.push({process:"cancel",text:_("cancel"),params:{a:MODx.action["welcome"]}});B.push("-");B.push({text:_("help_ex"),handler:MODx.loadHelpPane});return B;}});Ext.reg("modx-page-static-create",MODx.page.CreateStatic);