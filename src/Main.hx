import h3d.pass.DirShadowMap;
import h3d.col.Plane;
import h3d.prim.Grid;
import h3d.mat.RenderTarget;
import dn.Color;
import h3d.scene.Light;
import MouseStuff.MouseHelper;
import h3d.scene.Mesh;
import h3d.col.Bounds;
import h3d.Camera;
import h3d.prim.Cube;
import h3d.scene.Graphics;
import h2d.Flow;
import h2d.col.Ray;
import scene.ContainerComp;
import h2d.domkit.BaseComponents.DrawableComp;
import dn.heaps.Scaler;
import assetParsing.MyProject;

class Main extends hxd.App {
    var style:h2d.domkit.Style = null;
    var alignment:Flow = null;
    
    override function init() {
        super.init();
        
        initLighting();
        initGUI();
        initScene();
        initCamera();
        var topView = new h2d.Scene();
        var rt = new RenderTarget();        
    }

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
        s3d.lightSystem.ambientLight.set(0.5, 0.5, 0.5);

        // set things such as bias
        //var shadow = s3d.renderer.getPass(DirShadowMap);
        var directionalLight = new h3d.scene.fwd.DirLight(new h3d.Vector(-0.3, 0.2, -1), s3d);
        directionalLight.enableSpecular = true;
    }
    function initScene() {
        //add cube mesh
        var cube = new Cube();
        cube.addUVs();
        cube.addNormals();
        var m = new h3d.scene.Mesh(cube, s3d);
        m.material.color.setColor(Std.random(0x1000000));
        s3d.addChild(m);

        //add plane mesh
        var plane = new h3d.prim.Grid(4,4,1,1);
        plane.addNormals();
        var planeMesh = new Mesh( plane);
        planeMesh.setPosition(-2,-2,0);
        // add interactivity
        MouseHelper.initInteract(s3d,planeMesh);
        s3d.addChild(planeMesh);
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