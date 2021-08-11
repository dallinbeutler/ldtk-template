import core.debug.Gizmo;
import core.debug.DrawAxes;
import h3d.prim.Grid;
import MouseStuff.MouseHelper;
import h3d.scene.Mesh;
import h3d.col.Bounds;
import h3d.prim.Cube;
import h3d.scene.Graphics;
import h2d.Flow;
import scene.ContainerComp;
import assetParsing.MyProject;

class Main extends hxd.App {
    var style:h2d.domkit.Style = null;
    var alignment:Flow = null;
    
    override function init() {
        super.init();
        
        initLighting();
        initGUI();
        createPlane();
        createCube();
        initCamera();
        // var topView = new h2d.Scene();
        // s2d.addChild(topView);
        var g3 = new h3d.scene.Graphics(s3d);
        // drawGizmo(g3,1,1,1);
        drawGrid();
        // var g = new h2d.Graphics(topView);
        // g.beginFill(0xFF00FF,1);
        // g.drawCircle(0,0, 500);
        // g.endFill();
        new Gizmo(s3d);

    }
    function drawGrid(){
        var gh = new core.debug.DrawGrid(s3d,10,10,0x444444,0x88888,6.0);
        var ah = new core.debug.DrawAxes(s3d, 10,8 );        
    }

    // function drawGizmo(g :h3d.scene.Graphics,x,y,z ) {
    //     g.setPosition(x,y,z);
    //     g.lineStyle(10,0xFF0000);
    //     g.drawLine(new Point(0,0,0),new Point(1,0,0));
    //     g.lineStyle(10,0x00FF00);
    //     g.drawLine(new Point(0,0,0),new Point(0,1,0));
    //     g.lineStyle(10,0x0000FF);
    //     g.drawLine(new Point(0,0,0),new Point(0,0,1));
    //     g.setPosition(0,0,0);
    // }

    function initCamera(){
        s3d.camera.pos.add(new h3d.Vector(5.0,5.0,0.0));
        var total = s2d.width + s2d.height;
        var width = s2d.width *2/ total;
        var height = s2d.height *2/ total;
        s3d.camera.orthoBounds = Bounds.fromValues( -width,-height, 0,width,height,5000);
        new core.OrthoCameraController(s3d).loadFromCamera();
    }


    function initGUI(){
        alignment = new Flow(s2d);
        alignment.horizontalAlign = Left;
        alignment.verticalAlign = Top;

        var root = new scene.ContainerComp(Right,alignment);
        style = new h2d.domkit.Style();
		style.load(hxd.Res.style);
		style.addObject(root);
    }

    function initLighting(){
        // var ls = new h3d.scene.fwd.LightSystem();
        // var ls = new h3d.scene.pbr.LightSystem();
        
		// var light = new h3d.scene.pbr.DirLight(s3d);
		var light = new h3d.scene.fwd.DirLight(s3d);
		light.setPosition(100 , 200, 100);
		light.setDirection(new h3d.Vector(-1,-2,-1,1));
		// light. = 10;
        // light.shadows.mode = Dynamic;
        // light.shadows.bias = 0.01;
        // light.shadows.blur.radius = 0;
        // light.shadows.pcfScale = .1;
        // light.shadows.pcfQuality = 10;
        // s3d.lightSystem = ls;
		
		s3d.camera.pos.set(10, 10, 10);

    }
    
    function createPlane() {
		var prim = new Grid(1,1,1,1);
		prim.translate(-.5, -.5, -0);
		// prim.unindex();
		prim.addNormals();
		prim.addUVs();
		var obj = new Mesh(prim, s3d);
		obj.scaleX = 10;
		obj.scaleY = 10;
		obj.z = -0.01;
		obj.material.color.setColor(0xffffff);
		obj.material.mainPass.enableLights = true;
		obj.material.receiveShadows = true;
		// obj.material.mainPass.addShader(new h3d.shader.pbr.PropsValues(1, 0, 0));
        
        MouseHelper.initInteract(s3d,obj);

		return obj;
	}
	
	function createCube() {
		var prim = new Cube();
		// prim.translate(0,0, 0.5);
		prim.unindex();
		prim.addNormals();
		prim.addUVs();
		var obj = new Mesh(prim, s3d);
		obj.material.color.setColor(0xff0000);
		obj.material.shadows = true;
		obj.material.mainPass.enableLights = true;
		obj.material.mainPass.addShader(new h3d.shader.pbr.PropsValues(.5, .5, 0));
		return obj;
	}

    
    function renderMap(){
        s2d.setScale( dn.heaps.Scaler.bestFit_i(256,256) ); // scale view to fit

        var p = new assetParsing.MyProject();
        var layer = p.all_levels.Level_0.l_IntGrid;
        var g = new h2d.Graphics(s2d);

        g.beginFill(p.bgColor_int);
        g.drawRect(0,0, layer.cWid * layer.gridSize, layer.cHei * layer.gridSize);
        g.endFill();

        for(cx in 0...layer.cWid)
            for(cy in 0...layer.cHei){
                var color = layer.getColorInt(cx,cy);
                if (color == null) continue;
                g.beginFill(color);
                g.drawRect(cx * layer.gridSize, cy * layer.gridSize, layer.gridSize, layer.gridSize);
            }

    }

    override function onResize() {
		alignment.minWidth = alignment.maxWidth = s2d.width;
		alignment.minHeight = alignment.maxHeight = s2d.height;
        s3d.camera.screenRatio = s2d.height/s2d.width;
	}

    override function update(dt:Float){
        style.sync();
    }

    static function main() {
        #if hl
		hxd.res.Resource.LIVE_UPDATE = true;
		hxd.Res.initLocal();
		#else
		hxd.Res.initEmbed();
		#end
        new Main();
    }
}