﻿/**
 * 
 * This is the client code that needs to be implemented into a 
 * Flash, AIR or FLEX application to collect debug information 
 * in De MonsterDebugger. 
 * 
 * Be aware that any traces made to De MonsterDebugger may 
 * be viewed by others. De Monster Debugger is intended to be 
 * used to debug unpublished Flash, AIR of FLEX applications in
 * the environment that they will be used in as a final product. 
 * Please make sure that you do not send any debug material to
 * the debugger from a live running application. 
 * 
 * Use at your own risk.
 * 
 * @author		Ferdi Koomen
 * @company 	De Monsters
 * @link 		http://www.deMonsterDebugger.com
 * @version 	2.02
 * 
 * 
 * 
 * Copyright 2009, De Monsters
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 */


package nl.demonsters.debugger
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	
	
	public class MonsterDebugger
	{
		
		// Singleton instance
		private static var instance:MonsterDebugger = null;
		
		
		// Connections
		private var lineOut:LocalConnection;
		private var lineIn:LocalConnection;
		
		
		// Connection names
		private const LINE_OUT					:String = "_debuggerRed";
		private const LINE_IN					:String = "_debuggerBlue";
		
		
		// The allow domain for the local connection
		// * = Allow communication with all domains
		private const ALLOWED_DOMAIN			:String = "*";
		
		
		// Error colors
		public static const COLOR_NORMAL		:uint = 0x111111;
		public static const COLOR_ERROR			:uint = 0xFF0000;
		public static const COLOR_WARNING		:uint = 0xFF3300;
		

		// Commands
		private const COMMAND_HELLO				:String = "HELLO";
		private const COMMAND_ROOT				:String = "ROOT";
		private const COMMAND_TRACE				:String = "TRACE";
		private const COMMAND_GET_OBJECT		:String = "GET_OBJECT";
		private const COMMAND_GET_PROPERTIES	:String = "GET_PROPERTIES";
		private const COMMAND_GET_FUNCTIONS		:String = "GET_FUNCTIONS";
		private const COMMAND_SET_PROPERTY		:String = "SET_PROPERTY";
		private const COMMAND_CALL_METHOD		:String = "CALL_METHOD";
		private const COMMAND_SHOW_HIGHLIGHT	:String = "SHOW_HIGHLIGHT";
		private const COMMAND_HIDE_HIGHLIGHT	:String = "HIDE_HIGHLIGHT";
		private const COMMAND_CLEAR_TRACES		:String = "CLEAR_TRACES";
		private const COMMAND_NOTFOUND			:String = "NOTFOUND";
		
		
		// Types
		private const TYPE_VOID					:String = "void";
		private const TYPE_ARRAY				:String = "Array";
		private const TYPE_BOOLEAN				:String = "Boolean";
		private const TYPE_NUMBER				:String = "Number";
		private const TYPE_OBJECT				:String = "Object";
		private const TYPE_VECTOR				:String = "Vector";
		private const TYPE_STRING				:String = "String";
		private const TYPE_INT					:String = "int";
		private const TYPE_UINT					:String = "uint";
		private const TYPE_XML					:String = "XML";
		private const TYPE_XMLLIST				:String = "XMLList";
		private const TYPE_XMLNODE				:String = "XMLNode";
		private const TYPE_XMLVALUE				:String = "XMLValue";
		private const TYPE_XMLATTRIBUTE			:String = "XMLAttribute";
		private const TYPE_METHOD				:String = "MethodClosure";
		private const TYPE_FUNCTION				:String = "Function";
		private const TYPE_BYTEARRAY			:String = "ByteArray";	
		private const TYPE_WARNING				:String = "Warning";
		private const TYPE_DISPLAYOBJECT		:String = "DisplayObject";
		
		
		// Access types
		private const ACCESS_VARIABLE			:String = "variable";
		private const ACCESS_CONSTANT			:String = "constant";
		private const ACCESS_ACCESSOR			:String = "accessor";
		private const ACCESS_METHOD				:String = "method";
		
		
		// Permission types
		private const PERMISSION_READWRITE		:String = "readwrite";
		private const PERMISSION_READONLY		:String = "readonly";
		private const PERMISSION_WRITEONLY		:String = "writeonly";
		
		
		// Icon types
		private const ICON_DEFAULT				:String = "iconDefault";
		private const ICON_ROOT					:String = "iconRoot";
		private const ICON_WARNING				:String = "iconWarning";
		private const ICON_VARIABLE				:String = "iconVariable";
		private const ICON_VARIABLE_READONLY	:String = "iconVariableReadonly";
		private const ICON_VARIABLE_WRITEONLY	:String = "iconVariableWriteonly";
		private const ICON_XMLNODE				:String = "iconXMLNode";
		private const ICON_XMLVALUE				:String = "iconXMLValue";
		private const ICON_XMLATTRIBUTE 		:String = "iconXMLAttribute";
		private const ICON_FUNCTION				:String = "iconFunction";
		
		
		// Highlight color and border thickness
		private const HIGHLIGHT_COLOR			:uint = 0xFFFF00;
		private const HIGHLIGHT_BORDER			:int = 4;
		
		
		// Max local connection package size
		private const MAX_PACKAGE_BYTES			:int = 40000;
		
		
		// Version
		private const VERSION:Number = 2.02;
		
		
		// The root of the application
		private var root:Object = null;
		
		
		// Highlight display object
		private var highlight:Sprite = null;
		
		
		// Enabled / disabled
		public var _enabled:Boolean = true;
		
		
		
		/**
		 * Constructor
		 * The target can also be a static function
		 * @param target: The root of the application
		 */
		public function MonsterDebugger(target:Object = null)
		{
			// Check if the debugger has already been initialized
			if (instance == null)
			{
				// Save the instance
				instance = this;			
			
				// Setup line out
				lineOut = new LocalConnection();
				lineOut.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				lineOut.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				lineOut.addEventListener(StatusEvent.STATUS, statusHandler);
				
				// Setup line in
				lineIn = new LocalConnection();
				lineIn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				lineIn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				lineIn.addEventListener(StatusEvent.STATUS, statusHandler);
				lineIn.allowDomain(ALLOWED_DOMAIN);
				lineIn.client = this;
				
				try {
					lineIn.connect(LINE_IN);
				} catch(error:ArgumentError) {
					// Do nothing
				}

			}
			
			// Save the root
			// Send the first message
			if (target != MonsterDebugger.singletonCheck) {
				instance.root = target;
				instance.send({text:COMMAND_HELLO, version:VERSION});
			}
		}
		
		
		/**
		 * This function is called from the AIR application
		 * @param data: A compressed object containing the commands
		 */
		public function onReceivedData(data:ByteArray):void
		{
			if (enabled)
			{
				//Variables for the commands
				var object:*;
				var method:Function;
				var xml:XML;
				
				// Uncompress the item data
				data.uncompress();
				
				// Read the command from the data
				var command:Object = data.readObject();
				
				// Do the actions
				switch(command["text"])
				{
					// Save the domain
					case COMMAND_HELLO:
						send({text:COMMAND_HELLO, version:VERSION});
					break;
					
					// Get the base of the application
					case COMMAND_ROOT:
						object = getObject("", 0);
						if (object != null) {
							xml = XML(parseObject(object, "", command["functions"], 1, 2));
							send({text:COMMAND_ROOT, xml:xml});
						}
					break;
					
					// Return the parsed object
					case COMMAND_GET_OBJECT:
						object = getObject(command["target"], 0);
						if (object != null) {
							xml = XML(parseObject(object, command["target"], command["functions"], 1, 2));
							send({text:COMMAND_GET_OBJECT, xml:xml});
						}
					break;
					
					// Return a list of functions
					case COMMAND_GET_PROPERTIES:
						object = getObject(command["target"], 0);
						if (object != null) {
							xml = XML(parseObject(object, command["target"], false, 1, 1));
							send({text:COMMAND_GET_PROPERTIES, xml:xml});
						}
					break;
					
					// Return a list of functions
					case COMMAND_GET_FUNCTIONS:
						object = getObject(command["target"], 0);
						if (object != null) {
							xml = XML(getFunctions(object, command["target"]));
							send({text:COMMAND_GET_FUNCTIONS, xml:xml});
						}
					break;
					
					// Adjust a property and return the value
					case COMMAND_SET_PROPERTY:
						object = getObject(command["target"], 1);
						if (object != null) {
							try {
								object[command["name"]] = command["value"];
								send({text:COMMAND_SET_PROPERTY, value:object[command["name"]]});
							} catch (error1:Error) {
								send({text:COMMAND_NOTFOUND, target:command["target"]});
								break;
							}
						}
					break;
					
					// Call a method and return the answer
					case COMMAND_CALL_METHOD:
						method = getObject(command["target"], 0);
						if (method != null) {
							if (command["returnType"] == TYPE_VOID) {
								method.apply(this, command["arguments"]);
							} else {
								object = method.apply(this, command["arguments"]);
								xml = XML(parseObject(object, "", false, 1, 4));
								send({text:COMMAND_CALL_METHOD, id:command["id"], xml:xml});
							}
						}
					break;
					
					// Remove and add a new highlight if posible
					case COMMAND_SHOW_HIGHLIGHT:
						if (highlight != null) {
							try {
								highlight.parent.removeChild(highlight);
								highlight = null;
							} catch(error2:Error) {
								//
							}
						}
						object = getObject(command["target"], 0);
						if (isDisplayObject(object) && isDisplayObject(object["parent"])) {
							var bounds:Rectangle = object.getBounds(object["parent"]);			
							highlight = new Sprite();
							highlight.x = 0;
							highlight.y = 0;
							highlight.graphics.beginFill(0, 0);
							highlight.graphics.lineStyle(HIGHLIGHT_BORDER, HIGHLIGHT_COLOR);
							highlight.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
							highlight.graphics.endFill();
							highlight.mouseChildren = false;
							highlight.mouseEnabled = false;
							try {
								object["parent"].addChild(highlight);
							} catch(error3:Error) {
								highlight = null;
							}
						}
					break;
					
					// Remove the highlight
					case COMMAND_HIDE_HIGHLIGHT:
						if (highlight != null) {
							try {
								highlight.parent.removeChild(highlight);
								highlight = null;
							} catch(error4:Error) {
								//
							}
						}
					break;
				}
			}
		}
		
		
		/**
		 * The actual send function
		 * @param data: The raw uncompressed data to send
		 */
		private function send(data:Object):void
		{
			if (enabled)
			{
				// Compress the data
				var item:ByteArray = new ByteArray();
				item.writeObject(data);
				item.compress();
				
				// Array to hold the data packages
				var dataPackages:Array = new Array();
				
				// Counter for the loops
				var i:int = 0;
				
				// Check if the data should be splitted
				// The max size for localconnection = 40kb = 40960b
				// We use 960b for the package definition
				if (item.length > MAX_PACKAGE_BYTES)
				{
					// Save the length
					var bytesAvailable:int = item.length;
					var offset:int = 0;
					
					// Calculate the total package count
					var total:int = Math.ceil(item.length / MAX_PACKAGE_BYTES);
					
					// Loop through the bytes / chunks
					for (i = 0; i < total; i++)
					{
						// Set the length to read
						var length:int = bytesAvailable;
						if (length > MAX_PACKAGE_BYTES) {
							length = MAX_PACKAGE_BYTES;
						}
						
						// Read a chunk of data
						var tmp:ByteArray = new ByteArray();
						tmp.writeBytes(item, offset, length);
						
						// Create a data package
						dataPackages.push({total:total, nr:(i + 1), bytes:tmp});
						
						// Update the bytes available and offset
						bytesAvailable -= length;
						offset += length;
					}		
				} 
				else
				{
					// The data size is under 40kb, so just send one package
					dataPackages.push({total:1, nr:1, bytes:item});
				}
				
				// send the data packages through the line out
				for (i = 0; i < dataPackages.length; i++) {
					try {
						lineOut.send(LINE_OUT, "onReceivedData", dataPackages[i]);
					} catch (error:Error) {
						break;
					}
				}
			}
		}
		
		
		/**
		 * Static trace function
		 * @param target: The target from where the trace is called
		 * @param object: The object to trace
		 * @param color: The color of the trace in the interface
		 * @parem functions: Include or exclude the functions
		 * @param depth: The maximum depth of the trace
		 */
		public static function trace(target:Object, object:*, color:uint = 0x111111, functions:Boolean = false, depth:int = 4):void
		{
			if (instance == null) instance = new MonsterDebugger(MonsterDebugger.singletonCheck);
			if (MonsterDebugger.enabled) instance.traceInternal(target, object, color, functions, depth);
		}
		
		
		/**
		 * Private trace function
		 * @param target: The target from where the trace is called
		 * @param object: The object to trace
		 * @param color: The color of the trace in the interface
		 * @parem functions: Include or exclude the functions
		 * @param depth: The maximum depth of the trace
		 */
		private function traceInternal(target:Object, object:*, color:uint = 0x111111, functions:Boolean = false, depth:int = 4):void
		{
			if (enabled)
			{
				// Get the object information
				var xml:XML = XML(parseObject(object, "", functions, 1, depth));
				
				//Create a send object
				send({text:COMMAND_TRACE, date:new Date(), target:String(target), xml:xml, color:color});
			}
		}
		
		
		/**
		 * Static clear traces function
		 * This clears the traces in the application
		 */
		public static function clearTraces():void
		{
			if (instance == null) instance = new MonsterDebugger(MonsterDebugger.singletonCheck);
			if (MonsterDebugger.enabled) instance.clearTracesInternal();
		}
		
		
		/**
		 * Private clear traces function
		 * This clears the traces in the application
		 */
		private function clearTracesInternal():void
		{
			if (enabled)
			{
				//Create a send object
				send({text:COMMAND_CLEAR_TRACES});
			}
		}
		
		
		/**
		 * Check if an object is drawable displayobject
		 * @param object: The object to check
		 */
		private function isDisplayObject(object:*):Boolean
		{
			// The return value
			var drawable:Boolean = false;
			
			try {
				// Get the descriptor
				var description:XML = describeType(object);
				for (var i:int = 0; i < description.extendsClass.length(); i++) {
					if (parseType(description.extendsClass[i].@type) == TYPE_DISPLAYOBJECT){
						drawable = true;
						break;
					}
				}
			} catch(error:Error) {
				// Do nothing
			}
			
			// Return the flag
			return drawable;
		}
		
		
		/**
		 * Return an object
		 * @param target: A point seperated path to the object
		 * @param parent: Number of parents 
		 */
		private function getObject(target:String = "", parent:int = 0):*
		{
			// Object to return
			var object:* = instance.root;
			
			// Check if the path is not empty
			if (target != "")
			{
				// Split the path
				var splitted:Array = target.split(".");
				
				// Loop through the array
				for (var i:int = 0; i < splitted.length - parent; i++)
				{
					// Check if the string isn't empty
					if (splitted[i] != "") 
					{
						try
						{
							// Check if we should call the XML children function()
							// If not: Just update the path to the object
							if (splitted[i] == "children()") {
								object = object.children();
							} else {
								object = object[splitted[i]];
							}
						}
						catch (error:ReferenceError)
						{
							// The object is not found
							send({text:COMMAND_NOTFOUND, target:target});
							break;
						}
					}
				}
			}
			
			// Return the object
			return object;
		}
		
		
		/**
		 * Get the functions of an object
		 * @param object: The object to parse
		 * @param target: A point seperated path to the object
		 */
		private function getFunctions(object:*, target:String = ""):String
		{
			// The return string
			var xml:String = "";
			
			// Create the opening node
			xml += createNode("root");
			
			try
			{
				// Get the descriptor
				var description:XML = describeType(object);
				var type:String = parseType(description.@name);
				var childType:String = "";
				var childName:String = "";
				var childTarget:String = "";
				var methods:XMLList = description..method;
				var methodsArr:Array = new Array();
				var returnType:String;
				var parameters:XMLList;
				var args:Array;
				var argsString:String;
				var optional:Boolean = false;
				var double:Boolean = false;
				var i:int = 0;
				var n:int = 0;
				
				// Create the head node
				xml += createNode("node", {icon:ICON_DEFAULT, label:"(" + type + ")", target:target});
				
				// Save the methods
				// Filter out doubles (this should not happen though)
				for (i = 0; i < methods.length(); i++) {
					for (n = 0; n < methodsArr.length; n++) {
						if (methodsArr[n].name == methods[i].@name) {
							double = true;
							break;
						}
					}
					if (!double) {
						methodsArr.push({name:methods[i].@name, xml:methods[i], access:ACCESS_METHOD});
					}
				}
				
				// Sort the nodes
				methodsArr.sortOn("name");
				
				// Loop through the methods
				for (i = 0; i < methodsArr.length; i++)
				{
					// Save the type
					childType = TYPE_FUNCTION;
					childName = methodsArr[i].xml.@name;
					childTarget = target + "." + childName;
					
					// Save the function info
					// Parameters, arguments, return type, etc
					returnType = parseType(methodsArr[i].xml.@returnType);
					parameters = methodsArr[i].xml..parameter;
					args = new Array();
					argsString = "";
					optional = false;
					
					// Create the parameters
					for (n = 0; n < parameters.length(); n++)
					{
						// Optional parameters should start with a bracket
						if (parameters[n].@optional == "true" && !optional){
							optional = true;
							args.push("[");
						}
						
						// Push the parameter
						args.push(parseType(parameters[n].@type));
					}
					
					// The optional bracket is needed
					if (optional) {
						args.push("]");
					}
					
					// Create the arguments string
					argsString = args.join(", ");
					argsString = argsString.replace("[, ", "[");
					argsString = argsString.replace(", ]", "]");
					
					// Create the node
					xml += createNode("node", {
						icon:			ICON_FUNCTION,
						label:			childName + "(" + argsString + "):" + returnType,
						args:			argsString,
						name:			childName,
						type:			TYPE_FUNCTION, 
						access:			ACCESS_METHOD,
						returnType:		returnType, 
						target:			childTarget								
					});
					
								
					// Loop through the parameters
					for (n = 0; n < parameters.length(); n++)
					{
						// Create the node
						xml += createNode("parameter", {
							type:			parseType(parameters[n].@type),
							index:			parameters[n].@index,
							optional:		parameters[n].@optional			
						}, true);
					}
					
					// Close the function node
					xml += createNode("/node");
				}
				
				// Create the head node
				xml += createNode("/node");
			} 
			catch (error:Error)
			{
				// The object is not found
				var msg:String = "";
				msg += createNode("root");
				msg += createNode("node", {icon:ICON_WARNING, type:TYPE_WARNING, label:"Not found", name:"Not found"}, true);
				msg += createNode("/root");
				send({text:COMMAND_NOTFOUND, target:target, xml:XML(msg)});
			}
			
			// Create a closing node
			xml += createNode("/root");
			
			// Return the xml
			return xml;
		}
		
		
		/**
		 * Parse an object
		 * @param object: The object to parse
		 * @param target: A point seperated path to the object
		 * @param functions: Include or exclude functions
		 * @param currentDepth: The current trace depth
		 * @param maxDepth:: The maximum trace depth
		 */
		private function parseObject(object:*, target:String = "", functions:Boolean = false, currentDepth:int = 1, maxDepth:int = 4):String
		{
			// Variables needed in the loops
			var xml:String = "";
			var childType:String = "";
			var childName:String = "";
			var childTarget:String = "";
			var description:XML = new XML();
			var type:String = "";
			var base:String = "";
			var i:int = 0;
			var n:int = 0;
			
			// Check if the max trace depth is reached
			if (maxDepth == -1 || currentDepth <= maxDepth)
			{
				// Create the opening node if needed
				if (currentDepth == 1) xml += createNode("root");
				
				try
				{
					// Get the descriptor
					description = describeType(object);
					type = parseType(description.@name);
					base = parseType(description.@base);
					
					
					/**
					 * FUNCTION
					 */
					if (functions && base == TYPE_FUNCTION)
					{
						// Trace an empty function
						xml += createNode("node", {
							icon:			ICON_FUNCTION,
							label:			"(Function)", 
							name:			"",
							type:			TYPE_FUNCTION,
							value:			"",
							target:			target,
							access:			ACCESS_VARIABLE,
							permission:		PERMISSION_READWRITE
						}, true);
					}
					
					
					/**
					 * ARRAY, VECTOR
					 */
					else if (type == TYPE_ARRAY || type == TYPE_VECTOR)
					{
						// Add data description if needed
						if (currentDepth == 1) xml += createNode("node", {icon:ICON_ROOT, label:"(" + type + ")", target:target});
						
						// Create the length property
						// The only property of the array
						xml += createNode("node", {
							icon:			ICON_VARIABLE,
							label:			"length" + " (" + TYPE_UINT + ") = " + object["length"],
							name:			"length",
							type:			TYPE_UINT, 
							value:			object["length"], 
							target:			target + "." + "length",
							access:			ACCESS_VARIABLE,
							permission:		PERMISSION_READONLY
						}, true);
						
						// Loop through the array
						for (i = 0; i < object["length"]; i++)
						{
							// Save the type
							childType = parseType(describeType(object[i]).@name);
							childTarget = target + "." + String(i);
							
							// Check if we can create a single string or a new node
							if (childType == TYPE_STRING || childType == TYPE_BOOLEAN || childType == TYPE_NUMBER || childType == TYPE_INT || childType == TYPE_UINT || childType == TYPE_FUNCTION)
							{
								try
								{
									xml += createNode("node", {
										icon:			ICON_VARIABLE,
										label:			"[" + i + "] (" + childType + ") = " + printObject(object[i], childType), 
										name:			"[" + i + "]",
										type:			childType, 
										value:			printObject(object[i], childType), 
										target:			childTarget,
										access:			ACCESS_VARIABLE,
										permission:		PERMISSION_READWRITE
									}, true);
								}
								catch(error1:Error)
								{
									// Do nothing
								}
							}
							else
							{
								xml += createNode("node", {
									icon:			ICON_VARIABLE,
									label:			"[" + i + "] (" + childType + ")", 
									name:			"[" + i + "]",
									type:			childType, 
									value:			"",
									target:			childTarget,
									access:			ACCESS_VARIABLE,
									permission:		PERMISSION_READWRITE
								});
								try 
								{
									// Try to parse the object
									xml += parseObject(object[i], childTarget, functions, currentDepth + 1, maxDepth);
								} 
								catch(error2:Error)
								{
									// If this fails add a warning message for the user
									xml += createNode("node", {icon:ICON_WARNING, type:TYPE_WARNING, label:"Unreadable", name:"Unreadable"}, true);
								}
								xml += createNode("/node");
							}
						}
						
						// Close data description if needed
						if (currentDepth == 1) xml += createNode("/node");
					}
					
					
					/**
					 * OBJECT
					 */
					else if (type == TYPE_OBJECT)
					{
						// Add data description if needed
						if (currentDepth == 1) xml += createNode("node", {icon:ICON_ROOT, label:"(" + type + ")", target:target});
	
						// Get and sort the properties
						var properties:Array = new Array();
						for (var prop:* in object) {
							properties.push(prop);
						}
						properties.sort();
						
						// Loop through the array
						for (i = 0; i < properties.length; i++)
						{
							// Save the type
							childType = parseType(describeType(object[properties[i]]).@name);
							childTarget = target + "." + properties[i];
							
							// Check if we can create a single string or a new node
							if (childType == TYPE_STRING || childType == TYPE_BOOLEAN || childType == TYPE_NUMBER || childType == TYPE_INT || childType == TYPE_UINT || childType == TYPE_FUNCTION)
							{
								try
								{
									xml += createNode("node", {
										icon:			ICON_VARIABLE,
										label:			properties[i] + " (" + childType + ") = " + printObject(object[properties[i]], childType),
										name:			properties[i],
										type:			childType, 
										value:			printObject(object[properties[i]], childType), 
										target:			childTarget,
										access:			ACCESS_VARIABLE,
										permission:		PERMISSION_READWRITE
									}, true);
								}
								catch(error3:Error)
								{
									// Do nothing
								}
							}
							else
							{
								xml += createNode("node", {
									icon:			ICON_VARIABLE,
									label:			properties[i] + " (" + childType + ")", 
									name:			properties[i],
									type:			childType, 
									value:			"",
									target:			childTarget,
									access:			ACCESS_VARIABLE,
									permission:		PERMISSION_READWRITE
								});
								try 
								{
									// Try to parse the object
									xml += parseObject(object[properties[i]], childTarget, functions, currentDepth + 1, maxDepth);
								} 
								catch(error4:Error)
								{
									// If this fails add a warning message for the user
									xml += createNode("node", {icon:ICON_WARNING, type:TYPE_WARNING, label:"Unreadable", name:"Unreadable"}, true);
								}
								xml += createNode("/node");
							}
						}
						
						// Close data description if needed
						if (currentDepth == 1) xml += createNode("/node");
					}
					
					
					/**
					 * XML
					 */
					else if (type == TYPE_XML)
					{						
						// Add data description if needed
						if (currentDepth == 1) xml += createNode("node", {icon:ICON_ROOT, label:"(" + type + ")", target:target});
						
						// Parse the XML
						xml += parseXML(object, target + "." + "cildren()", currentDepth, maxDepth);
						
						// Close data description if needed
						if (currentDepth == 1) xml += createNode("/node");
					}
										
					
					/**
					 * XML List
					 */
					else if (type == TYPE_XMLLIST)
					{						
						// Add data description if needed
						if (currentDepth == 1) xml += createNode("node", {icon:ICON_ROOT, label:"(" + type + ")", target:target});
						
						// Create the length property
						// The only property of the array
						xml += createNode("node", {
							icon:			ICON_VARIABLE,
							label:			"length" + " (" + TYPE_UINT + ") = " + object.length(),
							name:			"length",
							type:			TYPE_UINT, 
							value:			object.length(), 
							target:			target + "." + "length",
							access:			ACCESS_VARIABLE,
							permission:		PERMISSION_READONLY
						}, true);
						
						// Loop through the xml nodes
						for (i = 0; i < object.length(); i++)
						{							
							xml += parseXML(object[i], target + "." + String(i) + ".children()", currentDepth, maxDepth);
						}
						
						// Close data description if needed
						if (currentDepth == 1) xml += createNode("/node");
					}								
								
								
					/**
					 * STRING, NUMBER, BOOLEAN, INT, UINT
					 */
					else if (type == TYPE_STRING || type == TYPE_BOOLEAN || type == TYPE_NUMBER || type == TYPE_INT || type == TYPE_UINT)
					{
						// Create the node
						xml += createNode("node", {
							icon:			ICON_VARIABLE,
							label:			"(" + type + ") = " + printObject(object, type), 
							name:			"",
							type:			type, 
							value:			printObject(object, type), 
							target:			target,
							access:			ACCESS_VARIABLE,
							permission:		PERMISSION_READWRITE
						}, true);
					}
					
					
					/**
					 * CUSTOM CLASS
					 */
					else
					{
						// Add data description if needed
						if (currentDepth == 1) xml += createNode("node", {icon:ICON_ROOT, label:"(" + type + ")", target:target});
						
						// Get the data
						var variables:XMLList = description..variable;
						var accessors:XMLList = description..accessor;
						var constants:XMLList = description..constant;
						var methods:XMLList = description..method;
						var variablesArr:Array = new Array();
						var methodsArr:Array = new Array();
						var double:Boolean = false;
						var permission:String = "";
						var icon:String = "";
												
						// Save the variables
						double = false;
						for (i = 0; i < variables.length(); i++) {
							for (n = 0; n < variablesArr.length; n++) {
								if (variablesArr[n].name == variables[i].@name) {
									double = true;
									break;
								}
							}
							if (!double) {
								variablesArr.push({name:variables[i].@name, xml:variables[i], access:ACCESS_VARIABLE});
							}
						}
												
						// Save the accessors
						double = false;
						for (i = 0; i < accessors.length(); i++) {
							for (n = 0; n < variablesArr.length; n++) {
								if (variablesArr[n].name == accessors[i].@name) {
									double = true;
									break;
								}
							}
							if (!double) {
								variablesArr.push({name:accessors[i].@name, xml:accessors[i], access:ACCESS_ACCESSOR});
							}
						}
												
						// Save the constants
						double = false;
						for (i = 0; i < constants.length(); i++) {
							for (n = 0; n < variablesArr.length; n++) {
								if (variablesArr[n].name == constants[i].@name) {
									double = true;
									break;
								}
							}
							if (!double) {
								variablesArr.push({name:constants[i].@name, xml:constants[i], access:ACCESS_CONSTANT});
							}
						}
						
						// Save the methods
						double = false;
						for (i = 0; i < methods.length(); i++) {
							for (n = 0; n < methodsArr.length; n++) {
								if (methodsArr[n].name == methods[i].@name) {
									double = true;
									break;
								}
							}
							if (!double) {
								methodsArr.push({name:methods[i].@name, xml:methods[i], access:ACCESS_METHOD});
							}
						}
						
						// Sort the nodes
						variablesArr.sortOn("name");
						methodsArr.sortOn("name");
						
						
						/**
						 * VARIABLES
						 */
						for (i = 0; i < variablesArr.length; i++)
						{
							// Save the type
							childType = parseType(variablesArr[i].xml.@type);
							childName = variablesArr[i].xml.@name;
							childTarget = target + "." + childName;
							
							// Save the permission and icon
							permission = PERMISSION_READWRITE;
							icon = ICON_VARIABLE;
							
							// Check for read / write permissions
							if (variablesArr[i].access == ACCESS_CONSTANT) {
								// Constant
								permission = PERMISSION_READONLY;
								icon = ICON_VARIABLE_READONLY;
							}
							if (variablesArr[i].xml.@access == PERMISSION_READONLY) {
								// Only a getter
								permission = PERMISSION_READONLY;
								icon = ICON_VARIABLE_READONLY;
							}
							if (variablesArr[i].xml.@access == PERMISSION_WRITEONLY) {
								// Only a setter
								permission = PERMISSION_WRITEONLY;
								icon = ICON_VARIABLE_WRITEONLY;
							}
							
							// Don't include write only accessor
							if (permission != PERMISSION_WRITEONLY)
							{
								// Check if we can create a single string or a new node
								if (childType == TYPE_STRING || childType == TYPE_BOOLEAN || childType == TYPE_NUMBER || childType == TYPE_INT || childType == TYPE_UINT || childType == TYPE_FUNCTION)
								{
									try
									{
										xml += createNode("node", {
											icon:			icon,
											label:			childName + " (" + childType + ") = " + printObject(object[childName], childType), 
											name:			childName,
											type:			childType, 
											value:			printObject(object[childName], childType), 
											target:			childTarget,
											access:			variablesArr[i].access,
											permission:		permission
										}, true);
									}
									catch(error5:Error)
									{
										// Do nothing
									}
								}
								else
								{
									xml += createNode("node", {
										icon:			icon,
										label:			childName + " (" + childType + ")", 
										name:			childName,
										type:			childType, 
										target:			childTarget,
										access:			variablesArr[i].access,
										permission:		permission
									});
									try 
									{
										// Try to parse the object
										xml += parseObject(object[childName], childTarget, functions, currentDepth + 1, maxDepth);
									} 
									catch(error6:Error)
									{
										// If this fails add a warning message for the user
										xml += createNode("node", {icon:ICON_WARNING, type:TYPE_WARNING, label:"Unreadable", name:"Unreadable"}, true);
									}
									xml += createNode("/node");
								}
							}
						}
						
						
						/**
						 * METHODS
						 */
						if (functions)
						{
							for (i = 0; i < methodsArr.length; i++)
							{
								// Save the type
								childType = TYPE_FUNCTION;
								childName = methodsArr[i].xml.@name;
								childTarget = target + "." + childName;
								
								// Save the parameters
								var returnType:String = parseType(methodsArr[i].xml.@returnType);
								var parameters:XMLList = methodsArr[i].xml..parameter;
								var args:Array = new Array();
								
								// Create the parameters
								for (n = 0; n < parameters.length(); n++) {
									args.push(parseType(parameters[n].@type));
								}
								
								// Create the node
								xml += createNode("node", {
									icon:			ICON_FUNCTION,
									label:			childName + "(" + args.join(", ") + "):" + returnType,
									args:			args.join(", "),
									name:			childName,
									type:			TYPE_FUNCTION, 
									access:			variablesArr[i].access,
									returnType:		returnType, 
									target:			childTarget								
								}, true);
							}
						}
						
						// Close data description if needed
						if (currentDepth == 1) xml += createNode("/node");
					}
				} 
				catch (error7:Error)
				{
					// The object is not found
					var msg:String = "";
					msg += createNode("root");
					msg += createNode("node", {icon:ICON_WARNING, type:TYPE_WARNING, label:"Not found", name:"Not found"}, true);
					msg += createNode("/root");
					send({text:COMMAND_NOTFOUND, target:target, xml:XML(msg)});
				}
				
				// Create a closing node if needed
				if (currentDepth == 1) xml += createNode("/root");
			}
	
			//Return the xml
			return xml;
		}
		
		
		/**
		 * Parse a XML node
		 * @param node: The xml to parse
		 * @param target: A point seperated path to the object
		 * @param currentDepth: The current trace depth
		 * @param maxDepth:: The maximum trace depth
		 */
		private function parseXML(node:*, target:String = "", currentDepth:int = 1, maxDepth:int = -1):String
		{
			// Create a return string
			var xml:String = "";
			var i:int = 0;
			
			// Check if the maximum trace depth is reached
			if (maxDepth == -1 || currentDepth <= maxDepth)
			{				
				// Check if the user traced an attribute
				if (target.indexOf("@") != -1)
				{
					// Display a single attribute
					xml += createNode("node", {
						icon:			ICON_XMLATTRIBUTE,
						label:			node,
						name:			"",
						type:			TYPE_XMLATTRIBUTE,
						value:			node,
						target:			target,
						access:			ACCESS_VARIABLE,
						permission:		PERMISSION_READWRITE
					}, true);
				}
				else if (node.name() == null)
				{
					// Only a text value
					xml += createNode("node", {
						icon:			ICON_XMLVALUE,
						label:			"(" + TYPE_XMLVALUE + ") = " + printObject(node, TYPE_XMLVALUE),
						name:			"",
						type:			TYPE_XMLVALUE,
						value:			printObject(node, TYPE_XMLVALUE),
						target:			target,
						access:			ACCESS_VARIABLE,
						permission:		PERMISSION_READWRITE
					}, true);
				}
				else if (node.hasSimpleContent())
				{					
					// Node with one text value and possible attributes
					xml += createNode("node", {
						icon:			ICON_XMLNODE,
						label:			node.name() + " (" + TYPE_XMLNODE + ")",
						name:			node.name(),
						type:			TYPE_XMLNODE,
						value:			"",
						target:			target,
						access:			ACCESS_VARIABLE,
						permission:		PERMISSION_READWRITE
					});
					
					// Only a text value
					if (node != "") {
						xml += createNode("node", {
							icon:			ICON_XMLVALUE,
							label:			"(" + TYPE_XMLVALUE + ") = " + printObject(node, TYPE_XMLVALUE),
							name:			"",
							type:			TYPE_XMLVALUE,
							value:			printObject(node, TYPE_XMLVALUE),
							target:			target,
							access:			ACCESS_VARIABLE,
							permission:		PERMISSION_READWRITE
						}, true);
					}
					
					// Loop through the arrributes
					for (i = 0; i < node.attributes().length(); i++)
					{
						xml += createNode("node", {
							icon:			ICON_XMLATTRIBUTE,
							label:			"@" + node.attributes()[i].name() + " (" + TYPE_XMLATTRIBUTE + ") = " + node.attributes()[i],
							name:			"",
							type:			TYPE_XMLATTRIBUTE,
							value:			node.attributes()[i],
							target:			target + "." + "@" + node.attributes()[i].name(),
							access:			ACCESS_VARIABLE,
							permission:		PERMISSION_READWRITE
						}, true);
					}
					
					// Close the node
					xml += createNode("/node");
				}
				else 
				{
					// Node with children and attributes
					// This node has no value due to the children
					xml += createNode("node", {
						icon:			ICON_XMLNODE,
						label:			node.name() + " (" + TYPE_XMLNODE + ")",
						name:			node.name(),
						type:			TYPE_XMLNODE,
						value:			"",
						target:			target,
						access:			ACCESS_VARIABLE,
						permission:		PERMISSION_READWRITE
					});
					
					// Loop through the arrributes
					for (i = 0; i < node.attributes().length(); i++)
					{
						xml += createNode("node", {
							icon:			ICON_XMLATTRIBUTE,
							label:			"@" + node.attributes()[i].name() + " (" + TYPE_XMLATTRIBUTE + ") = " + node.attributes()[i],
							name:			"",
							type:			TYPE_XMLATTRIBUTE,
							value:			node.attributes()[i],
							target:			target + "." + "@" + node.attributes()[i].name(),
							access:			ACCESS_VARIABLE,
							permission:		PERMISSION_READWRITE
						}, true);
					}
					
					// Loop through children
					for (i = 0; i < node.children().length(); i++)
					{
						var childTarget:String = target + "." + "children()" + "." + i;
						xml += parseXML(node.children()[i], childTarget, currentDepth + 1, maxDepth);
					}
					
					// Close the node
					xml += createNode("/node");
				}
			}
			
			// Return the formatted XML
			return xml;
		}
		
		
		/**
		 * Converts package names to type
		 * Example: "nl.demonsters.debugger::MonsterDebugger" becomes "MonsterDebugger"
		 * We could also use getDefinitionByName() but that can't parse "builtin.as$0::MethodClosure"
		 * @param type: The string to parse
		 */
		private function parseType(type:String):String
		{
			// The return string
			var s:String = type;
			
			// Remove the package information if needed
			if (type.lastIndexOf("::") != -1) {
				s = type.substring(type.lastIndexOf("::") + 2, type.length);
			}
			
			// Remove the items after the .
			// Vector.<String> becomes Vector
			if (s.lastIndexOf(".") != -1) {
				s = s.substring(0, s.lastIndexOf("."));
			}
			
			// Change "MethodClosure" to "Function"
			// This is better for the user interface
			if (s == TYPE_METHOD) {
				s = TYPE_FUNCTION;
			}
			
			// Return the value
			return htmlEscape(s);
		}
		
		
		/**
		 * Create an XML node
		 * @param title: The title of the node
		 * @param object: The values of the node
		 * @param close: Create a closing tag
		 */
		private function createNode(title:String, object:Object = null, close:Boolean = false):String
		{
			// The string to store the node
			var xml:String = "";
			
			// Open the node
			xml += "<" + title;
			
			//Loop through the values
			if (object) {
				for (var prop:* in object) {
					xml += " " + prop + "='" + object[prop] + "'";
				}
			}
			
			// Close the node
			if (close) {
				xml += "></" + title + ">";
			} else {
				xml += ">";
			}
			
			// Return the node
			return xml;
		}
		
		
		/**
		 * Print a single object
		 * @param object: The object to parse
		 * @param type: The object type
		 */
		private function printObject(object:*, type:String):String
		{
			// Create a return string
			var s:String = "";
			
			// Check if the object can be converted
			// Here we can handle the exceptions
			if (type == TYPE_BYTEARRAY)
			{
				// We dont want to send the complete byte array
				// Only display the number of bytes
				s = object["length"] + " bytes";
			}
			else
			{
				// Display the object
				s = htmlEscape(String(object));
			}
			
			// Return the printed object
			return s;
		}
		
	
		/**
		 * Converts regular characters to HTML characters
		 * @param s: The string to convert
		 */
		public function htmlEscape(s:String):String
		{
			if (s) {
				// Remove single quotes
				while(s.indexOf("\'") != -1) {
					s = s.replace("\'", "&apos;");
				}
				// Remove double quotes
				while(s.indexOf("\"") != -1) {
					s = s.replace("\"", "&quot;");
				}
                var xml:XML = <a>{s}</a>;
                return xml.toXMLString().replace(/(^<a>)|(<\/a>$)/g, "");
			} else {
				return "";
			}
		}
			
		
		/**
		 * Converts HTML characters to regular characters
		 * @param s: The string to convert
		 */
		public function htmlUnescape(s:String):String
		{
			if (s) {
				var xml:XML = <a/>;
                xml.replace(0, s);
                return String(xml);
			} else {
				return "";
			}
		}
		
		
		/**
		 * Enable or disable the debugger
		 */
		public static function get enabled():Boolean
		{
			if (instance == null) instance = new MonsterDebugger(null);
			return instance._enabled;
		}
		public static function set enabled(value:Boolean):void
		{
			if (instance == null) instance = new MonsterDebugger(null);
			instance._enabled = value;
		}
		
		
		/**
		 * This function is used for the singleton check in the constructor
		 * and is given as an argument in the trace and clearTrace function
		 */
		private static function singletonCheck():void{}
		
		
		/**
		 * Event handlers
		 * Can be used for debugging
		 */
		private function asyncErrorHandler(event:AsyncErrorEvent):void {}
		private function securityErrorHandler(event:SecurityErrorEvent):void {}
		private function statusHandler(event:StatusEvent):void {}
	}
	
}