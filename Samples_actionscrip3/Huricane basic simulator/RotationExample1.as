package {
    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.geom.*;
    import flash.display.Graphics;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    public class RotationExample1 extends MovieClip {
        private var ellipse:Shape = new Shape();
        private var speed:int = 10;
        private var ellipse1:Shape;
        private var ellipse2:Shape;
        
        public function RotationExample1():void {
            ellipse1 = drawEllipse(-50, -40, (this.stage.stageWidth / 2), 
                                    (this.stage.stageHeight / 2));
            
            ellipse2 = drawEllipse(30, 40, (this.stage.stageWidth / 2), 
                                          (this.stage.stageHeight / 2));
            this.addChild(ellipse1);
            this.addChild(ellipse2);
            var t:Timer = new Timer(50);
            t.addEventListener(TimerEvent.TIMER, timerHandler);
            t.start();
        }
        private function drawEllipse(x1, y1, x2, y2):Shape {
        
            var e:Shape = new Shape();
            e.graphics.beginFill(0xFF0000);
            e.graphics.lineStyle(2);
            e.graphics.drawEllipse(x1, y1, 100, 80);
            e.graphics.endFill();
            e.x  = x2;  
            e.y  = y2;
            e.z = 1;
            return e;
        }
        private function timerHandler(event:TimerEvent):void {
            ellipse1.rotationY += speed;    
            ellipse1.rotationX -= speed;
            ellipse2.rotationY += speed;    
            ellipse2.rotationX -= speed;
        }
    }
}
