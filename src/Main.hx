import assets.MyProject;
class Main extends hxd.App {

    override function init() {
        super.init();
        hxd.Res.initEmbed();
		s2d.setScale( dn.heaps.Scaler.bestFit_i(256,256) ); // scale view to fit

        var p = new MyProject();
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

        
        var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = "Hello World !";
    }

    static function main() {
        new Main();
    }
}