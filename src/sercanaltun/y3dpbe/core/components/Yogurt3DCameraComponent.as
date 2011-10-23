package sercanaltun.y3dpbe.core.components
{
	import com.pblabs.core.PBComponent;
	import com.yogurt3d.core.cameras.Camera;
	
	import flash.geom.Vector3D;
	
	import sercanaltun.y3dpbe.core.ns.y3d_hidden;
	
	public class Yogurt3DCameraComponent extends PBComponent
	{
		y3d_hidden var m_camera:Camera;
		
		private var m_position:Vector3D;
		
		public function Yogurt3DCameraComponent()
		{
			super();
			y3d_hidden::m_camera = new Camera();
		}
		////////////////////////////////////////////
		// Component Implementation
		////////////////////////////////////////////
		protected override function onAdd():void
		{
			super.onAdd();
			if( owner is Yogurt3DContextObject )
			{
				m_context = Yogurt3DContextObject( owner );
				m_context.registerCameraComponent( this );
			}
		}
		
		protected override function onRemove():void
		{
			super.onRemove();
			if( m_context )
			{
				m_context.unregisterCameraComponent( this );
			}
		}
		
		public function onFrame(e:*):void
		{
			applyBindings();
		}
		////////////////////////////////////////////
		// Spatial 
		////////////////////////////////////////////
		public function get position():Vector3D
		{
			return m_position;
		}
		public function set position( value:Vector3D ):void
		{
			m_position = value;
		}
	}
}