MODx.page.CreateChunk=function(A){A=A||{};Ext.applyIf(A,{formpanel:"modx-panel-chunk",actions:{"new":MODx.action["element/chunk/create"],edit:MODx.action["element/chunk/update"],cancel:MODx.action["welcome"]},buttons:[{process:"create",text:_("save"),method:"remote",checkDirty:true,keys:[{key:MODx.config.keymap_save||"s",alt:true,ctrl:true}]},"-",{process:"cancel",text:_("cancel"),params:{a:MODx.action["welcome"]}},"-",{text:_("help_ex"),handler:MODx.loadHelpPane}],loadStay:true,components:[{xtype:"modx-panel-chunk",renderTo:"modx-panel-chunk-div",chunk:A.record.id||MODx.request.id,record:A.record||{},baseParams:{action:"create",category:MODx.request.category}}]});MODx.page.CreateChunk.superclass.constructor.call(this,A);};Ext.extend(MODx.page.CreateChunk,MODx.Component);Ext.reg("modx-page-chunk-create",MODx.page.CreateChunk);