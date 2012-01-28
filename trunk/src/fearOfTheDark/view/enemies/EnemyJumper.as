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
		
		private var jumpTime:Number;
		private var jumpState:int;
		private var currentTime:int;
		private var lastTime:int;
		
		public function EnemyJumper() {	}
		
		override public function init():void
		{
			super.init();
			jumpTime = 0;
			jumpState = ENEMY_JUMPER_JUMP_STATE_NONE;
		}
		
		override protected function enemyNone():void
		{
			enemyState = ENEMY_STATE_IDLE;
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
			if (x > enemyTarget.x)	{ enemyDir = ENEMY_DIR_LEFT; }
			else 					{ enemyDir = ENEMY_DIR_RIGHT; }
			
			currentTime = getTimer();
			jumpTime = 0;
			jumpState = ENEMY_JUMPER_JUMP_STATE_UP;
			enemyState = ENEMY_STATE_ALERT;
		}
		
		override protected function enemyAlert():void
		{
			lastTime = currentTime;
			currentTime = getTimer();
			jumpTime += (currentTime - lastTime);
			
			//trace("jumpState = " + jumpState);
			//trace("enemyState = " + enemyState);
			//trace("--------------");
			
			if ((jumpState == ENEMY_JUMPER_JUMP_STATE_UP) && (jumpTime >= ENEMY_JUMPER_JUMP_DURATION_MS))
			{
				jumpTime = 0;
				jumpState = ENEMY_JUMPER_JUMP_STATE_DOWN;
			}
			else
			
			if ((jumpState == ENEMY_JUMPER_JUMP_STATE_DOWN) && (jumpTime >= (ENEMY_JUMPER_JUMP_DURATION_MS * 0.6)) && (b2body.GetLinearVelocity().y <= 0.1))
			{
				enemyStop();
				jumpTime = 0;
				jumpState = ENEMY_JUMPER_JUMP_STATE_NONE;
				enemyDir = ENEMY_DIR_NONE;
				enemyState = ENEMY_STATE_ALERT_TO_IDLE;
			}
		}
		
		override protected function enemyAlertToIdle():void
		{
			lastTime = currentTime;
			currentTime = getTimer();
			jumpTime += (currentTime - lastTime);
			
			if (jumpTime >= ENEMY_JUMPER_JUMP_WAIT_MS)
			{
				enemyState = ENEMY_STATE_IDLE;
			}
		}
		
		override protected function enemyStun():void
		{
		}
		
		override protected function enemyStunned():void
		{
		}
		
		override protected function enemyRecover():void
		{
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
			
			b2body.ApplyImpulse(new V2(impulseX, impulseY), b2body.GetWorldCenter());
		}
		
		override protected function enemyStop():void
		{
			b2body.SetLinearVelocity(new V2(0, 0))
		}
	}
}