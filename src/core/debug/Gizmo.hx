package core.debug;

import h3d.prim.HMDModel;
import hxd.res.Model;
import hxd.Res;
import h3d.scene.Sphere;
import h3d.col.Collider;
import h3d.prim.Cube;
import MouseStuff.MouseHelper;
import hxd.Key;
import h3d.Vector;
import h3d.scene.Mesh;
import h3d.scene.Object;
import h3d.prim.Cylinder;

class Gizmo extends h3d.scene.Graphics {
	public function new(?parent:h3d.scene.Object, size = 2.0, lineWidth = 2.0, colorX = 0xEB304D, colorY = 0x7FC309, colorZ = 0x288DF9) {
		super(parent);

		material.props = h3d.mat.MaterialSetup.current.getDefaults("ui");

		lineShader.width = lineWidth;

		setColor(colorX);
		lineTo(size, 0, 0);

		setColor(colorY);
		moveTo(0, 0, 0);
		lineTo(0, size, 0);

		setColor(colorZ);
		moveTo(0, 0, 0);
		lineTo(0, 0, size);

		var modelCache = new h3d.prim.ModelCache();
		var lib = modelCache.loadLibrary(hxd.Res.models.gizmo);

        var gizmoModel = modelCache.loadModel(hxd.Res.models.gizmo);

        var xHit = gizmoModel.getMeshByName("xAxis_hit");
        xHit.material.color = new Vector(1,0,0,1);
        xHit.material.shadows = false;
        var yHit = gizmoModel.getMeshByName("yAxis_hit");
        yHit.material.color = new Vector(0,1,0,1);
        yHit.material.shadows = false;

        var zHit = gizmoModel.getMeshByName("zAxis_hit");
        zHit.material.color = new Vector(0,0,1,1);
        zHit.material.shadows = false;


        gizmoModel.getMeshByName("xAxis").visible = false;
        gizmoModel.getMeshByName("yAxis").visible = false;
        gizmoModel.getMeshByName("zAxis").visible = false;
        // var xMesh = gizmoModel.getMeshByName("xAxis");
        // xMesh.material.color = new Vector(1,0,0,1);
        // var yMesh = gizmoModel.getMeshByName("yAxis");
        // yMesh.material.color = new Vector(1,0,0,1);
        // var zMesh = gizmoModel.getMeshByName("zAxis");      
        // zMesh.material.color = new Vector(1,0,0,1);

        //"root"
        //"scale"
        //"yz"
        //"xz"
        //"xy"
        //"xRotate"
        //"yRotate"
        //"zRotate"
				
		initInteract(new Vector(1,0,0), xHit, xHit.getCollider());
		initInteract(new Vector(0,1,0), yHit, yHit.getCollider());
		initInteract(new Vector(0,0,1), zHit, zHit.getCollider());

        this.addChild(gizmoModel);
		// var obj = cast(modelCache.loadModel(hxd.Res.models.gizmo),HMDModel);
		// obj.get

		// var c = new Cylinder(8, .1, 1);

		// c.addNormals();
		// c.addUVs();

		// var m = new h3d.scene.Mesh(c, parent);
		// var col = new Cube(.2, .2, 8).getCollider();
		// initInteract(new Vector(), m, col);

		// var sph = new h3d.prim.Sphere(.1, 8, 6, 1);
		// sph.addNormals();
		// sph.addUVs();

		// var endm = new Mesh(sph, parent);
		// endm.setPosition(0, 0, 1);
		// endm.material.shadows = true;
		// endm.material.color = new Vector(0, 1, 0);

		// // MouseHelper.initInteract(parent,m,col);
		// initInteract(new Vector(), endm, endm.getCollider());
	}

	function initInteract(axis:Vector, m:h3d.scene.Mesh, col:Collider) {
		var i = new h3d.scene.Interactive(col, parent);
		i.propagateEvents = true;
		var color = m.material.color.clone();
		i.bestMatch = true;
		var mouseDown = false;
		var startingOffset:Vector = null;
		i.onPush = function(e:hxd.Event) {
			if (e.button == 0) {
				mouseDown = true;
				m.material.color.set(1, 1, 0);
				e.propagate = false;
				startingOffset = new Vector(e.relX,e.relY,e.relZ);
			}
		};
		i.onRelease = function(e:hxd.Event) {
			if (e.button == 0) {
				mouseDown = false;
				m.material.color.load(color);
			}
		};

		i.onOver = function(e:hxd.Event) {
			m.material.color.set(color.r + .5,  color.g + .5, 0);
		};
		i.onMove = i.onCheck = function(e:hxd.Event) {
			if (mouseDown){		
				var mouseP = i.absPos.getPosition();
				var offset = ((new Vector(e.relX,e.relY,e.relZ)).sub(startingOffset));			
				offset = new Vector(offset.x * axis.x,offset.y * axis.y, offset.z * offset.z);
				var currentPos = this.getTransform().getPosition();
				this.setPosition(currentPos.x + offset.x,currentPos.y + offset.y,currentPos.z +offset.z);
				startingOffset = new Vector(e.relX,e.relY,e.relZ);				
			} 
			//   if( beacon == null ) return;
			//   beacon.x = e.relX;
			//   beacon.y = e.relY;
			//   beacon.z = e.relZ;
		};
		i.on

		i.onOut = function(e:hxd.Event) {
			if (!mouseDown)
				m.material.color.load(color);
			//   beacon.remove();
			//   beacon = null;
		};
	}
}
