package sercanaltun.y3dpbe.core.components
{
	import com.pblabs.core.PBComponent;
	import com.yogurt3d.core.sceneobjects.interfaces.IScene;
	import com.yogurt3d.core.sceneobjects.interfaces.ISceneObject;
	import com.yogurt3d.core.transformations.Transformation;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import sercanaltun.y3dpbe.core.ns.y3d_hidden;
	
	public class Y3DSceneObjectComp extends PBComponent
	{
		use namespace y3d_hidden;
		////////////////////////////////////////////
		// Managers
		////////////////////////////////////////////
		[Inject]
		public var stage:Stage;
		
		
		////////////////////////////////////////////
		// Attribute
		////////////////////////////////////////////
		protected var m_addedToOwner:Boolean;
		protected var m_addedToScene:Boolean;
		protected var m_y3dScene:IScene;
		y3d_hidden var m_sceneObject:ISceneObject;
		////////////////////////////////////////////
		// Constructor
		////////////////////////////////////////////
		public function Y3DSceneObjectComp()
		{
			super();
			m_addedToOwner = false;
			m_addedToScene = false;
		}
		////////////////////////////////////////////
		// Getters and Setters
		////////////////////////////////////////////
		// --- Scene
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
		/// --- Transformation
		public function get transformation():Transformation
		{
			return m_sceneObject.transformation;
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
		public function get rotationX():Number
		{
			if( m_sceneObject)
			{
				return m_sceneObject.transformation.rotationX;
			}
			return 0;
		}
		public function set rotationX( value:Number ):void
		{
			/// Check null
			if( m_sceneObject )
			{
				/// Add mesh to sceneObject 
				m_sceneObject.transformation.rotationX = value;
			}
		}
		public function get rotationY():Number
		{
			if( m_sceneObject)
			{
				return m_sceneObject.transformation.rotationY;
			}
			return 0;
		}
		public function set rotationY( value:Number ):void
		{
			/// Check null
			if( m_sceneObject )
			{
				/// Add mesh to sceneObject 
				m_sceneObject.transformation.rotationY = value;
			}
		}
		public function get rotationZ():Number
		{
			if( m_sceneObject)
			{
				return m_sceneObject.transformation.rotationZ;
			}
			return 0;
		}
		public function set rotationZ( value:Number ):void
		{
			/// Check null
			if( m_sceneObject )
			{
				/// Add mesh to sceneObject 
				m_sceneObject.transformation.rotationY = value;
			}
		}
		////////////////////////////////////////////
		// PBComponent Implementation
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