MODx.page.UpdateSnippet=function(A){A=A||{};Ext.applyIf(A,{formpanel:"modx-panel-snippet",actions:{"new":MODx.action["element/snippet/create"],edit:MODx.action["element/snippet/update"],cancel:MODx.action["welcome"]},buttons:[{process:"update",text:_("save"),method:"remote",checkDirty:true,keys:[{key:MODx.config.keymap_save||"s",alt:true,ctrl:true}]},"-",{process:"cancel",text:_("cancel"),params:{a:MODx.action["welcome"]}},"-",{text:_("help_ex"),handler:MODx.loadHelpPane}],loadStay:true,components:[{xtype:"modx-panel-snippet",renderTo:"modx-panel-snippet-div",snippet:A.record.id||MODx.request.id,record:A.record||{}}]});MODx.page.UpdateSnippet.superclass.constructor.call(this,A);};Ext.extend(MODx.page.UpdateSnippet,MODx.Component);Ext.reg("modx-page-snippet-update",MODx.page.UpdateSnippet);