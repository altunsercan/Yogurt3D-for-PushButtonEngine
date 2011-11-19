package sercanaltun.y3dpbe.core.components
{
	import com.yogurt3d.core.lights.ELightType;
	import com.yogurt3d.core.lights.Light;
	
	import sercanaltun.y3dpbe.core.ns.y3d_hidden;

	public class Y3DLightComponent extends Y3DSceneObjectComp
	{
		////////////////////////////////////////////
		// Attribute
		////////////////////////////////////////////
		protected var m_light:Light;
		////////////////////////////////////////////
		// Constructor
		////////////////////////////////////////////
		public function Y3DLightComponent()
		{
			super();
			m_light = new Light();
			y3d_hidden::m_sceneObject = m_light;
		}
		////////////////////////////////////////////
		// Getters and Setters
		////////////////////////////////////////////
		public function get type():ELightType
		{
			return m_light.type;	
		}
		public function set type( value:ELightType ):void
		{
			/// Check change 
			if( m_light.type != value )
			{
				m_light.type = value;
			}
		}
		public function get attenuation():Vector.<Number>
		{
			return m_light.attenuation;	
		}
		public function set attenuation( value:Vector.<Number> ):void
		{
			/// Check change 
			if( m_light.attenuation != value )
			{
				m_light.attenuation = value;
			}
		}
	}
}