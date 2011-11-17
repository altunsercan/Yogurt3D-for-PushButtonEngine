package sercanaltun.y3dpbe.tutorials.comp
{
	import com.pblabs.core.PBComponent;
	import com.yogurt3d.core.managers.tickmanager.TickManager;
	import com.yogurt3d.core.managers.tickmanager.TimeInfo;
	import com.yogurt3d.core.objects.interfaces.ITickedObject;
	
	import flash.display.Stage;
	import flash.events.Event;
	
	public class TestPreciseRotator extends PBComponent implements ITickedObject
	{
		////////////////////////////////////////////
		// Attributes
		////////////////////////////////////////////
		private var m_rotateTarget:String;
		private var m_currentRotation:Number;
		////////////////////////////////////////////
		// Constructor
		////////////////////////////////////////////
		public function TestPreciseRotator()
		{
			super();
			m_currentRotation=0;
		}
		////////////////////////////////////////////
		// Getters & Setters
		////////////////////////////////////////////
		public function get rotateTarget():String
		{
			return m_rotateTarget;
		}
		public function set rotateTarget(target:String):void
		{
			m_rotateTarget = target;
		}
		////////////////////////////////////////////
		// PBComponent Implementation
		////////////////////////////////////////////
		protected override function onAdd():void
		{
			super.onAdd();
			TickManager.registerObject( this );
		}
		
		protected override function onRemove():void
		{
			super.onRemove();
		}
		
		public function updateWithTimeInfo(_timeInfo:TimeInfo):void
		{
			applyBindings();
			
			if( m_rotateTarget != null)
			{
				// here we are using object time ( ie. Life time of the object ) as way to determine the rotation
				// we can also use systemtime or delta ( Time difference between frames ) to calculate rotation				
				owner.setProperty( m_rotateTarget, _timeInfo.objectTime / 1000 * 60 );
			}
		}
		
	}
}