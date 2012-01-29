package fearOfTheDark.view.enemies
{
	import flash.display.*;
	import flash.utils.*;
	
	import Box2DAS.Common.*;
	
	public class EnemyRunAfter extends Enemy 
	{
		private static const ENEMY_RUN_AFTER_ALERT_DISTANCE:int = 500;
		
		public function EnemyRunAfter() {	}
		
		override public function init():void
		{
			super.init();
		}
		
		override protected function enemyNone():void
		{
			super.enemyNone();
		}
		
		override protected function enemyIdle():void
		{
			//trace("target.x = " + enemyTarget.x);
			
			if (Math.abs(x - enemyTarget.x) < ENEMY_RUN_AFTER_ALERT_DISTANCE)
			{
				enemyState = ENEMY_STATE_IDLE_TO_ALERT;
			}
		}
		
		override protected function enemyIdleToAlert():void
		{
			enemyState = ENEMY_STATE_ALERT;
		}
		
		override protected function enemyAlert():void
		{
			if (x > enemyTarget.x)	{ enemyDir = ENEMY_DIR_LEFT; }
			else 					{ enemyDir = ENEMY_DIR_RIGHT; }
			
			if (Math.abs(x - enemyTarget.x) > ENEMY_RUN_AFTER_ALERT_DISTANCE)
			{
				enemyStop();
				enemyDir = ENEMY_DIR_NONE;
				enemyState = ENEMY_STATE_ALERT_TO_IDLE;
			}
		}
		
		override protected function enemyAlertToIdle():void
		{
			enemyState = ENEMY_STATE_IDLE;
		}
		
		override protected function enemyStun():void
		{
			super.enemyStun();
		}
		
		override protected function enemyStunned():void
		{
			super.enemyStunned();
		}
		
		override protected function enemyRecover():void
		{
			super.enemyRecover();
		}
		
		override protected function enemyFreeze():void
		{
			super.enemyFreeze();
		}
		
		override protected function enemyFrozen():void
		{
			super.enemyFrozen();
		}
		
		override protected function enemyTurn():void
		{
			super.enemyTurn();
		}
		
		override protected function enemyTurning():void
		{
			super.enemyTurning();
		}
		
		override protected function enemyTurned():void
		{
			super.enemyTurned();
		}
		
		override protected function updateEnemy():void
		{
			super.updateEnemy();
			
			switch (enemyDir)
			{
				case ENEMY_DIR_LEFT:
					b2body.ApplyImpulse(new V2( -2.5, 0), b2body.GetWorldCenter());
					//b2body.SetLinearVelocity(new V2( -2, b2body.GetLinearVelocity().y));
					break;
					
				case ENEMY_DIR_RIGHT:
					b2body.ApplyImpulse(new V2( 2.5, 0), b2body.GetWorldCenter());
					//b2body.SetLinearVelocity(new V2(2, b2body.GetLinearVelocity().y));
					break;
			}
		}
		
		override protected function enemyStop():void
		{
			b2body.SetLinearVelocity(new V2(0, b2body.GetLinearVelocity().y));
		}
	}
}