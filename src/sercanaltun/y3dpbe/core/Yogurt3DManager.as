package sercanaltun.y3dpbe.core
{
	import com.pblabs.core.IPBManager;
	import com.pblabs.core.PBGameObject;
	import com.yogurt3d.Yogurt3D;
	import com.yogurt3d.core.cameras.Camera;
	import com.yogurt3d.core.cameras.interfaces.ICamera;
	import com.yogurt3d.core.events.Yogurt3DEvent;
	import com.yogurt3d.core.managers.contextmanager.Context;
	import com.yogurt3d.core.materials.base.Color;
	import com.yogurt3d.core.renderers.interfaces.IRenderer;
	import com.yogurt3d.core.sceneobjects.Scene;
	import com.yogurt3d.core.sceneobjects.interfaces.IScene;
	import com.yogurt3d.core.viewports.Viewport;
	import com.yogurt3d.presets.renderers.molehill.MolehillRenderer;
	
	import flash.display.Stage;
	import flash.utils.Dictionary;

	public class Yogurt3DManager implements IPBManager
	{
		public var m_initCallback:Function;
		[Inject]
		public var stage:Stage;
		
		private var m_initialized:Boolean = false;
		private var m_autostart:Boolean;
		private var m_contextStore:Dictionary;
		private var m_activeContextName:String;
		private var m_defaultContext:Context;
		
		////////////////////////////////////////////
		// IPBManager Implementation
		////////////////////////////////////////////
		public function initialize( ):void
		{
			//// We initialize in init3d since it is an async operation
			 
		}
		public function init3D(initCallback:Function = null, autostart:Boolean = true ):void
		{
			m_initCallback = initCallback;
			if(!m_initialized)
			{
				m_autostart = autostart;
				m_contextStore = new Dictionary();
				/// if the Yogurt3DManager is initialized for the first time
				/// start Yogurt3DEngine
				Yogurt3D.instance.addEventListener( Yogurt3DEvent.READY , onEngineReady );
				Yogurt3D.instance.init( stage );
			}else
			{
				
			}
		}
		
		public function destroy():void
		{
			stopRender();
		}
		////////////////////////////////////////////
		// Getters and setters
		////////////////////////////////////////////
		public function get defaultContext():Context
		{
			return m_defaultContext
		}
		public function set defaultContext(value:Context):void
		{
			m_defaultContext = value;
		}
		////////////////////////////////////////////
		// Initialize Yogurt3d
		////////////////////////////////////////////
		private function onEngineReady(_e:Yogurt3DEvent):void
		{
			m_initialized = true;
			// We create our default scene
			Yogurt3D.instance.defaultSetup( stage.width, stage.height ); 
			
			Yogurt3D.instance.defaultScene.sceneColor = new Color( 0, 0, 0 );
			if( m_autostart )
			{
				startRender();	
			}
			m_initCallback();
		}
		public function useDefaultSetup( width:Number, heigth:Number):void
		{
			var _scene:IScene 			= new Scene();
			var _camera:ICamera 		= new Camera();
			var _renderer:IRenderer 	= new MolehillRenderer();	
			var _viewport:Viewport		= new Viewport();
			_scene.addChild(_camera);
			
			var context:Context = new Context();
			context.renderer 	= _renderer;
			context.camera 	= _camera;
			context.scene		= _scene;
			context.viewport	= _viewport;
			
			_viewport.setViewport( 0, 0, width, heigth );
			
			this.addContext( context, "defaultContext" );
		}
		////////////////////////////////////////////
		// Control Functions
		////////////////////////////////////////////
		//  ---  Rendering
		public function startRender():void
		{
			if( m_initialized)
			{
				Yogurt3D.instance.startAutoUpdate();
			}	
		}
		public function stopRender():void
		{
			if( m_initialized )
			{
				Yogurt3D.instance.stopAutoUpdate();
			}
		}
		//  ---  Context
		public function addContext(context:Context, name:String = "", defaultContext:Boolean = false ):void
		{
			Yogurt3D.instance.contextManager.addContext( context );
			m_contextStore[ name ] = context;
			if( name )
			{
				m_contextStore[ name ] = context;
				m_contextStore[ context ] = name;
			}
			if( defaultContext )
			{
				m_defaultContext = context;
			}
		}
		public function removeContext(context:Context):void
		{
			Yogurt3D.instance.contextManager.removeContext( context );
			var name:String = m_contextStore[ context ];
			if( name )
			{
				delete m_contextStore[ name ];
				delete m_contextStore[ context];
			}
		}
		public function removeContextByName( name:String ):void
		{
			var context:Context = m_contextStore[ name ];
			Yogurt3D.instance.contextManager.removeContext( context );
			if( context )
			{
				delete m_contextStore[ name ];
				delete m_contextStore[ context];
			}
			if( m_defaultContext == context )
			{
				m_defaultContext = null;
			}
		}
	}
}