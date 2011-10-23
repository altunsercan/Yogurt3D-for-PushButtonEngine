package
{
	import com.pblabs.core.PBGameObject;
	import com.pblabs.core.PBGroup;
	import com.yogurt3d.Yogurt3D;
	import com.yogurt3d.core.cameras.Camera;
	import com.yogurt3d.core.cameras.interfaces.ICamera;
	import com.yogurt3d.core.managers.contextmanager.Context;
	import com.yogurt3d.core.materials.MaterialFill;
	import com.yogurt3d.core.materials.base.Material;
	import com.yogurt3d.core.renderers.interfaces.IRenderer;
	import com.yogurt3d.core.sceneobjects.Scene;
	import com.yogurt3d.core.sceneobjects.interfaces.IScene;
	import com.yogurt3d.core.viewports.Viewport;
	import com.yogurt3d.presets.primitives.meshs.SphereMesh;
	import com.yogurt3d.presets.renderers.molehill.MolehillRenderer;
	
	import sercanaltun.y3dpbe.core.Yogurt3DManager;
	import sercanaltun.y3dpbe.core.components.Yogurd3DSceneObjectComponent;
	import sercanaltun.y3dpbe.core.components.Yogurt3DCameraComponent;
	
	public class Yogurt3DTest extends PBGroup
	{
		
		[Inject]
		public var yogurtManager:Yogurt3DManager;
		
		public override function initialize():void
		{
			
			super.initialize();
			
			yogurtManager.init3D( onYogurt3DInitialized );
			
		}
		public function onYogurt3DInitialized():void
		{
			/// Create 3D context
			/// LONG VERSION: To show you what a context is like
			var _scene:IScene 			= new Scene(); 				/// Scene is the object where you put your 3d objects. You can share scenes between Context objects
			var _camera:ICamera 		= new Camera(); 			/// Camera is a special SceneObject which is basicly, well, a camera...
			_scene.addChild(_camera); 								/// We add camera to the scene 
			var _renderer:IRenderer 	= new MolehillRenderer();	// Molehill renderer is the GPU accelerated renderer introduced in Flash v11
			var _viewport:Viewport		= new Viewport(); 			// This is the canvas which renderer draws on
			_viewport.setViewport( 0, 0, 800, 600 ); 				/// Set canvas position and size
			
			/// Put these all into a single Context object which says:
			var context:Context = new Context();
			context.scene		= _scene;							/// Draw this scene
			context.viewport	= _viewport;						/// on this canvas
			context.camera 	= _camera;								/// looking from this view
			context.renderer 	= _renderer;						/// using this renderer
			
			yogurtManager.addContext( context, "defaultContext", true );     /// We give Yogurt3D manager this context and we are good to go
			/// SHORT VERSION: does the same thing above
			//yogurtManager.useDefaultSetup( 800, 600 );
			
			/// Create your first 3D object
			var obj:PBGameObject = new PBGameObject("SphereObject");
			
			// Add SceneObjectComponent
			var sceneObjComp:Yogurd3DSceneObjectComponent = new Yogurd3DSceneObjectComponent();
			sceneObjComp.name = "scObjComp";
			sceneObjComp.scene = yogurtManager.defaultContext.scene;  /// Give reference to scene which sceneobject belongs to
			sceneObjComp.geometry = new SphereMesh( 10 );
			sceneObjComp.material = new MaterialFill( 0xCCFFCC, 0.6 );
			
			
			yogurtManager.defaultContext.camera.transformation.z = -20; /// Shift camera back in z axis so we would be outside of sphere
			
		}
	}
}