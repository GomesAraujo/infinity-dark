package fearOfTheDark.view.enemies
{
	import Box2DAS.Common.*;
	
	public class EnemyRunAfter extends Enemy 
	{
		public function EnemyRunAfter() {	}
		
		override public function init():void
		{
			super.init();
		}
		
		override protected function enemyNone():void
		{
			enemyState = ENEMY_STATE_IDLE;
		}
		
		override protected function enemyIdle():void
		{
		}
		
		override protected function enemyIdleToAlert():void
		{
		}
		
		override protected function enemyAlert():void
		{
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
			
			
			switch (enemyDir)
			{
				case ENEMY_DIR_LEFT:
					b2body.ApplyImpulse(new V2( -0.1, 0), b2body.GetWorldCenter());
					break;
					
				case ENEMY_DIR_RIGHT:
					b2body.ApplyImpulse(new V2( 0.1, 0), b2body.GetWorldCenter());
					break;
			}
		}
	}
}