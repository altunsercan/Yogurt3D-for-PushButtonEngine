package sercanaltun.y3dpbe.core.components
{
	import com.pblabs.core.PBComponent;
	import com.pblabs.core.PBGameObject;
	import com.yogurt3d.core.sceneobjects.SceneObjectContainer;
	import com.yogurt3d.core.sceneobjects.interfaces.ISceneObjectContainer;
	
	import sercanaltun.y3dpbe.core.ns.y3d_hidden;
	
	public class Y3DSceneObjectContainerComp extends Y3DSceneObjectComp
	{
		////////////////////////////////////////////
		// Attribute
		////////////////////////////////////////////
		protected var m_sceneObjCont:ISceneObjectContainer;
		
		////////////////////////////////////////////
		// Constructor
		////////////////////////////////////////////
		public function Y3DSceneObjectContainerComp()
		{
			super();
			m_sceneObjCont = new SceneObjectContainer();
			y3d_hidden::m_sceneObject = m_sceneObjCont;
		}
		////////////////////////////////////////////
		// Getters and Setters
		////////////////////////////////////////////
		
		////////////////////////////////////////////
		// Container Functions
		////////////////////////////////////////////
		public function addChild( value:Object ):Boolean
		{
			/// If added object is a component add it to container
			if( value is Y3DSceneObjectComp)
			{
				m_sceneObjCont.addChild( Y3DSceneObjectComp( value ).y3d_hidden::m_sceneObject )
				return true;
			}else if( value is PBGameObject)
			{
				/// Check if the object has a Y3DSceneObjectComp
				/// Add them all!!!
				var compList:Vector.<PBComponent> = PBGameObject( value ).getAllComponents();
				for each ( var comp:PBComponent in compList )
				{
					var scComp:Y3DSceneObjectComp = null;
					try{
						scComp = Y3DSceneObjectComp( comp )
					}catch(_e:Error)
					{
					}
					if( scComp )
					{
						m_sceneObjCont.addChild( Y3DSceneObjectComp( comp ).y3d_hidden::m_sceneObject )
					}
				}
				return true;
			}
			/// Not a supported object type for this container
			return false;
		}
		public function removeChild( value:Object ):Boolean
		{
			if( value is Y3DSceneObjectComp)
			{
				m_sceneObjCont.removeChild( Y3DSceneObjectComp( value ).y3d_hidden::m_sceneObject )
				return true;
			}else if( value is PBGameObject)
			{
				var compList:Vector.<PBComponent> = PBGameObject( value ).getAllComponents();
				for each ( var comp:PBComponent in compList )
				{
					if( value is Y3DSceneObjectComp)
					{
						m_sceneObjCont.removeChild( Y3DSceneObjectComp( value ).y3d_hidden::m_sceneObject )
					}
				}
				return true;
			}
			/// Not a supported object type for this container
			return false;
		}
	}
}