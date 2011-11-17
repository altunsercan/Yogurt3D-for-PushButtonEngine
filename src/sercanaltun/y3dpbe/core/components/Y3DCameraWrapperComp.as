package sercanaltun.y3dpbe.core.components
{
	import com.pblabs.core.PBComponent;
	import com.yogurt3d.core.cameras.Camera;
	import com.yogurt3d.core.cameras.Frustum;
	import com.yogurt3d.core.culling.FrustrumPlaneAABB;
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
	
	public class Y3DCameraWrapperComp extends Y3DSceneObjectComp
	{
		
		
		////////////////////////////////////////////
		// Attribute
		////////////////////////////////////////////
		protected var m_camera:Camera
		////////////////////////////////////////////
		// Constructor
		////////////////////////////////////////////
		public function Y3DSceneObjectRenderableComp()
		{
			super();
			//m_camera = new SceneObjectRenderable();
			//y3d_hidden::m_sceneObject = m_sceneObjRend;
			
		}
		////////////////////////////////////////////
		// Initialization
		////////////////////////////////////////////
		public function createDefaultCamera():void
		{
			useCamera( new Camera() );
		}
		public function useCamera(camera:Camera):void
		{
			m_camera = camera;
			y3d_hidden::m_sceneObject = m_camera;
		}
		////////////////////////////////////////////
		// Getters and Setters
		////////////////////////////////////////////
		public function get frustrum():Frustum
		{
			if( m_camera)
				return m_camera.frustum;
			return null;
		}
		public function set frustrum(frustrum:Frustum):void
		{
			m_camera.frustum = frustrum;
		}
		
	}
}