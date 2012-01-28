package   
{
	import flash.display.MovieClip;
	import fearOfTheDark.view.enemies.*;
	import wck.*;
	
	public class FearOfTheDark extends wck.WCK
	{
		public function FearOfTheDark()
		{
			super();
			
			EnemyRunAfter(game["enemyRun"]).init();
			EnemyRunAfter(game["enemyRun"]).enemyTarget = game["boxman"];
		}
	}
}