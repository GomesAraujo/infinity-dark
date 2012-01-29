package fearOfTheDark.view.enemies.attacks
{
	import shapes.*;
	
	public class EnemyBossRock extends Box
	{
		public function EnemyBossRock() {	}
		
		public function freezeRock():void
		{
			active = false;
		}
	}
}