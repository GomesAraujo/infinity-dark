package
{
	import flash.display.MovieClip;
	import fearOfTheDark.view.enemies.*;
	import fearOfTheDark.view.ui.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import wck.*;
	
	public class FearOfTheDark extends wck.WCK
	{
		public function FearOfTheDark()
		{
			
			super();
			menu.btnStart.addEventListener(MouseEvent.CLICK, init);
			menu.btnCredits.addEventListener(MouseEvent.CLICK, creditsHandler);
		}
		
		private function creditsHandler(e:MouseEvent):void 
		{
			gotoAndStop(3);
			creditos.btnBack.addEventListener(MouseEvent.CLICK, backClickHandler);
		}
		
		private function backClickHandler(e:MouseEvent):void 
		{
			gotoAndStop(1);
			menu.btnStart.addEventListener(MouseEvent.CLICK, init);
			menu.btnCredits.addEventListener(MouseEvent.CLICK, creditsHandler);
		}
		
		private function init(event:Event=null):void
		{
			gotoAndStop(2);
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