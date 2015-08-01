// Gota.as

//package com.gskinner.effects {
	package{
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;

   public class Gota extends Sprite
   {
      private var scale:Number = 1;
      private var speed:Number = 40; // La velocidad de las gotas
      private var angle:Number = Math.PI / 2 + .3; // El ángulo inicial en radianes

      public function Gota():void
      {
         // Función constructora
      }
      public function init():void
      {
         angle -= Math.random() / 5; // Añade un pelín de aleatoriedad al ángulo, línea opcional
         x = Math.random() * (stage.stageWidth + Math.atan(angle - Math.PI / 2) * stage.stageHeight);
         // Posición x aleatoria
         // Lo de + Math.atan(angle - Math.PI / 2) * stage.stageHeight es para que, si el
         // ángulo es distinto de 90º, no haya una parte de la pantalla que esté siempre
         // vacía. No haré las explicaciones trigonométricas. 
         y = Math.random() * (stage.stageHeight / 2) - 100;
         // Posición y aleatoria
         // Lo de -100 es para que las gotas no empiecen tan abajo
         scale = Math.random() * 1.5;
         // Escala aleatoria, diversifica el tamaño de las gotas
         scaleX = scale;
         scaleY = scale;
         alpha = scale;
         rotation = (angle * 180 / Math.PI) - 90;
         // Rotación, en grados. Se resta 90º porque la inicial ya es 90º, las gotas hacia
         // abajo

         addEventListener(Event.ENTER_FRAME, movement);
         // Para que se muevan en cada fotograma
      }
      private function movement(evento:Event):void
      {
         y += speed * Math.sin(angle);
         x += speed * Math.cos(angle);
         // Si el ángulo es 90º (PI / 2), no se mueven en el eje x
         if (y > stage.stageHeight + height)
         {
            removeEventListener(Event.ENTER_FRAME, movement);
            stage.removeChild(this);
            // Si se salen, se eliminan
         }
      }
   }
}
