package sercanaltun.y3dpbe.tutorials
{
	import com.pblabs.core.PBGameObject;
	import com.pblabs.core.PBGroup;
	import com.yogurt3d.core.lights.ELightType;
	import com.yogurt3d.core.materials.MaterialDiffuseFill;
	import com.yogurt3d.core.materials.MaterialSpecularFill;
	import com.yogurt3d.presets.primitives.meshs.BoxMesh;
	import com.yogurt3d.presets.primitives.meshs.PlaneMesh;
	
	import flash.geom.Vector3D;
	
	import sercanaltun.y3dpbe.core.Yogurt3DManager;
	import sercanaltun.y3dpbe.core.components.Y3DLightComponent;
	import sercanaltun.y3dpbe.core.components.Y3DSceneObjectRenderableComp;
	import sercanaltun.y3dpbe.tutorials.comp.TestPointLightAnimator;
	import sercanaltun.y3dpbe.tutorials.comp.TestPreciseRotator;

	public class Y3DPointLightTutorial extends PBGroup
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
			var plane:PBGameObject = new PBGameObject("Plane");
			plane.owningGroup = this;
			// Add SceneObjectComponent
			var sceneObjComp:Y3DSceneObjectRenderableComp = new Y3DSceneObjectRenderableComp();
			sceneObjComp.name = "scObjComp";
			sceneObjComp.scene = yogurtManager.defaultContext.scene;
			sceneObjComp.geometry = new PlaneMesh( 350, 350 );
			sceneObjComp.material = new MaterialSpecularFill( 0xEFEFEF );
			
			plane.addComponent( sceneObjComp ); 
			
			plane.initialize();
			
			var light:PBGameObject = new PBGameObject("Light");
			light.owningGroup = this;
			var ligthComp:Y3DLightComponent = new Y3DLightComponent();
			ligthComp.scene = yogurtManager.defaultContext.scene;
			ligthComp.type = ELightType.POINT;
			ligthComp.position = new Vector3D( 0, 5, 0 );
			light.addComponent( ligthComp, "lightComp" );
			
			var animator:TestPointLightAnimator = new TestPointLightAnimator();
			animator.attenuationTarget = "@lightComp.attenuation";
			animator.positionTarget = "@lightComp.position";
			light.addComponent( animator, "animateComp" );
			
			light.initialize();
			
			/////// Set up camera
			yogurtManager.defaultContext.camera.transformation.position = new Vector3D( 0, 250, 350 );
			yogurtManager.defaultContext.camera.transformation.lookAt( new Vector3D( 0, 0, 0 ) );
			
		}
	}
}