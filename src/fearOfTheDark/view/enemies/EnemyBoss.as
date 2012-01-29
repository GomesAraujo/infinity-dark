package fearOfTheDark.view.enemies
{
	import fearOfTheDark.view.enemies.attacks.EnemyBossRock;
	
	import flash.display.*;
	import flash.utils.*;
	
	import Box2DAS.Common.*;
	
	public class EnemyBoss extends Enemy
	{
		private static const ENEMY_BOSS_ROCKS_STATE_NONE:int = 0;
		private static const ENEMY_BOSS_ROCKS_STATE_WAITING:int = 1;
		private static const ENEMY_BOSS_ROCKS_STATE_READY:int = 2;
		private static const ENEMY_BOSS_ROCKS_STATE_FALL:int = 3;
		private static const ENEMY_BOSS_ROCKS_STATE_FALLING:int = 4;
		private static const ENEMY_BOSS_ROCKS_STATE_AFTER_FALL:int = 5;
		
		private static const ENEMY_BOSS_STATE_NONE:int = 0;
		private static const ENEMY_BOSS_STATE_WALKING:int = 1;
		private static const ENEMY_BOSS_STATE_RUNNING:int = 2;
		private static const ENEMY_BOSS_STATE_RECOVER:int = 3;
		
		private static const ENEMY_BOSS_ROCKS_APPEAR_X_DELTA:int = 400;
		private static const ENEMY_BOSS_ROCKS_APPEAR_Y:int = 0;
		
		private static const ENEMY_BOSS_ROCKS_WAIT_DURATION_MS:int = 5000;
		private static const ENEMY_BOSS_ROCKS_AFTER_FALL_DURATION_MS:int = 2000;
		
		private static const ENEMY_BOSS_RUN_DISTANCE:Number = 400;
		
		private static const ENEMY_BOSS_RUN_DURATION_MS:int = 3000;
		private static const ENEMY_BOSS_RECOVER_DURATION_MS:int = 3000;
		
		private static const ENEMY_BOSS_WALK_IMPULSE_X:Number = 0.12;
		private static const ENEMY_BOSS_RUN_IMPULSE_X:Number = 0.08;
		
		private var rock1:EnemyBossRock;
		private var rock2:EnemyBossRock;
		private var rock3:EnemyBossRock;
		private var rocksTime:Number;
		private var rocksState:int;
		private var bossTime:Number;
		private var bossState:int;
		private var currentTime:int;
		private var lastTime:int;
		
		public function EnemyBoss() {	}
		
		override public function init():void
		{
			super.init();
			rocksTime = 0;
			rocksState = ENEMY_BOSS_ROCKS_STATE_NONE;
			bossTime = 0;
			bossState = ENEMY_BOSS_STATE_NONE;
		}
		
		public function registerRocks(r1:EnemyBossRock, r2:EnemyBossRock, r3:EnemyBossRock):void
		{
			rock1 = r1;
			rock2 = r2;
			rock3 = r3;
		}
		
		override protected function enemyNone():void
		{
			rock1.visible = false;
			rock2.visible = false;
			rock3.visible = false;
			
			rock1.active = false;
			rock2.active = false;
			rock3.active = false;
			
			enemyState = ENEMY_STATE_IDLE;
		}
		
		override protected function enemyIdle():void
		{
			enemyState = ENEMY_STATE_IDLE_TO_ALERT;
		}
		
		override protected function enemyIdleToAlert():void
		{
			currentTime = getTimer();
			enemyState = ENEMY_STATE_ALERT;
		}
		
		override protected function enemyAlert():void
		{
			lastTime = currentTime;
			currentTime = getTimer();
			
			//if (isOffscreen())
			{
				if (x > enemyTarget.x)	{ enemyDir = ENEMY_DIR_LEFT; }
				else 					{ enemyDir = ENEMY_DIR_RIGHT; }
			}
			
			switch (bossState)
			{
				case ENEMY_BOSS_STATE_NONE:
					bossState = ENEMY_BOSS_STATE_WALKING;
					break;
					
				case ENEMY_BOSS_STATE_WALKING:
					if (Math.abs(x - enemyTarget.x) < ENEMY_BOSS_RUN_DISTANCE)
					{
						bossTime = 0;
						bossState = ENEMY_BOSS_STATE_RUNNING;
					}
					break;
					
				case ENEMY_BOSS_STATE_RUNNING:
					bossTime += (currentTime - lastTime);
					
					if (bossTime >= ENEMY_BOSS_RUN_DURATION_MS)
					{
						bossTime = 0;
						bossState = ENEMY_BOSS_STATE_RECOVER;
					}
					break;
					
				case ENEMY_BOSS_STATE_RECOVER:
					bossTime += (currentTime - lastTime);
					
					if (bossTime >= ENEMY_BOSS_RECOVER_DURATION_MS)
					{
						bossState = ENEMY_BOSS_STATE_RECOVER;
					}
					break;
			}
			
			switch (rocksState)
			{
				case ENEMY_BOSS_ROCKS_STATE_NONE:
					rocksTime = 0;
					rocksState = ENEMY_BOSS_ROCKS_STATE_WAITING;
					break;
					
				case ENEMY_BOSS_ROCKS_STATE_WAITING:
					rocksTime += (currentTime - lastTime);
					if (rocksTime > ENEMY_BOSS_ROCKS_WAIT_DURATION_MS)
					{
						rocksState = ENEMY_BOSS_ROCKS_STATE_READY;
					}
					break;
					
				case ENEMY_BOSS_ROCKS_STATE_READY:
					// Extra conditions
					rocksState = ENEMY_BOSS_ROCKS_STATE_FALL;
					break;
					
				case ENEMY_BOSS_ROCKS_STATE_FALL:
					rock1.x = x + (Math.random() * ENEMY_BOSS_ROCKS_APPEAR_X_DELTA) * ((Math.random() > 0.5) ? 1.0 : -1.0);
					rock1.y = ENEMY_BOSS_ROCKS_APPEAR_Y;
					rock1.syncTransform();
					rock1.visible = true;
					rock1.active = true;
					rock1.b2body.SetLinearVelocity(new V2(0, 0));
					rock1.b2body.ApplyImpulse(new V2(0, 0.05), rock1.b2body.GetWorldCenter());
					
					rock2.x = x + (Math.random() * ENEMY_BOSS_ROCKS_APPEAR_X_DELTA) * ((Math.random() > 0.5) ? 1.0 : -1.0);
					rock2.y = ENEMY_BOSS_ROCKS_APPEAR_Y;
					rock2.syncTransform();
					rock2.visible = true;
					rock2.active = true;
					rock2.b2body.SetLinearVelocity(new V2(0, 0));
					rock2.b2body.ApplyImpulse(new V2(0, 0.05), rock2.b2body.GetWorldCenter());
					
					rock3.x = x + (Math.random() * ENEMY_BOSS_ROCKS_APPEAR_X_DELTA) * ((Math.random() > 0.5) ? 1.0 : -1.0);
					rock3.y = ENEMY_BOSS_ROCKS_APPEAR_Y;
					rock3.syncTransform();
					rock3.visible = true;
					rock3.active = true;
					rock3.b2body.SetLinearVelocity(new V2(0, 0));
					rock3.b2body.ApplyImpulse(new V2(0, 0.05), rock3.b2body.GetWorldCenter());
					
					rocksState = ENEMY_BOSS_ROCKS_STATE_FALLING;
					break;
					
				case ENEMY_BOSS_ROCKS_STATE_FALLING:
					if ((rock1.b2body.GetLinearVelocity().y <= 0.05) && (rock2.b2body.GetLinearVelocity().y <= 0.05) && (rock3.b2body.GetLinearVelocity().y <= 0.05))
					{
						rocksTime = 0;
						rocksState = ENEMY_BOSS_ROCKS_STATE_AFTER_FALL;
					}
					break;
					
				case ENEMY_BOSS_ROCKS_STATE_AFTER_FALL:
					rocksTime += (currentTime - lastTime);
					if (rocksTime > ENEMY_BOSS_ROCKS_AFTER_FALL_DURATION_MS)
					{
						rock1.visible = false;
						rock2.visible = false;
						rock3.visible = false;
						
						//rock1.b2body.ApplyImpulse(new V2(0, -0.05), rock1.b2body.GetWorldCenter());
						//rock2.b2body.ApplyImpulse(new V2(0, -0.05), rock2.b2body.GetWorldCenter());
						//rock3.b2body.ApplyImpulse(new V2(0, -0.05), rock3.b2body.GetWorldCenter());
						
						rock1.active = false;
						rock2.active = false;
						rock3.active = false;
						
						rocksTime = 0;
						rocksState = ENEMY_BOSS_ROCKS_STATE_WAITING;
					}
					break;
			}
		}
		
		override protected function enemyAlertToIdle():void
		{
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
			
			if (bossState == ENEMY_BOSS_STATE_RUNNING)	{ impulseX = ENEMY_BOSS_RUN_IMPULSE_X;  }
			else										{ impulseX = ENEMY_BOSS_WALK_IMPULSE_X;  }
			
			switch (enemyDir)
			{
				case ENEMY_DIR_LEFT:
					b2body.ApplyImpulse(new V2(-impulseX, 0), b2body.GetWorldCenter());
					break;
					
				case ENEMY_DIR_RIGHT:
					b2body.ApplyImpulse(new V2(impulseX, 0), b2body.GetWorldCenter());
					break;
			}
		}
		
		override protected function enemyStop():void
		{
			b2body.SetLinearVelocity(new V2(0, 0));
		}
	}
}