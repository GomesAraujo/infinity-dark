﻿package fearOfTheDark.view.player{		import Box2DAS.*;	import Box2DAS.Collision.*;	import Box2DAS.Collision.Shapes.*;	import Box2DAS.Common.*;	import Box2DAS.Dynamics.*;	import Box2DAS.Dynamics.Contacts.*;	import Box2DAS.Dynamics.Joints.*;	import cmodule.Box2D.*;	import wck.*;	import shapes.*;	import misc.*;	import extras.*;	import flash.utils.*;	import flash.events.*;	import flash.display.*;	import flash.text.*;	import flash.geom.*;		public class BoxMan extends Box {				public var contacts:ContactList;				public override function create():void {			reportBeginContact = true;			reportEndContact = true;			fixedRotation = true;			super.create();			listenWhileVisible(world, StepEvent.STEP, parseInput, false, 10);			listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, handleContact);						stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);						contacts = new ContactList();			contacts.listenTo(this);		}				private function keyUpHandler(evt:KeyboardEvent):void 		{			//trace ("UPUPUP")			//trace (this.currentLabel);			if (this.currentLabel == "walkR")			{				gotoAndStop("idleR");			}			else			{				gotoAndStop("idleL");			}		}				public function handleContact(e:ContactEvent):void {			var p:Pellet = e.other.m_userData as Pellet;			if(p) {				Util.addChildAtPosOf(world, new FX(), p);  				p.remove();			}		}				public function parseInput(e:Event):void {			var manifold:b2WorldManifold = null;			var dot:Number = -1;						// Search for the most ground/floor-like contact.			if(!contacts.isEmpty()) {				contacts.forEach(function(keys:Array, c:ContactEvent) {					var wm:b2WorldManifold = c.getWorldManifold();					if(wm.normal) { 												// Dot producting the contact normal with gravity indicates how floor-like the						// contact is. If the dot product = 1, it is a flat foor. If it is -1, it is						// a ceiling. If it's 0.5, it's a sloped floor. Save the contact manifold						// that is the most floor like.						var d:Number = wm.normal.dot(gravity);						if(!manifold || d > dot) {							manifold = wm;							dot = d;						}					}				});				contacts.clean();			}			var left:Boolean = Input.kd('A', 'LEFT');			var right:Boolean = Input.kd('D', 'RIGHT');			var jump:Boolean = Input.kp(' ', 'UP');			var v:V2;						// Here we could add a dot product threshold for disallowing the player from jumping			// off of walls, ceilings, etc. For example:			// if(jump && manifold && dot > 0) {			if(jump && manifold) {				v = manifold.normal.clone().multiplyN(-20);				b2body.ApplyImpulse(v, b2body.GetWorldCenter());			}			else if(left) {				b2body.SetAwake(true);				b2body.SetLinearVelocity(new V2( -2, b2body.GetLinearVelocity().y)) 				setTimeout(soltar, 50);									gotoAndStop("walkL");												//trace (Object(parent).light.x);								Object(parent).light.x = this.x;				Object(parent).lightFoot.x = this.x;												//Object(parent).darkness.x = this.x;				//Object(parent).darkness.y = this.y;							}			else if(right) {				b2body.SetAwake(true);				b2body.SetLinearVelocity(new V2(2, b2body.GetLinearVelocity().y)) 				setTimeout(soltar, 50);										gotoAndStop("walkR");								Object(parent).light.x = this.x;				Object(parent).lightFoot.x = this.x;								//Object(parent).darkness.x = this.x;				//Object(parent).darkness.y = this.y;								/*				for (var i=0; i<parent.numChildren; i++)				{					trace(i+" - ", parent.getChildAt(i).name);				}				*/			}		}		private function soltar(){			b2body.SetLinearVelocity(new V2(0, b2body.GetLinearVelocity().y))		}	}}