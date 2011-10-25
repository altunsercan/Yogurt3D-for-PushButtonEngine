package sercanaltun.y3dpbe.core.components
{
	import com.pblabs.core.PBComponent;
	import com.yogurt3d.core.geoms.interfaces.IMesh;
	import com.yogurt3d.core.materials.base.Material;
	import com.yogurt3d.core.sceneobjects.SceneObject;
	import com.yogurt3d.core.sceneobjects.SceneObjectRenderable;
	import com.yogurt3d.core.sceneobjects.interfaces.IScene;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	public class Yogurt3DSceneObjectComponent extends PBComponent
	{
		////////////////////////////////////////////
		// Managers
		////////////////////////////////////////////
		[Inject]
		public var stage:Stage;
		
		////////////////////////////////////////////
		// Attribute
		////////////////////////////////////////////
		private var m_addedToOwner:Boolean;
		private var m_addedToScene:Boolean;
		
		private var m_y3dScene:IScene;
		private var m_sceneObject:SceneObjectRenderable;
		
		////////////////////////////////////////////
		// Constructor
		////////////////////////////////////////////
		public function Yogurt3DSceneObjectComponent()
		{
			super();
			m_addedToOwner = false;
			m_addedToScene = false;
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
				updateContainer();
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
		
		public function get position():Vector3D
		{
			return m_sceneObject.transformation.position.clone();
		}
		public function set position( value:Vector3D ):void
		{
			/// Check null
			if( m_sceneObject )
			{
				/// Add mesh to sceneObject 
				m_sceneObject.transformation.position = value;
			}
		}
		/// FOR TEST PURPOSES
		public function get pointTarget():Point
		{
			return null;
		}
		public function set pointTarget( value:Point ):void
		{
			var vector3d:Vector3D = new Vector3D( (value.x-400)/800*20, (value.y-300)/600*-20, 0);
			
			position = vector3d;
			
		}
		////////////////////////////////////////////
		// Component Implementation
		////////////////////////////////////////////
		protected override function onAdd():void
		{
			super.onAdd();
			m_addedToOwner = true;
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
			updateContainer();
		}
		
		protected override function onRemove():void
		{
			super.onRemove();
			
			updateContainer();
			stage.removeEventListener(Event.ENTER_FRAME, onFrame);
			
			m_addedToOwner = false;
		}
		
		public function onFrame(e:*):void
		{
			applyBindings();
		}
		////////////////////////////////////////////
		// Container
		////////////////////////////////////////////
		private function updateContainer():void
		{
			/// If component is added to owner
			if( m_addedToOwner)
			{
				/// Check if the container properties are set
				if( m_y3dScene )
				{
					/// If the current scene is not set scene remove from it
					if( m_sceneObject.scene!=null && m_sceneObject.scene != m_y3dScene )
					{
						m_sceneObject.scene.removeChild( m_sceneObject ); 
					}
					/// Didn't add it to the current scene yet? Add it
					if( m_sceneObject.scene == null )
					{
						m_y3dScene.addChild( m_sceneObject );
					}
				}else
				{
					/// Remove from current scene if exists
					if( m_sceneObject.scene!=null && m_sceneObject.scene != m_y3dScene )
					{
						m_sceneObject.scene.removeChild( m_sceneObject ); 
					}
				}
			}
			
		}
	}
}