MODx.page.CreateTemplate=function(A){A=A||{};Ext.applyIf(A,{formpanel:"modx-panel-template",actions:{"new":MODx.action["element/template/create"],edit:MODx.action["element/template/update"],cancel:MODx.action["welcome"]},buttons:[{process:"create",text:_("save"),method:"remote",checkDirty:true,keys:[{key:MODx.config.keymap_save||"s",alt:true,ctrl:true}]},"-",{process:"cancel",text:_("cancel"),params:{a:MODx.action["welcome"]}},"-",{text:_("help_ex"),handler:MODx.loadHelpPane}],loadStay:true,components:[{xtype:"modx-panel-template",renderTo:"modx-panel-template-div",template:0,record:A.record||{},baseParams:{action:"create",category:MODx.request.category}}]});MODx.page.CreateTemplate.superclass.constructor.call(this,A);};Ext.extend(MODx.page.CreateTemplate,MODx.Component);Ext.reg("modx-page-template-create",MODx.page.CreateTemplate);