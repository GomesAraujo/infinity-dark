package fearOfTheDark.view.enemies
{
	import flash.display.*;
	import flash.utils.*;
	
	import Box2DAS.Common.*;
	
	public class EnemyJumper extends Enemy 
	{
		private static const ENEMY_JUMPER_ALERT_DISTANCE:Number = 200;
		private static const ENEMY_JUMPER_JUMP_IMPULSE_X:Number = 0.12;
		private static const ENEMY_JUMPER_JUMP_IMPULSE_Y:Number = 0.45;
		private static const ENEMY_JUMPER_JUMP_DURATION_MS:Number = 300;
		private static const ENEMY_JUMPER_JUMP_WAIT_MS:Number = 500;
		
		private static const ENEMY_JUMPER_JUMP_STATE_NONE:int = 0;
		private static const ENEMY_JUMPER_JUMP_STATE_UP:int = 1;
		private static const ENEMY_JUMPER_JUMP_STATE_DOWN:int = 2;
		
		private var jumpState:int;
		
		public function EnemyJumper() {	}
		
		override public function init():void
		{
			super.init();
			jumpState = ENEMY_JUMPER_JUMP_STATE_NONE;
		}
		
		override protected function enemyNone():void
		{
			super.enemyNone();
		}
		
		override protected function enemyIdle():void
		{
			if (Math.abs(x - enemyTarget.x) < ENEMY_JUMPER_ALERT_DISTANCE)
			{
				enemyState = ENEMY_STATE_IDLE_TO_ALERT;
			}
		}
		
		override protected function enemyIdleToAlert():void
		{
			if (x > enemyTarget.x)
			{
				scaleX = 1.0;
				enemyDir = ENEMY_DIR_LEFT;
			}
			else
			{
				scaleX = -1.0;
				enemyDir = ENEMY_DIR_RIGHT;
			}
			
			currentTime = getTimer();
			actionTime = 0;
			jumpState = ENEMY_JUMPER_JUMP_STATE_UP;
			enemyState = ENEMY_STATE_ALERT;
		}
		
		override protected function enemyAlert():void
		{
			lastTime = currentTime;
			currentTime = getTimer();
			actionTime += (currentTime - lastTime);
			
			//trace("jumpState = " + jumpState);
			//trace("enemyState = " + enemyState);
			//trace("--------------");
			
			if ((jumpState == ENEMY_JUMPER_JUMP_STATE_UP) && (actionTime >= ENEMY_JUMPER_JUMP_DURATION_MS))
			{
				actionTime = 0;
				jumpState = ENEMY_JUMPER_JUMP_STATE_DOWN;
			}
			else
			
			if ((jumpState == ENEMY_JUMPER_JUMP_STATE_DOWN) && (actionTime >= (ENEMY_JUMPER_JUMP_DURATION_MS * 0.8)) && (b2body.GetLinearVelocity().y <= 0.1))
			{
				enemyStop();
				actionTime = 0;
				jumpState = ENEMY_JUMPER_JUMP_STATE_NONE;
				enemyDir = ENEMY_DIR_NONE;
				enemyState = ENEMY_STATE_ALERT_TO_IDLE;
			}
		}
		
		override protected function enemyAlertToIdle():void
		{
			lastTime = currentTime;
			currentTime = getTimer();
			actionTime += (currentTime - lastTime);
			
			if (actionTime >= ENEMY_JUMPER_JUMP_WAIT_MS)
			{
				enemyState = ENEMY_STATE_IDLE;
			}
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
			
			var impulseX:Number = 0;
			var impulseY:Number = 0;
			
			if (enemyDir == ENEMY_DIR_LEFT)		{ impulseX = -ENEMY_JUMPER_JUMP_IMPULSE_X; } else
			if (enemyDir == ENEMY_DIR_RIGHT)	{ impulseX =  ENEMY_JUMPER_JUMP_IMPULSE_X; }
			
			if (jumpState == ENEMY_JUMPER_JUMP_STATE_UP)	{ impulseY = -ENEMY_JUMPER_JUMP_IMPULSE_Y; } else
			if (jumpState == ENEMY_JUMPER_JUMP_STATE_DOWN)	{ impulseY =  ENEMY_JUMPER_JUMP_IMPULSE_Y * 0.1; }
			
			if (enemyDir != ENEMY_DIR_NONE)
			{
				b2body.ApplyImpulse(new V2(impulseX, impulseY), b2body.GetWorldCenter());
			}
		}
		
		override protected function enemyStop():void
		{
			b2body.SetLinearVelocity(new V2(0, 0));
		}
	}
}