Ext.ns("Ext.ux.tree");Ext.ux.tree.ColumnTree=Ext.extend(Ext.tree.TreePanel,{lines:false,borderWidth:Ext.isBorderBox?0:2,cls:"x-column-tree",onRender:function(){Ext.tree.ColumnTree.superclass.onRender.apply(this,arguments);this.headers=this.header.createChild({cls:"x-tree-headers"});var C=this.columns,F;var B=0;var E=19;for(var D=0,A=C.length;D<A;D++){F=C[D];B+=F.width;this.headers.createChild({cls:"x-tree-hd "+(F.cls?F.cls+"-hd":""),cn:{cls:"x-tree-hd-text",html:F.header},style:"width:"+(F.width-this.borderWidth)+"px;"});}this.headers.createChild({cls:"x-clear"});this.headers.setWidth(B+E);this.innerCt.setWidth(B);}});Ext.reg("columntree",Ext.ux.tree.ColumnTree);Ext.tree.ColumnTree=Ext.ux.tree.ColumnTree;Ext.ux.tree.ColumnNodeUI=Ext.extend(Ext.tree.TreeNodeUI,{focus:Ext.emptyFn,renderElements:function(A,K,J,H){this.indentMarkup=A.parentNode?A.parentNode.ui.getChildIndent():"";var L=A.getOwnerTree();var G=L.columns;var F=L.borderWidth;var I=G[0];var D=['<li class="x-tree-node"><div ext:tree-node-id="',A.id,'" class="x-tree-node-el x-tree-node-leaf ',K.cls,'">','<div class="x-tree-col" style="width:',I.width-F,'px;">','<span class="x-tree-node-indent">',this.indentMarkup,"</span>",'<img src="',this.emptyIcon,'" class="x-tree-ec-icon x-tree-elbow">','<img src="',K.icon||this.emptyIcon,'" class="x-tree-node-icon',(K.icon?" x-tree-node-inline-icon":""),(K.iconCls?" "+K.iconCls:""),'" unselectable="on">','<a hidefocus="on" class="x-tree-node-anchor" href="',K.href?K.href:"#",'" tabIndex="1" ',K.hrefTarget?' target="'+K.hrefTarget+'"':"",">",'<span unselectable="on">',A.text||(I.renderer?I.renderer(K[I.dataIndex],A,K):K[I.dataIndex]),"</span></a>","</div>"];for(var B=1,E=G.length;B<E;B++){I=G[B];D.push('<div class="x-tree-col ',(I.cls?I.cls:""),'" style="width:',I.width-F,'px;">','<div class="x-tree-col-text">',(I.renderer?I.renderer(K[I.dataIndex],A,K):K[I.dataIndex]),"</div>","</div>");}D.push('<div class="x-clear"></div></div>','<ul class="x-tree-node-ct" style="display:none;"></ul>',"</li>");if(H!==true&&A.nextSibling&&A.nextSibling.ui.getEl()){this.wrap=Ext.DomHelper.insertHtml("beforeBegin",A.nextSibling.ui.getEl(),D.join(""));}else{this.wrap=Ext.DomHelper.insertHtml("beforeEnd",J,D.join(""));}this.elNode=this.wrap.childNodes[0];this.ctNode=this.wrap.childNodes[1];var C=this.elNode.firstChild.childNodes;this.indentNode=C[0];this.ecNode=C[1];this.iconNode=C[2];this.anchor=C[3];this.textNode=C[3].firstChild;}});Ext.tree.ColumnNodeUI=Ext.ux.tree.ColumnNodeUI;MODx.tree.ColumnTree=function(A){A=A||{};Ext.applyIf(A,{rootVisible:false,autoScroll:true,autoHeight:true,root:{nodeType:"async",text:A.rootText||""},loader:new Ext.tree.TreeLoader({dataUrl:A.url,baseParams:A.baseParams||{},uiProviders:{"col":Ext.tree.ColumnNodeUI},listeners:A.loaderListeners||{"beforeload":{fn:function(D,C){if(C.attributes.class_key){var B={};Ext.apply(B,this.config.baseParams);Ext.apply(B,C.attributes);B.loader=null;B.uiProvider=null;this.getLoader().baseParams=B;}},scope:this}}}),tbar:this._getToolbar(),menuConfig:{defaultAlign:"tl-b?",enableScrolling:false}});MODx.tree.ColumnTree.superclass.constructor.call(this,A);this.on("contextmenu",this._showContextMenu,this);this.on("nodedragover",this._handleDrop,this);this.on("nodedrop",this._handleDrag,this);this.cm=new Ext.menu.Menu(A.menuConfig);this.config=A;};Ext.extend(MODx.tree.ColumnTree,Ext.tree.ColumnTree,{windows:{},_showContextMenu:function(A,B){A.select();this.cm.activeNode=A;this.cm.record=A.attributes;this.cm.removeAll();if(A.attributes.menu&&A.attributes.menu.items){this._addContextMenuItem(A.attributes.menu.items);this.cm.show(A.ui.getEl(),"t?");}},_addContextMenuItem:function(C){var B=C,A=B.length;for(var D=0;D<A;D++){B[D].scope=this;this.cm.add(B[D]);}},_handleDrag:function(B){Ext.Msg.show({title:_("please_wait"),msg:_("saving"),width:240,progress:true,closable:false});MODx.util.Progress.reset();for(var A=1;A<20;A++){setTimeout("MODx.util.Progress.time("+A+","+MODx.util.Progress.id+")",A*1000);}function D(I){var F={};var G=I.childNodes;var E=G.length;for(var H=0;H<E;H++){F[G[H].id]=D(G[H]);}return F;}var C=Ext.encode(D(B.tree.root));MODx.Ajax.request({url:this.config.url,params:{data:encodeURIComponent(C),action:this.config.sortAction||"sort"},listeners:{"success":{fn:function(E){MODx.util.Progress.reset();Ext.Msg.hide();this.reloadNode(B.target);},scope:this},"failure":{fn:function(E){MODx.util.Progress.reset();Ext.Msg.hide();MODx.form.Handler.errorJSON(E);return false;},scope:this}}});},reloadNode:function(A){this.getLoader().load(A);A.expand();},_handleDrop:function(){},loadWindow:function(A,D,C){var B=C.record||this.cm.record;if(!this.windows[C.xtype]){Ext.applyIf(C,{record:C.blankValues?{}:B,grid:this,listeners:{"success":{fn:C.success||this.refresh,scope:C.scope||this}}});this.windows[C.xtype]=Ext.ComponentMgr.create(C);}if(this.windows[C.xtype].setValues&&C.blankValues!==true){this.windows[C.xtype].setValues(B);}this.windows[C.xtype].show(D.target);},refresh:function(C,B,A){this.getLoader().baseParams=this.config.baseParams;this.getRootNode().reload();this.getRootNode().expand(null,null);if(C){B=B||this;A=A||[];this.getRootNode().on("load",function(){Ext.callback(C,B,A);},B);}return true;},refreshActiveNode:function(){if(this.cm.activeNode){this.getLoader().load(this.cm.activeNode);this.cm.activeNode.expand();}else{this.refresh();}},refreshParentNode:function(){this.refreshNode(this.cm.activeNode.id);},refreshNode:function(E,B){var C=this.getNodeById(E);if(C){var D=B?C:C.parentNode;var A=this.getLoader().load(D);D.expand();}},_getToolbar:function(){var A=MODx.config.template_url+"images/restyle/icons/";return[{icon:A+"refresh.png",cls:"x-btn-icon",tooltip:{text:_("tree_refresh")},handler:this.refresh,scope:this}];},rendYesNo:function(B,C,A){switch(B){case"":return"-";case 0:C.css="red";return _("no");case 1:C.css="green";return _("yes");}}});Ext.reg("tree-column",MODx.tree.ColumnTree);