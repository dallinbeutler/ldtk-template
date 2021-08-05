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
// import assets.MyProject;

class Main extends hxd.App {
    var style:h2d.domkit.Style = null;
    var alignment:Flow = null;
    override function init() {
        super.init();
        // var p = new MyProject();
        var g = new h2d.Graphics(s2d);
        alignment = new Flow(s2d);
        alignment.horizontalAlign = Left;
        alignment.verticalAlign = Top;


        var root = new scene.ContainerComp(Right,alignment);
        
        //lighting
        s3d.lightSystem.ambientLight.set(0.5, 0.5, 0.5);
        var directionalLight = new h3d.scene.fwd.DirLight(new h3d.Vector(-0.3, -0.2, -1), s3d);
        directionalLight.enableSpecular = true;


        // var g3 = new h3d.scene.Graphics(s3d);
        var cube = new Cube();
        cube.addUVs();
        cube.addNormals();
        var m = new h3d.scene.Mesh(cube, s3d);
        
        s3d.addChild(m);
        
        style = new h2d.domkit.Style();
		style.load(hxd.Res.style);
		style.addObject(root);


        // hxd.Res.props.watch(initCamera);
        fixOrtho();

        // var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        // tf.text = "Hello Worlds!";
        
        new core.OrthoCameraController(s3d).loadFromCamera();
        var grid = new h3d.prim.Grid(8,8,1,1);
        grid.addNormals();
        var gridMesh = new Mesh( grid);
        MouseHelper.initInteract(s3d,gridMesh);
        
        gridMesh.setPosition(-4,-4,0);
        // gridMesh.material.mainPass.wireframe = true;
        s3d.addChild(gridMesh);
    }
    
    var scale = 20*2;//since we sub and add from center
    function fixOrtho(){
        // var startup:haxe.DynamicAccess<Float> = haxe.Json.parse(hxd.Res.props.entry);
        var width = s2d.width / scale;
        var height = s2d.height / scale;
        // s3d.camera.orthoBounds = Bounds.fromValues( -5.0,-5.0, 0,5,5,5000);
        s3d.camera.orthoBounds = Bounds.fromValues( -width,-height, 0,width,height,5000);
    }

    // function initCamera(){
    //     var cam = new Camera();




        
    //     s3d.camera = cam;
    // }

    override function onResize() {
		alignment.minWidth = alignment.maxWidth = s2d.width;
		alignment.minHeight = alignment.maxHeight = s2d.height;
        fixOrtho();
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