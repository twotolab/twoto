MODx.panel.PropertySet=function(A){A=A||{};Ext.applyIf(A,{id:"modx-panel-property-sets",items:[{html:"<h2>"+_("propertysets")+"</h2>",cls:"modx-page-header",border:false},{layout:"form",bodyStyle:"padding: 15px;",id:"modx-property-set-form",border:true,items:[{html:"<p>"+_("propertysets_desc")+"</p>",id:"modx-property-set-msg",border:false},{layout:"column",border:false,items:[{columnWidth:0.3,style:"padding:10px;",border:false,items:[{xtype:"modx-tree-property-sets",preventRender:true}]},{columnWidth:0.7,style:"padding:10px;",layout:"form",border:false,autoHeight:true,items:[{id:"modx-grid-property-set-properties-ct",autoHeight:true}]}]}]}]});MODx.panel.PropertySet.superclass.constructor.call(this,A);(function(){MODx.load({xtype:"modx-grid-property-set-properties",id:"modx-grid-element-properties",xtype:"modx-grid-property-set-properties",autoHeight:true,renderTo:"modx-grid-property-set-properties-ct"});}).defer(50,this);};Ext.extend(MODx.panel.PropertySet,MODx.FormPanel);Ext.reg("modx-panel-property-sets",MODx.panel.PropertySet);MODx.grid.PropertySetProperties=function(A){A=A||{};Ext.applyIf(A,{autoHeight:true,lockProperties:false,tbar:[{xtype:"modx-combo-property-set",id:"modx-combo-property-set",baseParams:{action:"getList"},listeners:{"select":{fn:function(B){Ext.getCmp("modx-grid-element-properties").changePropertySet(B);},scope:this}},value:""},{text:_("property_create"),handler:function(B,C){Ext.getCmp("modx-grid-element-properties").create(B,C);},scope:this},"->",{text:_("propertyset_save"),handler:function(){Ext.getCmp("modx-grid-element-properties").save();},scope:this}]});MODx.grid.PropertySetProperties.superclass.constructor.call(this,A);};Ext.extend(MODx.grid.PropertySetProperties,MODx.grid.ElementProperties);Ext.reg("modx-grid-property-set-properties",MODx.grid.PropertySetProperties);MODx.tree.PropertySets=function(A){A=A||{};Ext.applyIf(A,{rootVisible:false,enableDD:false,title:"",url:MODx.config.connectors_url+"element/propertyset.php",baseParams:{action:"getNodes"},tbar:[{text:_("propertyset_new"),handler:this.createSet,scope:this}],useDefaultToolbar:true});MODx.tree.PropertySets.superclass.constructor.call(this,A);this.on("click",this.loadGrid,this);};Ext.extend(MODx.tree.PropertySets,MODx.tree.Tree,{loadGrid:function(C,B){var A=C.id.split("_");if(A[0]=="ps"){MODx.Ajax.request({url:MODx.config.connectors_url+"element/propertyset.php",params:{action:"getProperties",id:A[1]},listeners:{"success":{fn:function(F){var G=F.object;var E=Ext.getCmp("modx-grid-element-properties");var D=E.getStore();E.defaultProperties=G;delete E.config.elementId;delete E.config.elementType;D.removeAll();D.loadData(G);Ext.getCmp("modx-combo-property-set").setValue(A[1]);},scope:this}}});}else{if(A[0]=="el"&&A[2]&&A[3]){MODx.Ajax.request({url:MODx.config.connectors_url+"element/propertyset.php",params:{action:"getProperties",id:A[1],element:A[2],element_class:A[3]},listeners:{"success":{fn:function(F){var G=F.object;var E=Ext.getCmp("modx-grid-element-properties");var D=E.getStore();E.defaultProperties=G;E.config.elementId=A[2];E.config.elementType=A[3];D.removeAll();D.loadData(G);Ext.getCmp("modx-combo-property-set").setValue(A[1]);},scope:this}}});}}},createSet:function(A,B){if(!this.winCreateSet){this.winCreateSet=MODx.load({xtype:"modx-window-property-set-create",listeners:{"success":{fn:function(){this.refresh();Ext.getCmp("modx-combo-property-set").store.reload();},scope:this}}});}this.winCreateSet.show(B.target);},duplicateSet:function(A,C){var D=this.cm.activeNode.id.split("_");var B=this.cm.activeNode.attributes.data;B.id=D[1];B.new_name=_("duplicate_of",{name:B.name});if(!this.winDupeSet){this.winDupeSet=MODx.load({xtype:"modx-window-property-set-duplicate",record:B,listeners:{"success":{fn:function(){this.refresh();Ext.getCmp("modx-combo-property-set").store.reload();},scope:this}}});}this.winDupeSet.setValues(B);this.winDupeSet.show(C.target);},updateSet:function(A,C){var D=this.cm.activeNode.id.split("_");var B=this.cm.activeNode.attributes.data;B.id=D[1];if(!this.winUpdateSet){this.winUpdateSet=MODx.load({xtype:"modx-window-property-set-update",record:B,listeners:{"success":{fn:function(){this.refresh();Ext.getCmp("modx-combo-property-set").store.reload();},scope:this}}});}this.winUpdateSet.setValues(B);this.winUpdateSet.show(C.target);},removeSet:function(A,B){var C=this.cm.activeNode.id.split("_");C=C[1];MODx.msg.confirm({text:_("propertyset_remove_confirm"),url:MODx.config.connectors_url+"element/propertyset.php",params:{action:"remove",id:C},listeners:{"success":{fn:function(){this.refreshNode(this.cm.activeNode.id);var D=Ext.getCmp("modx-grid-element-properties");D.getStore().removeAll();D.defaultProperties=[];Ext.getCmp("modx-combo-property-set").setValue("");},scope:this}}});},addElement:function(B,C){var D=this.cm.activeNode.id.split("_");D=D[1];var A=this.cm.activeNode.text;if(!this.winPSEA){this.winPSEA=MODx.load({xtype:"modx-window-propertyset-element-add",record:{propertysetName:this.cm.activeNode.text,propertyset:D},listeners:{"success":{fn:function(){this.refreshNode(this.cm.activeNode.id,true);},scope:this}}});}this.winPSEA.show(C.target);},removeElement:function(A,B){var C=this.cm.activeNode.attributes;MODx.msg.confirm({text:_("propertyset_element_remove_confirm"),url:MODx.config.connectors_url+"element/propertyset.php",params:{action:"removeElement",element:C.pk,element_class:C.element_class,propertyset:C.propertyset},listeners:{"success":{fn:function(){this.refreshNode(this.cm.activeNode.id);},scope:this}}});}});Ext.reg("modx-tree-property-sets",MODx.tree.PropertySets);MODx.window.AddElementToPropertySet=function(A){A=A||{};Ext.applyIf(A,{title:_("propertyset_element_add"),url:MODx.config.connectors_url+"element/propertyset.php",baseParams:{action:"addElement"},width:400,fields:[{xtype:"hidden",name:"propertyset"},{xtype:"statictextfield",fieldLabel:_("propertyset"),name:"propertysetName",anchor:"95%"},{xtype:"modx-combo-element-class",fieldLabel:_("class_name"),name:"element_class",id:"modx-combo-element-class",anchor:"95%",listeners:{"select":{fn:this.onClassSelect,scope:this}}},{xtype:"modx-combo-elements",fieldLabel:_("element"),name:"element",id:"modx-combo-elements",anchor:"95%"}]});MODx.window.AddElementToPropertySet.superclass.constructor.call(this,A);};Ext.extend(MODx.window.AddElementToPropertySet,MODx.Window,{onClassSelect:function(A){var B=Ext.getCmp("modx-combo-elements").store;B.baseParams.element_class=A.getValue();B.load();}});Ext.reg("modx-window-propertyset-element-add",MODx.window.AddElementToPropertySet);MODx.combo.ElementClass=function(A){A=A||{};Ext.applyIf(A,{name:"element_class",hiddenName:"element_class",displayField:"name",valueField:"name",fields:["name"],listWidth:300,editable:false,url:MODx.config.connectors_url+"element/index.php",baseParams:{action:"getClasses"}});MODx.combo.ElementClass.superclass.constructor.call(this,A);};Ext.extend(MODx.combo.ElementClass,MODx.combo.ComboBox);Ext.reg("modx-combo-element-class",MODx.combo.ElementClass);MODx.combo.Elements=function(A){A=A||{};Ext.applyIf(A,{name:"element",hiddenName:"element",displayField:"name",valueField:"id",fields:["id","name"],listWidth:300,editable:false,url:MODx.config.connectors_url+"element/index.php",baseParams:{action:"getListByClass",element_class:"modSnippet"}});MODx.combo.Elements.superclass.constructor.call(this,A);};Ext.extend(MODx.combo.Elements,MODx.combo.ComboBox);Ext.reg("modx-combo-elements",MODx.combo.Elements);MODx.window.CreatePropertySet=function(A){A=A||{};Ext.applyIf(A,{title:_("propertyset_create"),url:MODx.config.connectors_url+"element/propertyset.php",baseParams:{action:"create"},width:550,fields:[{xtype:"textfield",fieldLabel:_("name"),name:"name",id:"modx-cpropset-name",anchor:"95%",allowBlank:false},{xtype:"modx-combo-category",fieldLabel:_("category"),name:"category",id:"modx-cpropset-category",anchor:"95%",allowBlank:true},{xtype:"textarea",fieldLabel:_("description"),name:"description",id:"modx-cpropset-description",anchor:"95%",grow:true}]});MODx.window.CreatePropertySet.superclass.constructor.call(this,A);};Ext.extend(MODx.window.CreatePropertySet,MODx.Window);Ext.reg("modx-window-property-set-create",MODx.window.CreatePropertySet);MODx.window.UpdatePropertySet=function(A){A=A||{};Ext.applyIf(A,{title:_("propertyset_update"),url:MODx.config.connectors_url+"element/propertyset.php",baseParams:{action:"update"},width:550,fields:[{xtype:"hidden",name:"id",id:"modx-upropset-id"},{xtype:"textfield",fieldLabel:_("name"),name:"name",id:"modx-upropset-name",anchor:"95%",allowBlank:false},{xtype:"modx-combo-category",fieldLabel:_("category"),name:"category",id:"modx-upropset-category",anchor:"95%",allowBlank:true},{xtype:"textarea",fieldLabel:_("description"),name:"description",id:"modx-upropset-description",anchor:"95%",grow:true}]});MODx.window.UpdatePropertySet.superclass.constructor.call(this,A);};Ext.extend(MODx.window.UpdatePropertySet,MODx.Window);Ext.reg("modx-window-property-set-update",MODx.window.UpdatePropertySet);MODx.window.DuplicatePropertySet=function(A){A=A||{};Ext.applyIf(A,{title:_("propertyset_duplicate"),url:MODx.config.connectors_url+"element/propertyset.php",baseParams:{action:"duplicate"},width:550,fields:[{xtype:"hidden",name:"id",id:"modx-dpropset-id"},{xtype:"textfield",fieldLabel:_("new_name"),name:"new_name",anchor:"95%",value:_("duplicate_of",{name:A.record.name})},{xtype:"checkbox",boxLabel:_("propertyset_duplicate_copyels"),labelSeparator:"",name:"copyels",id:"modx-dpropset-copyels",checked:true}]});MODx.window.DuplicatePropertySet.superclass.constructor.call(this,A);};Ext.extend(MODx.window.DuplicatePropertySet,MODx.Window);Ext.reg("modx-window-property-set-duplicate",MODx.window.DuplicatePropertySet);