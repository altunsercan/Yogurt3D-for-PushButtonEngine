package sercanaltun.y3dpbe.tutorials
{
	import com.pblabs.PBE;
	import com.pblabs.core.PBGame;
	import com.pblabs.core.PBGameObject;
	import com.pblabs.core.PBGroup;
	import com.pblabs.simplest.SimplestMouseFollowComponent;
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
	import com.yogurt3d.presets.primitives.meshs.BoxMesh;
	import com.yogurt3d.presets.primitives.meshs.SphereMesh;
	import com.yogurt3d.presets.renderers.molehill.MolehillRenderer;
	
	import flash.geom.Vector3D;
	
	import sercanaltun.y3dpbe.core.Yogurt3DManager;
	import sercanaltun.y3dpbe.core.components.Y3DSceneObjectContainerComp;
	import sercanaltun.y3dpbe.core.components.Y3DSceneObjectRenderableComp;
	import sercanaltun.y3dpbe.tutorials.comp.TestRotator;
	
	public class Y3DQuickStartTest extends PBGroup
	{
		
		[Inject]
		public var yogurtManager:Yogurt3DManager;
		
		public override function initialize():void
		{
			
			super.initialize();
			
			yogurtManager.init3D( onYogurt3DInitialized );
			
		}
		public override function destroy():void
		{
			/// Don't forget to clean up yogurt3d
			
			yogurtManager.removeContextByName("defaultContext");
			yogurtManager.stopRender();
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
			var cube1:PBGameObject = new PBGameObject("Cube1");
			cube1.owningGroup = this;
			// Add SceneObjectComponent
			var sceneObjComp:Y3DSceneObjectRenderableComp = new Y3DSceneObjectRenderableComp();
			sceneObjComp.name = "scObjComp";
			sceneObjComp.geometry = new BoxMesh();
			sceneObjComp.material = new MaterialFill( 0x00FF00 );
			sceneObjComp.position = new Vector3D( -10, 0, 0 );
			
			cube1.addComponent( sceneObjComp ); /// Don't forget to add the component ( No shame, I did too )
			cube1.initialize();
			
			// Add Another One
			var cube2:PBGameObject  = new PBGameObject("Cube2");
			cube2.owningGroup = this;
			sceneObjComp = new Y3DSceneObjectRenderableComp();
			sceneObjComp.name = "scObjComp";
			sceneObjComp.geometry = new BoxMesh();
			sceneObjComp.material = new MaterialFill( 0x0000FF);
			sceneObjComp.position = new Vector3D( 10, 0, 0 );
			
			cube2.addComponent( sceneObjComp ); 
			
			cube2.initialize();
			
			/// A container to hold them as a 3D Group
			var container:PBGameObject = new PBGameObject("Container");
			container.owningGroup = this;
			var sceneContComp:Y3DSceneObjectContainerComp = new Y3DSceneObjectContainerComp();
			sceneContComp.name = "scContComp";
			sceneContComp.scene = yogurtManager.defaultContext.scene;  /// Give reference to scene which sceneobject belongs to
			sceneContComp.addChild( cube1 );
			sceneContComp.addChild( cube2 );
			container.addComponent( sceneContComp );
			
			var rotator:TestRotator = new TestRotator();
			rotator.name = "rotateComp";
			rotator.rotateTarget = "@scContComp.rotationY";
			container.addComponent( rotator );
			container.initialize();
			
			/////// Set up camera
			yogurtManager.defaultContext.camera.transformation.z = 100;
			yogurtManager.defaultContext.camera.transformation.y = 10;
			yogurtManager.defaultContext.camera.transformation.lookAt( new Vector3D(0, 0, 0 ) );
			
			yogurtManager.startRender();
		}
		
		
	}
}