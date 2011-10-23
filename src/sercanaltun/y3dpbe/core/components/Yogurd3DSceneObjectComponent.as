package sercanaltun.y3dpbe.core.components
{
	import com.pblabs.core.PBComponent;
	import com.yogurt3d.core.geoms.interfaces.IMesh;
	import com.yogurt3d.core.materials.base.Material;
	import com.yogurt3d.core.sceneobjects.SceneObject;
	import com.yogurt3d.core.sceneobjects.SceneObjectRenderable;
	import com.yogurt3d.core.sceneobjects.interfaces.IScene;
	
	public class Yogurd3DSceneObjectComponent extends PBComponent
	{
		////////////////////////////////////////////
		// Attribute
		////////////////////////////////////////////
		private var m_y3dScene:IScene;
		private var m_sceneObject:SceneObjectRenderable;
		
		////////////////////////////////////////////
		// Constructor
		////////////////////////////////////////////
		public function Yogurd3DSceneObjectComponent()
		{
			super();
			m_sceneObject = new SceneObjectRenderable();
		}
		////////////////////////////////////////////
		// Getters and Setters
		////////////////////////////////////////////
		public function get scene():IScene
		{
			return m_y3dScene;	
		}
		public function set scene( value:IScene ):void
		{
			/// Check change 
			if( m_y3dScene != value )
			{
				/// Remove from previous scene if any
				if( m_y3dScene )
				{
					m_y3dScene.removeChild( m_sceneObject );
				}
				m_y3dScene = value;
				/// Add to the scene 
				if( m_y3dScene )
				{
					m_y3dScene.addChild(m_sceneObject); 
				}
			}
		}
		
		public function get geometry():IMesh
		{
			return m_sceneObject.geometry;
		}
		public function set geometry( value:IMesh ):void
		{
			/// Check change
			if( m_sceneObject && m_sceneObject.geometry != value )
			{
				/// Add mesh to sceneObject 
				m_sceneObject.geometry = value;
			}
		}
		
		public function get material():Material
		{
			return m_sceneObject.material;
		}
		public function set material( value:Material ):void
		{
			/// Check change
			if( m_sceneObject && m_sceneObject.material != value )
			{
				/// Add mesh to sceneObject 
				m_sceneObject.material = value;
			}
		}
		
		////////////////////////////////////////////
		// Component Implementation
		////////////////////////////////////////////
		protected override function onAdd():void
		{
			super.onAdd();
			
		}
		
		protected override function onRemove():void
		{
			super.onRemove();
		}
		
		public function onFrame(e:*):void
		{
			applyBindings();
		}
	}
}