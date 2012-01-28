package fearOfTheDark.view.enemies
{
	import Box2DAS.*;
	import Box2DAS.Collision.*;
	import Box2DAS.Collision.Shapes.*;
	import Box2DAS.Common.*;
	import Box2DAS.Dynamics.*;
	import Box2DAS.Dynamics.Contacts.*;
	import Box2DAS.Dynamics.Joints.*;
	
	import cmodule.Box2D.*;
	
	import extras.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;
	
	import misc.*;
	
	import shapes.*;
	
	import wck.*;
	
	public class Enemy extends Box 
	{
		protected static const ENEMY_DIR_NONE:int = 0;
		protected static const ENEMY_DIR_LEFT:int = 1;
		protected static const ENEMY_DIR_RIGHT:int = 2;
		
		protected static const ENEMY_STATE_NONE:int = 0;
		protected static const ENEMY_STATE_IDLE:int = 1;
		protected static const ENEMY_STATE_IDLE_TO_ALERT:int = 2;
		protected static const ENEMY_STATE_ALERT:int = 3;
		protected static const ENEMY_STATE_ALERT_TO_IDLE:int = 4;
		protected static const ENEMY_STATE_STUN:int = 5;
		protected static const ENEMY_STATE_STUNNED:int = 6;
		protected static const ENEMY_STATE_RECOVER:int = 7;
		
		private var _time100px:Number;
		private var _enemyState:int;
		private var _enemyDir:int;
		private var _target:Box;
		
		public var contacts:ContactList;
		
		public function Enemy() {	  }
		
		public override function create():void
		{
			reportBeginContact = true;
			reportEndContact = true;
			fixedRotation = true;
			super.create();
			//listenWhileVisible(world, StepEvent.STEP, parseInput, false, 10);
			listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, handleContact);
			contacts = new ContactList();
			contacts.listenTo(this);
			
			init();
		}
		
		public function init():void
		{
			time100px = 0;
			enemyState = ENEMY_STATE_NONE;
			enemyDir = ENEMY_DIR_NONE;
			setTimeout(updateEnemy, 50);
		}
		
		public function handleContact(e:ContactEvent):void
		{
			var p:Pellet = e.other.m_userData as Pellet;
			if (p)
			{
				Util.addChildAtPosOf(world, new FX(), p);  
				p.remove();
			}
		}
		
		[Inspectable(defaultValue=0)]
		public function set time100px(value:Number):void
		{
			_time100px = value;
		}
		
		public function get time100px():Number
		{
			return _time100px;
		}
		
		[Inspectable(defaultValue=ENEMY_DIR_NONE)]
		public function set enemyDir(value:int):void
		{
			_enemyDir = value;
		}
		
		public function get enemyDir():int
		{
			return _enemyDir;
		}
		
		[Inspectable(defaultValue=ENEMY_STATE_NONE)]
		public function set enemyState(value:int):void
		{
			_enemyState = value;
		}
		
		public function get enemyState():int
		{
			return _enemyState;
		}
		
		public function setTarget(t:Box):void
		{
			_target = t;
			trace("!!!! " + _target.name);
		}
		
		// AI
		protected function updateEnemy():void
		{
			var manifold:b2WorldManifold = null;
			var dot:Number = -1;
			
			// Search for the most ground/floor-like contact.
			if (!contacts.isEmpty())
			{
				contacts.forEach(function(keys:Array, c:ContactEvent)
				{
					var wm:b2WorldManifold = c.getWorldManifold();
					if (wm.normal)
					{
						// Dot producting the contact normal with gravity indicates how floor-like the
						// contact is. If the dot product = 1, it is a flat foor. If it is -1, it is
						// a ceiling. If it's 0.5, it's a sloped floor. Save the contact manifold
						// that is the most floor like.
						var d:Number = wm.normal.dot(gravity);
						if(!manifold || d > dot) {
							manifold = wm;
							dot = d;
						}
					}
				});
				contacts.clean();
			}
			
			switch (enemyState)
			{
				case ENEMY_STATE_NONE:
					enemyNone();
					break;
					
				case ENEMY_STATE_IDLE:
					enemyIdle();
					break;
					
				case ENEMY_STATE_IDLE_TO_ALERT:
					enemyIdleToAlert();
					break;
					
				case ENEMY_STATE_ALERT:
					enemyAlert();
					break;
					
				case ENEMY_STATE_ALERT_TO_IDLE:
					enemyAlertToIdle();
					break;
					
				case ENEMY_STATE_STUN:
					enemyStun();
					break;
					
				case ENEMY_STATE_STUNNED:
					enemyStunned();
					break;
					
				case ENEMY_STATE_RECOVER:
					enemyRecover();
					break;
			}
			
			setTimeout(updateEnemy, 50);
		}
		
		protected function enemyNone():void
		{
		}
		
		protected function enemyIdle():void
		{
		}
		
		protected function enemyIdleToAlert():void
		{
		}
		
		protected function enemyAlert():void
		{
		}
		
		protected function enemyAlertToIdle():void
		{
		}
		
		protected function enemyStun():void
		{
		}
		
		protected function enemyStunned():void
		{
		}
		
		protected function enemyRecover():void
		{
		}
		
		// Damage
		private function receiveDamage(e:Event):void
		{
		}
	}
}