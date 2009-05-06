﻿/*
Copyright (c) 2009 Trevor McCauley

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. 
*/
package com.myavatareditor.avatarcore.xml {
	
	import com.myavatareditor.avatarcore.ICollection;
	import flash.utils.describeType;
	
	/**
	 * Writes an object to XML based on XML formatting that
	 * can be parsed by XMLDefinitionParser.
	 * @author Trevor McCauley; www.senocular.com
	 */
	public class XMLDefinitionWriter {
		
		private var defaultPropertiesIgnoredByXML:Object = {};
		private var defaultPropertiesAsAttributesInXML:Object = {
			name:1,
			propertiesIgnoredByXML:1,
			propertiesAsAttributesInXML:1
		};
		
		public function XMLDefinitionWriter() {
			
		}
		
		public function write(object:Object):XML {
			
			// type information about object
			var xml:XML;
			var type:XML = describeType(object);
			var classQualifiedName:String = type.@name.toString();
			
			// determine package and class names
			var packageIndex:int = classQualifiedName.indexOf("::");
			var packageName:String;
			var className:String = classQualifiedName;
			if (packageIndex >= 0){
				packageName = classQualifiedName.substring(0, packageIndex);
				className = classQualifiedName.substring(packageIndex + 2);
			}
			
			// create main, written XML object
			if (object is IXMLWritable){
				var xmlWritable:IXMLWritable = object as IXMLWritable;
				xml = xmlWritable.getObjectAsXML();
			}
			if (xml == null) {
				xml = <{className} />;
				assignXMLProperties(xml, object, type);
			}
			if (packageName){
				xml.setNamespace(new Namespace(packageName));
			}
			
			return xml;
		}
		
		private function assignXMLProperties(xml:XML, object:Object, type:XML):void {
			// helper properties to determine where values
			// are placed in the XML if placed there at all
			var propertiesIgnoredByXML:Object = defaultPropertiesIgnoredByXML;
			var propertiesAsAttributesInXML:Object = defaultPropertiesAsAttributesInXML;
			
			if (object is IXMLWritable){
				var xmlWritable:IXMLWritable = object as IXMLWritable;
				var temp:Object;
				temp = xmlWritable.getPropertiesIgnoredByXML();
				if (temp) propertiesIgnoredByXML = temp;
				temp = xmlWritable.getPropertiesAsAttributesInXML();
				if (temp) propertiesAsAttributesInXML = temp;
			}
			
			// define XML children and attributes
			var children:XMLList = new XMLList();
			var childElem:XML;
			var properties:XMLList = type..variable + type..accessor;
			var prop:XML;
			var propName:String;
			var value:*;
			for each (prop in properties){
				
				propName = prop.@name;
				value = object[propName];
				
				// ignore undefined or explicitly ignored properties
				if (propName in propertiesIgnoredByXML || isUndefined(value, prop.@type)){
					continue;
				}
				
				// properties as elements or attributes
				if (propName in propertiesAsAttributesInXML){
					xml.@[propName] = value.toString();
				}else if (isPrimitive(value)){
					children += <{propName}>{value.toString()}</{propName}>;
				}else if (value is XML || value is XMLList){
					children += value;
				}else{
					childElem = write(value);
					
					// only add property XML if non-empty
					if (childElem.elements().length() || childElem.attributes().length()){
						childElem.setName(propName);
						children += childElem;
					}
				}
			}
			
			// collection items as child elements
			if (object is ICollection){
				var collector:ICollection = object as ICollection;
				var collection:Array = collector.collection;
				var i:int, n:int = collection.length;
				for (i=0; i<n; i++){
					children += write(collection[i]);
				}
			}
			
			// add child elements to xml
			if (children.length()){
				xml.setChildren(children);
			}
		}
		
		private function isUndefined(value:*, type:String):Boolean {
			return Boolean(value == null || (type == "Number" && isNaN(value)));
		}
		
		private function isPrimitive(value:*):Boolean {
			switch(typeof value) {
				
				case "object":
					return false;
					break;
					
				default:
					break;
			}
			
			return true;
		}
	}
}