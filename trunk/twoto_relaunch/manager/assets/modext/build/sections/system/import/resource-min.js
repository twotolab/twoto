Ext.onReady(function(){MODx.load({xtype:"modx-page-import-resource"});});MODx.page.ImportResource=function(A){A=A||{};Ext.applyIf(A,{formpanel:"modx-panel-import-resources",buttons:[{process:"import",text:_("import_resources"),method:"remote"},{process:"cancel",text:_("cancel"),params:{a:MODx.action["welcome"]}}],components:[{xtype:"modx-panel-import-resources",renderTo:"modx-import-resources-div"}]});MODx.page.ImportResource.superclass.constructor.call(this,A);};Ext.extend(MODx.page.ImportResource,MODx.Component);Ext.reg("modx-page-import-resource",MODx.page.ImportResource);