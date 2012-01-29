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
		protected static const ENEMY_STATE_FREEZE:int = 8;
		protected static const ENEMY_STATE_FROZEN:int = 9;
		
		private var _time100px:Number;
		private var _enemyState:int;
		private var _enemyDir:int;
		private var _enemyTarget:Box;
		
		public var contacts:ContactList;
		
		public function Enemy() {	  }
		
		public override function create():void
		{
			reportBeginContact = true;
			reportEndContact = true;
			fixedRotation = true;
			super.create();
			listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, handleContact);
			contacts = new ContactList();
			contacts.listenTo(this);
		}
		
		public function init():void
		{
			time100px = 0;
			enemyState = ENEMY_STATE_NONE;
			enemyDir = ENEMY_DIR_NONE;
			enemyTarget = null;
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
		
		[Inspectable(defaultValue=null)]
		public function set enemyTarget(t:Box):void
		{
			_enemyTarget = t;
		}
		
		public function get enemyTarget():Box
		{
			return _enemyTarget;
		}
		
		// Damage
		public function hitBoy():void
		{
			trace(name + " KILLED BOY!");
		}
		
		public function receiveDamage():void
		{
		}
		
		public function freezeEnemy():void
		{
			enemyState = ENEMY_STATE_FREEZE;
		}
		
		// AI
		protected function updateEnemy():void
		{
			var manifold:b2WorldManifold = null;
			var dot:Number = -1;
			
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
					
				case ENEMY_STATE_FREEZE:
					enemyFreeze();
					break;
					
				case ENEMY_STATE_FROZEN:
					enemyFrozen();
					break;
			}
			
			setTimeout(updateEnemy, 50);
		}
		
		protected function enemyStop():void
		{
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
		
		protected function enemyFreeze():void
		{
			active = false;
			enemyState = ENEMY_STATE_FROZEN;
		}
		
		protected function enemyFrozen():void
		{
		}
		
		protected function isOffscreen():Boolean
		{
			return false;
		}
	}
}