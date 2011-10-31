package sercanaltun.y3dpbe.test.comp
{
	import com.pblabs.core.PBComponent;
	
	import flash.display.Stage;
	import flash.events.Event;
	
	public class TestRotator extends PBComponent
	{
		////////////////////////////////////////////
		// Managers
		////////////////////////////////////////////
		[Inject]
		public var stage:Stage;
		////////////////////////////////////////////
		// Attributes
		////////////////////////////////////////////
		private var m_rotateTarget:String;
		private var m_currentRotation:Number;
		////////////////////////////////////////////
		// Constructor
		////////////////////////////////////////////
		public function TestRotator()
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
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		protected override function onRemove():void
		{
			super.onRemove();
			stage.removeEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		public function onFrame(e:*):void
		{
			applyBindings();
			
			if( m_rotateTarget != null)
			{
				m_currentRotation++;
				owner.setProperty( m_rotateTarget, m_currentRotation );
			}
		}
		
	}
}