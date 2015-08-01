package 
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class MouseEvents
	{
		static public const RELEASE_OUTSIDE = "onReleaseOutside";
		private var target:InteractiveObject;
		
		function MouseEvents(obj:InteractiveObject)
		{
			target = obj;
			createChildrens();
		}
		
		private function createChildrens():void
		{
			target.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
		}
		
		private function onPress(event:MouseEvent):void
		{
			target.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		private function onRollOut(event:MouseEvent):void
		{
			if (event.buttonDown) {
				target.stage.addEventListener(MouseEvent.MOUSE_UP, onReleaseOutSide);
			}
			target.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		private function onReleaseOutSide(event:MouseEvent):void
		{
			if (event.target == target) {
				return;
			}
			var nEvent:Event = new Event(RELEASE_OUTSIDE);
			target.dispatchEvent(nEvent);
			target.stage.removeEventListener(MouseEvent.MOUSE_UP, onReleaseOutSide);
		}
	}
}