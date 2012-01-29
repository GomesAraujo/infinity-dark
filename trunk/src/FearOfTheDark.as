﻿package
{
	import flash.display.MovieClip;
	import fearOfTheDark.view.enemies.*;
	import fearOfTheDark.view.ui.*;
	import flash.events.Event;
	import wck.*;
	
	public class FearOfTheDark extends wck.WCK
	{
		public function FearOfTheDark()
		{
			super();
			
			EnemyRunAfter(worldGame["enemyRun"]).init();
			EnemyRunAfter(worldGame["enemyRun"]).enemyTarget = worldGame["boxman"];
			
			EnemyJumper(worldGame["enemyJumper"]).init();
			EnemyJumper(worldGame["enemyJumper"]).enemyTarget = worldGame["boxman"];
			
			EnemyBoss(worldGame["enemyBoss"]).init();
			EnemyBoss(worldGame["enemyBoss"]).enemyTarget = worldGame["boxman"];
			EnemyBoss(worldGame["enemyBoss"]).registerRocks(worldGame["rock1"], worldGame["rock2"], worldGame["rock3"]);
						
			Map(this["map"]).setStageLength(3834);
			
			worldGame.bg_1.gotoAndStop(1);
			worldGame.bg_2.gotoAndStop(2);
			worldGame.bg_3.gotoAndStop(3);
			//bg_4.gotoAndStop(4);
			
			addEventListener(Event.ENTER_FRAME, updateMap);
		}
		
		function updateMap(evt:Event)
		{		
			Map(this["map"]).setBoyPositionInStage(worldGame.boxman.x);
		}
	}
}