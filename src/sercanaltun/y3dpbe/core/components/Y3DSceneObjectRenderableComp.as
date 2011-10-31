package sercanaltun.y3dpbe.core.components
{
	import com.pblabs.core.PBComponent;
	import com.yogurt3d.core.geoms.interfaces.IMesh;
	import com.yogurt3d.core.materials.base.Material;
	import com.yogurt3d.core.sceneobjects.SceneObject;
	import com.yogurt3d.core.sceneobjects.SceneObjectRenderable;
	import com.yogurt3d.core.sceneobjects.interfaces.IScene;
	import com.yogurt3d.core.sceneobjects.interfaces.ISceneObjectRenderable;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import sercanaltun.y3dpbe.core.ns.y3d_hidden;
	
	public class Y3DSceneObjectRenderableComp extends Y3DSceneObjectComp
	{
		
		
		////////////////////////////////////////////
		// Attribute
		////////////////////////////////////////////
		protected var m_sceneObjRend:ISceneObjectRenderable;
		
		////////////////////////////////////////////
		// Constructor
		////////////////////////////////////////////
		public function Y3DSceneObjectRenderableComp()
		{
			super();
			m_sceneObjRend = new SceneObjectRenderable();
			y3d_hidden::m_sceneObject = m_sceneObjRend;
			
		}
		////////////////////////////////////////////
		// Getters and Setters
		////////////////////////////////////////////
		public function get geometry():IMesh
		{
			return m_sceneObjRend.geometry;
		}
		public function set geometry( value:IMesh ):void
		{
			/// Check change
			if( m_sceneObjRend && m_sceneObjRend.geometry != value )
			{
				/// Add mesh to sceneObject 
				m_sceneObjRend.geometry = value;
			}
		}
		
		public function get material():Material
		{
			return m_sceneObjRend.material;
		}
		public function set material( value:Material ):void
		{
			/// Check change
			if( m_sceneObjRend && m_sceneObjRend.material != value )
			{
				/// Add mesh to sceneObject 
				m_sceneObjRend.material = value;
			}
		}
	}
}