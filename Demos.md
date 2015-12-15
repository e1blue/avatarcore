_(Last updated for ver 0.5.5)_

The following examples show uses of the Avatar Core framework. They demonstrate features and provide solutions to common (or uncommon) problems.

**In This Document:**



## Live Demos ##

All of these demos were built with [Flash Professional CS4](http://www.adobe.com/products/flash/), but their source code is external for viewing outside of Flash.

### Simple Feature Selection ###
This demo covers the most common use case for Avatar Core.  You have an avatar character on the left and a set of options listed out on the left for changing the features of the character.  The interface consists of a group of standard Flash controls used to select the different features available to the avatar as defined in an external XML definition.

&lt;wiki:gadget url="http://www.myavatareditor.com/avatarcore/demo/FeatureSelectionGadget.xml" width="620" height="320" border="1" /&gt;

Source at a glance:
  * [feature\_selection\_definitions.xml](http://www.myavatareditor.com/avatarcore/demo/feature_selection_definitions.xml)
  * [FeatureSelectionAvatar.as](http://www.myavatareditor.com/avatarcore/demo/FeatureSelectionAvatar.as)
  * [FeatureSelectionEditor.as](http://www.myavatareditor.com/avatarcore/demo/FeatureSelectionEditor.as)
Find the full demo download (including FLA and complete Avatar Core framework) in the [Downloads section](http://code.google.com/p/avatarcore/downloads/list).

### Adjust Features ###

This demo shows how the Adjust objects used by Features can be modified to alter the appearance of the Feature.  Select a Feature by clicking on it, then use the control bar at the bottom of the screen to modify it's Adjust.

View live demo:
  * **[AdjustFeatures.html](http://www.myavatareditor.com/avatarcore/demo/AdjustFeatures.html)**
Source files:
  * [AdjustFeatures.fla](http://www.myavatareditor.com/avatarcore/demo/AdjustFeatures.fla) (graphical assets only)
  * [AdjustFeatures.as](http://www.myavatareditor.com/avatarcore/demo/AdjustFeatures.as)

View live demo using Constrain behaviors:
  * **[AdjustConstrainedFeatures.html](http://www.myavatareditor.com/avatarcore/demo/AdjustConstrainedFeatures.html)**
Source files:
  * [AdjustConstrainedFeatures.fla](http://www.myavatareditor.com/avatarcore/demo/AdjustConstrainedFeatures.fla) (graphical assets only)
  * [AdjustConstrainedFeatures.as](http://www.myavatareditor.com/avatarcore/demo/AdjustConstrainedFeatures.as)


### Drag Features ###

This demo shows how Features can be moved (via Adjust) by dragging them with the mouse.  Making this work can be a little unintuitive, especially when it comes to parenting and behaviors like Mirror.  This approach takes into account those complications.


View live demo:
  * **[DragFeatures.html](http://www.myavatareditor.com/avatarcore/demo/DragFeatures.html)**
Source files:
  * [DragFeatures.fla](http://www.myavatareditor.com/avatarcore/demo/DragFeatures.fla) (graphical assets only)
  * [DragFeatures.as](http://www.myavatareditor.com/avatarcore/demo/DragFeatures.as)


View live demo using Constrain behaviors:
  * **[DragConstrainedFeatures.html](http://www.myavatareditor.com/avatarcore/demo/DragConstrainedFeatures.html)**
Source files:
  * [DragConstrainedFeatures.fla](http://www.myavatareditor.com/avatarcore/demo/DragConstrainedFeatures.fla) (graphical assets only)
  * [DragConstrainedFeatures.as](http://www.myavatareditor.com/avatarcore/demo/DragConstrainedFeatures.as)



## Copy And Paste Demos ##

Copy and paste these code samples directly into a new file to test them without any (or little) modification.  Information on how to set up your compiler/tool to recognize the Avatar Core framework is available on the [Installation](Installation.md) page.  These examples work easiest with [Flash Professional](http://www.adobe.com/products/flash/), pasting the code into the first frame of a new FLA document.

### Simple Smiley ###

This is a simple implementation of an Avatar defined in XML using loaded SWF art in Features positioned with Adjust objects.

```
import com.myavatareditor.avatarcore.*;
import com.myavatareditor.avatarcore.display.*;
import com.myavatareditor.avatarcore.xml.*;

var avatarXML:XML =
```
```
	<Avatar xmlns="com.myavatareditor.avatarcore">
		<Feature>
			<art src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_eye.swf" />
			<adjust x="-20" y="-20" />
		</Feature>
		<Feature>
			<art src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_eye.swf" />
			<adjust x="20" y="-20" />
		</Feature>
		<Feature>
			<art src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_mouth.swf" />
			<adjust y="20" />
		</Feature>
		<Feature>
			<art zIndex="-1" src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_head.swf" />
		</Feature>
	</Avatar>;
```
```
var xmlParser:XMLDefinitionParser = new XMLDefinitionParser();
var avatar:Avatar = xmlParser.parse(avatarXML) as Avatar;

var avatarDisplay:AvatarDisplay = new AvatarDisplay(avatar);
avatarDisplay.x = 100;
avatarDisplay.y = 100;
addChild(avatarDisplay);
```

### Simple Smiley With Library ###

This variation of the Simple Smiley example uses a Library.  Each Feature has a name value that relates to FeatureDefinition objects in the FeatureDefinition.  Each property object of the Feature also has a name that relates to the respective value in the sets contained within the FeatureDefinition.  This particular example uses the name shortcuts in feature (i.e. artName vs art.name) to specify names for the property objects.

```
import com.myavatareditor.avatarcore.*;
import com.myavatareditor.avatarcore.display.*;
import com.myavatareditor.avatarcore.xml.*;

var libraryXML:XML = 
```
```
	<Library xmlns="com.myavatareditor.avatarcore">
		<FeatureDefinition name="eyeLeft">
			<artSet>
				<Art name="normal" src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_eye.swf" />
			</artSet>
			<adjustSet>
				<Adjust name="default" x="-20" y="-20" />
			</adjustSet>
		</FeatureDefinition>
		<FeatureDefinition name="eyeRight">
			<artSet>
				<Art name="normal" src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_eye.swf" />
			</artSet>
			<adjustSet>
				<Adjust name="default" x="20" y="-20" />
			</adjustSet>
		</FeatureDefinition>
		<FeatureDefinition name="mouth">
			<artSet>
				<Art name="normal" src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_mouth.swf" />
			</artSet>
			<adjustSet>
				<Adjust name="default" y="20" />
			</adjustSet>
		</FeatureDefinition>
		<FeatureDefinition name="head">
			<artSet>
				<Art name="normal" zIndex="-1" src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_head.swf" />
			</artSet>
		</FeatureDefinition>
	</Library>;
```
```
var avatarXML:XML = 
```
```
	<Avatar xmlns="com.myavatareditor.avatarcore">
		<Feature name="eyeLeft" artName="normal" adjustName="default" />
		<Feature name="eyeRight" artName="normal" adjustName="default" />
		<Feature name="mouth" artName="normal" adjustName="default" />
		<Feature name="head" artName="normal" />
	</Avatar>;
```
```
var xmlParser:XMLDefinitionParser = new XMLDefinitionParser();
var avatar:Avatar = xmlParser.parse(avatarXML) as Avatar;
avatar.library = xmlParser.parse(libraryXML) as Library;

var avatarDisplay:AvatarDisplay = new AvatarDisplay(avatar);
avatarDisplay.x = 100;
avatarDisplay.y = 100;
addChild(avatarDisplay);
```

### Smiley With Mirrored Eyes ###

This version of the Smiley uses the Mirror behavior to mirror an eye Feature allowing it to represent both eyes rather than require a Feature for each.

```
import com.myavatareditor.avatarcore.*;
import com.myavatareditor.avatarcore.display.*;
import com.myavatareditor.avatarcore.xml.*;
Mirror; // make sure Mirror class is compiled
	
var avatarXML:XML = 
```
```
	<Avatar xmlns="com.myavatareditor.avatarcore">
		<Feature>
			<art src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_eye.swf" />
			<adjust x="-20" y="-20" />
			<behaviors>
				<Mirror />
			</behaviors>
		</Feature>
		<Feature>
			<art src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_mouth.swf" />
			<adjust y="20" />
		</Feature>
		<Feature>
			<art zIndex="-1" src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_head.swf" />
		</Feature>
	</Avatar>;
```
```
var xmlParser:XMLDefinitionParser = new XMLDefinitionParser();
var avatar:Avatar = xmlParser.parse(avatarXML) as Avatar;

var avatarDisplay:AvatarDisplay = new AvatarDisplay(avatar);
avatarDisplay.x = 100;
avatarDisplay.y = 100;
addChild(avatarDisplay);
```


### Smiley With Parent Adjusts ###

This example shows how parent relationships are made with parentName and how Adjust properties are inherited by child Features.  Especially note how scaling the parent head Feature affects the head Feature's Art size but not the size of the Art of the children.  The scaling does, however, affect the location of the child Art as seen with the eyes.

```
import flash.events.Event;
import flash.utils.getTimer;

import com.myavatareditor.avatarcore.*;
import com.myavatareditor.avatarcore.display.*;
import com.myavatareditor.avatarcore.xml.*;
Mirror; // make sure Mirror class is compiled
	
var avatarXML:XML = 
```
```
	<Avatar xmlns="com.myavatareditor.avatarcore">
		<Feature name="head">
			<art zIndex="-1" src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_head.swf" />
			<adjust />
		</Feature>
		<Feature parentName="head">
			<art src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_eye.swf" />
			<adjust x="-20" y="-20" />
			<behaviors>
				<Mirror />
			</behaviors>
		</Feature>
		<Feature parentName="head">
			<art src="http://www.myavatareditor.com/avatarcore/demo/images/smiley_mouth.swf" />
			<adjust y="20" />
		</Feature>
	</Avatar>;
```
```
var xmlParser:XMLDefinitionParser = new XMLDefinitionParser();
var avatar:Avatar = xmlParser.parse(avatarXML) as Avatar;

var avatarDisplay:AvatarDisplay = new AvatarDisplay(avatar);
avatarDisplay.x = 100;
avatarDisplay.y = 100;
addChild(avatarDisplay);

addEventListener(Event.ENTER_FRAME, scaleAndRotateHead);
function scaleAndRotateHead(event:Event):void {
	var head:Feature = avatar.getItemByName("head") as Feature;
	var adjust:Adjust = head.adjust;
	adjust.scaleX = 2 + Math.sin( getTimer()/1000 );
	adjust.rotation++;
	head.adjust = adjust;
}
```