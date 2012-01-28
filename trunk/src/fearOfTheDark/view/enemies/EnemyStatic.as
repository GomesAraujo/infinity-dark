package fearOfTheDark.view.enemies
{
	import Box2DAS.Common.*;
	
	public class EnemyStatic extends Enemy 
	{
		public function EnemyStatic() {	}
		
		override public function init():void
		{
			super.init();
		}
		
		override protected function enemyNone():void
		{
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
	}
}