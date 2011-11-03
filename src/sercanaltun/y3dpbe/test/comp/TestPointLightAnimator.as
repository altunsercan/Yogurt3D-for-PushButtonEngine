package sercanaltun.y3dpbe.test.comp
{
	import com.pblabs.core.PBComponent;
	import com.yogurt3d.core.managers.tickmanager.TickManager;
	import com.yogurt3d.core.managers.tickmanager.TimeInfo;
	import com.yogurt3d.core.objects.interfaces.ITickedObject;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class TestPointLightAnimator extends PBComponent implements ITickedObject
	{
		////////////////////////////////////////////
		// Attributes
		////////////////////////////////////////////
		private var m_positionTarget:String;
		private var m_attenuationTarget:String;
		////////////////////////////////////////////
		// Constructor
		////////////////////////////////////////////
		public function TestPointLightAnimator()
		{
			super();
		}
		////////////////////////////////////////////
		// Getters & Setters
		////////////////////////////////////////////
		public function get positionTarget():String
		{
			return m_positionTarget;
		}
		public function set positionTarget(target:String):void
		{
			m_positionTarget = target;
		}
		public function get attenuationTarget():String
		{
			return m_attenuationTarget;
		}
		public function set attenuationTarget(target:String):void
		{
			m_attenuationTarget = target;
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
			
			if( m_positionTarget != null && m_attenuationTarget != null )
			{
				owner.setProperty( m_attenuationTarget, Vector.<Number>([.1, (_timeInfo.objectTime %1000) / 1000 / 8, 0, 1]) );
				owner.setProperty( m_positionTarget, new Vector3D(
					Math.sin( _timeInfo.objectTime / 1000 ) * 100,
					5,
					Math.cos( _timeInfo.objectTime / 1000 ) * 100
				));
			}
		}
		
	}
}