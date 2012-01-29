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
			super.enemyNone();
		}
		
		override protected function enemyIdle():void
		{
			super.enemyIdle();
		}
		
		override protected function enemyIdleToAlert():void
		{
			super.enemyIdleToAlert();
		}
		
		override protected function enemyAlert():void
		{
			super.enemyAlert();
		}
		
		override protected function enemyAlertToIdle():void
		{
			super.enemyAlertToIdle();
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
		
		protected function enemyFreeze():void
		{
			super.enemyFreeze();
		}
		
		protected function enemyFrozen():void
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
	}
}