package sercanaltun.y3dpbe.test
{
	import com.pblabs.core.PBGameObject;
	import com.pblabs.core.PBGroup;
	import com.yogurt3d.core.lights.ELightType;
	import com.yogurt3d.core.materials.MaterialDiffuseFill;
	import com.yogurt3d.presets.primitives.meshs.BoxMesh;
	
	import flash.geom.Vector3D;
	
	import sercanaltun.y3dpbe.core.Yogurt3DManager;
	import sercanaltun.y3dpbe.core.components.Y3DLightComponent;
	import sercanaltun.y3dpbe.core.components.Y3DSceneObjectRenderableComp;
	import sercanaltun.y3dpbe.test.comp.TestPreciseRotator;

	public class Y3DTimingTutorial extends PBGroup
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
			yogurtManager.useDefaultSetup( 800, 600 );
			
			/// Create your 3D object
			var cube:PBGameObject = new PBGameObject("Cube");
			cube.owningGroup = this;
			// Add SceneObjectComponent
			var sceneObjComp:Y3DSceneObjectRenderableComp = new Y3DSceneObjectRenderableComp();
			sceneObjComp.name = "scObjComp";
			sceneObjComp.scene = yogurtManager.defaultContext.scene;
			sceneObjComp.geometry = new BoxMesh();
			sceneObjComp.material = new MaterialDiffuseFill( 0x00FF00 );
			
			cube.addComponent( sceneObjComp ); 
			
			var rotator:TestPreciseRotator = new TestPreciseRotator();
			rotator.name = "rotateComp";
			rotator.rotateTarget = "@scObjComp.rotationY";
			cube.addComponent( rotator );
			
			cube.initialize();
			
			var light:PBGameObject = new PBGameObject("Light");
			light.owningGroup = this;
			var ligthComp:Y3DLightComponent = new Y3DLightComponent();
			ligthComp.scene = yogurtManager.defaultContext.scene;
			ligthComp.type = ELightType.DIRECTIONAL;
			ligthComp.position = new Vector3D( -10,-10,-10 );
			ligthComp.transformation.lookAt( new Vector3D(0,0,0) )
			light.addComponent( ligthComp, "lightComp" );
			
			light.initialize();
			
			/////// Set up camera
			yogurtManager.defaultContext.camera.transformation.z = -20;
			yogurtManager.defaultContext.camera.transformation.lookAt( new Vector3D(0, 0, 0 ) );
			
		}
	}
}