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
        // var p = new MyProject();
        // var g = new h2d.Graphics(s2d);


        // var tileSize = 200;
        // for(x in 0...4){
        //     for(y in 0...4){        
        //         // g.beginTileFill(x*logo.width,y*logo.height,1,1,logo);        
        //         // g.drawRect(x*logo.width, y*logo.height, logo.width, logo.height);            
        //         g.beginFill(Color.rgbToInt(Color.WHITE));
        //         g.drawRect(x*tileSize, y*tileSize, tileSize, tileSize);            
        //     }
        // }
        // g.endFill();




        var topView = new h2d.Scene();


        alignment = new Flow(s2d);
        alignment.horizontalAlign = Left;
        alignment.verticalAlign = Top;
        

        var root = new scene.ContainerComp(Right,alignment);
        
        //lighting
        
        s3d.lightSystem.ambientLight.set(0.5, 0.5, 0.5);

        var shadow = s3d.renderer.getPass(DirShadowMap);
        //Increasing the amount of passes increases the amount of blur applied to the shadow
        
        // shadow.bias = .001;
        // shadow.blur.quality = 4;
        // shadow.samplingKind = PCF;
        // shadow.pcfQuality = 10;

        // s3d.lightSystem.shadowLight = 
        // .color.set(.2,.2,.2,1.0);
        var directionalLight = new h3d.scene.fwd.DirLight(new h3d.Vector(-0.3, 0.2, -1), s3d);
        
        
        directionalLight.enableSpecular = true;
        


        // var g3 = new h3d.scene.Graphics(s3d);
        var cube = new Cube();
        
        cube.addUVs();
        cube.addNormals();
        
        var m = new h3d.scene.Mesh(cube, s3d);

        // m.material.mainPass.enableLights = true;
        // m.material.shadows = true;
        
        // m.material.castShadows = true;
        // m.material.receiveShadows= true;
        m.material.color.setColor(Std.random(0x1000000));

        s3d.addChild(m);
        
        style = new h2d.domkit.Style();
		style.load(hxd.Res.style);
		style.addObject(root);

       
        // s3d.camera.orthoBounds = Bounds.fromValues( -width,-height, 0,width,height,5000);
        s3d.camera.pos.add(new h3d.Vector(5.0,5.0,0.0));
        var total = s2d.width + s2d.height;
        var width = s2d.width *2/ total;
        var height = s2d.height *2/ total;
        // hxd.Res.props.watch(initCamera);
        s3d.camera.orthoBounds = Bounds.fromValues( -width,-height, 0,width,height,5000);
        // s3d.camera.fovY = 0.01;
        // s3d.camera.setFovX(


        // var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        // tf.text = "Hello Worlds!";
        
        new core.OrthoCameraController(m).loadFromCamera();
        var plane = new h3d.prim.Grid(4,4,1,1);
        // plane.render()        
        plane.addNormals();
        var planeMesh = new Mesh( plane);
        planeMesh.setPosition(-2,-2,0);
        var rt = new RenderTarget();        

        MouseHelper.initInteract(s3d,planeMesh);
        s3d.addChild(planeMesh);
    }
    
    var scale = 20*2;//since we sub and add from center

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